"use client";

import React, { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent } from "@/components/ui/card";
import Link from "next/link";
import { Loader2, AlertCircle, CheckCircle2 } from "lucide-react";
import { sendPasswordReset } from "@/lib/auth";

export default function ResetPage() {
  const [email, setEmail] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [sent, setSent] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!email.trim()) return;

    setError("");
    setLoading(true);
    try {
      await sendPasswordReset(email);
      setSent(true);
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : "发送失败");
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
          <h1 className="font-display text-heading-2 font-bold">重置密码</h1>
          <p className="mt-1 text-body-sm text-muted-foreground">
            输入注册邮箱，我们将发送重置链接
          </p>
        </div>

        <Card>
          <CardContent className="p-6 space-y-4">
            {error && (
              <div className="flex items-center gap-2 rounded-md bg-destructive/10 px-3 py-2 text-sm text-destructive">
                <AlertCircle className="h-4 w-4 shrink-0" />
                <span>{error}</span>
              </div>
            )}

            {sent ? (
              <div className="flex flex-col items-center gap-3 py-4">
                <CheckCircle2 className="h-10 w-10 text-success" />
                <p className="text-sm font-medium text-center">
                  重置邮件已发送，请查收邮箱
                </p>
                <p className="text-caption text-muted-foreground text-center">
                  如未收到，请检查垃圾邮件文件夹
                </p>
              </div>
            ) : (
              <form onSubmit={handleSubmit} className="space-y-4">
                <div className="space-y-1.5">
                  <label className="text-sm font-medium">邮箱地址</label>
                  <Input
                    type="email"
                    placeholder="you@example.com"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    autoFocus
                  />
                </div>
                <Button className="w-full" type="submit" disabled={loading || !email.trim()}>
                  {loading && <Loader2 className="h-4 w-4 animate-spin" />}
                  发送重置邮件
                </Button>
              </form>
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
