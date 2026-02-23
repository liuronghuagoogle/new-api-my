"use client";

import React, { useState, useEffect, useCallback } from "react";
import Topbar from "@/components/layout/topbar";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import {
  Wallet, Zap, BarChart3, KeyRound,
  TrendingUp, Activity, Clock, CheckCircle2, Loader2, AlertCircle,
} from "lucide-react";
import {
  AreaChart, Area, XAxis, YAxis, CartesianGrid, Tooltip,
  ResponsiveContainer, BarChart, Bar,
} from "recharts";
import { useAuth } from "@/components/auth/auth-provider";
import { getLogs, getLogStat, getQuotaData, getTokens } from "@/lib/api-hooks";
import { formatQuota, quotaToUsd, formatTimeShort, type Log, type QuotaData } from "@/lib/types";
import CheckinCard from "@/components/checkin-card";

/* ── 图表 Tooltip ── */
function ChartTooltip({ active, payload, label }: { active?: boolean; payload?: Array<{ value: number; name: string }>; label?: string }) {
  if (!active || !payload?.length) return null;
  return (
    <div className="rounded-md border border-border bg-card px-3 py-2 shadow-card">
      <p className="text-caption text-muted-foreground">{label}</p>
      {payload.map((p, i) => (
        <p key={i} className="text-sm font-medium">{p.name}: {typeof p.value === "number" ? p.value.toLocaleString() : p.value}</p>
      ))}
    </div>
  );
}

/* ── 颜色列表 ── */
const MODEL_COLORS = ["bg-primary", "bg-accent", "bg-success", "bg-warning", "bg-destructive"];

export default function DashboardPage() {
  const { user, status, refreshUser } = useAuth();

  const [loading, setLoading] = useState(true);
  const [recentLogs, setRecentLogs] = useState<Log[]>([]);
  const [stat, setStat] = useState<{ quota: number; rpm: number; tpm: number } | null>(null);
  const [chartData, setChartData] = useState<Array<{ date: string; tokens: number; count: number }>>([]);
  const [modelDist, setModelDist] = useState<Array<{ model: string; tokens: number; pct: number }>>([]);
  const [tokenCount, setTokenCount] = useState({ active: 0, total: 0 });

  const loadData = useCallback(async () => {
    setLoading(true);
    try {
      // 刷新用户信息 (余额)
      refreshUser();

      // 并发请求
      const now = Math.floor(Date.now() / 1000);
      const sevenDaysAgo = now - 7 * 86400;

      const [logsRes, statRes, quotaRes, tokensRes] = await Promise.allSettled([
        getLogs({ page: 1, pageSize: 5 }),
        getLogStat(),
        getQuotaData(sevenDaysAgo, now),
        getTokens(1, 100),
      ]);

      // 最近请求
      if (logsRes.status === "fulfilled") {
        setRecentLogs(logsRes.value.items || []);
      }

      // 统计
      if (statRes.status === "fulfilled") {
        setStat(statRes.value);
      }

      // 图表数据 + 模型分布
      if (quotaRes.status === "fulfilled") {
        const raw = quotaRes.value || [];
        processChartData(raw);
      }

      // Token 数量
      if (tokensRes.status === "fulfilled") {
        const items = tokensRes.value.items || [];
        const active = items.filter((t) => t.status === 1).length;
        setTokenCount({ active, total: tokensRes.value.total });
      }
    } catch {
      // 静默处理
    } finally {
      setLoading(false);
    }
  }, [refreshUser]);

  const processChartData = (raw: QuotaData[]) => {
    // 按日期聚合
    const dateMap = new Map<string, { tokens: number; count: number }>();
    const modelMap = new Map<string, number>();

    for (const item of raw) {
      // 日期聚合
      const dateStr = new Date(item.created_at * 1000).toLocaleDateString("zh-CN", { month: "numeric", day: "numeric" });
      const existing = dateMap.get(dateStr) || { tokens: 0, count: 0 };
      existing.tokens += item.token_used;
      existing.count += item.count;
      dateMap.set(dateStr, existing);

      // 模型聚合
      if (item.model_name) {
        modelMap.set(item.model_name, (modelMap.get(item.model_name) || 0) + item.token_used);
      }
    }

    // 图表数据
    setChartData(
      Array.from(dateMap.entries())
        .map(([date, d]) => ({ date, tokens: d.tokens, count: d.count }))
        .sort((a, b) => a.date.localeCompare(b.date))
    );

    // 模型分布
    const totalTokens = Array.from(modelMap.values()).reduce((a, b) => a + b, 0);
    const sorted = Array.from(modelMap.entries())
      .sort((a, b) => b[1] - a[1])
      .slice(0, 5);
    setModelDist(
      sorted.map(([model, tokens]) => ({
        model,
        tokens,
        pct: totalTokens > 0 ? Math.round((tokens / totalTokens) * 100) : 0,
      }))
    );
  };

  useEffect(() => {
    loadData();
  }, [loadData]);

  const balance = user ? formatQuota(user.quota ?? 0) : "—";
  const usedQuota = user ? formatQuota(user.used_quota ?? 0) : "—";
  const checkinEnabled = status?.checkin_enabled === true;

  return (
    <>
      <Topbar title="仪表盘" description="API 使用概览与账户总览" />
      <div className="flex-1 overflow-y-auto scrollbar-thin">
        <div className="mx-auto max-w-6xl space-y-6 px-6 py-6">

          {/* Stats + Checkin */}
          {checkinEnabled ? (
            <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-[1fr_1fr_1.2fr] lg:grid-rows-2">
              {/* 2×2 田字格 — 左侧两列 */}
              <StatCard icon={Wallet} label="当前余额" value={`$${balance}`} sub="可用额度" />
              <StatCard icon={Zap} label="当前 RPM" value={stat ? String(stat.rpm) : "—"} sub="请求/分钟" />
              <div className="sm:col-span-2 lg:col-span-1 lg:row-span-2">
                <CheckinCard onQuotaChange={refreshUser} />
              </div>
              <StatCard icon={BarChart3} label="已用额度" value={`$${usedQuota}`} sub="累计消费" />
              <StatCard icon={KeyRound} label="活跃密钥" value={String(tokenCount.active)} sub={`共 ${tokenCount.total} 个`} />
            </div>
          ) : (
            <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
              <StatCard icon={Wallet} label="当前余额" value={`$${balance}`} sub="可用额度" />
              <StatCard icon={Zap} label="当前 RPM" value={stat ? String(stat.rpm) : "—"} sub="请求/分钟" />
              <StatCard icon={BarChart3} label="已用额度" value={`$${usedQuota}`} sub="累计消费" />
              <StatCard icon={KeyRound} label="活跃密钥" value={String(tokenCount.active)} sub={`共 ${tokenCount.total} 个`} />
            </div>
          )}

          {/* Charts Row */}
          <div className="grid gap-6 lg:grid-cols-[1.5fr_1fr]">
            {/* Usage Trend */}
            <Card>
              <CardHeader>
                <div className="flex items-center justify-between">
                  <CardTitle className="flex items-center gap-2">
                    <TrendingUp className="h-4 w-4 text-muted-foreground" />
                    Token 用量趋势
                  </CardTitle>
                  <Badge variant="secondary">近 7 天</Badge>
                </div>
              </CardHeader>
              <CardContent>
                <div className="h-64">
                  {loading ? (
                    <div className="flex h-full items-center justify-center"><Loader2 className="h-5 w-5 animate-spin text-muted-foreground" /></div>
                  ) : chartData.length > 0 ? (
                    <ResponsiveContainer width="100%" height="100%">
                      <AreaChart data={chartData} margin={{ top: 8, right: 4, left: -20, bottom: 0 }}>
                        <defs>
                          <linearGradient id="tokenGrad" x1="0" y1="0" x2="0" y2="1">
                            <stop offset="0%" stopColor="hsl(24,70%,50%)" stopOpacity={0.15} />
                            <stop offset="100%" stopColor="hsl(24,70%,50%)" stopOpacity={0} />
                          </linearGradient>
                        </defs>
                        <CartesianGrid strokeDasharray="3 3" stroke="hsl(30,10%,88%)" vertical={false} />
                        <XAxis dataKey="date" tick={{ fontSize: 12 }} stroke="hsl(25,5%,45%)" tickLine={false} axisLine={false} />
                        <YAxis tick={{ fontSize: 12 }} stroke="hsl(25,5%,45%)" tickLine={false} axisLine={false} tickFormatter={(v: number) => `${(v / 1000).toFixed(0)}K`} />
                        <Tooltip content={<ChartTooltip />} />
                        <Area type="monotone" dataKey="tokens" name="Token 数" stroke="hsl(24,70%,50%)" strokeWidth={2} fill="url(#tokenGrad)" />
                      </AreaChart>
                    </ResponsiveContainer>
                  ) : (
                    <div className="flex h-full items-center justify-center text-sm text-muted-foreground">暂无数据</div>
                  )}
                </div>
              </CardContent>
            </Card>

            {/* Request Count Trend */}
            <Card>
              <CardHeader>
                <div className="flex items-center justify-between">
                  <CardTitle className="flex items-center gap-2">
                    <Activity className="h-4 w-4 text-muted-foreground" />
                    请求量趋势
                  </CardTitle>
                  <Badge variant="secondary">近 7 天</Badge>
                </div>
              </CardHeader>
              <CardContent>
                <div className="h-64">
                  {loading ? (
                    <div className="flex h-full items-center justify-center"><Loader2 className="h-5 w-5 animate-spin text-muted-foreground" /></div>
                  ) : chartData.length > 0 ? (
                    <ResponsiveContainer width="100%" height="100%">
                      <BarChart data={chartData} margin={{ top: 8, right: 4, left: -20, bottom: 0 }}>
                        <CartesianGrid strokeDasharray="3 3" stroke="hsl(30,10%,88%)" vertical={false} />
                        <XAxis dataKey="date" tick={{ fontSize: 11 }} stroke="hsl(25,5%,45%)" tickLine={false} axisLine={false} />
                        <YAxis tick={{ fontSize: 11 }} stroke="hsl(25,5%,45%)" tickLine={false} axisLine={false} />
                        <Tooltip content={<ChartTooltip />} />
                        <Bar dataKey="count" name="请求数" fill="hsl(24,70%,50%)" radius={[3, 3, 0, 0]} opacity={0.85} />
                      </BarChart>
                    </ResponsiveContainer>
                  ) : (
                    <div className="flex h-full items-center justify-center text-sm text-muted-foreground">暂无数据</div>
                  )}
                </div>
              </CardContent>
            </Card>
          </div>

          {/* Model Usage + Recent Activity */}
          <div className="grid gap-6 lg:grid-cols-[1fr_1.5fr]">
            {/* Model Distribution */}
            <Card>
              <CardHeader>
                <CardTitle>模型分布</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                {loading ? (
                  <div className="flex justify-center py-8"><Loader2 className="h-5 w-5 animate-spin text-muted-foreground" /></div>
                ) : modelDist.length > 0 ? (
                  modelDist.map((m, i) => (
                    <div key={m.model} className="space-y-1.5">
                      <div className="flex items-center justify-between text-sm">
                        <span className="font-medium truncate max-w-[60%]">{m.model}</span>
                        <span className="text-muted-foreground shrink-0">{(m.tokens / 1000).toFixed(0)}K ({m.pct}%)</span>
                      </div>
                      <div className="h-1.5 w-full overflow-hidden rounded-full bg-secondary">
                        <div className={`h-full rounded-full ${MODEL_COLORS[i % MODEL_COLORS.length]} transition-all`} style={{ width: `${m.pct}%` }} />
                      </div>
                    </div>
                  ))
                ) : (
                  <p className="text-center text-sm text-muted-foreground py-4">暂无数据</p>
                )}
              </CardContent>
            </Card>

            {/* Recent Requests */}
            <Card>
              <CardHeader>
                <div className="flex items-center justify-between">
                  <CardTitle className="flex items-center gap-2">
                    <Clock className="h-4 w-4 text-muted-foreground" />
                    最近请求
                  </CardTitle>
                </div>
              </CardHeader>
              <CardContent className="p-0">
                <div className="overflow-x-auto">
                  <table className="w-full text-sm">
                    <thead>
                      <tr className="border-b border-border">
                        <th className="px-5 py-2.5 text-left text-caption font-medium text-muted-foreground">时间</th>
                        <th className="px-5 py-2.5 text-left text-caption font-medium text-muted-foreground">模型</th>
                        <th className="px-5 py-2.5 text-right text-caption font-medium text-muted-foreground">Token 数</th>
                        <th className="px-5 py-2.5 text-right text-caption font-medium text-muted-foreground">费用</th>
                        <th className="px-5 py-2.5 text-center text-caption font-medium text-muted-foreground">状态</th>
                      </tr>
                    </thead>
                    <tbody>
                      {loading ? (
                        <tr><td colSpan={5} className="py-8 text-center"><Loader2 className="mx-auto h-5 w-5 animate-spin text-muted-foreground" /></td></tr>
                      ) : recentLogs.length > 0 ? (
                        recentLogs.map((log) => (
                          <tr key={log.id} className="border-b border-border last:border-0 transition-colors hover:bg-muted/30">
                            <td className="px-5 py-2.5 text-muted-foreground">{formatTimeShort(log.created_at)}</td>
                            <td className="px-5 py-2.5 font-mono text-body-sm">{log.model_name}</td>
                            <td className="px-5 py-2.5 text-right tabular-nums">{(log.prompt_tokens + log.completion_tokens).toLocaleString()}</td>
                            <td className="px-5 py-2.5 text-right tabular-nums">${quotaToUsd(log.quota).toFixed(4)}</td>
                            <td className="px-5 py-2.5 text-center">
                              {log.type !== 5 ? (
                                <CheckCircle2 className="mx-auto h-3.5 w-3.5 text-success" />
                              ) : (
                                <AlertCircle className="mx-auto h-3.5 w-3.5 text-destructive" />
                              )}
                            </td>
                          </tr>
                        ))
                      ) : (
                        <tr><td colSpan={5} className="py-8 text-center text-muted-foreground">暂无请求记录</td></tr>
                      )}
                    </tbody>
                  </table>
                </div>
              </CardContent>
            </Card>
          </div>

        </div>
      </div>
    </>
  );
}

/* ── Stat Card 组件 ── */
function StatCard({ icon: Icon, label, value, sub }: { icon: React.ElementType; label: string; value: string; sub: string }) {
  return (
    <Card className="transition-shadow duration-150 hover:shadow-card-hover">
      <CardContent className="p-5">
        <div className="flex items-start justify-between">
          <div>
            <p className="text-caption font-medium text-muted-foreground">{label}</p>
            <p className="mt-1 font-display text-heading-2 font-semibold tracking-tight">{value}</p>
            <p className="mt-1.5 text-caption text-muted-foreground">{sub}</p>
          </div>
          <div className="rounded-md bg-primary/8 p-2">
            <Icon className="h-4 w-4 text-primary" strokeWidth={1.5} />
          </div>
        </div>
      </CardContent>
    </Card>
  );
}
