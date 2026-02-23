"use client";

import React, { useState, useEffect, Suspense } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent } from "@/components/ui/card";
import { Separator } from "@/components/ui/separator";
import Link from "next/link";
import { Github, Loader2, AlertCircle } from "lucide-react";
import { useAuth } from "@/components/auth/auth-provider";
import { login as apiLogin, verify2FA, getOAuthState } from "@/lib/auth";

/* ── OAuth 图标 ── */
function DiscordIcon({ className }: { className?: string }) {
  return (
    <svg className={className} viewBox="0 0 24 24" fill="currentColor">
      <path d="M20.317 4.37a19.791 19.791 0 0 0-4.885-1.515.074.074 0 0 0-.079.037c-.21.375-.444.864-.608 1.25a18.27 18.27 0 0 0-5.487 0 12.64 12.64 0 0 0-.617-1.25.077.077 0 0 0-.079-.037A19.736 19.736 0 0 0 3.677 4.37a.07.07 0 0 0-.032.027C.533 9.046-.32 13.58.099 18.057a.082.082 0 0 0 .031.057 19.9 19.9 0 0 0 5.993 3.03.078.078 0 0 0 .084-.028c.462-.63.874-1.295 1.226-1.994a.076.076 0 0 0-.041-.106 13.107 13.107 0 0 1-1.872-.892.077.077 0 0 1-.008-.128 10.2 10.2 0 0 0 .372-.292.074.074 0 0 1 .077-.01c3.928 1.793 8.18 1.793 12.062 0a.074.074 0 0 1 .078.01c.12.098.246.198.373.292a.077.077 0 0 1-.006.127 12.299 12.299 0 0 1-1.873.892.077.077 0 0 0-.041.107c.36.698.772 1.362 1.225 1.993a.076.076 0 0 0 .084.028 19.839 19.839 0 0 0 6.002-3.03.077.077 0 0 0 .032-.054c.5-5.177-.838-9.674-3.549-13.66a.061.061 0 0 0-.031-.03z" />
    </svg>
  );
}

export default function LoginPage() {
  return (
    <Suspense fallback={
      <div className="flex min-h-screen items-center justify-center bg-background">
        <div className="h-6 w-6 animate-spin rounded-full border-2 border-primary border-t-transparent" />
      </div>
    }>
      <LoginContent />
    </Suspense>
  );
}

function LoginContent() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const { user, status, loading: authLoading, login: setUser } = useAuth();

  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  // 2FA 状态
  const [show2FA, setShow2FA] = useState(false);
  const [tfaCode, setTfaCode] = useState("");

  // 已登录 → 跳转控制台
  useEffect(() => {
    if (!authLoading && user) {
      router.replace("/dashboard");
    }
  }, [user, authLoading, router]);

  // URL 参数提示
  useEffect(() => {
    if (searchParams.get("expired") === "true") {
      setError("登录已过期，请重新登录");
    }
  }, [searchParams]);

  const systemName = status?.system_name || "API 控制台";

  /* ── 密码登录 ── */
  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!username.trim() || !password.trim()) return;

    setError("");
    setLoading(true);
    try {
      const result = await apiLogin(username, password);
      if (result.require_2fa) {
        setShow2FA(true);
      } else if (result.user) {
        setUser(result.user);
        router.replace("/dashboard");
      }
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : "登录失败";
      setError(msg);
    } finally {
      setLoading(false);
    }
  };

  /* ── 2FA 验证 ── */
  const handle2FA = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!tfaCode.trim()) return;

    setError("");
    setLoading(true);
    try {
      const u = await verify2FA(tfaCode);
      setUser(u);
      router.replace("/dashboard");
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : "验证失败";
      setError(msg);
    } finally {
      setLoading(false);
    }
  };

  /* ── OAuth 跳转 ── */
  const handleOAuth = async (provider: string, authUrl: string) => {
    try {
      const state = await getOAuthState();
      const url = `${authUrl}${authUrl.includes("?") ? "&" : "?"}state=${state}`;
      window.location.href = url;
    } catch {
      setError("无法获取 OAuth 状态");
    }
  };

  /* ── 收集可用的 OAuth 提供商 ── */
  const oauthProviders: Array<{
    key: string;
    name: string;
    icon: React.ReactNode;
    authUrl: string;
  }> = [];

  if (status?.github_oauth && status.github_client_id) {
    oauthProviders.push({
      key: "github",
      name: "GitHub",
      icon: <Github className="h-4 w-4" />,
      authUrl: `https://github.com/login/oauth/authorize?client_id=${status.github_client_id}&scope=user:email`,
    });
  }

  if (status?.discord_oauth && status.discord_client_id) {
    oauthProviders.push({
      key: "discord",
      name: "Discord",
      icon: <DiscordIcon className="h-4 w-4" />,
      authUrl: `https://discord.com/api/oauth2/authorize?client_id=${status.discord_client_id}&response_type=code&scope=identify+email`,
    });
  }

  if (status?.oidc_enabled && status.oidc_client_id && status.oidc_authorization_endpoint) {
    oauthProviders.push({
      key: "oidc",
      name: status.oidc_display_name || "SSO",
      icon: <span className="text-xs font-bold">SSO</span>,
      authUrl: `${status.oidc_authorization_endpoint}?client_id=${status.oidc_client_id}&response_type=code&scope=openid profile email`,
    });
  }

  if (status?.linuxdo_oauth && status.linuxdo_client_id) {
    oauthProviders.push({
      key: "linuxdo",
      name: "LinuxDO",
      icon: <span className="text-xs font-bold">L</span>,
      authUrl: `https://connect.linux.do/oauth2/authorize?client_id=${status.linuxdo_client_id}&response_type=code&scope=read`,
    });
  }

  // 自定义 OAuth
  status?.custom_oauth_providers?.forEach((p) => {
    oauthProviders.push({
      key: p.slug,
      name: p.name,
      icon: <span className="text-xs font-bold">{p.name.charAt(0)}</span>,
      authUrl: `${p.authorization_endpoint}?client_id=${p.client_id}&response_type=code&scope=${encodeURIComponent(p.scope || "openid profile email")}`,
    });
  });

  // OAuth redirect_uri 统一指向 /oauth/{provider}
  const addRedirectUri = (url: string, provider: string) => {
    const origin = typeof window !== "undefined" ? window.location.origin : "";
    const redirectUri = `${origin}/oauth/${provider}`;
    return `${url}&redirect_uri=${encodeURIComponent(redirectUri)}`;
  };

  if (authLoading) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-background">
        <div className="h-6 w-6 animate-spin rounded-full border-2 border-primary border-t-transparent" />
      </div>
    );
  }

  return (
    <div className="flex min-h-screen items-center justify-center bg-background px-4">
      <div className="w-full max-w-sm">
        {/* Logo */}
        <div className="mb-8 text-center">
          <div className="mx-auto mb-4 flex h-10 w-10 items-center justify-center rounded-lg bg-primary text-primary-foreground font-bold">
            A
          </div>
          <h1 className="font-display text-heading-2 font-bold">
            {show2FA ? "两步验证" : "欢迎回来"}
          </h1>
          <p className="mt-1 text-body-sm text-muted-foreground">
            {show2FA ? "请输入验证器应用中的验证码" : `登录 ${systemName}`}
          </p>
        </div>

        <Card>
          <CardContent className="p-6 space-y-4">
            {/* 错误提示 */}
            {error && (
              <div className="flex items-center gap-2 rounded-md bg-destructive/10 px-3 py-2 text-sm text-destructive">
                <AlertCircle className="h-4 w-4 shrink-0" />
                <span>{error}</span>
              </div>
            )}

            {show2FA ? (
              /* ── 2FA 表单 ── */
              <form onSubmit={handle2FA} className="space-y-4">
                <div className="space-y-1.5">
                  <label className="text-sm font-medium">验证码</label>
                  <Input
                    placeholder="输入 6 位验证码"
                    value={tfaCode}
                    onChange={(e) => setTfaCode(e.target.value)}
                    maxLength={8}
                    autoFocus
                  />
                  <p className="text-caption text-muted-foreground">
                    也可输入 8 位备用码
                  </p>
                </div>
                <Button className="w-full" type="submit" disabled={loading || !tfaCode.trim()}>
                  {loading && <Loader2 className="h-4 w-4 animate-spin" />}
                  验证
                </Button>
                <button
                  type="button"
                  onClick={() => { setShow2FA(false); setTfaCode(""); setError(""); }}
                  className="w-full text-center text-caption text-muted-foreground hover:text-foreground cursor-pointer"
                >
                  返回登录
                </button>
              </form>
            ) : (
              /* ── 登录表单 ── */
              <>
                <form onSubmit={handleLogin} className="space-y-4">
                  <div className="space-y-1.5">
                    <label className="text-sm font-medium">用户名或邮箱</label>
                    <Input
                      placeholder="you@example.com"
                      value={username}
                      onChange={(e) => setUsername(e.target.value)}
                      autoFocus
                    />
                  </div>
                  <div className="space-y-1.5">
                    <div className="flex items-center justify-between">
                      <label className="text-sm font-medium">密码</label>
                      <Link href="/reset" className="text-caption text-primary hover:underline">
                        忘记密码？
                      </Link>
                    </div>
                    <Input
                      type="password"
                      placeholder="请输入密码"
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                    />
                  </div>
                  <Button className="w-full" type="submit" disabled={loading || !username.trim() || !password.trim()}>
                    {loading && <Loader2 className="h-4 w-4 animate-spin" />}
                    登录
                  </Button>
                </form>

                {/* OAuth 区域 */}
                {oauthProviders.length > 0 && (
                  <>
                    <div className="relative py-2">
                      <Separator />
                      <span className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 bg-card px-2 text-caption text-muted-foreground">
                        或通过以下方式登录
                      </span>
                    </div>
                    <div className={`grid gap-2 ${oauthProviders.length === 1 ? "grid-cols-1" : "grid-cols-2"}`}>
                      {oauthProviders.map((p) => (
                        <Button
                          key={p.key}
                          variant="outline"
                          className="w-full"
                          onClick={() => handleOAuth(p.key, addRedirectUri(p.authUrl, p.key))}
                        >
                          {p.icon}
                          {p.name}
                        </Button>
                      ))}
                    </div>
                  </>
                )}

                {/* 注册链接 */}
                {status?.register_enabled !== false && (
                  <p className="text-center text-caption text-muted-foreground">
                    还没有账户？{" "}
                    <Link href="/register" className="text-primary hover:underline">
                      立即注册
                    </Link>
                  </p>
                )}
              </>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
