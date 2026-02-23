"use client";

import React, { useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent } from "@/components/ui/card";
import Link from "next/link";
import { Loader2, AlertCircle, CheckCircle2 } from "lucide-react";
import { useAuth } from "@/components/auth/auth-provider";
import { register, sendVerificationCode } from "@/lib/auth";

export default function RegisterPage() {
  const router = useRouter();
  const { status } = useAuth();

  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [email, setEmail] = useState("");
  const [verificationCode, setVerificationCode] = useState("");
  const [loading, setLoading] = useState(false);
  const [sendingCode, setSendingCode] = useState(false);
  const [codeSent, setCodeSent] = useState(false);
  const [error, setError] = useState("");
  const [success, setSuccess] = useState(false);

  const needEmail = status?.email_verification ?? false;
  const affCode = typeof window !== "undefined" ? new URLSearchParams(window.location.search).get("aff") || localStorage.getItem("aff") || "" : "";

  const handleSendCode = async () => {
    if (!email.trim()) return;
    setSendingCode(true);
    setError("");
    try {
      await sendVerificationCode(email);
      setCodeSent(true);
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : "发送失败");
    } finally {
      setSendingCode(false);
    }
  };

  const handleRegister = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");

    if (password.length < 8) {
      setError("密码长度至少 8 位");
      return;
    }
    if (password !== confirmPassword) {
      setError("两次输入的密码不一致");
      return;
    }

    setLoading(true);
    try {
      await register({
        username,
        password,
        email: needEmail ? email : undefined,
        verification_code: needEmail ? verificationCode : undefined,
        aff_code: affCode || undefined,
      });
      setSuccess(true);
      // 保存邀请码
      if (affCode) localStorage.setItem("aff", affCode);
      setTimeout(() => router.push("/login"), 2000);
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : "注册失败");
    } finally {
      setLoading(false);
    }
  };

  // 注册未开放
  if (status && status.register_enabled === false) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-background px-4">
        <div className="text-center">
          <h1 className="font-display text-heading-2 font-bold">注册未开放</h1>
          <p className="mt-2 text-muted-foreground">当前系统未开放注册</p>
          <Link href="/login" className="mt-4 inline-block text-primary hover:underline">
            返回登录
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="flex min-h-screen items-center justify-center bg-background px-4">
      <div className="w-full max-w-sm">
        <div className="mb-8 text-center">
          <div className="mx-auto mb-4 flex h-10 w-10 items-center justify-center rounded-lg bg-primary text-primary-foreground font-bold">
            A
          </div>
          <h1 className="font-display text-heading-2 font-bold">创建账户</h1>
          <p className="mt-1 text-body-sm text-muted-foreground">注册新账户</p>
        </div>

        <Card>
          <CardContent className="p-6 space-y-4">
            {error && (
              <div className="flex items-center gap-2 rounded-md bg-destructive/10 px-3 py-2 text-sm text-destructive">
                <AlertCircle className="h-4 w-4 shrink-0" />
                <span>{error}</span>
              </div>
            )}

            {success ? (
              <div className="flex flex-col items-center gap-3 py-4">
                <CheckCircle2 className="h-10 w-10 text-success" />
                <p className="text-sm font-medium">注册成功！正在跳转到登录页...</p>
              </div>
            ) : (
              <form onSubmit={handleRegister} className="space-y-4">
                <div className="space-y-1.5">
                  <label className="text-sm font-medium">用户名</label>
                  <Input
                    placeholder="请输入用户名"
                    value={username}
                    onChange={(e) => setUsername(e.target.value)}
                    autoFocus
                  />
                </div>

                {needEmail && (
                  <>
                    <div className="space-y-1.5">
                      <label className="text-sm font-medium">邮箱</label>
                      <div className="flex gap-2">
                        <Input
                          type="email"
                          placeholder="you@example.com"
                          value={email}
                          onChange={(e) => setEmail(e.target.value)}
                          className="flex-1"
                        />
                        <Button
                          type="button"
                          variant="outline"
                          size="sm"
                          onClick={handleSendCode}
                          disabled={sendingCode || !email.trim() || codeSent}
                          className="shrink-0"
                        >
                          {sendingCode ? <Loader2 className="h-4 w-4 animate-spin" /> : codeSent ? "已发送" : "发送验证码"}
                        </Button>
                      </div>
                    </div>
                    <div className="space-y-1.5">
                      <label className="text-sm font-medium">验证码</label>
                      <Input
                        placeholder="输入邮箱验证码"
                        value={verificationCode}
                        onChange={(e) => setVerificationCode(e.target.value)}
                      />
                    </div>
                  </>
                )}

                <div className="space-y-1.5">
                  <label className="text-sm font-medium">密码</label>
                  <Input
                    type="password"
                    placeholder="至少 8 位"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                  />
                </div>
                <div className="space-y-1.5">
                  <label className="text-sm font-medium">确认密码</label>
                  <Input
                    type="password"
                    placeholder="再次输入密码"
                    value={confirmPassword}
                    onChange={(e) => setConfirmPassword(e.target.value)}
                  />
                </div>

                <Button className="w-full" type="submit" disabled={loading || !username.trim() || !password.trim()}>
                  {loading && <Loader2 className="h-4 w-4 animate-spin" />}
                  注册
                </Button>
              </form>
            )}

            <p className="text-center text-caption text-muted-foreground">
              已有账户？{" "}
              <Link href="/login" className="text-primary hover:underline">
                立即登录
              </Link>
            </p>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
