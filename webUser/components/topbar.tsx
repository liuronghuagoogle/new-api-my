"use client";

import { Bell, Search } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";

export default function Topbar() {
  return (
    <div className="flex items-center justify-between gap-4">
      <div>
        <p className="text-sm text-mutedForeground">欢迎回来</p>
        <h1 className="text-2xl font-semibold tracking-tight">用户管理控制台</h1>
      </div>

      <div className="flex items-center gap-3">
        <div className="hidden items-center gap-2 rounded-full border border-border bg-background/70 px-4 py-2 text-sm text-mutedForeground shadow-sm backdrop-blur lg:flex">
          <Search className="h-4 w-4" />
          <span>搜索模型、Key、账单…</span>
        </div>
        <Button variant="ghost" size="icon" aria-label="通知">
          <Bell className="h-4 w-4" />
        </Button>
        <Avatar>
          <AvatarFallback>LU</AvatarFallback>
        </Avatar>
      </div>
    </div>
  );
}
