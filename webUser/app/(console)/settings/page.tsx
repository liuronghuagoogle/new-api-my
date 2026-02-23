"use client";

import React, { useState, useEffect } from "react";
import Link from "next/link";
import Topbar from "@/components/layout/topbar";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Separator } from "@/components/ui/separator";
import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui/tabs";
import {
  User, Shield, Bell, Key, Mail, Lock,
  Globe, Check, Loader2, ExternalLink,
} from "lucide-react";
import { useAuth } from "@/components/auth/auth-provider";
import { updatePassword, updateEmail } from "@/lib/api-hooks";

/** 将后端 role 数字映射为中文标签 */
function getRoleLabel(role: number): string {
  switch (role) {
    case 0:
      return "访客";
    case 1:
      return "普通用户";
    case 10:
      return "管理员";
    case 100:
      return "超级管理员";
    default:
      return "未知角色";
  }
}

/** 将后端 role 数字映射为 Badge variant */
function getRoleBadgeVariant(role: number): "default" | "secondary" | "outline" | "destructive" {
  switch (role) {
    case 100:
      return "destructive";
    case 10:
      return "default";
    default:
      return "outline";
  }
}

export default function SettingsPage() {
  const { user, refreshUser } = useAuth();

  // ── 邮箱 ──
  const [email, setEmail] = useState("");
  const [emailLoading, setEmailLoading] = useState(false);
  const [emailSuccess, setEmailSuccess] = useState(false);
  const [emailError, setEmailError] = useState("");

  // ── 密码 ──
  const [currentPassword, setCurrentPassword] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [passwordLoading, setPasswordLoading] = useState(false);
  const [passwordSuccess, setPasswordSuccess] = useState(false);
  const [passwordError, setPasswordError] = useState("");

  // 初始化邮箱值
  useEffect(() => {
    if (user?.email) {
      setEmail(user.email);
    }
  }, [user?.email]);

  // ── 邮箱更新 ──
  async function handleUpdateEmail() {
    setEmailError("");
    setEmailSuccess(false);

    const trimmed = email.trim();
    if (!trimmed) {
      setEmailError("请输入邮箱地址");
      return;
    }

    setEmailLoading(true);
    try {
      await updateEmail(trimmed);
      await refreshUser();
      setEmailSuccess(true);
      setTimeout(() => setEmailSuccess(false), 3000);
    } catch (err: unknown) {
      setEmailError(err instanceof Error ? err.message : "更新邮箱失败");
    } finally {
      setEmailLoading(false);
    }
  }

  // ── 密码更新 ──
  async function handleUpdatePassword() {
    setPasswordError("");
    setPasswordSuccess(false);

    if (!currentPassword) {
      setPasswordError("请输入当前密码");
      return;
    }
    if (!newPassword) {
      setPasswordError("请输入新密码");
      return;
    }
    if (newPassword.length < 8) {
      setPasswordError("新密码长度不能少于 8 个字符");
      return;
    }
    if (newPassword !== confirmPassword) {
      setPasswordError("两次输入的新密码不一致");
      return;
    }

    setPasswordLoading(true);
    try {
      await updatePassword({
        original_password: currentPassword,
        new_password: newPassword,
      });
      setPasswordSuccess(true);
      setCurrentPassword("");
      setNewPassword("");
      setConfirmPassword("");
      setTimeout(() => setPasswordSuccess(false), 3000);
    } catch (err: unknown) {
      setPasswordError(err instanceof Error ? err.message : "修改密码失败");
    } finally {
      setPasswordLoading(false);
    }
  }

  // 头像显示用户名首字母
  const avatarLetter = user?.username?.charAt(0)?.toUpperCase() || "U";
  const displayName = user?.display_name || user?.username || "用户";
  const displayEmail = user?.email || "未设置邮箱";
  const displayGroup = user?.group || "default";
  const displayRole = getRoleLabel(user?.role ?? 1);
  const roleBadgeVariant = getRoleBadgeVariant(user?.role ?? 1);

  return (
    <>
      <Topbar title="个人设置" description="管理账户、安全和偏好设置" />
      <div className="flex-1 overflow-y-auto scrollbar-thin">
        <div className="mx-auto max-w-4xl space-y-6 px-6 py-6">

          {/* Profile Header */}
          <Card>
            <CardContent className="p-6">
              <div className="flex items-start gap-4">
                <div className="flex h-16 w-16 items-center justify-center rounded-full bg-primary/10 font-display text-heading-2 font-semibold text-primary">
                  {avatarLetter}
                </div>
                <div className="flex-1">
                  <h2 className="font-display text-heading-3 font-semibold">{displayName}</h2>
                  <p className="text-body-sm text-muted-foreground">{displayEmail}</p>
                  <div className="mt-2 flex items-center gap-2">
                    <Badge variant="secondary">{displayGroup}</Badge>
                    <Badge variant={roleBadgeVariant}>{displayRole}</Badge>
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>

          {/* Settings Tabs */}
          <Tabs defaultValue="account">
            <TabsList>
              <TabsTrigger value="account" className="gap-1.5">
                <User className="h-3.5 w-3.5" /> 账户
              </TabsTrigger>
              <TabsTrigger value="security" className="gap-1.5">
                <Shield className="h-3.5 w-3.5" /> 安全
              </TabsTrigger>
              <TabsTrigger value="notifications" className="gap-1.5">
                <Bell className="h-3.5 w-3.5" /> 通知
              </TabsTrigger>
            </TabsList>

            {/* Account */}
            <TabsContent value="account" className="space-y-6">
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <Mail className="h-4 w-4 text-muted-foreground" />
                    邮箱
                  </CardTitle>
                  <CardDescription>用于账户恢复和通知的邮箱地址</CardDescription>
                </CardHeader>
                <CardContent className="space-y-3">
                  <div className="flex items-center gap-3">
                    <Input
                      value={email}
                      onChange={(e) => {
                        setEmail(e.target.value);
                        setEmailError("");
                        setEmailSuccess(false);
                      }}
                      placeholder="请输入邮箱地址"
                      className="max-w-sm"
                    />
                    <Button
                      variant="outline"
                      size="sm"
                      onClick={handleUpdateEmail}
                      disabled={emailLoading}
                    >
                      {emailLoading && <Loader2 className="mr-1.5 h-3.5 w-3.5 animate-spin" />}
                      更新
                    </Button>
                  </div>
                  {emailSuccess && (
                    <p className="flex items-center gap-1.5 text-sm text-green-600">
                      <Check className="h-3.5 w-3.5" />
                      邮箱已更新
                    </p>
                  )}
                  {emailError && (
                    <p className="text-sm text-destructive">{emailError}</p>
                  )}
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <Key className="h-4 w-4 text-muted-foreground" />
                    API 令牌
                  </CardTitle>
                  <CardDescription>用于程序化访问的 API 密钥</CardDescription>
                </CardHeader>
                <CardContent>
                  <div className="flex items-center justify-between rounded-md bg-muted/50 px-4 py-3">
                    <div>
                      <p className="text-sm font-medium">管理 API 令牌</p>
                      <p className="text-caption text-muted-foreground">
                        在令牌管理页面创建和管理您的 API 密钥
                      </p>
                    </div>
                    <Link href="/tokens">
                      <Button variant="outline" size="sm" className="gap-1.5">
                        前往管理 <ExternalLink className="h-3.5 w-3.5" />
                      </Button>
                    </Link>
                  </div>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <Globe className="h-4 w-4 text-muted-foreground" />
                    偏好设置
                  </CardTitle>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-sm font-medium">语言</p>
                      <p className="text-caption text-muted-foreground">控制台显示语言</p>
                    </div>
                    <select className="rounded-md border border-border bg-transparent px-3 py-1.5 text-sm">
                      <option>English</option>
                      <option>中文</option>
                      <option>日本語</option>
                    </select>
                  </div>
                </CardContent>
              </Card>
            </TabsContent>

            {/* Security */}
            <TabsContent value="security" className="space-y-6">
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <Lock className="h-4 w-4 text-muted-foreground" />
                    修改密码
                  </CardTitle>
                </CardHeader>
                <CardContent className="space-y-3">
                  <div className="max-w-sm space-y-3">
                    <div className="space-y-1">
                      <label className="text-sm font-medium">当前密码</label>
                      <Input
                        type="password"
                        value={currentPassword}
                        onChange={(e) => {
                          setCurrentPassword(e.target.value);
                          setPasswordError("");
                          setPasswordSuccess(false);
                        }}
                        placeholder="请输入当前密码"
                      />
                    </div>
                    <div className="space-y-1">
                      <label className="text-sm font-medium">新密码</label>
                      <Input
                        type="password"
                        value={newPassword}
                        onChange={(e) => {
                          setNewPassword(e.target.value);
                          setPasswordError("");
                          setPasswordSuccess(false);
                        }}
                        placeholder="至少 8 个字符"
                      />
                    </div>
                    <div className="space-y-1">
                      <label className="text-sm font-medium">确认新密码</label>
                      <Input
                        type="password"
                        value={confirmPassword}
                        onChange={(e) => {
                          setConfirmPassword(e.target.value);
                          setPasswordError("");
                          setPasswordSuccess(false);
                        }}
                        placeholder="再次输入新密码"
                      />
                    </div>
                    {passwordSuccess && (
                      <p className="flex items-center gap-1.5 text-sm text-green-600">
                        <Check className="h-3.5 w-3.5" />
                        密码已更新
                      </p>
                    )}
                    {passwordError && (
                      <p className="text-sm text-destructive">{passwordError}</p>
                    )}
                    <Button
                      size="sm"
                      onClick={handleUpdatePassword}
                      disabled={passwordLoading}
                    >
                      {passwordLoading && <Loader2 className="mr-1.5 h-3.5 w-3.5 animate-spin" />}
                      更新密码
                    </Button>
                  </div>
                </CardContent>
              </Card>
            </TabsContent>

            {/* Notifications */}
            <TabsContent value="notifications" className="space-y-6">
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <Bell className="h-4 w-4 text-muted-foreground" />
                    通知设置
                  </CardTitle>
                  <CardDescription>配置接收通知的方式和条件</CardDescription>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="max-w-sm space-y-3">
                    <div className="space-y-1">
                      <label className="text-sm font-medium">余额不足预警阈值</label>
                      <Input type="number" defaultValue="10" placeholder="金额（美元）" />
                      <p className="text-caption text-muted-foreground">余额低于此金额时发送通知</p>
                    </div>
                  </div>

                  <Separator />

                  <div className="space-y-3">
                    <p className="text-sm font-medium">通知方式</p>
                    {[
                      { name: "邮箱", desc: "通过邮件接收通知" },
                      { name: "Webhook", desc: "发送通知到自定义 URL" },
                    ].map((m) => (
                      <div key={m.name} className="flex items-center justify-between rounded-md bg-muted/50 px-4 py-3">
                        <div>
                          <p className="text-sm font-medium">{m.name}</p>
                          <p className="text-caption text-muted-foreground">{m.desc}</p>
                        </div>
                        <Button variant="outline" size="sm">配置</Button>
                      </div>
                    ))}
                  </div>
                </CardContent>
              </Card>
            </TabsContent>
          </Tabs>

        </div>
      </div>
    </>
  );
}
