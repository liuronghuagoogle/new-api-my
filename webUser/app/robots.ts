import type { MetadataRoute } from "next";

export default function robots(): MetadataRoute.Robots {
  const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || process.env.NEXT_PUBLIC_API_URL || "https://ai.facai.cloudns.org";

  return {
    rules: [
      {
        userAgent: "*",
        allow: ["/", "/guide", "/login", "/register", "/pricing"],
        disallow: ["/dashboard", "/tokens", "/logs", "/topup", "/settings", "/playground", "/api/"],
      },
    ],
    sitemap: `${siteUrl}/sitemap.xml`,
  };
}
