"use client";

import React, { useState, Suspense } from "react";
import { useSearchParams } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import Link from "next/link";
import { Loader2, AlertCircle, CheckCircle2, Copy } from "lucide-react";
import { confirmPasswordReset } from "@/lib/auth";

export default function UserResetPage() {
  return (
    <Suspense fallback={
      <div className="flex min-h-screen items-center justify-center bg-background">
        <div className="h-6 w-6 animate-spin rounded-full border-2 border-primary border-t-transparent" />
      </div>
    }>
      <UserResetContent />
    </Suspense>
  );
}

function UserResetContent() {
  const searchParams = useSearchParams();
  const email = searchParams.get("email") || "";
  const token = searchParams.get("token") || "";

  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [newPassword, setNewPassword] = useState("");

  const handleConfirm = async () => {
    if (!email || !token) {
      setError("无效的重置链接");
      return;
    }

    setError("");
    setLoading(true);
    try {
      const pwd = await confirmPasswordReset(email, token);
      setNewPassword(pwd);
      // 复制到剪贴板
      navigator.clipboard.writeText(pwd).catch(() => {});
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : "重置失败");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="flex min-h-screen items-center justify-center bg-background px-4">
      <div className="w-full max-w-sm">
        <div className="mb-8 text-center">
          <div className="mx-auto mb-4 flex h-10 w-10 items-center justify-center rounded-lg bg-primary text-primary-foreground font-bold">
            A
          </div>
          <h1 className="font-display text-heading-2 font-bold">确认重置</h1>
        </div>

        <Card>
          <CardContent className="p-6 space-y-4">
            {error && (
              <div className="flex items-center gap-2 rounded-md bg-destructive/10 px-3 py-2 text-sm text-destructive">
                <AlertCircle className="h-4 w-4 shrink-0" />
                <span>{error}</span>
              </div>
            )}

            {newPassword ? (
              <div className="space-y-4">
                <div className="flex flex-col items-center gap-3">
                  <CheckCircle2 className="h-10 w-10 text-success" />
                  <p className="text-sm font-medium">密码已重置</p>
                </div>
                <div className="flex items-center gap-2 rounded-md bg-muted px-3 py-2">
                  <code className="flex-1 font-mono text-sm">{newPassword}</code>
                  <button
                    onClick={() => navigator.clipboard.writeText(newPassword)}
                    className="text-muted-foreground hover:text-foreground cursor-pointer"
                  >
                    <Copy className="h-4 w-4" />
                  </button>
                </div>
                <p className="text-caption text-muted-foreground text-center">
                  新密码已复制到剪贴板，请登录后修改
                </p>
              </div>
            ) : (
              <div className="space-y-4">
                <p className="text-sm text-muted-foreground text-center">
                  确认为 <strong>{email}</strong> 重置密码？
                </p>
                <Button
                  className="w-full"
                  onClick={handleConfirm}
                  disabled={loading || !email || !token}
                >
                  {loading && <Loader2 className="h-4 w-4 animate-spin" />}
                  确认重置
                </Button>
              </div>
            )}

            <p className="text-center text-caption text-muted-foreground">
              <Link href="/login" className="text-primary hover:underline">
                返回登录
              </Link>
            </p>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
