import { cn } from "@/lib/utils";

interface StatCardProps {
  title: string;
  value: string;
  caption: string;
  trend?: string;
  className?: string;
}

export default function StatCard({
  title,
  value,
  caption,
  trend,
  className,
}: StatCardProps) {
  return (
    <div
      className={cn(
        "rounded-2xl border border-border bg-card/90 p-5 shadow-sm",
        className
      )}
    >
      <div className="text-xs uppercase tracking-[0.2em] text-mutedForeground">
        {title}
      </div>
      <div className="mt-3 text-3xl font-semibold tracking-tight">{value}</div>
      <div className="mt-3 flex items-center justify-between text-sm text-mutedForeground">
        <span>{caption}</span>
        {trend && (
          <span className="rounded-full bg-emerald-500/15 px-2 py-1 text-xs text-emerald-400">
            {trend}
          </span>
        )}
      </div>
    </div>
  );
}
