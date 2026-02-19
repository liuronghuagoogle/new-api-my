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
    <div className={cn("surface-card surface-card-hover p-5", className)}>
      <div className="text-[11px] uppercase tracking-[0.2em] text-mutedForeground">{title}</div>
      <div className="mt-3 text-[32px] font-semibold leading-none tracking-tight text-foreground">{value}</div>
      <div className="mt-4 flex items-center justify-between text-sm text-mutedForeground">
        <span>{caption}</span>
        {trend && (
          <span className="rounded-full border border-success/35 bg-success/12 px-2.5 py-1 text-xs font-medium text-success">
            {trend}
          </span>
        )}
      </div>
    </div>
  );
}
