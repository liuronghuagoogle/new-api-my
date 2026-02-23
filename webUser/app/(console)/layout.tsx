import type { Metadata } from "next";
import ConsoleShell from "@/components/layout/console-shell";

export const metadata: Metadata = {
  title: {
    default: "控制台",
    template: "%s | AI 发财网",
  },
  robots: { index: false, follow: false },
};

export default function ConsoleLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return <ConsoleShell>{children}</ConsoleShell>;
}
