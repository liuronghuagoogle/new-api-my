import "./globals.css";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "用户控制台",
  description: "AI 平台用户管理端",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="zh-CN" className="dark">
      <body className="min-h-screen bg-background text-foreground">
        {children}
      </body>
    </html>
  );
}
