/**
 * API 客户端 — 通过 Next.js middleware 代理到后端
 *
 * 后端使用 session cookie 认证，同源代理下 cookie 自动携带。
 * 额外发送 New-Api-User header（后端 authHelper 会校验）。
 */

function getUserId(): number {
  if (typeof window === "undefined") return -1;
  try {
    const raw = localStorage.getItem("user");
    if (!raw) return -1;
    return JSON.parse(raw).id ?? -1;
  } catch {
    return -1;
  }
}

/** 获取通用认证 headers（cookie 由浏览器自动携带） */
export function getAuthHeaders(extra?: Record<string, string>): Record<string, string> {
  const headers: Record<string, string> = {
    "Content-Type": "application/json",
    "Cache-Control": "no-store",
    ...extra,
  };
  const uid = getUserId();
  if (uid !== -1) {
    headers["New-Api-User"] = String(uid);
  }
  return headers;
}

/* ── 通用响应格式 ── */
export interface ApiResponse<T = unknown> {
  success: boolean;
  message: string;
  data: T;
}

export class ApiError extends Error {
  status: number;
  data: ApiResponse | null;
  constructor(status: number, message: string, data?: ApiResponse | null) {
    super(message);
    this.status = status;
    this.data = data ?? null;
  }
}

/** 处理 401 响应（清除登录态并跳转） */
function handle401(): never {
  if (typeof window !== "undefined") {
    localStorage.removeItem("user");
    window.location.href = "/login?expired=true";
  }
  throw new ApiError(401, "登录已过期");
}

/** JSON API 请求 — 自动处理认证、401、错误解析 */
export async function api<T = unknown>(
  path: string,
  options?: RequestInit
): Promise<ApiResponse<T>> {
  const headers = getAuthHeaders(
    (options?.headers as Record<string, string>) || undefined
  );

  const res = await fetch(path, {
    ...options,
    headers,
    credentials: "include",
  });

  if (res.status === 401) handle401();

  let body: ApiResponse<T>;
  try {
    body = await res.json();
  } catch {
    throw new ApiError(res.status, `HTTP ${res.status}`);
  }

  if (!res.ok || !body.success) {
    throw new ApiError(res.status, body.message || `HTTP ${res.status}`, body);
  }

  return body;
}

/** 流式请求 — 返回原始 Response，由调用方读取 ReadableStream */
export async function fetchStream(
  path: string,
  options?: RequestInit
): Promise<Response> {
  const headers = getAuthHeaders(
    (options?.headers as Record<string, string>) || undefined
  );

  const res = await fetch(path, {
    ...options,
    headers,
    credentials: "include",
  });

  if (res.status === 401) handle401();

  if (!res.ok) {
    // 尝试从响应体提取错误信息
    let message = `HTTP ${res.status}`;
    try {
      const body = await res.json();
      message = body.error?.message || body.message || message;
    } catch { /* 忽略 */ }
    throw new ApiError(res.status, message);
  }

  return res;
}

/* ── 快捷方法 ── */
export const get = <T = unknown>(path: string) => api<T>(path);

export const post = <T = unknown>(path: string, body?: unknown) =>
  api<T>(path, {
    method: "POST",
    body: body ? JSON.stringify(body) : undefined,
  });

export const put = <T = unknown>(path: string, body?: unknown) =>
  api<T>(path, {
    method: "PUT",
    body: body ? JSON.stringify(body) : undefined,
  });

export const del = <T = unknown>(path: string) =>
  api<T>(path, { method: "DELETE" });
