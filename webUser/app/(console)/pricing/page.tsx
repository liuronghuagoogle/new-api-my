"use client";

import React, { useState, useEffect, useCallback, useMemo } from "react";
import Topbar from "@/components/layout/topbar";
import { Card, CardContent } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Table, TableHeader, TableBody, TableRow, TableHead, TableCell,
} from "@/components/ui/table";
import { Search, Loader2, AlertCircle, ArrowUpDown, Info } from "lucide-react";
import { getPricing } from "@/lib/api-hooks";
import type { Pricing, PricingVendor } from "@/lib/types";
import { QUOTA_PER_UNIT } from "@/lib/types";

/* ── 端点类型 → 中文标签映射 ── */
const endpointTypeLabels: Record<string, string> = {
  "openai": "对话",
  "openai-response": "对话(Response)",
  "openai-response-compact": "对话(Compact)",
  "anthropic": "对话(Claude)",
  "gemini": "对话(Gemini)",
  "embeddings": "向量",
  "image-generation": "图片生成",
  "openai-video": "视频",
  "jina-rerank": "重排序",
};

/* ── 根据端点类型推断模型主要类型 ── */
function inferModelType(endpoints?: string[]): string {
  if (!endpoints || endpoints.length === 0) return "未知";
  if (endpoints.includes("image-generation")) return "图片";
  if (endpoints.includes("embeddings")) return "向量";
  if (endpoints.includes("openai-video")) return "视频";
  if (endpoints.includes("jina-rerank")) return "重排序";
  if (
    endpoints.includes("openai") ||
    endpoints.includes("anthropic") ||
    endpoints.includes("gemini") ||
    endpoints.includes("openai-response") ||
    endpoints.includes("openai-response-compact")
  ) {
    return "对话";
  }
  return "其他";
}

/* ── 类型对应的 Badge variant ── */
function getTypeBadgeVariant(type: string): "default" | "secondary" | "outline" | "success" | "warning" | "destructive" {
  switch (type) {
    case "对话": return "default";
    case "图片": return "warning";
    case "向量": return "secondary";
    case "视频": return "success";
    case "重排序": return "outline";
    default: return "outline";
  }
}

/* ── 计算每百万 token 的 USD 价格 ── */
// 后端内部：quota_type=0 使用 model_ratio (倍率)，quota_type=1 使用 model_price (固定价格)
// model_ratio：相对于 gpt-4o-mini（ratio=1）的倍率，基准价为 $0.75/M prompt, $3/M completion
// model_price：单位为 QUOTA_PER_UNIT（500000）= $1
const BASE_PROMPT_PRICE = 0.75;   // $/M tokens
const BASE_COMPLETION_PRICE = 3;   // $/M tokens

function calcPrice(m: Pricing): { prompt: number; completion: number } {
  if (m.quota_type === 1) {
    // 固定价格模式: model_price 单位 = QUOTA_PER_UNIT = $1
    const promptPrice = m.model_price / QUOTA_PER_UNIT;
    const completionPrice = promptPrice * (m.completion_ratio > 0 ? m.completion_ratio : 1);
    return { prompt: promptPrice, completion: completionPrice };
  }
  // 倍率模式
  const ratio = m.model_ratio;
  const completionRatio = m.completion_ratio > 0 ? m.completion_ratio : 1;
  return {
    prompt: BASE_PROMPT_PRICE * ratio,
    completion: BASE_COMPLETION_PRICE * ratio * completionRatio,
  };
}

/* ── 排序字段类型 ── */
type SortField = "model" | "vendor" | "type" | "prompt" | "completion";
type SortDir = "asc" | "desc";

export default function PricingPage() {
  const [models, setModels] = useState<Pricing[]>([]);
  const [vendorsMap, setVendorsMap] = useState<Record<number, PricingVendor>>({});
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [search, setSearch] = useState("");
  const [vendorFilter, setVendorFilter] = useState<string>("all");
  const [typeFilter, setTypeFilter] = useState<string>("all");
  const [sortField, setSortField] = useState<SortField>("model");
  const [sortDir, setSortDir] = useState<SortDir>("asc");

  /* ── 加载数据 ── */
  const loadPricing = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const res = await getPricing();
      setModels(res.data ?? []);
      // 构建 vendor map
      const vMap: Record<number, PricingVendor> = {};
      if (Array.isArray(res.vendors)) {
        for (const v of res.vendors) {
          vMap[v.id] = v;
        }
      }
      setVendorsMap(vMap);
    } catch (err) {
      setError(err instanceof Error ? err.message : "加载定价数据失败");
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    loadPricing();
  }, [loadPricing]);

  /* ── 获取供应商名称 ── */
  const getVendorName = useCallback((m: Pricing) => {
    if (m.vendor_id && vendorsMap[m.vendor_id]) {
      return vendorsMap[m.vendor_id].name;
    }
    return m.owner_by || "未知";
  }, [vendorsMap]);

  /* ── 从数据中提取可用的厂商和类型列表 ── */
  const vendors = useMemo(() => {
    const set = new Set(models.map((m) => getVendorName(m)));
    return Array.from(set).sort();
  }, [models, getVendorName]);

  const modelTypes = useMemo(() => {
    const set = new Set(models.map((m) => inferModelType(m.supported_endpoint_types)));
    return Array.from(set).sort();
  }, [models]);

  /* ── 过滤 ── */
  const filtered = useMemo(() => {
    return models.filter((m) => {
      if (search && !m.model_name.toLowerCase().includes(search.toLowerCase())) return false;
      if (vendorFilter !== "all" && getVendorName(m) !== vendorFilter) return false;
      if (typeFilter !== "all" && inferModelType(m.supported_endpoint_types) !== typeFilter) return false;
      return true;
    });
  }, [models, search, vendorFilter, typeFilter, getVendorName]);

  /* ── 排序 ── */
  const sorted = useMemo(() => {
    const arr = [...filtered];
    arr.sort((a, b) => {
      let cmp = 0;
      switch (sortField) {
        case "model":
          cmp = a.model_name.localeCompare(b.model_name);
          break;
        case "vendor":
          cmp = getVendorName(a).localeCompare(getVendorName(b));
          break;
        case "type":
          cmp = inferModelType(a.supported_endpoint_types).localeCompare(inferModelType(b.supported_endpoint_types));
          break;
        case "prompt":
          cmp = calcPrice(a).prompt - calcPrice(b).prompt;
          break;
        case "completion":
          cmp = calcPrice(a).completion - calcPrice(b).completion;
          break;
      }
      return sortDir === "asc" ? cmp : -cmp;
    });
    return arr;
  }, [filtered, sortField, sortDir, getVendorName]);

  /* ── 排序切换 ── */
  const toggleSort = (field: SortField) => {
    if (sortField === field) {
      setSortDir((prev) => (prev === "asc" ? "desc" : "asc"));
    } else {
      setSortField(field);
      setSortDir("asc");
    }
  };

  /* ── 列头渲染（可排序） ── */
  const SortableHead = ({ field, label, className }: { field: SortField; label: string; className?: string }) => (
    <TableHead className={className}>
      <button
        onClick={() => toggleSort(field)}
        className="inline-flex items-center gap-1 hover:text-foreground cursor-pointer"
      >
        {label}
        <ArrowUpDown className={`h-3 w-3 ${sortField === field ? "text-foreground" : "text-muted-foreground/50"}`} />
      </button>
    </TableHead>
  );

  return (
    <>
      <Topbar title="模型定价" description="可用模型列表与费率信息" />
      <div className="flex-1 overflow-y-auto scrollbar-thin">
        <div className="mx-auto max-w-6xl space-y-6 px-6 py-6">

          {/* 提示信息 */}
          <div className="flex items-start gap-3 rounded-lg border border-border bg-muted/30 px-4 py-3">
            <Info className="mt-0.5 h-4 w-4 shrink-0 text-muted-foreground" />
            <div className="text-sm text-muted-foreground">
              以下为当前可用模型及其定价信息。价格单位为 USD/百万 Token，实际消费以调用时系统费率为准。
            </div>
          </div>

          {/* 筛选器 */}
          <div className="flex flex-col gap-3 sm:flex-row sm:items-center">
            <div className="relative max-w-sm flex-1">
              <Search className="absolute left-3 top-1/2 h-3.5 w-3.5 -translate-y-1/2 text-muted-foreground" />
              <Input
                placeholder="搜索模型..."
                value={search}
                onChange={(e) => setSearch(e.target.value)}
                className="pl-9"
              />
            </div>
            <div className="flex items-center gap-2">
              <select
                value={vendorFilter}
                onChange={(e) => setVendorFilter(e.target.value)}
                className="rounded-md border border-border bg-transparent px-3 py-2 text-sm"
              >
                <option value="all">全部厂商</option>
                {vendors.map((v) => (
                  <option key={v} value={v}>{v}</option>
                ))}
              </select>
              <select
                value={typeFilter}
                onChange={(e) => setTypeFilter(e.target.value)}
                className="rounded-md border border-border bg-transparent px-3 py-2 text-sm"
              >
                <option value="all">全部类型</option>
                {modelTypes.map((t) => (
                  <option key={t} value={t}>{t}</option>
                ))}
              </select>
            </div>
            {!loading && (
              <div className="text-sm text-muted-foreground ml-auto">
                共 {sorted.length} 个模型
                {sorted.length !== models.length && ` (总计 ${models.length})`}
              </div>
            )}
          </div>

          {/* 加载状态 */}
          {loading && (
            <Card>
              <CardContent className="flex items-center justify-center py-16">
                <Loader2 className="h-6 w-6 animate-spin text-muted-foreground" />
                <span className="ml-3 text-muted-foreground">加载定价数据中...</span>
              </CardContent>
            </Card>
          )}

          {/* 错误状态 */}
          {!loading && error && (
            <Card>
              <CardContent className="flex flex-col items-center justify-center py-16">
                <AlertCircle className="h-8 w-8 text-destructive" />
                <p className="mt-3 text-sm text-destructive">{error}</p>
                <button
                  onClick={loadPricing}
                  className="mt-4 rounded-md bg-primary px-4 py-2 text-sm text-primary-foreground hover:bg-primary/90"
                >
                  重试
                </button>
              </CardContent>
            </Card>
          )}

          {/* 模型表格 */}
          {!loading && !error && (
            <Card>
              <CardContent className="p-0">
                <Table>
                  <TableHeader>
                    <TableRow>
                      <SortableHead field="model" label="模型" />
                      <SortableHead field="vendor" label="厂商" />
                      <SortableHead field="type" label="类型" />
                      <SortableHead field="prompt" label="输入价格" className="text-right" />
                      <SortableHead field="completion" label="输出价格" className="text-right" />
                      <TableHead>端点</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {sorted.map((m) => {
                      const modelType = inferModelType(m.supported_endpoint_types);
                      const price = calcPrice(m);
                      const vendor = getVendorName(m);
                      return (
                        <TableRow key={m.model_name}>
                          <TableCell>
                            <code className="font-mono text-body-sm font-medium">{m.model_name}</code>
                          </TableCell>
                          <TableCell>
                            <Badge variant="outline">{vendor}</Badge>
                          </TableCell>
                          <TableCell>
                            <Badge variant={getTypeBadgeVariant(modelType)}>{modelType}</Badge>
                          </TableCell>
                          <TableCell className="text-right tabular-nums font-mono text-body-sm">
                            ${price.prompt < 0.001 ? price.prompt.toFixed(4) : price.prompt.toFixed(3)}
                          </TableCell>
                          <TableCell className="text-right tabular-nums font-mono text-body-sm">
                            ${price.completion < 0.001 ? price.completion.toFixed(4) : price.completion.toFixed(3)}
                          </TableCell>
                          <TableCell>
                            <div className="flex flex-wrap gap-1">
                              {m.supported_endpoint_types && m.supported_endpoint_types.length > 0 ? (
                                m.supported_endpoint_types.map((ep) => (
                                  <span
                                    key={ep}
                                    className="inline-block rounded bg-muted px-1.5 py-0.5 text-xs text-muted-foreground"
                                  >
                                    {endpointTypeLabels[ep] || ep}
                                  </span>
                                ))
                              ) : (
                                <span className="text-xs text-muted-foreground">--</span>
                              )}
                            </div>
                          </TableCell>
                        </TableRow>
                      );
                    })}
                    {sorted.length === 0 && (
                      <TableRow>
                        <TableCell colSpan={6} className="py-12 text-center text-muted-foreground">
                          {models.length === 0 ? "暂无可用模型。" : "未找到匹配的模型。"}
                        </TableCell>
                      </TableRow>
                    )}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          )}

        </div>
      </div>
    </>
  );
}
