import Sidebar from "@/components/sidebar";
import Topbar from "@/components/topbar";
import StatCard from "@/components/stat-card";
import UsageCard from "@/components/usage-card";
import ActivityCard from "@/components/activity-card";
import KeyCard from "@/components/key-card";
import { Separator } from "@/components/ui/separator";

export default function HomePage() {
  return (
    <div className="flex min-h-screen bg-background">
      <Sidebar />
      <main className="flex-1 px-6 py-8 xl:px-10">
        <div className="mx-auto flex max-w-6xl flex-col gap-8">
          <Topbar />

          <div className="rounded-3xl border border-border bg-card/60 p-8 shadow-sm">
            <div className="flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
              <div>
                <p className="text-sm text-mutedForeground">
                  新模型已上线，支持 Claude 3.7 & GPT-4.1
                </p>
                <h2 className="mt-2 text-2xl font-semibold tracking-tight">
                  更快、更稳、更安全的推理体验
                </h2>
              </div>
              <div className="flex gap-3">
                <button className="rounded-full bg-foreground px-5 py-2 text-sm font-medium text-background">
                  立即体验
                </button>
                <button className="rounded-full border border-border px-5 py-2 text-sm font-medium">
                  了解更多
                </button>
              </div>
            </div>
          </div>

          <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
            <StatCard title="今日调用" value="3,245" caption="同比 +12%" trend="+12%" />
            <StatCard title="本月费用" value="¥ 1,820" caption="预算剩余 34%" />
            <StatCard title="活跃 Key" value="8" caption="近 7 天" />
            <StatCard title="平均延迟" value="840ms" caption="p95 1.2s" />
          </div>

          <div className="grid gap-6 lg:grid-cols-[1.4fr_1fr]">
            <UsageCard />
            <ActivityCard />
          </div>

          <div className="grid gap-6 lg:grid-cols-[1.2fr_0.8fr]">
            <KeyCard />
            <div className="rounded-2xl border border-border bg-card/90 p-6 shadow-sm">
              <div className="text-xs uppercase tracking-[0.2em] text-mutedForeground">
                今日动态
              </div>
              <div className="mt-4 flex flex-col gap-4 text-sm">
                <div className="flex items-start justify-between">
                  <div>
                    <p className="font-medium">新账单已生成</p>
                    <p className="text-mutedForeground">已自动发送到邮箱</p>
                  </div>
                  <span className="text-xs text-mutedForeground">2 小时前</span>
                </div>
                <Separator />
                <div className="flex items-start justify-between">
                  <div>
                    <p className="font-medium">密钥调用异常下降</p>
                    <p className="text-mutedForeground">建议检查限流配置</p>
                  </div>
                  <span className="text-xs text-mutedForeground">4 小时前</span>
                </div>
                <Separator />
                <div className="flex items-start justify-between">
                  <div>
                    <p className="font-medium">新版本上线</p>
                    <p className="text-mutedForeground">控制台已支持多账单</p>
                  </div>
                  <span className="text-xs text-mutedForeground">昨天</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>
  );
}
