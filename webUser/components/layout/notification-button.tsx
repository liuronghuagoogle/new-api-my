"use client";

import React from "react";
import { Bell } from "lucide-react";
import { Button } from "@/components/ui/button";
import { useAuth } from "@/components/auth/auth-provider";
import { useNotifications } from "@/hooks/use-notifications";
import NoticeModal from "@/components/layout/notice-modal";

export default function NotificationButton() {
  const { status } = useAuth();
  const announcements = status?.announcements || [];

  const {
    noticeVisible,
    unreadCount,
    unreadKeys,
    handleNoticeOpen,
    handleNoticeClose,
    handleCloseTodayNotice,
  } = useNotifications(announcements);

  return (
    <>
      <Button
        variant="ghost"
        size="icon"
        className="relative h-8 w-8"
        onClick={handleNoticeOpen}
        aria-label="系统公告"
      >
        <Bell className="h-4 w-4" />
        {unreadCount > 0 && (
          <span className="absolute -right-0.5 -top-0.5 flex h-4 min-w-4 items-center justify-center rounded-full bg-primary px-1 text-[10px] font-medium text-primary-foreground">
            {unreadCount > 99 ? "99+" : unreadCount}
          </span>
        )}
      </Button>

      <NoticeModal
        visible={noticeVisible}
        onClose={handleNoticeClose}
        onCloseToday={handleCloseTodayNotice}
        announcements={announcements}
        unreadKeys={unreadKeys}
      />
    </>
  );
}
