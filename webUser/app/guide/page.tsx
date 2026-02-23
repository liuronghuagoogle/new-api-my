"use client";

import React, { useState, useCallback } from "react";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui/tabs";
import { useAuth } from "@/components/auth/auth-provider";
import {
  ArrowLeft,
  Monitor,
  Apple,
  Copy,
  Check,
  Info,
  AlertTriangle,
  BookOpen,
  Terminal,
  Settings,
  CheckCircle2,
  Download,
  FileCode,
  ShieldCheck,
} from "lucide-react";

/* ── 复制按钮 ── */
function CopyButton({ text }: { text: string }) {
  const [copied, setCopied] = useState(false);

  const handleCopy = useCallback(async () => {
    try {
      await navigator.clipboard.writeText(text);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch {
      // fallback
      const ta = document.createElement("textarea");
      ta.value = text;
      ta.style.position = "fixed";
      ta.style.opacity = "0";
      document.body.appendChild(ta);
      ta.select();
      document.execCommand("copy");
      document.body.removeChild(ta);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    }
  }, [text]);

  return (
    <button
      onClick={handleCopy}
      className="flex items-center gap-1 rounded px-2 py-1 text-xs text-slate-400 transition-colors hover:bg-white/10 hover:text-white cursor-pointer"
    >
      {copied ? (
        <>
          <Check className="h-3 w-3 text-emerald-400" />
          <span className="text-emerald-400">已复制</span>
        </>
      ) : (
        <>
          <Copy className="h-3 w-3" />
          <span>复制</span>
        </>
      )}
    </button>
  );
}

/* ── 代码块 ── */
function CodeBlock({ label, code }: { label: string; code: string }) {
  return (
    <div className="my-4 overflow-hidden rounded-lg border border-border">
      <div className="flex items-center justify-between bg-slate-900 px-4 py-2">
        <span className="font-mono text-xs text-slate-400">{label}</span>
        <CopyButton text={code} />
      </div>
      <pre className="overflow-x-auto bg-slate-950 p-4 font-mono text-sm leading-relaxed text-slate-200">
        <code>{code}</code>
      </pre>
    </div>
  );
}

/* ── 提示框 ── */
function Alert({
  type,
  children,
}: {
  type: "info" | "warning";
  children: React.ReactNode;
}) {
  const isInfo = type === "info";
  return (
    <div
      className={`my-4 flex gap-3 rounded-lg border-l-[3px] p-4 text-sm leading-relaxed ${
        isInfo
          ? "border-l-blue-500 bg-blue-50 text-blue-900 dark:bg-blue-950/30 dark:text-blue-200"
          : "border-l-amber-500 bg-amber-50 text-amber-900 dark:bg-amber-950/30 dark:text-amber-200"
      }`}
    >
      {isInfo ? (
        <Info className="mt-0.5 h-4 w-4 shrink-0 text-blue-500" />
      ) : (
        <AlertTriangle className="mt-0.5 h-4 w-4 shrink-0 text-amber-500" />
      )}
      <div>{children}</div>
    </div>
  );
}

/* ── 步骤卡片 ── */
function StepCard({
  number,
  icon: Icon,
  title,
  description,
  children,
}: {
  number: number;
  icon: React.ElementType;
  title: string;
  description: string;
  children: React.ReactNode;
}) {
  return (
    <div className="rounded-lg border border-border bg-card p-6 shadow-card">
      <div className="mb-4 flex items-start gap-4">
        <div className="flex h-8 w-8 shrink-0 items-center justify-center rounded-md bg-primary text-sm font-bold text-primary-foreground">
          {number}
        </div>
        <div className="flex-1">
          <div className="flex items-center gap-2">
            <Icon className="h-5 w-5 text-primary" strokeWidth={1.5} />
            <h2 className="text-lg font-semibold">{title}</h2>
          </div>
          <p className="mt-1 text-sm text-muted-foreground">{description}</p>
        </div>
      </div>
      <div className="ml-12">{children}</div>
    </div>
  );
}

/* ── Windows 步骤 ── */
function WindowsGuide({ baseUrl }: { baseUrl: string }) {
  return (
    <div className="space-y-5">
      <StepCard
        number={1}
        icon={Download}
        title="检查 Git 安装"
        description="Git 是版本控制工具，Claude Code 依赖它来管理代码。首先验证系统是否已安装。"
      >
        <CodeBlock label="PowerShell / CMD" code="git --version" />
        <Alert type="info">
          <strong>如果显示版本号：</strong>说明已安装，可跳过此步骤
          <br />
          <strong>如果提示未找到命令：</strong>请访问{" "}
          <a href="https://git-scm.com/download/win" target="_blank" rel="noopener" className="font-medium underline underline-offset-2">
            Git 官网
          </a>{" "}
          下载安装
        </Alert>
      </StepCard>

      <StepCard
        number={2}
        icon={Download}
        title="安装 Node.js"
        description="Node.js 是 JavaScript 运行环境，Claude Code 基于此构建。要求版本 >= 18"
      >
        <Alert type="warning">
          <strong>重要提示：</strong>Node.js 版本必须大于或等于 18。如果已安装旧版本，请升级到最新 LTS 版本。
        </Alert>
        <p className="mt-3 text-sm text-muted-foreground">
          访问{" "}
          <a href="https://nodejs.org/" target="_blank" rel="noopener" className="font-medium text-primary underline underline-offset-2">
            Node.js 官网
          </a>{" "}
          下载 LTS 版本安装包
        </p>
      </StepCard>

      <StepCard
        number={3}
        icon={CheckCircle2}
        title="验证 Node.js 安装"
        description="确认 Node.js 和 npm 已正确安装"
      >
        <CodeBlock label="PowerShell / CMD" code={`node --version\nnpm --version`} />
        <Alert type="warning">
          <strong>PowerShell 执行策略问题：</strong>如果 PowerShell 执行 npm 时被拦截，请先运行：
        </Alert>
        <CodeBlock
          label="PowerShell (管理员权限)"
          code="Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"
        />
      </StepCard>

      <StepCard
        number={4}
        icon={Terminal}
        title="安装 Claude Code"
        description="使用 npm 全局安装 Claude Code CLI 工具"
      >
        <CodeBlock
          label="PowerShell / CMD"
          code="npm install -g @anthropic-ai/claude-code --registry=https://registry.npmmirror.com"
        />
        <Alert type="info">
          命令使用国内镜像源 (npmmirror.com) 以提高下载速度
        </Alert>
      </StepCard>

      <StepCard
        number={5}
        icon={Settings}
        title="配置环境变量"
        description="设置中转站地址和 API 密钥，三种方式任选其一"
      >
        <h3 className="mb-2 text-sm font-semibold">临时配置（仅当前会话）- PowerShell</h3>
        <CodeBlock
          label="PowerShell"
          code={`$env:ANTHROPIC_BASE_URL = "${baseUrl}"\n$env:ANTHROPIC_AUTH_TOKEN = "你的API密钥"`}
        />

        <h3 className="mb-2 mt-6 text-sm font-semibold">永久配置（用户级）- PowerShell</h3>
        <CodeBlock
          label="PowerShell"
          code={`[System.Environment]::SetEnvironmentVariable("ANTHROPIC_BASE_URL","${baseUrl}",[System.EnvironmentVariableTarget]::User)\n[System.Environment]::SetEnvironmentVariable("ANTHROPIC_AUTH_TOKEN","你的API密钥",[System.EnvironmentVariableTarget]::User)`}
        />

        <h3 className="mb-2 mt-6 text-sm font-semibold">永久配置（用户级）- CMD</h3>
        <CodeBlock
          label="CMD"
          code={`setx ANTHROPIC_BASE_URL "${baseUrl}"\nsetx ANTHROPIC_AUTH_TOKEN "你的API密钥"`}
        />

        <Alert type="warning">
          <strong>重要：</strong>配置完成后，需要重新打开 PowerShell 或 CMD 窗口，环境变量才会生效
        </Alert>

        <Alert type="info">
          请将 <code className="rounded bg-muted px-1.5 py-0.5 font-mono text-xs">你的API密钥</code> 替换为在控制台「API 密钥」页面中创建的实际密钥
        </Alert>
      </StepCard>

      <StepCard
        number={6}
        icon={FileCode}
        title="VSCode 插件配置"
        description="如果使用 VSCode 的 Claude 插件，需要配置 config.json 文件"
      >
        <p className="mb-3 text-sm text-muted-foreground">
          配置文件路径：<code className="rounded bg-muted px-1.5 py-0.5 font-mono text-xs">C:\Users\你的用户名\.claude\config.json</code>
          （如果文件不存在，请手动创建）
        </p>
        <CodeBlock
          label="JSON"
          code={`{\n  "primaryApiKey": "你的API密钥",\n  "customBaseUrl": "${baseUrl}"\n}`}
        />
      </StepCard>

      <StepCard
        number={7}
        icon={ShieldCheck}
        title="验证安装"
        description="确认 Claude Code 已正确安装并配置"
      >
        <h3 className="mb-2 text-sm font-semibold">PowerShell 验证</h3>
        <CodeBlock
          label="PowerShell"
          code={`claude --version\necho $env:ANTHROPIC_BASE_URL\necho $env:ANTHROPIC_AUTH_TOKEN`}
        />
        <h3 className="mb-2 mt-4 text-sm font-semibold">CMD 验证</h3>
        <CodeBlock
          label="CMD"
          code={`claude --version\necho %ANTHROPIC_BASE_URL%\necho %ANTHROPIC_AUTH_TOKEN%`}
        />
        <Alert type="info">
          <strong>验证成功标志：</strong>
          <br />
          &bull; claude --version 显示版本号
          <br />
          &bull; BASE_URL 显示 {baseUrl}
          <br />
          &bull; AUTH_TOKEN 显示您的 API 密钥
        </Alert>
      </StepCard>
    </div>
  );
}

/* ── macOS 步骤 ── */
function MacOSGuide({ baseUrl }: { baseUrl: string }) {
  return (
    <div className="space-y-5">
      <StepCard
        number={1}
        icon={Download}
        title="检查 Git 安装"
        description="macOS 通常已预装 Git，首先验证是否存在"
      >
        <CodeBlock label="Terminal" code="git --version" />
        <Alert type="info">
          <strong>如果显示版本号：</strong>说明已安装，可跳过此步骤
          <br />
          <strong>如果提示未找到命令：</strong>使用 Homebrew 安装
        </Alert>
        <CodeBlock label="Terminal (使用 Homebrew)" code="brew install git" />
        <p className="mt-2 text-sm text-muted-foreground">
          如果没有 Homebrew，请先访问{" "}
          <a href="https://brew.sh/zh-cn/" target="_blank" rel="noopener" className="font-medium text-primary underline underline-offset-2">
            brew.sh
          </a>{" "}
          安装
        </p>
      </StepCard>

      <StepCard
        number={2}
        icon={Download}
        title="安装 Node.js"
        description="使用 Homebrew 或官网安装 Node.js。要求版本 >= 18"
      >
        <h3 className="mb-2 text-sm font-semibold">方法 1：使用 Homebrew（推荐）</h3>
        <CodeBlock label="Terminal" code="brew install node" />
        <h3 className="mb-2 mt-4 text-sm font-semibold">方法 2：官网下载</h3>
        <p className="text-sm text-muted-foreground">
          访问{" "}
          <a href="https://nodejs.org/" target="_blank" rel="noopener" className="font-medium text-primary underline underline-offset-2">
            Node.js 官网
          </a>
          ，下载 macOS 安装包 (.pkg)
        </p>
      </StepCard>

      <StepCard
        number={3}
        icon={CheckCircle2}
        title="验证 Node.js 安装"
        description="确认 Node.js 和 npm 已正确安装"
      >
        <CodeBlock label="Terminal" code={`node --version\nnpm --version`} />
      </StepCard>

      <StepCard
        number={4}
        icon={Terminal}
        title="安装 Claude Code"
        description="使用 npm 全局安装 Claude Code CLI 工具"
      >
        <CodeBlock label="Terminal" code="npm install -g @anthropic-ai/claude-code" />
      </StepCard>

      <StepCard
        number={5}
        icon={Settings}
        title="配置环境变量"
        description="设置中转站地址和 API 密钥"
      >
        <h3 className="mb-2 text-sm font-semibold">临时配置（仅当前会话）</h3>
        <CodeBlock
          label="Terminal"
          code={`export ANTHROPIC_BASE_URL="${baseUrl}"\nexport ANTHROPIC_AUTH_TOKEN="你的API密钥"`}
        />

        <h3 className="mb-2 mt-6 text-sm font-semibold">永久配置（Shell 配置文件）</h3>
        <p className="mb-3 text-sm text-muted-foreground">
          根据使用的 shell（bash 或 zsh），将以下内容添加到对应配置文件：
        </p>
        <CodeBlock
          label="~/.bash_profile 或 ~/.zshrc"
          code={`export ANTHROPIC_BASE_URL="${baseUrl}"\nexport ANTHROPIC_AUTH_TOKEN="你的API密钥"`}
        />
        <p className="mt-3 text-sm text-muted-foreground">保存后执行以下命令使配置生效：</p>
        <CodeBlock
          label="Terminal"
          code="source ~/.zshrc  # 或 source ~/.bash_profile"
        />

        <Alert type="info">
          请将 <code className="rounded bg-muted px-1.5 py-0.5 font-mono text-xs">你的API密钥</code> 替换为在控制台「API 密钥」页面中创建的实际密钥
        </Alert>
      </StepCard>

      <StepCard
        number={6}
        icon={FileCode}
        title="VSCode 插件配置"
        description="如果使用 VSCode 的 Claude 插件，需要配置 config.json 文件"
      >
        <p className="mb-3 text-sm text-muted-foreground">
          配置文件路径：<code className="rounded bg-muted px-1.5 py-0.5 font-mono text-xs">~/.claude/config.json</code>
          （如果文件不存在，请手动创建）
        </p>
        <CodeBlock
          label="JSON"
          code={`{\n  "primaryApiKey": "你的API密钥",\n  "customBaseUrl": "${baseUrl}"\n}`}
        />
      </StepCard>

      <StepCard
        number={7}
        icon={ShieldCheck}
        title="验证安装"
        description="确认 Claude Code 已正确安装并配置"
      >
        <CodeBlock
          label="Terminal"
          code={`claude --version\necho $ANTHROPIC_BASE_URL\necho $ANTHROPIC_AUTH_TOKEN`}
        />
        <Alert type="info">
          <strong>验证成功标志：</strong>
          <br />
          &bull; claude --version 显示版本号
          <br />
          &bull; BASE_URL 显示 {baseUrl}
          <br />
          &bull; AUTH_TOKEN 显示您的 API 密钥
        </Alert>
      </StepCard>
    </div>
  );
}

/* ── 主页面 ── */
export default function GuidePage() {
  const { status } = useAuth();
  const systemName = status?.system_name || "AI 发财网";

  // 使用环境变量中的 API 地址，回退到当前页面域名
  const baseUrl = process.env.NEXT_PUBLIC_API_URL
    || (typeof window !== "undefined" ? window.location.origin : "https://your-domain.com");

  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      <header className="sticky top-0 z-40 border-b border-border bg-background/80 backdrop-blur-sm">
        <div className="mx-auto flex h-14 max-w-4xl items-center justify-between px-6">
          <div className="flex items-center gap-4">
            <Button variant="ghost" size="sm" asChild>
              <Link href="/">
                <ArrowLeft className="h-4 w-4" />
                返回首页
              </Link>
            </Button>
          </div>
          <div className="flex items-center gap-2">
            <BookOpen className="h-4 w-4 text-primary" />
            <span className="text-sm font-medium">{systemName}</span>
          </div>
        </div>
      </header>

      {/* Content */}
      <main className="mx-auto max-w-4xl px-6 py-10">
        {/* Page Header */}
        <div className="mb-8">
          <h1 className="font-display text-3xl font-bold tracking-tight sm:text-4xl">
            Claude Code 安装指南
          </h1>
          <p className="mt-3 text-lg text-muted-foreground">
            快速配置 Claude Code CLI 工具，通过本站中转接入 AI 编程助手
          </p>
        </div>

        {/* Platform Tabs */}
        <Tabs defaultValue="windows">
          <TabsList className="mb-6">
            <TabsTrigger value="windows" className="gap-2">
              <Monitor className="h-4 w-4" />
              Windows
            </TabsTrigger>
            <TabsTrigger value="macos" className="gap-2">
              <Apple className="h-4 w-4" />
              macOS
            </TabsTrigger>
          </TabsList>

          <TabsContent value="windows">
            <WindowsGuide baseUrl={baseUrl} />
          </TabsContent>

          <TabsContent value="macos">
            <MacOSGuide baseUrl={baseUrl} />
          </TabsContent>
        </Tabs>
      </main>

      {/* Footer */}
      <footer className="border-t border-border">
        <div className="mx-auto max-w-4xl px-6 py-6 text-center text-sm text-muted-foreground">
          <p>
            中转站地址：
            <a href={baseUrl} className="font-medium text-primary underline underline-offset-2">
              {baseUrl}
            </a>
          </p>
        </div>
      </footer>
    </div>
  );
}
