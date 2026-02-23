"use client";

import React, { useEffect, useState } from "react";
import { useRouter, useSearchParams, useParams } from "next/navigation";
import { Loader2, AlertCircle } from "lucide-react";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import Link from "next/link";
import { handleOAuthCallback } from "@/lib/auth";
import { useAuth } from "@/components/auth/auth-provider";

export default function OAuthCallbackPage() {
  const router = useRouter();
  const params = useParams();
  const searchParams = useSearchParams();
  const { login: setUser } = useAuth();

  const provider = params.provider as string;
  const code = searchParams.get("code") || "";
  const state = searchParams.get("state") || "";

  const [error, setError] = useState("");

  useEffect(() => {
    if (!code || !state || !provider) {
      setError("无效的 OAuth 回调参数");
      return;
    }

    handleOAuthCallback(provider, code, state)
      .then((result) => {
        if (result.message === "bind") {
          router.replace("/settings");
        } else if (result.user) {
          setUser(result.user);
          router.replace("/dashboard");
        }
      })
      .catch((err) => {
        setError(err instanceof Error ? err.message : "OAuth 登录失败");
      });
  }, [code, state, provider, router, setUser]);

  if (error) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-background px-4">
        <Card className="w-full max-w-sm">
          <CardContent className="p-6 space-y-4">
            <div className="flex items-center gap-2 rounded-md bg-destructive/10 px-3 py-2 text-sm text-destructive">
              <AlertCircle className="h-4 w-4 shrink-0" />
              <span>{error}</span>
            </div>
            <Link href="/login">
              <Button variant="outline" className="w-full">返回登录</Button>
            </Link>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="flex min-h-screen items-center justify-center bg-background">
      <div className="flex flex-col items-center gap-3">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
        <p className="text-sm text-muted-foreground">正在验证登录...</p>
      </div>
    </div>
  );
}
