/* ── 认证工具 ── */

import { get, post, type ApiResponse } from "./api";

/* ── 类型 ── */
export interface User {
  id: number;
  username: string;
  display_name: string;
  role: number;
  status: number;
  email?: string;
  group: string;
  quota?: number;
  used_quota?: number;
  request_count?: number;
  aff_code?: string;
  aff_count?: number;
  aff_quota?: number;
  aff_history_quota?: number;
}

export interface SystemStatus {
  system_name: string;
  logo: string;
  footer_html: string;
  wechat_qrcode: string;
  wechat_login: boolean;
  github_oauth: boolean;
  github_client_id: string;
  discord_oauth: boolean;
  discord_client_id: string;
  oidc_enabled: boolean;
  oidc_client_id: string;
  oidc_authorization_endpoint: string;
  oidc_display_name: string;
  linuxdo_oauth: boolean;
  linuxdo_client_id: string;
  telegram_oauth: boolean;
  telegram_bot_name: string;
  turnstile_check: boolean;
  turnstile_site_key: string;
  email_verification: boolean;
  register_enabled: boolean;
  passkey_login: boolean;
  checkin_enabled?: boolean;
  announcements_enabled?: boolean;
  announcements?: Announcement[];
  custom_oauth_providers?: Array<{
    slug: string;
    name: string;
    client_id: string;
    authorization_endpoint: string;
    scope: string;
    icon?: string;
  }>;
}

export interface Announcement {
  publishDate?: string;
  content: string;
  type?: string;
  extra?: string;
}

/* ── 本地存储 ── */
export function getStoredUser(): User | null {
  if (typeof window === "undefined") return null;
  try {
    const raw = localStorage.getItem("user");
    if (!raw) return null;
    return JSON.parse(raw);
  } catch {
    return null;
  }
}

export function setStoredUser(user: User) {
  localStorage.setItem("user", JSON.stringify(user));
}

export function clearStoredUser() {
  localStorage.removeItem("user");
}

export function isLoggedIn(): boolean {
  return getStoredUser() !== null;
}

/* ── API 调用 ── */

/** 获取系统状态（哪些 OAuth 开启、是否允许注册等） */
export async function fetchStatus(): Promise<SystemStatus> {
  const res = await get<SystemStatus>("/api/status");
  return res.data;
}

/** 密码登录 */
export async function login(
  username: string,
  password: string
): Promise<{ user?: User; require_2fa?: boolean }> {
  const res = await post<User & { require_2fa?: boolean }>("/api/user/login", {
    username,
    password,
  });

  if (res.data.require_2fa) {
    return { require_2fa: true };
  }

  setStoredUser(res.data);
  return { user: res.data };
}

/** 2FA 验证 */
export async function verify2FA(code: string): Promise<User> {
  const res = await post<User>("/api/user/login/2fa", { code });
  setStoredUser(res.data);
  return res.data;
}

/** 获取 OAuth state */
export async function getOAuthState(): Promise<string> {
  const aff = localStorage.getItem("aff") || "";
  const res = await get<string>(`/api/oauth/state?aff=${aff}`);
  return res.data;
}

/** 处理 OAuth 回调 */
export async function handleOAuthCallback(
  provider: string,
  code: string,
  state: string
): Promise<{ user?: User; message?: string }> {
  const res = await get<User>(`/api/oauth/${provider}?code=${code}&state=${state}`);
  if (res.message === "bind") {
    return { message: "bind" };
  }
  setStoredUser(res.data);
  return { user: res.data };
}

/** 注册 */
export async function register(data: {
  username: string;
  password: string;
  email?: string;
  verification_code?: string;
  aff_code?: string;
}): Promise<void> {
  await post("/api/user/register", data);
}

/** 发送邮箱验证码（注册用） */
export async function sendVerificationCode(email: string): Promise<void> {
  await get(`/api/verification?email=${encodeURIComponent(email)}`);
}

/** 发送密码重置邮件 */
export async function sendPasswordReset(email: string): Promise<void> {
  await get(`/api/reset_password?email=${encodeURIComponent(email)}`);
}

/** 确认密码重置 */
export async function confirmPasswordReset(
  email: string,
  token: string
): Promise<string> {
  const res = await post<string>("/api/user/reset", { email, token });
  return res.data; // 新密码
}

/** 获取当前用户信息 */
export async function fetchSelf(): Promise<User> {
  const res = await get<User>("/api/user/self");
  setStoredUser(res.data);
  return res.data;
}

/** 退出登录 */
export async function logout(): Promise<void> {
  try {
    await get("/api/user/logout");
  } catch {
    // 即使请求失败也清除本地状态
  }
  clearStoredUser();
}
