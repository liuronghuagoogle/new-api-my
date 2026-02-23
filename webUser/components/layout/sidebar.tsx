"use client";

import React from "react";
import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import {
  LayoutDashboard,
  KeyRound,
  FileText,
  Wallet,
  Settings,
  MessageSquareText,
  LogOut,
  Receipt,
  BookOpen,
  ChevronLeft,
  ChevronRight,
} from "lucide-react";
import { cn } from "@/lib/utils";
import { Separator } from "@/components/ui/separator";
import { useAuth } from "@/components/auth/auth-provider";

const navItems = [
  { label: "仪表盘", href: "/dashboard", icon: LayoutDashboard },
  { label: "在线对话", href: "/playground", icon: MessageSquareText },
  { label: "API 密钥", href: "/tokens", icon: KeyRound },
  { label: "用量日志", href: "/logs", icon: FileText },
  { label: "钱包充值", href: "/topup", icon: Wallet },
  { label: "模型定价", href: "/pricing", icon: Receipt },
];

const bottomItems = [
  { label: "安装指南", href: "/guide", icon: BookOpen },
  { label: "个人设置", href: "/settings", icon: Settings },
];

interface SidebarProps {
  collapsed: boolean;
  onToggle: () => void;
}

export default function Sidebar({ collapsed, onToggle }: SidebarProps) {
  const pathname = usePathname();
  const router = useRouter();
  const { logout } = useAuth();

  const handleLogout = async () => {
    await logout();
    router.replace("/login");
  };

  const NavLink = ({ item }: { item: (typeof navItems)[0] }) => {
    const active = pathname === item.href;
    const Icon = item.icon;
    return (
      <Link
        href={item.href}
        className={cn(
          "group flex items-center gap-3 rounded-md px-3 py-2 text-sm font-medium transition-colors duration-150 cursor-pointer",
          active
            ? "bg-primary/8 text-primary"
            : "text-sidebar-muted hover:bg-muted hover:text-foreground",
          collapsed && "justify-center px-2"
        )}
        title={collapsed ? item.label : undefined}
      >
        <Icon
          className={cn(
            "h-[18px] w-[18px] shrink-0",
            active ? "text-primary" : "text-sidebar-muted group-hover:text-foreground"
          )}
          strokeWidth={active ? 2 : 1.5}
        />
        {!collapsed && <span>{item.label}</span>}
      </Link>
    );
  };

  return (
    <aside
      className={cn(
        "sticky top-0 flex h-screen flex-col border-r border-sidebar-border bg-sidebar transition-[width] duration-200",
        collapsed ? "w-16" : "w-64"
      )}
    >
      {/* Logo */}
      <div className={cn("flex h-14 items-center border-b border-sidebar-border", collapsed ? "justify-center px-2" : "px-5")}>
        {!collapsed ? (
          <Link href="/dashboard" className="flex items-center gap-2.5">
            <div className="flex h-7 w-7 items-center justify-center rounded-md bg-primary text-primary-foreground text-xs font-bold">
              AI
            </div>
            <span className="font-display text-base font-semibold tracking-tight">发财网</span>
          </Link>
        ) : (
          <Link href="/dashboard" className="flex h-7 w-7 items-center justify-center rounded-md bg-primary text-primary-foreground text-xs font-bold">
            AI
          </Link>
        )}
      </div>

      {/* Navigation */}
      <nav className="flex flex-1 flex-col gap-1 overflow-y-auto p-3 scrollbar-thin">
        {navItems.map((item) => (
          <NavLink key={item.href} item={item} />
        ))}
      </nav>

      {/* Bottom section */}
      <div className="flex flex-col gap-1 p-3 pt-0">
        <Separator className="mb-2" />
        {bottomItems.map((item) => (
          <NavLink key={item.href} item={item} />
        ))}
        <button
          onClick={handleLogout}
          className={cn(
            collapsed && "justify-center px-2"
          )}
          title={collapsed ? "退出登录" : undefined}
        >
          <LogOut className="h-[18px] w-[18px] shrink-0" strokeWidth={1.5} />
          {!collapsed && <span>退出登录</span>}
        </button>
      </div>

      {/* Collapse toggle */}
      <button
        onClick={onToggle}
        className="flex h-10 items-center justify-center border-t border-sidebar-border text-muted-foreground transition-colors hover:bg-muted hover:text-foreground cursor-pointer"
        aria-label={collapsed ? "展开侧边栏" : "收起侧边栏"}
      >
        {collapsed ? <ChevronRight className="h-4 w-4" /> : <ChevronLeft className="h-4 w-4" />}
      </button>
    </aside>
  );
}
