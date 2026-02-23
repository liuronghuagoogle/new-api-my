import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

/**
 * API 代理中间件
 *
 * /api/* — 使用 NextResponse.rewrite()，保留完整路径（含尾斜杠）。
 * /pg/*  — 手动 fetch 代理，透传 ReadableStream 以支持 SSE 流式响应。
 *
 * 使用 middleware 而非 next.config.mjs rewrites，因为 rewrites 的
 * :path* 参数会丢掉尾斜杠，导致与 Gin RedirectTrailingSlash 冲突。
 */
export async function middleware(request: NextRequest) {
  const apiBase = process.env.NEXT_PUBLIC_API_URL;
  if (!apiBase) {
    return NextResponse.json(
      { success: false, message: "NEXT_PUBLIC_API_URL 未配置" },
      { status: 502 }
    );
  }

  const { pathname, search } = request.nextUrl;
  const target = new URL(pathname + search, apiBase);

  // /pg/* 路径用于流式请求（SSE），需要手动代理以透传 ReadableStream
  if (pathname.startsWith("/pg/")) {
    const headers = new Headers(request.headers);
    // 移除 Next.js 自动添加的 host header，使用目标 host
    headers.set("host", target.host);

    const proxyRes = await fetch(target.toString(), {
      method: request.method,
      headers,
      body: request.body,
      // @ts-expect-error -- Node.js fetch 支持 duplex 用于流式请求体
      duplex: "half",
    });

    // 透传响应，保留流式 body
    return new Response(proxyRes.body, {
      status: proxyRes.status,
      statusText: proxyRes.statusText,
      headers: proxyRes.headers,
    });
  }

  // /api/* 路径用于普通 JSON 请求，使用 rewrite 代理
  return NextResponse.rewrite(target);
}

export const config = {
  matcher: ["/api/:path*", "/pg/:path*"],
};
