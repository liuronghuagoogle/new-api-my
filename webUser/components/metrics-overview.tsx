import { Zap, Clock, Server, Shield } from "lucide-react";

const metrics = [
  {
    icon: Zap,
    iconColor: "text-yellow-400",
    iconBg: "bg-yellow-500/15",
    title: "平均响应速度",
    value: "840ms",
    subtitle: "P95: 1.2s · P99: 1.8s",
    trend: "-12%",
    trendUp: true,
  },
  {
    icon: Clock,
    iconColor: "text-blue-400",
    iconBg: "bg-blue-500/15",
    title: "可用性",
    value: "99.9%",
    subtitle: "过去 30 天",
    trend: "+0.1%",
    trendUp: true,
  },
  {
    icon: Server,
    iconColor: "text-purple-400",
    iconBg: "bg-purple-500/15",
    title: "今日调用量",
    value: "3,245",
    subtitle: "环比 +12%",
    trend: "+8%",
    trendUp: true,
  },
  {
    icon: Shield,
    iconColor: "text-emerald-400",
    iconBg: "bg-emerald-500/15",
    title: "安全评分",
    value: "92/100",
    subtitle: "无安全事件",
    trend: "优秀",
    trendUp: true,
  },
];

export default function MetricsOverview() {
  return (
    <div className="rounded-2xl border border-border bg-card/90 p-6 shadow-sm">
      <div className="text-xs uppercase tracking-[0.2em] text-mutedForeground">
        系统指标
      </div>
      <div className="mt-4 grid gap-4 sm:grid-cols-2">
        {metrics.map((metric) => (
          <div
            key={metric.title}
            className="rounded-xl border border-border/60 bg-background/50 px-4 py-3"
          >
            <div className="flex items-start justify-between">
              <div className="flex items-center gap-2">
                <div className={`rounded-lg p-1.5 ${metric.iconBg}`}>
                  <metric.icon className={`h-3.5 w-3.5 ${metric.iconColor}`} />
                </div>
                <div className="text-xs text-mutedForeground">{metric.title}</div>
              </div>
              <div
                className={`rounded-full px-2 py-0.5 text-xs font-medium ${
                  metric.trendUp
                    ? "bg-emerald-500/15 text-emerald-400"
                    : "bg-red-500/15 text-red-400"
                }`}
              >
                {metric.trend}
              </div>
            </div>
            <div className="mt-2 text-lg font-semibold">{metric.value}</div>
            <div className="text-xs text-mutedForeground">{metric.subtitle}</div>
          </div>
        ))}
      </div>
    </div>
  );
}
