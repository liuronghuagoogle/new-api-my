const models = [
  {
    name: "Claude 3.5 Sonnet",
    usage: 45,
    color: "bg-foreground/80",
    requests: "12,482",
  },
  {
    name: "GPT-4.1",
    usage: 28,
    color: "bg-foreground/60",
    requests: "9,214",
  },
  {
    name: "Gemini 1.5 Pro",
    usage: 15,
    color: "bg-foreground/45",
    requests: "4,902",
  },
  {
    name: "Claude 3 Opus",
    usage: 8,
    color: "bg-foreground/30",
    requests: "2,615",
  },
  {
    name: "其他",
    usage: 4,
    color: "bg-mutedForeground/60",
    requests: "1,307",
  },
];

export default function ModelUsage() {
  return (
    <div className="surface-card p-6">
      <div className="flex items-center justify-between">
        <div className="text-xs uppercase tracking-[0.2em] text-mutedForeground">模型使用分布</div>
        <button className="text-xs text-mutedForeground transition-colors hover:text-foreground">本周</button>
      </div>
      <div className="mt-4 flex flex-col gap-4">
        {models.map((model) => (
          <div key={model.name}>
            <div className="flex items-center justify-between text-sm">
              <div className="font-medium">{model.name}</div>
              <div className="text-mutedForeground">{model.requests} 次</div>
            </div>
            <div className="mt-2 flex items-center gap-3">
              <div className="h-2 w-full rounded-full bg-muted">
                <div className={`h-2 rounded-full ${model.color} transition-all`} style={{ width: `${model.usage}%` }} />
              </div>
              <div className="w-10 text-right text-xs text-mutedForeground">{model.usage}%</div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
