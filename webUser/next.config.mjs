/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  skipTrailingSlashRedirect: true,
  async redirects() {
    return [
      // 精确映射：旧路径名与新路径名不同
      { source: "/console", destination: "/dashboard", permanent: true },
      { source: "/console/personal", destination: "/settings", permanent: true },
      { source: "/console/token", destination: "/tokens", permanent: true },
      { source: "/console/log", destination: "/logs", permanent: true },
      // 通配兜底：其余 /console/* 直接去掉前缀
      {
        source: "/console/:path*",
        destination: "/:path*",
        permanent: true,
      },
    ];
  },
};

export default nextConfig;
