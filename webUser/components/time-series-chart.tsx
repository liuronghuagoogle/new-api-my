import { cn } from "@/lib/utils";

interface TimeSeriesChartProps {
  title: string;
  data: { date: string; value: number }[];
  color?: string;
  className?: string;
}

export default function TimeSeriesChart({
  title,
  data,
  color = "text-blue-400",
  className,
}: TimeSeriesChartProps) {
  const max = Math.max(...data.map((d) => d.value));
  const min = Math.min(...data.map((d) => d.value));
  const range = max - min || 1;

  // Generate SVG path for the chart
  const points = data.map((item, index) => {
    const x = (index / (data.length - 1)) * 100;
    const y = 100 - ((item.value - min) / range) * 80 - 10;
    return `${x},${y}`;
  });

  const pathD = `M ${points.join(" L ")}`;

  return (
    <div
      className={cn(
        "rounded-2xl border border-border bg-card/90 p-6 shadow-sm",
        className
      )}
    >
      <div className="flex items-center justify-between">
        <div className="text-xs uppercase tracking-[0.2em] text-mutedForeground">
          {title}
        </div>
        <div className="flex gap-2">
          <button className="rounded-lg border border-border/60 px-3 py-1 text-xs transition-colors hover:bg-muted">
            日
          </button>
          <button className="rounded-lg bg-foreground px-3 py-1 text-xs text-background">
            周
          </button>
          <button className="rounded-lg border border-border/60 px-3 py-1 text-xs transition-colors hover:bg-muted">
            月
          </button>
        </div>
      </div>

      <div className="mt-6 h-40 w-full">
        <svg viewBox="0 0 100 100" className="h-full w-full">
          <defs>
            <linearGradient id="chart-gradient" x1="0%" y1="0%" x2="0%" y2="100%">
              <stop offset="0%" stopColor="currentColor" stopOpacity="0.3" />
              <stop offset="100%" stopColor="currentColor" stopOpacity="0" />
            </linearGradient>
          </defs>
          <path
            d={`${pathD} L 100,100 L 0,100 Z`}
            fill="url(#chart-gradient)"
            className={color}
          />
          <path
            d={pathD}
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            className={color}
            strokeLinecap="round"
            strokeLinejoin="round"
          />
          {data.map((item, index) => {
            const x = (index / (data.length - 1)) * 100;
            const y = 100 - ((item.value - min) / range) * 80 - 10;
            return (
              <circle
                key={index}
                cx={x}
                cy={y}
                r="1.5"
                fill="currentColor"
                className={color}
              />
            );
          })}
        </svg>
      </div>

      <div className="mt-4 flex items-center justify-between text-xs text-mutedForeground">
        <div>{data[0]?.date || ""}</div>
        <div>{data[data.length - 1]?.date || ""}</div>
      </div>
    </div>
  );
}
