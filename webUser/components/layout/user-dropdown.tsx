"use client";

import React from "react";
import { useRouter } from "next/navigation";
import { Settings, KeyRound, Wallet, LogOut, ChevronDown } from "lucide-react";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import {
  DropdownMenu,
  DropdownMenuTrigger,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuSeparator,
  DropdownMenuLabel,
  DropdownMenuGroup,
} from "@/components/ui/dropdown-menu";
import { useAuth } from "@/components/auth/auth-provider";
import { QUOTA_PER_UNIT } from "@/lib/types";

/** 用户名 → 头像背景色（基于字符哈希） */
function stringToColor(str: string): string {
  const colors = [
    "bg-primary/15 text-primary",
    "bg-accent/15 text-accent-foreground",
    "bg-success/15 text-success",
    "bg-warning/15 text-warning",
    "bg-destructive/15 text-destructive",
  ];
  let hash = 0;
  for (let i = 0; i < str.length; i++) {
    hash = str.charCodeAt(i) + ((hash << 5) - hash);
  }
  return colors[Math.abs(hash) % colors.length];
}

/** 格式化额度显示 */
function formatQuota(quota?: number): string {
  if (quota === undefined || quota === null) return "--";
  const usd = quota / QUOTA_PER_UNIT;
  return `$${usd.toFixed(2)}`;
}

export default function UserDropdown() {
  const { user, logout } = useAuth();
  const router = useRouter();

  if (!user) return null;

  const initial = (user.display_name || user.username || "U")[0].toUpperCase();
  const displayName = user.display_name || user.username;
  const colorClass = stringToColor(user.username || "U");

  const handleLogout = async () => {
    await logout();
    router.replace("/login");
  };

  return (
    <DropdownMenu>
      <DropdownMenuTrigger asChild>
        <button className="flex items-center gap-1.5 rounded-full py-1 pl-1 pr-2 transition-colors hover:bg-muted cursor-pointer focus:outline-none focus-visible:ring-2 focus-visible:ring-ring/40">
          <Avatar className="h-7 w-7">
            <AvatarFallback className={`text-xs font-semibold ${colorClass}`}>
              {initial}
            </AvatarFallback>
          </Avatar>
          <span className="hidden text-sm font-medium text-foreground md:inline">
            {displayName}
          </span>
          <ChevronDown className="h-3 w-3 text-muted-foreground" />
        </button>
      </DropdownMenuTrigger>

      <DropdownMenuContent align="end" className="w-56">
        {/* 用户信息头部 */}
        <DropdownMenuLabel className="font-normal">
          <div className="flex flex-col gap-1">
            <p className="text-sm font-medium leading-none">{displayName}</p>
            {user.email && (
              <p className="text-xs text-muted-foreground">{user.email}</p>
            )}
            <p className="text-xs text-muted-foreground">
              余额: {formatQuota(user.quota)}
            </p>
          </div>
        </DropdownMenuLabel>

        <DropdownMenuSeparator />

        <DropdownMenuGroup>
          <DropdownMenuItem onClick={() => router.push("/settings")}>
            <Settings className="h-4 w-4 text-muted-foreground" />
            <span>个人设置</span>
          </DropdownMenuItem>
          <DropdownMenuItem onClick={() => router.push("/tokens")}>
            <KeyRound className="h-4 w-4 text-muted-foreground" />
            <span>令牌管理</span>
          </DropdownMenuItem>
          <DropdownMenuItem onClick={() => router.push("/topup")}>
            <Wallet className="h-4 w-4 text-muted-foreground" />
            <span>钱包充值</span>
          </DropdownMenuItem>
        </DropdownMenuGroup>

        <DropdownMenuSeparator />

        <DropdownMenuItem onClick={handleLogout} className="text-destructive focus:text-destructive">
          <LogOut className="h-4 w-4" />
          <span>退出登录</span>
        </DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenu>
  );
}
