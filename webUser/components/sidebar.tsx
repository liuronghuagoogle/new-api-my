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
  { label: "仪表盘", icon: Gauge, active: true },
  { label: "对话", icon: MessageSquareText },
  { label: "API Keys", icon: KeyRound },
  { label: "用量", icon: Boxes },
  { label: "账单", icon: CreditCard },
  { label: "团队", icon: Users },
];

const bottomNav = [
  { label: "通知", icon: Bell },
  { label: "设置", icon: Settings },
  { label: "退出", icon: LogOut },
];

export default function Sidebar() {
  return (
    <aside className="hidden h-full w-64 flex-col border-r border-border bg-background/80 px-5 py-6 backdrop-blur xl:flex">
      <div className="flex items-center gap-2">
        <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-primary text-primaryForeground">
          AI
        </div>
        <div className="text-sm font-semibold tracking-tight">AI Console</div>
      </div>

      <div className="mt-8 flex flex-1 flex-col">
        <div className="text-xs uppercase tracking-[0.2em] text-mutedForeground">
          Overview
        </div>
        <nav className="mt-4 flex flex-col gap-1">
          {mainNav.map((item) => (
            <button
              key={item.label}
              className={cn(
                "flex items-center gap-3 rounded-xl px-3 py-2 text-sm text-mutedForeground transition-colors hover:bg-muted hover:text-foreground",
                item.active &&
                  "bg-muted text-foreground shadow-sm ring-1 ring-border"
              )}
            >
              <item.icon className="h-4 w-4" />
              {item.label}
            </button>
          ))}
        </nav>

        <div className="mt-auto">
          <div className="mb-3 text-xs uppercase tracking-[0.2em] text-mutedForeground">
            Preferences
          </div>
          <nav className="flex flex-col gap-1">
            {bottomNav.map((item) => (
              <button
                key={item.label}
                className="flex items-center gap-3 rounded-xl px-3 py-2 text-sm text-mutedForeground transition-colors hover:bg-muted hover:text-foreground"
              >
                <item.icon className="h-4 w-4" />
                {item.label}
              </button>
            ))}
          </nav>
        </div>
      </div>
    </aside>
  );
}
