import { Separator } from "@/components/ui/separator";
import { MessageSquare, KeyRound, CreditCard, AlertCircle, CheckCircle } from "lucide-react";

const activities = [
  {
    icon: MessageSquare,
    iconColor: "text-foreground/75",
    title: "API 调用成功",
    description: "Claude 3.5 Sonnet - 1,240 tokens",
    time: "2 分钟前",
  },
  {
    icon: KeyRound,
    iconColor: "text-subtleForeground",
    title: "新密钥已创建",
    description: "sk-live-9m2b-••••••••••",
    time: "15 分钟前",
  },
  {
    icon: CreditCard,
    iconColor: "text-success",
    title: "账户充值成功",
    description: "充值 ¥500.00",
    time: "1 小时前",
  },
  {
    icon: AlertCircle,
    iconColor: "text-warning",
    title: "调用速率警告",
    description: "超过 100 QPM 限制",
    time: "2 小时前",
  },
  {
    icon: MessageSquare,
    iconColor: "text-danger",
    title: "API 调用失败",
    description: "GPT-4.1 - 超时错误",
    time: "3 小时前",
  },
  {
    icon: CheckCircle,
    iconColor: "text-success",
    title: "账户已验证",
    description: "邮箱验证成功",
    time: "昨天",
  },
];

export default function RecentActivity() {
  return (
    <div className="surface-card p-6">
      <div className="flex items-center justify-between">
        <div className="text-xs uppercase tracking-[0.2em] text-mutedForeground">最近活动</div>
        <button className="text-xs text-mutedForeground transition-colors hover:text-foreground">查看全部</button>
      </div>
      <div className="mt-4 flex flex-col gap-4">
        {activities.map((activity, index) => (
          <div key={index}>
            <div className="flex gap-3">
              <div className="mt-0.5">
                <div className={`rounded-full border border-border/60 bg-background p-1.5 ${activity.iconColor}`}>
                  <activity.icon className="h-3.5 w-3.5" />
                </div>
              </div>
              <div className="flex-1">
                <div className="flex items-start justify-between">
                  <div className="flex-1">
                    <div className="text-sm font-medium">{activity.title}</div>
                    <div className="mt-0.5 text-xs text-mutedForeground">{activity.description}</div>
                  </div>
                  <div className="text-xs text-mutedForeground">{activity.time}</div>
                </div>
              </div>
            </div>
            {index < activities.length - 1 && <Separator className="my-4 bg-border/50" />}
          </div>
        ))}
      </div>
    </div>
  );
}
