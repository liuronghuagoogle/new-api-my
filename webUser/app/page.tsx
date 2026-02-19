import Sidebar from "@/components/sidebar";
import Topbar from "@/components/topbar";
import StatCard from "@/components/stat-card";
import ChartCard from "@/components/chart-card";
import QuickActions from "@/components/quick-actions";
import RecentActivity from "@/components/recent-activity";
import ModelUsage from "@/components/model-usage";
import BudgetOverview from "@/components/budget-overview";
import MetricsOverview from "@/components/metrics-overview";
import TimeSeriesChart from "@/components/time-series-chart";
import DashboardHero from "@/components/dashboard-hero";

const usageData = [1200, 1800, 1400, 2200, 1900, 2800, 2400, 3100, 2800, 3500];
const costData = [180, 250, 210, 320, 280, 380, 340, 420, 380, 480];
const latencyData = [920, 880, 950, 840, 890, 820, 860, 800, 850, 780];
const tokensData = [
  { date: "01/15", value: 85000 },
  { date: "01/16", value: 120000 },
  { date: "01/17", value: 95000 },
  { date: "01/18", value: 150000 },
  { date: "01/19", value: 130000 },
  { date: "01/20", value: 180000 },
  { date: "01/21", value: 160000 },
];

export default function HomePage() {
  return (
    <div className="flex min-h-screen bg-background text-foreground">
      <Sidebar />
      <main className="flex-1 px-5 py-6 md:px-8 md:py-8 xl:px-10">
        <div className="mx-auto flex w-full max-w-7xl flex-col gap-6">
          <Topbar />
          <DashboardHero />

          <QuickActions />

          <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
            <ChartCard
              title="今日调用"
              value="3,245"
              subtitle="同比 +12%"
              trend="+12%"
              trendUp={true}
              data={usageData}
            />
            <ChartCard
              title="本月费用"
              value="¥ 1,820"
              subtitle="预算剩余 34%"
              trend="34%"
              trendUp={true}
              data={costData}
            />
            <ChartCard
              title="平均延迟"
              value="840ms"
              subtitle="p95 1.2s · p99 1.8s"
              trend="-5%"
              trendUp={true}
              data={latencyData}
            />
            <StatCard title="活跃 Key" value="8" caption="近 7 天" trend="+2" />
          </div>

          <MetricsOverview />
          <BudgetOverview />

          <div className="grid gap-6 lg:grid-cols-[1.2fr_0.8fr]">
            <TimeSeriesChart title="Token 消耗趋势" data={tokensData} color="text-foreground/80" />
            <ModelUsage />
          </div>

          <RecentActivity />
        </div>
      </main>
    </div>
  );
}
