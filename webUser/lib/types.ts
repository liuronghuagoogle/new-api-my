/* ── 后端 API 响应类型定义 ── */

/** 额度单位常量，后端 quota 值 / QUOTA_PER_UNIT = 美元金额 */
export const QUOTA_PER_UNIT = 500000;

/** 将后端 quota 值转为美元 */
export function formatQuota(quota: number): string {
  return (quota / QUOTA_PER_UNIT).toFixed(2);
}

/** 将后端 quota 值转为数字金额 */
export function quotaToUsd(quota: number): number {
  return quota / QUOTA_PER_UNIT;
}

/** 格式化 Unix 时间戳为本地日期时间字符串 */
export function formatTime(timestamp: number): string {
  if (!timestamp || timestamp <= 0) return "—";
  return new Date(timestamp * 1000).toLocaleString("zh-CN", {
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
  });
}

/** 格式化短时间 */
export function formatTimeShort(timestamp: number): string {
  if (!timestamp || timestamp <= 0) return "—";
  return new Date(timestamp * 1000).toLocaleString("zh-CN", {
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
  });
}

/* ── 分页 ── */
export interface PageInfo<T> {
  page: number;
  page_size: number;
  total: number;
  items: T[];
}

/* ── Token ── */
export const TokenStatus = {
  ENABLED: 1,
  DISABLED: 2,
  EXPIRED: 3,
  EXHAUSTED: 4,
} as const;

export const TokenStatusLabel: Record<number, string> = {
  1: "已启用",
  2: "已禁用",
  3: "已过期",
  4: "额度用尽",
};

export interface Token {
  id: number;
  user_id: number;
  key: string;
  status: number;
  name: string;
  created_time: number;
  accessed_time: number;
  expired_time: number; // -1 = 永不过期
  remain_quota: number;
  unlimited_quota: boolean;
  model_limits_enabled: boolean;
  model_limits: string;
  allow_ips: string | null;
  used_quota: number;
  group: string;
  cross_group_retry: boolean;
}

/* ── Log ── */
export const LogType = {
  UNKNOWN: 0,
  TOPUP: 1,
  CONSUME: 2,
  MANAGE: 3,
  SYSTEM: 4,
  ERROR: 5,
  REFUND: 6,
} as const;

export const LogTypeLabel: Record<number, string> = {
  0: "未知",
  1: "充值",
  2: "消费",
  3: "管理",
  4: "系统",
  5: "错误",
  6: "退款",
};

export interface Log {
  id: number;
  user_id: number;
  created_at: number;
  type: number;
  content: string;
  username: string;
  token_name: string;
  model_name: string;
  quota: number;
  prompt_tokens: number;
  completion_tokens: number;
  use_time: number; // 秒
  is_stream: boolean;
  channel: number;
  channel_name: string;
  token_id: number;
  group: string;
  ip: string;
  request_id?: string;
  other: string;
}

/* ── QuotaData (Dashboard 图表) ── */
export interface QuotaData {
  id: number;
  user_id: number;
  username: string;
  model_name: string;
  created_at: number;
  token_used: number;
  count: number;
  quota: number;
}

/* ── Model (OpenAI format) ── */
export interface Model {
  id: string;
  object: string;
  created: number;
  owned_by: string;
  supported_endpoint_types?: string[];
}

/* ── Pricing ── */
export interface Pricing {
  model_name: string;
  description?: string;
  icon?: string;
  tags?: string;
  vendor_id?: number;
  quota_type: number;
  model_ratio: number;
  model_price: number;
  owner_by: string;
  completion_ratio: number;
  enable_groups: string[];
  supported_endpoint_types?: string[];
}

export interface PricingVendor {
  id: number;
  name: string;
  description?: string;
  icon?: string;
}

export interface PricingResponse {
  data: Pricing[];
  vendors: PricingVendor[];
  group_ratio: Record<string, number>;
  usable_group: Record<string, string>;
  supported_endpoint: Record<string, string>;
  auto_groups: string[];
}

/* ── LogStat ── */
export interface LogStat {
  quota: number;
  rpm: number;
  tpm: number;
}

/* ── Checkin (签到) ── */
export interface CheckinRecord {
  checkin_date: string;
  quota_awarded: number;
}

export interface CheckinStats {
  checked_in_today: boolean;
  total_checkins: number;
  total_quota: number;
  checkin_count: number;
  records: CheckinRecord[];
}

export interface CheckinStatusResponse {
  enabled: boolean;
  min_quota: number;
  max_quota: number;
  stats: CheckinStats;
}

export interface CheckinResponse {
  quota_awarded: number;
  checkin_date: string;
}
