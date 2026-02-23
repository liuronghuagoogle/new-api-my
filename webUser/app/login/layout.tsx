import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "登录",
  description: "登录 AI 发财网，管理您的 API 密钥和用量。",
};

export default function LoginLayout({ children }: { children: React.ReactNode }) {
  return children;
}
