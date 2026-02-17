import { Button } from "@/components/ui/button";

export default function UsageCard() {
  return (
    <div className="rounded-2xl border border-border bg-card/90 p-6 shadow-sm">
      <div className="flex items-center justify-between">
        <div>
          <div className="text-xs uppercase tracking-[0.2em] text-mutedForeground">
            本月用量
          </div>
          <div className="mt-2 text-3xl font-semibold">68,240</div>
          <p className="mt-2 text-sm text-mutedForeground">
            已消耗 ¥ 1,820，预算剩余 34%
          </p>
        </div>
        <Button variant="outline">查看明细</Button>
      </div>

      <div className="mt-6 h-2 w-full rounded-full bg-muted">
        <div className="h-2 w-[66%] rounded-full bg-foreground" />
      </div>

      <div className="mt-4 flex items-center justify-between text-xs text-mutedForeground">
        <span>已用 66%</span>
        <span>预算 ¥2,760</span>
      </div>
    </div>
  );
}
