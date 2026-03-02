/* ── 业务 API 调用 ── */

import { get, post, put, del, getAuthHeaders, ApiError } from "./api";
import type { PageInfo, Token, Log, LogStat, QuotaData, PricingResponse, CheckinStatusResponse, CheckinResponse } from "./types";

/* ── Token ── */
export async function getTokens(page = 1, pageSize = 10, keyword = ""): Promise<PageInfo<Token>> {
  const params = new URLSearchParams({ p: String(page), page_size: String(pageSize) });
  if (keyword) params.set("keyword", keyword);
  const res = await get<PageInfo<Token>>(`/api/token/?${params}`);
  return res.data;
}

export async function createToken(data: {
  name: string;
  remain_quota?: number;
  unlimited_quota?: boolean;
  expired_time?: number;
  model_limits_enabled?: boolean;
  model_limits?: string;
  group?: string;
}): Promise<void> {
  await post("/api/token/", data);
}

export async function updateToken(data: Partial<Token> & { id: number }, statusOnly = false): Promise<Token> {
  const url = statusOnly ? "/api/token/?status_only=true" : "/api/token/";
  const res = await put<Token>(url, data);
  return res.data;
}

export async function deleteToken(id: number): Promise<void> {
  await del(`/api/token/${id}`);
}

/* ── User Groups ── */
export interface GroupInfo {
  ratio: number | string;
  desc: string;
}

export async function getUserGroups(): Promise<Record<string, GroupInfo>> {
  const res = await get<Record<string, GroupInfo>>("/api/user/self/groups");
  return res.data;
}

/* ── Logs ── */
export async function getLogs(params: {
  page?: number;
  pageSize?: number;
  token_name?: string;
  model_name?: string;
  type?: number;
  start_timestamp?: number;
  end_timestamp?: number;
} = {}): Promise<PageInfo<Log>> {
  const q = new URLSearchParams();
  q.set("p", String(params.page ?? 1));
  q.set("page_size", String(params.pageSize ?? 20));
  if (params.token_name) q.set("token_name", params.token_name);
  if (params.model_name) q.set("model_name", params.model_name);
  if (params.type !== undefined) q.set("type", String(params.type));
  if (params.start_timestamp) q.set("start_timestamp", String(params.start_timestamp));
  if (params.end_timestamp) q.set("end_timestamp", String(params.end_timestamp));
  const res = await get<PageInfo<Log>>(`/api/log/self/?${q}`);
  return res.data;
}

export async function getLogStat(): Promise<LogStat> {
  const res = await get<LogStat>("/api/log/self/stat");
  return res.data;
}

/* ── Dashboard Data ── */
export async function getQuotaData(startTimestamp: number, endTimestamp: number): Promise<QuotaData[]> {
  const res = await get<QuotaData[]>(
    `/api/data/self?start_timestamp=${startTimestamp}&end_timestamp=${endTimestamp}`
  );
  return res.data;
}

/* ── Models ── */
export async function getModels(): Promise<string[]> {
  const res = await get<string[]>("/api/user/models");
  return res.data;
}

/* ── Pricing ── */
// pricing API 响应结构非标准（vendors/group_ratio 等字段与 success/data 同级），
// 不能用通用 get() 自动解包 .data，需直接 fetch 返回完整响应体
export async function getPricing(): Promise<PricingResponse> {
  const raw = await fetch("/api/pricing", {
    headers: getAuthHeaders(),
    credentials: "include",
  });
  if (raw.status === 401) {
    throw new ApiError(401, "登录已过期");
  }
  const body = await raw.json();
  if (!raw.ok || !body.success) {
    throw new ApiError(raw.status, body.message || `HTTP ${raw.status}`);
  }
  return body as PricingResponse;
}

/* ── Notice ── */
export async function getNotice(): Promise<string> {
  const res = await get<string>("/api/notice");
  return res.data;
}

/* ── User 操作 ── */
export async function updatePassword(data: {
  original_password: string;
  new_password: string;
}): Promise<void> {
  await put("/api/user/self", { password: data.new_password, original_password: data.original_password });
}

export async function updateEmail(email: string): Promise<void> {
  await put("/api/user/self", { email });
}

export async function redeemCode(key: string): Promise<void> {
  await post("/api/user/topup", { key });
}

export async function transferAffQuota(): Promise<void> {
  await post("/api/user/aff_transfer");
}

/* ── Checkin (签到) ── */
export async function getCheckinStatus(month?: string): Promise<CheckinStatusResponse> {
  const q = month ? `?month=${month}` : "";
  const res = await get<CheckinStatusResponse>(`/api/user/checkin${q}`);
  return res.data;
}

export async function doCheckin(turnstileToken?: string): Promise<CheckinResponse> {
  const q = turnstileToken ? `?turnstile=${encodeURIComponent(turnstileToken)}` : "";
  const res = await post<CheckinResponse>(`/api/user/checkin${q}`);
  return res.data;
}
