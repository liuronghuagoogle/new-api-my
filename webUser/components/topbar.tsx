"use client";

import { Bell, Search, Sparkles } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";

export default function Topbar() {
  return (
    <div className="surface-card flex items-center justify-between gap-4 p-4 md:p-5">
      <div>
        <p className="text-xs uppercase tracking-[0.2em] text-mutedForeground">Control Center</p>
        <h1 className="mt-2 text-2xl font-semibold tracking-tight text-foreground md:text-3xl">模型与账号总览</h1>
        <p className="mt-1 text-sm text-mutedForeground">稳定、克制、可追踪的控制台体验</p>
      </div>

      <div className="flex items-center gap-2.5">
        <div className="hidden items-center gap-2 rounded-full border border-border/70 bg-elevated px-4 py-2 text-sm text-mutedForeground lg:flex">
          <Search className="h-4 w-4" />
          <span>搜索模型、API Key、账单…</span>
        </div>
        <button className="hidden items-center gap-2 rounded-full border border-border/70 bg-card px-3.5 py-2 text-sm font-medium text-foreground transition-colors hover:bg-muted/65 md:flex">
          <Sparkles className="h-4 w-4" />
          新建工作流
        </button>
        <Button variant="outline" size="icon" aria-label="通知" className="rounded-full border-border/70 bg-card/80">
          <Bell className="h-4 w-4" />
        </Button>
        <Avatar className="h-9 w-9 ring-1 ring-border/75">
          <AvatarFallback className="bg-muted text-xs font-semibold text-foreground">LU</AvatarFallback>
        </Avatar>
      </div>
    </div>
  );
}
