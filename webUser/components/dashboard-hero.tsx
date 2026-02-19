import { ArrowUpRight, ShieldCheck, Sparkles } from "lucide-react";

export default function DashboardHero() {
  return (
    <section className="surface-card overflow-hidden p-7 md:p-8">
      <div className="grid gap-6 lg:grid-cols-[1.35fr_0.65fr] lg:items-end">
        <div>
          <div className="inline-flex items-center gap-2 rounded-full border border-border/70 bg-elevated/80 px-3 py-1 text-xs text-mutedForeground">
            <ShieldCheck className="h-3.5 w-3.5" />
            System Stable · 99.98% uptime
          </div>

          <h2 className="mt-4 max-w-2xl text-3xl font-semibold leading-tight tracking-tight text-foreground md:text-[36px]">
            新一代 API 控制台：统一策略、精细观测、稳定交付
          </h2>

          <p className="mt-3 max-w-xl text-sm leading-6 text-mutedForeground">
            采用低饱和暖灰体系重构视觉层级，强调信息可读性和交互反馈。当前页面数据全部来自前端 mock，便于快速验证体验与布局。
          </p>

          <div className="mt-6 flex flex-wrap gap-2.5">
            <button className="button-primary inline-flex items-center gap-2 transition-all">
              开始部署
              <ArrowUpRight className="h-4 w-4" />
            </button>
            <button className="button-ghost">查看变更日志</button>
          </div>
        </div>

        <div className="rounded-2xl border border-border/65 bg-elevated/80 p-4">
          <div className="flex items-center gap-2 text-xs uppercase tracking-[0.18em] text-mutedForeground">
            <Sparkles className="h-3.5 w-3.5" />
            Today Snapshot
          </div>

          <div className="mt-4 space-y-3">
            {[
              { label: "请求成功率", value: "99.2%" },
              { label: "平均响应", value: "840ms" },
              { label: "预算余量", value: "34%" },
            ].map((item) => (
              <div
                key={item.label}
                className="flex items-center justify-between rounded-xl border border-border/60 bg-card/75 px-3 py-2.5"
              >
                <span className="text-sm text-mutedForeground">{item.label}</span>
                <span className="text-sm font-semibold text-foreground">{item.value}</span>
              </div>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
}
