import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Claude Code 安装指南",
  description:
    "Windows / macOS 平台安装 Claude Code CLI 工具，配置中转站地址和 API 密钥的详细步骤指南。",
};

export default function GuideLayout({ children }: { children: React.ReactNode }) {
  return children;
}
