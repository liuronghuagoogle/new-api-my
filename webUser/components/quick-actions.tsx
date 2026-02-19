import {
  MessageSquare,
  KeyRound,
  CreditCard,
  FileText,
  Settings,
  HelpCircle,
} from "lucide-react";

const actions = [
  {
    icon: MessageSquare,
    label: "新建对话",
    description: "开始新的 AI 对话",
    color: "bg-foreground/10 text-foreground/75",
  },
  {
    icon: KeyRound,
    label: "创建密钥",
    description: "生成新的 API Key",
    color: "bg-muted text-subtleForeground",
  },
  {
    icon: CreditCard,
    label: "账户充值",
    description: "为账户添加余额",
    color: "bg-success/15 text-success",
  },
  {
    icon: FileText,
    label: "查看账单",
    description: "查看消费明细",
    color: "bg-warning/15 text-warning",
  },
  {
    icon: Settings,
    label: "系统设置",
    description: "配置系统参数",
    color: "bg-subtle/70 text-subtleForeground",
  },
  {
    icon: HelpCircle,
    label: "帮助中心",
    description: "查看使用文档",
    color: "bg-muted text-mutedForeground",
  },
];

export default function QuickActions() {
  return (
    <div className="surface-card p-6">
      <div className="text-xs uppercase tracking-[0.2em] text-mutedForeground">快速操作</div>
      <div className="mt-4 grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
        {actions.map((action) => (
          <button
            key={action.label}
            className="flex items-center gap-3 rounded-xl border border-border/70 bg-card/70 px-4 py-3 transition-all hover:-translate-y-0.5 hover:border-border hover:bg-elevated"
          >
            <div className={`rounded-lg p-2 ${action.color}`}>
              <action.icon className="h-4 w-4" />
            </div>
            <div className="text-left">
              <div className="text-sm font-medium">{action.label}</div>
              <div className="text-xs text-mutedForeground">{action.description}</div>
            </div>
          </button>
        ))}
      </div>
    </div>
  );
}
