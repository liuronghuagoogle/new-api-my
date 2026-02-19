import { cn } from "@/lib/utils";

interface ChartCardProps {
  title: string;
  value: string;
  subtitle: string;
  trend?: string;
  trendUp?: boolean;
  data: number[];
  className?: string;
}

export default function ChartCard({
  title,
  value,
  subtitle,
  trend,
  trendUp = true,
  data,
  className,
}: ChartCardProps) {
  const max = Math.max(...data);
  const min = Math.min(...data);
  const range = max - min || 1;

  const points = data.map((value, index) => {
    const x = (index / (data.length - 1)) * 100;
    const y = 100 - ((value - min) / range) * 74 - 13;
    return `${x},${y}`;
  });

  const pathD = `M ${points.join(" L ")}`;
  const gradientId = `chart-gradient-${title.replace(/\s+/g, "-").toLowerCase()}`;

  return (
    <div className={cn("surface-card surface-card-hover p-5", className)}>
      <div className="flex items-start justify-between gap-3">
        <div>
          <div className="text-[11px] uppercase tracking-[0.2em] text-mutedForeground">{title}</div>
          <div className="mt-2 text-[30px] font-semibold leading-none tracking-tight text-foreground">{value}</div>
          <div className="mt-2 text-sm text-mutedForeground">{subtitle}</div>
        </div>
        {trend && (
          <div
            className={cn(
              "rounded-full border px-2.5 py-1 text-xs font-medium",
              trendUp
                ? "border-success/35 bg-success/12 text-success"
                : "border-warning/35 bg-warning/12 text-warning"
            )}
          >
            {trend}
          </div>
        )}
      </div>

      <div className="mt-6 h-[72px] w-full rounded-xl border border-border/55 bg-elevated/60 p-2">
        <svg viewBox="0 0 100 100" className="h-full w-full">
          <defs>
            <linearGradient id={gradientId} x1="0%" y1="0%" x2="0%" y2="100%">
              <stop offset="0%" stopColor="currentColor" stopOpacity="0.26" />
              <stop offset="100%" stopColor="currentColor" stopOpacity="0" />
            </linearGradient>
          </defs>
          <path d={`${pathD} L 100,100 L 0,100 Z`} fill={`url(#${gradientId})`} className="text-foreground/28" />
          <path
            d={pathD}
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            className="text-foreground/70"
            strokeLinecap="round"
            strokeLinejoin="round"
          />
        </svg>
      </div>
    </div>
  );
}
