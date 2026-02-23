import "./globals.css";
import type { Metadata } from "next";
import Script from "next/script";
import { Inter, Playfair_Display } from "next/font/google";
import { AuthProvider } from "@/components/auth/auth-provider";

const inter = Inter({
  subsets: ["latin"],
  variable: "--font-inter",
  display: "swap",
});

const playfair = Playfair_Display({
  subsets: ["latin"],
  variable: "--font-playfair",
  display: "swap",
});

const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || process.env.NEXT_PUBLIC_API_URL || "https://ai.facai.cloudns.org";

export const metadata: Metadata = {
  title: {
    default: "AI 发财网 — 统一 AI API 接入平台",
    template: "%s | AI 发财网",
  },
  description:
    "一个 API 密钥访问 40+ 主流大语言模型。兼容 OpenAI 格式，聚合 GPT、Claude、Gemini、DeepSeek 等服务商，透明定价，开箱即用。",
  keywords: [
    "AI API", "OpenAI 代理", "Claude API", "Gemini API", "DeepSeek API",
    "AI 中转", "大语言模型", "LLM API", "API Gateway", "AI 接口",
  ],
  metadataBase: new URL(siteUrl),
  openGraph: {
    type: "website",
    locale: "zh_CN",
    siteName: "AI 发财网",
    title: "AI 发财网 — 统一 AI API 接入平台",
    description: "一个 API 密钥访问 40+ 主流大语言模型。兼容 OpenAI 格式，透明定价，开箱即用。",
  },
  twitter: {
    card: "summary_large_image",
    title: "AI 发财网 — 统一 AI API 接入平台",
    description: "一个 API 密钥访问 40+ 主流大语言模型。兼容 OpenAI 格式，透明定价，开箱即用。",
  },
  robots: {
    index: true,
    follow: true,
  },
  icons: {
    icon: "/favicon.ico",
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="zh-CN" className={`${inter.variable} ${playfair.variable}`}>
      <body className="min-h-screen bg-background font-body text-foreground antialiased">
        <AuthProvider>{children}</AuthProvider>
        {process.env.NEXT_PUBLIC_BAIDU_TONGJI && (
          <Script
            src={`https://hm.baidu.com/hm.js?${process.env.NEXT_PUBLIC_BAIDU_TONGJI}`}
            strategy="afterInteractive"
          />
        )}
      </body>
    </html>
  );
}
