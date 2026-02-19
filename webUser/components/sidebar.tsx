"use client";

import {
  Bell,
  Boxes,
  CreditCard,
  Gauge,
  KeyRound,
  LogOut,
  MessageSquareText,
  Settings,
  Users,
} from "lucide-react";
import { cn } from "@/lib/utils";

const mainNav = [
  { label: "仪表盘", icon: Gauge, active: true, hint: "总览" },
  { label: "对话", icon: MessageSquareText, hint: "Chat" },
  { label: "API Keys", icon: KeyRound, hint: "凭证" },
  { label: "用量", icon: Boxes, hint: "Usage" },
  { label: "账单", icon: CreditCard, hint: "Billing" },
  { label: "团队", icon: Users, hint: "Members" },
];

const bottomNav = [
  { label: "通知", icon: Bell },
  { label: "设置", icon: Settings },
  { label: "退出", icon: LogOut },
];

export default function Sidebar() {
  return (
    <aside className="hidden h-screen w-[292px] flex-col border-r border-border/70 bg-panel/80 p-5 backdrop-blur xl:flex">
      <div className="surface-card p-4">
        <div className="flex items-center gap-3">
          <div className="flex h-11 w-11 items-center justify-center rounded-2xl border border-border/70 bg-elevated text-[11px] font-semibold tracking-[0.16em] text-foreground">
            CL
          </div>
          <div>
            <p className="text-[11px] uppercase tracking-[0.18em] text-mutedForeground">Workspace</p>
            <h2 className="mt-1 text-base font-semibold tracking-tight">Claude Console</h2>
          </div>
        </div>
      </div>

      <div className="mt-6 rounded-2xl border border-border/65 bg-card/65 p-2">
        <div className="grid grid-cols-2 gap-2 text-xs">
          <button className="rounded-xl border border-border/70 bg-elevated px-3 py-2 text-left text-foreground">
            <div className="text-[10px] uppercase tracking-[0.16em] text-mutedForeground">Plan</div>
            <div className="mt-1 font-medium">Pro</div>
          </button>
          <button className="rounded-xl border border-border/70 bg-elevated px-3 py-2 text-left text-foreground">
            <div className="text-[10px] uppercase tracking-[0.16em] text-mutedForeground">Region</div>
            <div className="mt-1 font-medium">Global</div>
          </button>
        </div>
      </div>

      <div className="mt-7 px-1 text-[11px] uppercase tracking-[0.2em] text-mutedForeground">Navigation</div>
      <nav className="mt-3 flex flex-col gap-1.5">
        {mainNav.map((item) => (
          <button
            key={item.label}
            className={cn(
              "group flex items-center justify-between rounded-xl border border-transparent px-3.5 py-2.5 text-left transition-all",
              item.active
                ? "border-border/70 bg-card text-foreground shadow-[0_1px_2px_rgba(39,28,19,0.08)]"
                : "text-mutedForeground hover:border-border/55 hover:bg-card/75 hover:text-foreground"
            )}
          >
            <span className="flex items-center gap-3 text-sm">
              <item.icon className={cn("h-4 w-4", item.active ? "text-foreground" : "text-mutedForeground group-hover:text-foreground")} />
              {item.label}
            </span>
            <span className="rounded-md bg-muted/50 px-1.5 py-0.5 text-[10px] uppercase tracking-[0.12em] text-mutedForeground">
              {item.hint}
            </span>
          </button>
        ))}
      </nav>

      <div className="mt-auto rounded-2xl border border-border/65 bg-card/70 p-3">
        <div className="mb-2 px-1 text-[11px] uppercase tracking-[0.18em] text-mutedForeground">System</div>
        <nav className="flex flex-col gap-1">
          {bottomNav.map((item) => (
            <button
              key={item.label}
              className="flex items-center gap-3 rounded-xl px-3 py-2 text-sm text-mutedForeground transition-colors hover:bg-muted/65 hover:text-foreground"
            >
              <item.icon className="h-4 w-4" />
              {item.label}
            </button>
          ))}
        </nav>
      </div>
    </aside>
  );
}
