"use client";

import React, { useEffect, useState } from "react";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { useAuth } from "@/components/auth/auth-provider";
import {
  ArrowRight,
  Zap,
  Shield,
  Globe,
  BarChart3,
  KeyRound,
  Code,
} from "lucide-react";

const features = [
  {
    icon: Globe,
    title: "40+ AI 模型",
    desc: "聚合 OpenAI、Claude、Gemini、DeepSeek 等主流 AI 服务商",
  },
  {
    icon: Code,
    title: "OpenAI 兼容 API",
    desc: "统一的 API 格式，无缝替换，无需修改代码",
  },
  {
    icon: Zap,
    title: "高性能转发",
    desc: "智能负载均衡、自动重试、多渠道容错",
  },
  {
    icon: Shield,
    title: "安全可靠",
    desc: "独立密钥管理、细粒度权限控制、完整审计日志",
  },
  {
    icon: BarChart3,
    title: "用量追踪",
    desc: "实时监控 Token 用量和费用，透明的计费体系",
  },
  {
    icon: KeyRound,
    title: "灵活密钥",
    desc: "创建多个 API 密钥，按需设置额度和有效期",
  },
];

export default function HomePage() {
  const { user, status } = useAuth();
  const [mounted, setMounted] = useState(false);

  useEffect(() => setMounted(true), []);

  const systemName = status?.system_name || "API Gateway";
  const apiUrl = process.env.NEXT_PUBLIC_API_URL || (mounted ? window.location.origin : "https://your-domain.com");

  return (
    <div className="min-h-screen bg-background">
      {/* ── Navbar ── */}
      <header className="sticky top-0 z-40 border-b border-border bg-background/80 backdrop-blur-sm">
        <div className="mx-auto flex h-14 max-w-6xl items-center justify-between px-6">
          <Link href="/" className="flex items-center gap-2.5">
            <div className="flex h-7 w-7 items-center justify-center rounded-md bg-primary text-primary-foreground text-xs font-bold">
              AI
            </div>
            <span className="font-display text-base font-semibold tracking-tight">
              {systemName}
            </span>
          </Link>
          <nav className="flex items-center gap-2">
            <Button variant="ghost" size="sm" asChild>
              <Link href="/guide">安装指南</Link>
            </Button>
            {mounted && user ? (
              <Button size="sm" asChild>
                <Link href="/dashboard">
                  进入控制台 <ArrowRight className="h-3.5 w-3.5" />
                </Link>
              </Button>
            ) : (
              <>
                <Button variant="ghost" size="sm" asChild>
                  <Link href="/login">登录</Link>
                </Button>
                {status?.register_enabled !== false && (
                  <Button size="sm" asChild>
                    <Link href="/register">注册</Link>
                  </Button>
                )}
              </>
            )}
          </nav>
        </div>
      </header>

      {/* ── Hero ── */}
      <section className="mx-auto max-w-6xl px-6 py-24 text-center lg:py-32">
        <h1 className="mx-auto max-w-3xl font-display text-4xl font-bold leading-tight tracking-tight sm:text-5xl lg:text-6xl">
          统一的 AI API
          <br />
          <span className="text-primary">接入平台</span>
        </h1>
        <p className="mx-auto mt-6 max-w-xl text-lg text-muted-foreground leading-relaxed">
          一个 API 密钥，访问所有主流大语言模型。
          兼容 OpenAI 格式，透明定价，开箱即用。
        </p>
        <div className="mt-10 flex items-center justify-center gap-3">
          {mounted && user ? (
            <Button size="lg" asChild>
              <Link href="/dashboard">
                打开控制台 <ArrowRight className="h-4 w-4" />
              </Link>
            </Button>
          ) : (
            <>
              <Button size="lg" asChild>
                <Link href="/register">
                  免费开始 <ArrowRight className="h-4 w-4" />
                </Link>
              </Button>
              <Button variant="outline" size="lg" asChild>
                <Link href="/login">登录</Link>
              </Button>
            </>
          )}
        </div>

        {/* API 示例 */}
        <div className="mx-auto mt-16 max-w-2xl overflow-hidden rounded-lg border border-border bg-card text-left shadow-card">
          <div className="flex items-center gap-2 border-b border-border bg-muted/50 px-4 py-2">
            <div className="h-2.5 w-2.5 rounded-full bg-destructive/50" />
            <div className="h-2.5 w-2.5 rounded-full bg-warning/50" />
            <div className="h-2.5 w-2.5 rounded-full bg-success/50" />
            <span className="ml-2 text-caption text-muted-foreground">cURL</span>
          </div>
          <pre className="overflow-x-auto p-5 font-mono text-sm leading-relaxed text-foreground/90">
            <code>{`curl ${apiUrl}/v1/chat/completions \\
  -H "Authorization: Bearer sk-your-key" \\
  -H "Content-Type: application/json" \\
  -d '{
    "model": "gpt-4o",
    "messages": [{"role": "user", "content": "Hello!"}]
  }'`}</code>
          </pre>
        </div>
      </section>

      {/* ── Features Grid ── */}
      <section className="border-t border-border bg-muted/20">
        <div className="mx-auto max-w-6xl px-6 py-20 lg:py-24">
          <div className="text-center">
            <h2 className="font-display text-2xl font-bold sm:text-3xl">核心能力</h2>
            <p className="mt-3 text-muted-foreground">为开发者设计的 AI 中枢</p>
          </div>
          <div className="mt-12 grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {features.map((f) => {
              const Icon = f.icon;
              return (
                <Card key={f.title} className="transition-shadow duration-150 hover:shadow-card-hover">
                  <CardContent className="p-6">
                    <div className="mb-4 flex h-10 w-10 items-center justify-center rounded-md bg-primary/8">
                      <Icon className="h-5 w-5 text-primary" strokeWidth={1.5} />
                    </div>
                    <h3 className="font-display text-lg font-semibold">{f.title}</h3>
                    <p className="mt-2 text-sm text-muted-foreground leading-relaxed">{f.desc}</p>
                  </CardContent>
                </Card>
              );
            })}
          </div>
        </div>
      </section>

      {/* ── CTA ── */}
      <section className="border-t border-border">
        <div className="mx-auto max-w-6xl px-6 py-20 text-center lg:py-24">
          <h2 className="font-display text-2xl font-bold sm:text-3xl">
            准备开始了吗？
          </h2>
          <p className="mt-3 text-muted-foreground">
            注册即可获取 API 密钥，即刻接入
          </p>
          <div className="mt-8 flex items-center justify-center gap-3">
            <Button size="lg" asChild>
              <Link href="/register">
                创建账户 <ArrowRight className="h-4 w-4" />
              </Link>
            </Button>
            <Button variant="outline" size="lg" asChild>
              <Link href="/pricing">查看定价</Link>
            </Button>
          </div>
        </div>
      </section>

      {/* ── Footer ── */}
      <footer className="border-t border-border bg-muted/30">
        <div className="mx-auto max-w-6xl px-6 py-8">
          <div className="flex flex-col items-center justify-between gap-4 sm:flex-row">
            <div className="flex items-center gap-2">
              <div className="flex h-6 w-6 items-center justify-center rounded bg-primary text-primary-foreground text-[10px] font-bold">
                AI
              </div>
              <span className="text-sm text-muted-foreground">{systemName}</span>
            </div>
            <p className="text-caption text-muted-foreground">
              Powered by vx:aimiertao
            </p>
          </div>
        </div>
      </footer>
    </div>
  );
}
