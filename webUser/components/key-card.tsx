import { Button } from "@/components/ui/button";

export default function KeyCard() {
  return (
    <div className="rounded-2xl border border-border bg-card/90 p-6 shadow-sm">
      <div className="flex items-center justify-between">
        <div>
          <div className="text-xs uppercase tracking-[0.2em] text-mutedForeground">
            当前密钥
          </div>
          <div className="mt-3 text-lg font-semibold">sk-live-9m2b-••••••••••</div>
          <p className="mt-2 text-sm text-mutedForeground">
            最近使用：2 分钟前 · 权限：全模型
          </p>
        </div>
        <Button variant="outline">复制</Button>
      </div>
    </div>
  );
}
