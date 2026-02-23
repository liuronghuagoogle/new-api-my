"use client";

import { useState, useEffect, useCallback, useMemo } from "react";
import type { Announcement } from "@/lib/auth";

/** 生成公告唯一 key */
function getAnnouncementKey(a: Announcement): string {
  return `${a.publishDate || ""}-${(a.content || "").slice(0, 30)}`;
}

/** 从 localStorage 读取已读 keys */
function getReadKeys(): Set<string> {
  try {
    const raw = localStorage.getItem("notice_read_keys");
    if (!raw) return new Set();
    return new Set(JSON.parse(raw) as string[]);
  } catch {
    return new Set();
  }
}

/** 将所有公告标记为已读 */
function markAllAsRead(announcements: Announcement[]) {
  if (!announcements.length) return;
  const existing = getReadKeys();
  for (const a of announcements) {
    existing.add(getAnnouncementKey(a));
  }
  localStorage.setItem("notice_read_keys", JSON.stringify([...existing]));
}

export function useNotifications(announcements: Announcement[]) {
  const [noticeVisible, setNoticeVisible] = useState(false);

  const unreadCount = useMemo(() => {
    if (!announcements.length) return 0;
    const readSet = getReadKeys();
    return announcements.filter((a) => !readSet.has(getAnnouncementKey(a))).length;
  }, [announcements]);

  const unreadKeys = useMemo(() => {
    if (!announcements.length) return [] as string[];
    const readSet = getReadKeys();
    return announcements
      .filter((a) => !readSet.has(getAnnouncementKey(a)))
      .map(getAnnouncementKey);
  }, [announcements]);

  const handleNoticeOpen = useCallback(() => {
    setNoticeVisible(true);
  }, []);

  const handleNoticeClose = useCallback(() => {
    setNoticeVisible(false);
    markAllAsRead(announcements);
  }, [announcements]);

  const handleCloseTodayNotice = useCallback(() => {
    setNoticeVisible(false);
    localStorage.setItem("notice_close_date", new Date().toDateString());
    markAllAsRead(announcements);
  }, [announcements]);

  // 首次打开时，如果有未读且今天未关闭，自动弹出
  useEffect(() => {
    if (!announcements.length) return;
    const closedDate = localStorage.getItem("notice_close_date");
    const today = new Date().toDateString();
    if (closedDate === today) return;
    const readSet = getReadKeys();
    const hasUnread = announcements.some((a) => !readSet.has(getAnnouncementKey(a)));
    if (hasUnread) {
      setNoticeVisible(true);
    }
  }, [announcements]);

  return {
    noticeVisible,
    unreadCount,
    unreadKeys,
    handleNoticeOpen,
    handleNoticeClose,
    handleCloseTodayNotice,
  };
}
