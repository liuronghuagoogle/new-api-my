import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "重置密码",
  description: "通过邮箱验证重置您的 AI 发财网账户密码。",
  robots: { index: false, follow: false },
};

export default function ResetLayout({ children }: { children: React.ReactNode }) {
  return children;
}
