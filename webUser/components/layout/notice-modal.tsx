"use client";

import React, { useEffect, useState, useMemo } from "react";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@/components/ui/dialog";
import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui/tabs";
import { Button } from "@/components/ui/button";
import { Bell, Megaphone, Loader2 } from "lucide-react";
import { getNotice } from "@/lib/api-hooks";
import type { Announcement } from "@/lib/auth";

/** 格式化相对时间 */
function getRelativeTime(dateStr?: string): string {
  if (!dateStr) return "";
  const date = new Date(dateStr);
  if (isNaN(date.getTime())) return "";
  const now = Date.now();
  const diff = now - date.getTime();
  const seconds = Math.floor(diff / 1000);
  if (seconds < 60) return "刚刚";
  const minutes = Math.floor(seconds / 60);
  if (minutes < 60) return `${minutes} 分钟前`;
  const hours = Math.floor(minutes / 60);
  if (hours < 24) return `${hours} 小时前`;
  const days = Math.floor(hours / 24);
  if (days < 30) return `${days} 天前`;
  const months = Math.floor(days / 30);
  if (months < 12) return `${months} 个月前`;
  return `${Math.floor(months / 12)} 年前`;
}

/** 格式化绝对时间 */
function formatAbsoluteTime(dateStr?: string): string {
  if (!dateStr) return "";
  const d = new Date(dateStr);
  if (isNaN(d.getTime())) return dateStr;
  const pad = (n: number) => String(n).padStart(2, "0");
  return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())} ${pad(d.getHours())}:${pad(d.getMinutes())}`;
}

/** 简单 Markdown → HTML 转换（支持基本语法） */
function simpleMarkdown(text: string): string {
  return text
    // 标题
    .replace(/^### (.+)$/gm, '<h3 class="text-base font-semibold mt-4 mb-2">$1</h3>')
    .replace(/^## (.+)$/gm, '<h2 class="text-lg font-semibold mt-4 mb-2">$1</h2>')
    .replace(/^# (.+)$/gm, '<h1 class="text-xl font-semibold mt-4 mb-2">$1</h1>')
    // 粗体和斜体
    .replace(/\*\*(.+?)\*\*/g, "<strong>$1</strong>")
    .replace(/\*(.+?)\*/g, "<em>$1</em>")
    // 行内代码
    .replace(/`(.+?)`/g, '<code class="rounded bg-muted px-1.5 py-0.5 text-xs font-mono">$1</code>')
    // 图片（必须在链接之前匹配）
    .replace(/!\[([^\]]*)\]\(([^)]+)\)/g, '<img src="$2" alt="$1" class="max-w-full rounded-md my-2" />')
    // 链接
    .replace(/\[(.+?)\]\((.+?)\)/g, '<a href="$2" target="_blank" rel="noopener" class="text-primary underline underline-offset-2 hover:text-primary/80">$1</a>')
    // 分割线
    .replace(/^---$/gm, '<hr class="my-4 border-border" />')
    // 无序列表
    .replace(/^- (.+)$/gm, '<li class="ml-4 list-disc">$1</li>')
    // 段落（连续非空行）
    .replace(/\n\n/g, '</p><p class="mb-3">')
    // 换行
    .replace(/\n/g, "<br />");
}

interface NoticeModalProps {
  visible: boolean;
  onClose: () => void;
  onCloseToday: () => void;
  announcements: Announcement[];
  unreadKeys: string[];
}

export default function NoticeModal({
  visible,
  onClose,
  onCloseToday,
  announcements,
  unreadKeys,
}: NoticeModalProps) {
  const [noticeContent, setNoticeContent] = useState("");
  const [loading, setLoading] = useState(false);
  const [activeTab, setActiveTab] = useState("notice");

  const unreadSet = useMemo(() => new Set(unreadKeys), [unreadKeys]);

  const getKeyForItem = (item: Announcement) =>
    `${item.publishDate || ""}-${(item.content || "").slice(0, 30)}`;

  const processedAnnouncements = useMemo(() => {
    return announcements.slice(0, 20).map((item) => ({
      key: getKeyForItem(item),
      type: item.type || "default",
      time: formatAbsoluteTime(item.publishDate),
      relative: getRelativeTime(item.publishDate),
      content: item.content,
      extra: item.extra,
      isUnread: unreadSet.has(getKeyForItem(item)),
    }));
  }, [announcements, unreadSet]);

  // 加载 Markdown 通知
  useEffect(() => {
    if (!visible) return;
    setLoading(true);
    getNotice()
      .then((data) => setNoticeContent(data || ""))
      .catch(() => setNoticeContent(""))
      .finally(() => setLoading(false));
  }, [visible]);

  // 切换到有内容的 tab
  useEffect(() => {
    if (!visible) return;
    if (announcements.length > 0) {
      setActiveTab("system");
    } else {
      setActiveTab("notice");
    }
  }, [visible, announcements.length]);

  return (
    <Dialog open={visible} onOpenChange={(open) => !open && onClose()}>
      <DialogContent className="max-w-lg">
        <DialogHeader>
          <DialogTitle>系统公告</DialogTitle>
        </DialogHeader>

        <Tabs value={activeTab} onValueChange={setActiveTab}>
          <TabsList>
            <TabsTrigger value="notice" className="gap-1.5">
              <Bell className="h-3.5 w-3.5" />
              通知
            </TabsTrigger>
            <TabsTrigger value="system" className="gap-1.5">
              <Megaphone className="h-3.5 w-3.5" />
              系统公告
              {unreadKeys.length > 0 && (
                <span className="ml-1 inline-flex h-4 min-w-4 items-center justify-center rounded-full bg-primary px-1 text-[10px] font-medium text-primary-foreground">
                  {unreadKeys.length}
                </span>
              )}
            </TabsTrigger>
          </TabsList>

          {/* 通知 Tab — Markdown 公告 */}
          <TabsContent value="notice">
            {loading ? (
              <div className="flex items-center justify-center py-12">
                <Loader2 className="h-5 w-5 animate-spin text-muted-foreground" />
                <span className="ml-2 text-sm text-muted-foreground">加载中...</span>
              </div>
            ) : noticeContent ? (
              <div
                className="prose-sm max-h-[55vh] overflow-y-auto pr-2 scrollbar-thin text-sm leading-relaxed text-foreground"
                dangerouslySetInnerHTML={{ __html: simpleMarkdown(noticeContent) }}
              />
            ) : (
              <div className="flex flex-col items-center justify-center py-12 text-muted-foreground">
                <Bell className="h-8 w-8 mb-2 opacity-40" />
                <p className="text-sm">暂无通知</p>
              </div>
            )}
          </TabsContent>

          {/* 系统公告 Tab — Timeline */}
          <TabsContent value="system">
            {processedAnnouncements.length === 0 ? (
              <div className="flex flex-col items-center justify-center py-12 text-muted-foreground">
                <Megaphone className="h-8 w-8 mb-2 opacity-40" />
                <p className="text-sm">暂无系统公告</p>
              </div>
            ) : (
              <div className="max-h-[55vh] overflow-y-auto pr-2 scrollbar-thin">
                <div className="relative space-y-0">
                  {processedAnnouncements.map((item, idx) => (
                    <div key={idx} className="relative flex gap-4 pb-6 last:pb-0">
                      {/* Timeline line */}
                      {idx < processedAnnouncements.length - 1 && (
                        <div className="absolute left-[7px] top-4 bottom-0 w-px bg-border" />
                      )}
                      {/* Dot */}
                      <div className="relative mt-1.5 shrink-0">
                        <div
                          className={`h-[15px] w-[15px] rounded-full border-2 ${
                            item.isUnread
                              ? "border-primary bg-primary/20"
                              : "border-border bg-background"
                          }`}
                        />
                      </div>
                      {/* Content */}
                      <div className="flex-1 min-w-0">
                        <div className="flex items-baseline gap-2 mb-1">
                          <span className="text-xs text-muted-foreground">
                            {item.relative && `${item.relative} · `}{item.time}
                          </span>
                          {item.isUnread && (
                            <span className="inline-flex items-center rounded-sm bg-primary/10 px-1.5 py-0.5 text-[10px] font-medium text-primary">
                              NEW
                            </span>
                          )}
                        </div>
                        <div
                          className="text-sm leading-relaxed text-foreground"
                          dangerouslySetInnerHTML={{ __html: simpleMarkdown(item.content) }}
                        />
                        {item.extra && (
                          <div
                            className="mt-1 text-xs text-muted-foreground"
                            dangerouslySetInnerHTML={{ __html: simpleMarkdown(item.extra) }}
                          />
                        )}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </TabsContent>
        </Tabs>

        <DialogFooter>
          <Button variant="outline" size="sm" onClick={onCloseToday}>
            今日不再显示
          </Button>
          <Button size="sm" onClick={onClose}>
            关闭
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
