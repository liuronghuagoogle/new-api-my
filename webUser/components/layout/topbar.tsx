"use client";

import React from "react";
import NotificationButton from "@/components/layout/notification-button";
import UserDropdown from "@/components/layout/user-dropdown";

interface TopbarProps {
  title?: string;
  description?: string;
}

export default function Topbar({ title, description }: TopbarProps) {
  return (
    <header className="flex h-14 items-center justify-between border-b border-border bg-background/80 px-6 backdrop-blur-sm">
      {/* Left: Page info */}
      <div className="flex items-center gap-4">
        {title && (
          <div>
            <h1 className="font-display text-lg font-semibold leading-tight">{title}</h1>
            {description && (
              <p className="text-caption text-muted-foreground">{description}</p>
            )}
          </div>
        )}
      </div>

      {/* Right: Actions */}
      <div className="flex items-center gap-2">
        {/* 搜索功能预留，后续扩展时取消注释
        <div className="relative hidden md:block">
          <Search className="absolute left-2.5 top-1/2 h-3.5 w-3.5 -translate-y-1/2 text-muted-foreground" />
          <Input placeholder="搜索..." className="h-8 w-56 bg-muted/50 pl-8 text-body-sm" />
        </div>
        */}
        <NotificationButton />
        <UserDropdown />
      </div>
    </header>
  );
}
