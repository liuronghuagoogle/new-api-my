import { TrendingUp, TrendingDown, Wallet, CreditCard } from "lucide-react";

const budgetItems = [
  {
    title: "本月预算",
    value: "¥2,760.00",
    icon: Wallet,
    iconColor: "text-emerald-400",
    iconBg: "bg-emerald-500/15",
    trend: "+12%",
    trendUp: true,
    trendText: "较上月",
  },
  {
    title: "已消费",
    value: "¥1,820.00",
    icon: CreditCard,
    iconColor: "text-blue-400",
    iconBg: "bg-blue-500/15",
    trend: "66%",
    trendUp: false,
    trendText: "预算使用",
  },
  {
    title: "剩余额度",
    value: "¥940.00",
    icon: TrendingUp,
    iconColor: "text-purple-400",
    iconBg: "bg-purple-500/15",
    trend: "34%",
    trendUp: true,
    trendText: "预算剩余",
  },
  {
    title: "预测支出",
    value: "¥2,340.00",
    icon: TrendingDown,
    iconColor: "text-orange-400",
    iconBg: "bg-orange-500/15",
    trend: "85%",
    trendUp: false,
    trendText: "月末预测",
  },
];

export default function BudgetOverview() {
  return (
    <div className="rounded-2xl border border-border bg-card/90 p-6 shadow-sm">
      <div className="text-xs uppercase tracking-[0.2em] text-mutedForeground">
        预算概览
      </div>
      <div className="mt-4 grid gap-4 sm:grid-cols-2">
        {budgetItems.map((item) => (
          <div
            key={item.title}
            className="rounded-xl border border-border/60 bg-background/50 px-4 py-3"
          >
            <div className="flex items-start justify-between">
              <div className="flex items-center gap-2">
                <div className={`rounded-lg p-1.5 ${item.iconBg}`}>
                  <item.icon className={`h-3.5 w-3.5 ${item.iconColor}`} />
                </div>
                <div className="text-xs text-mutedForeground">{item.title}</div>
              </div>
              <div
                className={`text-xs font-medium ${
                  item.trendUp ? "text-emerald-400" : "text-orange-400"
                }`}
              >
                {item.trend}
              </div>
            </div>
            <div className="mt-2 text-lg font-semibold">{item.value}</div>
            <div className="text-xs text-mutedForeground">{item.trendText}</div>
          </div>
        ))}
      </div>
    </div>
  );
}
