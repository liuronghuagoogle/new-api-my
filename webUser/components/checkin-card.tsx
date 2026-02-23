"use client";

import React, { useState, useEffect, useCallback } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { CalendarCheck, Loader2, Check, Sparkles } from "lucide-react";
import { getCheckinStatus, doCheckin } from "@/lib/api-hooks";
import { formatQuota, type CheckinStats, type CheckinRecord } from "@/lib/types";
import { cn } from "@/lib/utils";

/* ── 热力图格子颜色 ── */
function getCellClass(record: CheckinRecord | undefined, isToday: boolean, isFuture: boolean, isPast: boolean): string {
  const base = "h-6 w-6 rounded-sm transition-colors";

  if (isFuture) return cn(base, "bg-muted/30");
  if (!record && isPast) return cn(base, "bg-secondary/50");
  if (!record && isToday) return cn(base, "bg-secondary/50 ring-2 ring-primary ring-offset-1 ring-offset-card");

  // 有签到记录 — 按额度分三级
  if (record) {
    const q = record.quota_awarded;
    let intensity = "bg-primary/25";
    if (q >= 5000) intensity = "bg-primary/75";
    else if (q >= 2000) intensity = "bg-primary/45";
    return cn(base, intensity, isToday && "ring-2 ring-primary ring-offset-1 ring-offset-card");
  }

  return cn(base, "bg-muted/30");
}

/* ── 生成月历网格 ── */
function buildMonthGrid(year: number, month: number) {
  const firstDay = new Date(year, month, 1);
  // 周一=0 ... 周日=6
  let startDow = firstDay.getDay() - 1;
  if (startDow < 0) startDow = 6;

  const daysInMonth = new Date(year, month + 1, 0).getDate();
  const today = new Date();
  const todayStr = `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, "0")}-${String(today.getDate()).padStart(2, "0")}`;

  const cells: Array<{
    day: number | null;
    dateStr: string;
    isToday: boolean;
    isFuture: boolean;
    isPast: boolean;
  }> = [];

  // 填充月初空白
  for (let i = 0; i < startDow; i++) {
    cells.push({ day: null, dateStr: "", isToday: false, isFuture: false, isPast: false });
  }

  for (let d = 1; d <= daysInMonth; d++) {
    const dateStr = `${year}-${String(month + 1).padStart(2, "0")}-${String(d).padStart(2, "0")}`;
    const cellDate = new Date(year, month, d);
    const isToday = dateStr === todayStr;
    const isFuture = cellDate > today && !isToday;
    const isPast = cellDate < today && !isToday;
    cells.push({ day: d, dateStr, isToday, isFuture, isPast });
  }

  return cells;
}

const WEEKDAYS = ["一", "二", "三", "四", "五", "六", "日"];

/* ── CheckinCard 组件 ── */
export default function CheckinCard({
  onQuotaChange,
}: {
  onQuotaChange?: () => void;
}) {
  const [stats, setStats] = useState<CheckinStats | null>(null);
  const [minQuota, setMinQuota] = useState(0);
  const [maxQuota, setMaxQuota] = useState(0);
  const [loading, setLoading] = useState(true);
  const [checking, setChecking] = useState(false);
  const [lastAwarded, setLastAwarded] = useState<number | null>(null);

  const now = new Date();
  const year = now.getFullYear();
  const month = now.getMonth();
  const monthStr = `${year}-${String(month + 1).padStart(2, "0")}`;

  const loadCheckin = useCallback(async () => {
    try {
      const res = await getCheckinStatus(monthStr);
      setStats(res.stats);
      setMinQuota(res.min_quota);
      setMaxQuota(res.max_quota);
    } catch {
      // 静默处理
    } finally {
      setLoading(false);
    }
  }, [monthStr]);

  useEffect(() => {
    loadCheckin();
  }, [loadCheckin]);

  const handleCheckin = async () => {
    setChecking(true);
    try {
      const res = await doCheckin();
      setLastAwarded(res.quota_awarded);
      // 刷新签到状态
      await loadCheckin();
      onQuotaChange?.();
    } catch {
      // 错误处理 (Turnstile 等 - 后续可扩展)
    } finally {
      setChecking(false);
    }
  };

  const checkedInToday = stats?.checked_in_today ?? false;
  const recordMap = new Map<string, CheckinRecord>();
  if (stats?.records) {
    for (const r of stats.records) {
      recordMap.set(r.checkin_date, r);
    }
  }

  const cells = buildMonthGrid(year, month);

  return (
    <Card className="flex h-full flex-col">
      <CardContent className="flex flex-1 flex-col p-5">
        {/* Header */}
        <div className="flex items-start justify-between">
          <div className="flex items-center gap-2.5">
            <div className="rounded-md bg-primary/8 p-2">
              <CalendarCheck className="h-4 w-4 text-primary" strokeWidth={1.5} />
            </div>
            <div>
              <p className="text-sm font-semibold">每日签到</p>
              <p className="text-caption text-muted-foreground">
                {loading
                  ? "加载中..."
                  : `签到可获得 $${formatQuota(minQuota)}~$${formatQuota(maxQuota)} 额度`}
              </p>
            </div>
          </div>
          <Button
            size="sm"
            variant={checkedInToday ? "outline" : "default"}
            disabled={loading || checking || checkedInToday}
            onClick={handleCheckin}
            className={cn(
              checkedInToday && "border-success/40 text-success hover:bg-success/5 cursor-default"
            )}
          >
            {checking ? (
              <>
                <Loader2 className="h-3.5 w-3.5 animate-spin" />
                签到中...
              </>
            ) : checkedInToday ? (
              <>
                <Check className="h-3.5 w-3.5" />
                已签到
              </>
            ) : (
              <>
                <Sparkles className="h-3.5 w-3.5" />
                签到
              </>
            )}
          </Button>
        </div>

        {/* 签到成功提示 */}
        {lastAwarded !== null && (
          <div className="mt-3 rounded-md bg-success/10 px-3 py-1.5 text-center text-sm text-success">
            签到成功！获得 <span className="font-semibold">${formatQuota(lastAwarded)}</span> 额度
          </div>
        )}

        {/* 热力图 */}
        <div className="mt-4 flex-1">
          {loading ? (
            <div className="flex h-full items-center justify-center">
              <Loader2 className="h-5 w-5 animate-spin text-muted-foreground" />
            </div>
          ) : (
            <div>
              {/* 星期标题 */}
              <div className="mb-1.5 grid grid-cols-7 gap-1.5">
                {WEEKDAYS.map((d) => (
                  <div key={d} className="flex h-4 items-center justify-center text-[10px] text-muted-foreground">
                    {d}
                  </div>
                ))}
              </div>
              {/* 日期格子 */}
              <div className="grid grid-cols-7 gap-1.5">
                {cells.map((cell, i) =>
                  cell.day === null ? (
                    <div key={`empty-${i}`} className="h-6 w-6" />
                  ) : (
                    <div
                      key={cell.dateStr}
                      className={getCellClass(recordMap.get(cell.dateStr), cell.isToday, cell.isFuture, cell.isPast)}
                      title={
                        recordMap.has(cell.dateStr)
                          ? `${cell.day}日 — 获得 $${formatQuota(recordMap.get(cell.dateStr)!.quota_awarded)}`
                          : `${cell.day}日`
                      }
                    />
                  )
                )}
              </div>
            </div>
          )}
        </div>

        {/* 底部统计 */}
        {!loading && stats && (
          <div className="mt-4 grid grid-cols-3 gap-3 border-t border-border pt-3">
            <div className="text-center">
              <p className="text-sm font-semibold tabular-nums">{stats.total_checkins}</p>
              <p className="text-caption text-muted-foreground">累计签到</p>
            </div>
            <div className="text-center">
              <p className="text-sm font-semibold tabular-nums text-primary">${formatQuota(monthQuota(stats))}</p>
              <p className="text-caption text-muted-foreground">本月获得</p>
            </div>
            <div className="text-center">
              <p className="text-sm font-semibold tabular-nums">${formatQuota(stats.total_quota)}</p>
              <p className="text-caption text-muted-foreground">累计获得</p>
            </div>
          </div>
        )}
      </CardContent>
    </Card>
  );
}

/** 从 records 计算本月获得额度 */
function monthQuota(stats: CheckinStats): number {
  return (stats.records || []).reduce((sum, r) => sum + r.quota_awarded, 0);
}
