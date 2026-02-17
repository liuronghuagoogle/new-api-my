const activities = [
  {
    title: "Claude 3.5 Sonnet",
    subtitle: "本周请求数",
    value: "12,482",
  },
  {
    title: "GPT-4.1",
    subtitle: "本周请求数",
    value: "9,214",
  },
  {
    title: "Gemini 1.5 Pro",
    subtitle: "本周请求数",
    value: "4,902",
  },
];

export default function ActivityCard() {
  return (
    <div className="rounded-2xl border border-border bg-card/90 p-6 shadow-sm">
      <div className="text-xs uppercase tracking-[0.2em] text-mutedForeground">
        热门模型
      </div>
      <div className="mt-4 flex flex-col gap-4">
        {activities.map((item) => (
          <div
            key={item.title}
            className="flex items-center justify-between rounded-xl border border-border/60 px-4 py-3"
          >
            <div>
              <div className="text-sm font-medium">{item.title}</div>
              <div className="text-xs text-mutedForeground">{item.subtitle}</div>
            </div>
            <div className="text-sm text-foreground/80">{item.value}</div>
          </div>
        ))}
      </div>
    </div>
  );
}
