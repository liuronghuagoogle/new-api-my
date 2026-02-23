"use client";

import React, { useState } from "react";
import Topbar from "@/components/layout/topbar";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import {
  Wallet, Gift, Copy, Users, CheckCircle2, Loader2, AlertCircle, Info,
} from "lucide-react";
import { cn } from "@/lib/utils";
import { useAuth } from "@/components/auth/auth-provider";
import { redeemCode as redeemCodeApi, transferAffQuota } from "@/lib/api-hooks";
import { formatQuota } from "@/lib/types";

export default function TopupPage() {
  const { user, refreshUser } = useAuth();

  const [redeemCodeValue, setRedeemCodeValue] = useState("");
  const [redeemLoading, setRedeemLoading] = useState(false);
  const [redeemMessage, setRedeemMessage] = useState<{ type: "success" | "error"; text: string } | null>(null);

  const [transferLoading, setTransferLoading] = useState(false);
  const [transferMessage, setTransferMessage] = useState<{ type: "success" | "error"; text: string } | null>(null);

  const [copySuccess, setCopySuccess] = useState(false);

  const quota = user?.quota ?? 0;
  const usedQuota = user?.used_quota ?? 0;
  const affCode = user?.aff_code ?? "";
  const affQuota = user?.aff_quota ?? 0;
  const affHistoryQuota = user?.aff_history_quota ?? 0;
  const requestCount = user?.request_count ?? 0;

  const referralLink = typeof window !== "undefined" && affCode
    ? `${window.location.origin}/register?aff=${affCode}`
    : "";

  async function handleRedeem() {
    const code = redeemCodeValue.trim();
    if (!code) return;

    setRedeemLoading(true);
    setRedeemMessage(null);
    try {
      await redeemCodeApi(code);
      await refreshUser();
      setRedeemMessage({ type: "success", text: "兑换成功，余额已更新" });
      setRedeemCodeValue("");
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : "兑换失败，请检查兑换码是否正确";
      setRedeemMessage({ type: "error", text: message });
    } finally {
      setRedeemLoading(false);
    }
  }

  async function handleTransfer() {
    if (affQuota <= 0) return;

    setTransferLoading(true);
    setTransferMessage(null);
    try {
      await transferAffQuota();
      await refreshUser();
      setTransferMessage({ type: "success", text: "转入成功，余额已更新" });
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : "转入失败，请稍后再试";
      setTransferMessage({ type: "error", text: message });
    } finally {
      setTransferLoading(false);
    }
  }

  async function handleCopyLink() {
    if (!referralLink) return;
    try {
      await navigator.clipboard.writeText(referralLink);
      setCopySuccess(true);
      setTimeout(() => setCopySuccess(false), 2000);
    } catch {
      // fallback: select text for manual copy
    }
  }

  return (
    <>
      <Topbar title="钱包" description="管理余额、兑换码充值和推荐返利" />
      <div className="flex-1 overflow-y-auto scrollbar-thin">
        <div className="mx-auto max-w-6xl space-y-6 px-6 py-6">

          {/* Balance Card */}
          <Card className="overflow-hidden">
            <div className="relative bg-gradient-to-br from-primary/5 via-transparent to-accent/5 p-6">
              <div className="flex flex-col gap-6 sm:flex-row sm:items-end sm:justify-between">
                <div>
                  <p className="text-body-sm text-muted-foreground">可用余额</p>
                  <p className="mt-1 font-display text-display font-bold tracking-tight">
                    ${formatQuota(quota)}
                  </p>
                  <p className="mt-1 text-body-sm text-muted-foreground">
                    已用额度：${formatQuota(usedQuota)}
                  </p>
                </div>
                <div className="flex items-center gap-3">
                  <div className="rounded-md bg-card px-4 py-2 shadow-xs">
                    <p className="text-caption text-muted-foreground">总请求次数</p>
                    <p className="font-display text-lg font-semibold">
                      {requestCount.toLocaleString()}
                    </p>
                  </div>
                  <div className="rounded-md bg-card px-4 py-2 shadow-xs">
                    <p className="text-caption text-muted-foreground">推荐累计收益</p>
                    <p className="font-display text-lg font-semibold">
                      ${formatQuota(affHistoryQuota)}
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </Card>

          <div className="grid gap-6 lg:grid-cols-[1fr_1fr]">

            {/* Redeem Code */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Gift className="h-4 w-4 text-muted-foreground" />
                  兑换码
                </CardTitle>
                <CardDescription>使用兑换码为账户充值额度</CardDescription>
              </CardHeader>
              <CardContent className="space-y-3">
                <Input
                  placeholder="输入兑换码..."
                  value={redeemCodeValue}
                  onChange={(e) => {
                    setRedeemCodeValue(e.target.value);
                    setRedeemMessage(null);
                  }}
                  onKeyDown={(e) => {
                    if (e.key === "Enter" && redeemCodeValue.trim() && !redeemLoading) {
                      handleRedeem();
                    }
                  }}
                  disabled={redeemLoading}
                />
                <Button
                  className="w-full"
                  variant="outline"
                  disabled={!redeemCodeValue.trim() || redeemLoading}
                  onClick={handleRedeem}
                >
                  {redeemLoading ? (
                    <>
                      <Loader2 className="h-4 w-4 animate-spin" />
                      兑换中...
                    </>
                  ) : (
                    "兑换"
                  )}
                </Button>
                {redeemMessage && (
                  <div
                    className={cn(
                      "flex items-center gap-2 rounded-md px-3 py-2 text-sm",
                      redeemMessage.type === "success"
                        ? "bg-emerald-500/10 text-emerald-600 dark:text-emerald-400"
                        : "bg-destructive/10 text-destructive"
                    )}
                  >
                    {redeemMessage.type === "success" ? (
                      <CheckCircle2 className="h-4 w-4 shrink-0" />
                    ) : (
                      <AlertCircle className="h-4 w-4 shrink-0" />
                    )}
                    {redeemMessage.text}
                  </div>
                )}
              </CardContent>
            </Card>

            {/* Referral */}
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Users className="h-4 w-4 text-muted-foreground" />
                  推荐返利
                </CardTitle>
                <CardDescription>邀请好友注册获得额度奖励</CardDescription>
              </CardHeader>
              <CardContent className="space-y-3">
                {affCode ? (
                  <div className="flex items-center gap-2 rounded-md bg-muted px-3 py-2">
                    <code className="flex-1 truncate font-mono text-body-sm">
                      {referralLink}
                    </code>
                    <Button
                      variant="ghost"
                      size="icon"
                      className="h-7 w-7 shrink-0"
                      onClick={handleCopyLink}
                      title="复制推荐链接"
                    >
                      {copySuccess ? (
                        <CheckCircle2 className="h-3.5 w-3.5 text-emerald-500" />
                      ) : (
                        <Copy className="h-3.5 w-3.5" />
                      )}
                    </Button>
                  </div>
                ) : (
                  <div className="rounded-md bg-muted px-3 py-2 text-sm text-muted-foreground">
                    暂无推荐码
                  </div>
                )}
                <div className="space-y-2">
                  <div className="flex items-center justify-between text-sm">
                    <span className="text-muted-foreground">待转入收益</span>
                    <span className="font-medium">${formatQuota(affQuota)}</span>
                  </div>
                  <div className="flex items-center justify-between text-sm">
                    <span className="text-muted-foreground">累计收益</span>
                    <span className="font-medium">${formatQuota(affHistoryQuota)}</span>
                  </div>
                </div>
                <Button
                  variant="outline"
                  size="sm"
                  className="w-full"
                  disabled={affQuota <= 0 || transferLoading}
                  onClick={handleTransfer}
                >
                  {transferLoading ? (
                    <>
                      <Loader2 className="h-4 w-4 animate-spin" />
                      转入中...
                    </>
                  ) : (
                    `转入余额 ($${formatQuota(affQuota)})`
                  )}
                </Button>
                {transferMessage && (
                  <div
                    className={cn(
                      "flex items-center gap-2 rounded-md px-3 py-2 text-sm",
                      transferMessage.type === "success"
                        ? "bg-emerald-500/10 text-emerald-600 dark:text-emerald-400"
                        : "bg-destructive/10 text-destructive"
                    )}
                  >
                    {transferMessage.type === "success" ? (
                      <CheckCircle2 className="h-4 w-4 shrink-0" />
                    ) : (
                      <AlertCircle className="h-4 w-4 shrink-0" />
                    )}
                    {transferMessage.text}
                  </div>
                )}
              </CardContent>
            </Card>
          </div>

          {/* Info note replacing transaction history */}
          <Card>
            <CardContent className="flex items-center gap-3 p-4">
              <Info className="h-4 w-4 shrink-0 text-muted-foreground" />
              <p className="text-sm text-muted-foreground">
                详细的充值和消费记录请前往
                <a href="/logs" className="mx-1 font-medium text-primary hover:underline">
                  日志页面
                </a>
                查看。
              </p>
            </CardContent>
          </Card>

        </div>
      </div>
    </>
  );
}
