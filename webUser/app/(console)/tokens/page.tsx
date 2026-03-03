"use client";

import React, { useState, useEffect, useCallback } from "react";
import Topbar from "@/components/layout/topbar";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter,
} from "@/components/ui/dialog";
import {
  Table, TableHeader, TableBody, TableRow, TableHead, TableCell,
} from "@/components/ui/table";
import {
  Plus, Search, Copy, Trash2, ToggleLeft, ToggleRight, Eye, EyeOff,
  ChevronLeft, ChevronRight, Loader2, AlertCircle, Check,
} from "lucide-react";
import { getTokens, createToken, deleteToken, updateToken, getUserGroups } from "@/lib/api-hooks";
import type { GroupInfo } from "@/lib/api-hooks";
import type { Token } from "@/lib/types";
import { TokenStatus, TokenStatusLabel, formatQuota, formatTime } from "@/lib/types";

/* ---- Status badge styling ---- */
const statusVariantMap: Record<number, "success" | "warning" | "destructive" | "secondary"> = {
  [TokenStatus.ENABLED]: "success",
  [TokenStatus.DISABLED]: "warning",
  [TokenStatus.EXPIRED]: "destructive",
  [TokenStatus.EXHAUSTED]: "secondary",
};

/** Mask a key string: show first 8 chars + asterisks */
function maskKey(key: string): string {
  if (!key) return "sk-***";
  if (key.length <= 8) return key + "********************";
  return key.slice(0, 8) + "********************";
}

export default function TokensPage() {
  /* ---- State: data ---- */
  const [tokens, setTokens] = useState<Token[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  /* ---- State: filters & pagination ---- */
  const [search, setSearch] = useState("");
  const [page, setPage] = useState(1);
  const pageSize = 10;

  /* ---- State: reveal keys ---- */
  const [revealedKeys, setRevealedKeys] = useState<Set<number>>(new Set());

  /* ---- State: copied feedback ---- */
  const [copiedId, setCopiedId] = useState<number | null>(null);

  /* ---- State: create dialog ---- */
  const [createOpen, setCreateOpen] = useState(false);
  const [createName, setCreateName] = useState("");
  const [createQuota, setCreateQuota] = useState("");
  const [createUnlimited, setCreateUnlimited] = useState(true);
  const [createExpired, setCreateExpired] = useState("");
  const [createModelLimits, setCreateModelLimits] = useState("");
  const [createGroup, setCreateGroup] = useState("");
  const [creating, setCreating] = useState(false);
  const [createError, setCreateError] = useState<string | null>(null);

  /* ---- State: user groups ---- */
  const [groups, setGroups] = useState<Record<string, GroupInfo>>({});

  useEffect(() => {
    getUserGroups().then(setGroups).catch(() => {});
  }, []);

  /* ---- State: delete confirmation ---- */
  const [deleteTarget, setDeleteTarget] = useState<Token | null>(null);
  const [deleting, setDeleting] = useState(false);

  /* ---- State: toggling status ---- */
  const [togglingId, setTogglingId] = useState<number | null>(null);

  /* ---- Derived ---- */
  const totalPages = Math.max(1, Math.ceil(total / pageSize));

  /* ---- Fetch tokens ---- */
  const fetchTokens = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const result = await getTokens(page, pageSize, search);
      setTokens(result.items ?? []);
      setTotal(result.total ?? 0);
    } catch (err: any) {
      console.error("Failed to fetch tokens:", err);
      setError(err?.message || "加载令牌列表失败");
      setTokens([]);
      setTotal(0);
    } finally {
      setLoading(false);
    }
  }, [page, pageSize, search]);

  useEffect(() => {
    fetchTokens();
  }, [fetchTokens]);

  /* ---- Handlers ---- */
  const handleSearchChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setSearch(e.target.value);
    setPage(1);
  };

  const toggleReveal = (id: number) => {
    setRevealedKeys((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  };

  const handleCopyKey = async (token: Token) => {
    const textToCopy = token.key || `sk-${token.name}`;
    try {
      await navigator.clipboard.writeText(textToCopy);
      setCopiedId(token.id);
      setTimeout(() => setCopiedId(null), 2000);
    } catch {
      // fallback: ignore
    }
  };

  /* ---- Create token ---- */
  const resetCreateForm = () => {
    setCreateName("");
    setCreateQuota("");
    setCreateUnlimited(true);
    setCreateExpired("");
    setCreateModelLimits("");
    setCreateGroup("");
    setCreateError(null);
  };

  const handleCreate = async () => {
    if (!createName.trim()) {
      setCreateError("请输入令牌名称");
      return;
    }

    setCreating(true);
    setCreateError(null);

    try {
      const data: Parameters<typeof createToken>[0] = {
        name: createName.trim(),
      };

      if (createUnlimited) {
        data.unlimited_quota = true;
      } else {
        const quotaVal = parseInt(createQuota, 10);
        if (isNaN(quotaVal) || quotaVal < 0) {
          setCreateError("请输入有效的额度数值");
          setCreating(false);
          return;
        }
        data.remain_quota = quotaVal;
        data.unlimited_quota = false;
      }

      if (createExpired) {
        // Convert date string to Unix timestamp
        const ts = Math.floor(new Date(createExpired).getTime() / 1000);
        data.expired_time = ts;
      } else {
        data.expired_time = -1;
      }

      if (createModelLimits.trim()) {
        data.model_limits_enabled = true;
        data.model_limits = createModelLimits.trim();
      }

      if (createGroup) {
        data.group = createGroup;
      }

      await createToken(data);
      setCreateOpen(false);
      resetCreateForm();
      // Refresh list
      setPage(1);
      await fetchTokens();
    } catch (err: any) {
      console.error("Failed to create token:", err);
      setCreateError(err?.message || "创建令牌失败");
    } finally {
      setCreating(false);
    }
  };

  /* ---- Delete token ---- */
  const handleDelete = async () => {
    if (!deleteTarget) return;
    setDeleting(true);
    try {
      await deleteToken(deleteTarget.id);
      setDeleteTarget(null);
      await fetchTokens();
    } catch (err: any) {
      console.error("Failed to delete token:", err);
      alert(err?.message || "删除令牌失败");
    } finally {
      setDeleting(false);
    }
  };

  /* ---- Toggle status ---- */
  const handleToggleStatus = async (token: Token) => {
    const newStatus = token.status === TokenStatus.ENABLED
      ? TokenStatus.DISABLED
      : TokenStatus.ENABLED;

    setTogglingId(token.id);
    try {
      await updateToken({ id: token.id, status: newStatus }, true);
      await fetchTokens();
    } catch (err: any) {
      console.error("Failed to toggle token status:", err);
      alert(err?.message || "切换令牌状态失败");
    } finally {
      setTogglingId(null);
    }
  };

  /* ---- Pagination helpers ---- */
  const renderPageButtons = () => {
    const buttons: React.ReactNode[] = [];
    const maxVisible = 5;

    let start = Math.max(1, page - Math.floor(maxVisible / 2));
    let end = start + maxVisible - 1;
    if (end > totalPages) {
      end = totalPages;
      start = Math.max(1, end - maxVisible + 1);
    }

    if (start > 1) {
      buttons.push(
        <Button key={1} variant={page === 1 ? "default" : "outline"} size="icon" className="h-8 w-8" onClick={() => setPage(1)}>
          1
        </Button>
      );
      if (start > 2) {
        buttons.push(
          <span key="start-ellipsis" className="px-1 text-muted-foreground">...</span>
        );
      }
    }

    for (let i = start; i <= end; i++) {
      buttons.push(
        <Button
          key={i}
          variant={page === i ? "default" : "outline"}
          size="icon"
          className="h-8 w-8"
          onClick={() => setPage(i)}
        >
          {i}
        </Button>
      );
    }

    if (end < totalPages) {
      if (end < totalPages - 1) {
        buttons.push(
          <span key="end-ellipsis" className="px-1 text-muted-foreground">...</span>
        );
      }
      buttons.push(
        <Button key={totalPages} variant={page === totalPages ? "default" : "outline"} size="icon" className="h-8 w-8" onClick={() => setPage(totalPages)}>
          {totalPages}
        </Button>
      );
    }

    return buttons;
  };

  const rangeStart = total === 0 ? 0 : (page - 1) * pageSize + 1;
  const rangeEnd = Math.min(page * pageSize, total);

  return (
    <>
      <Topbar title="API 密钥" description="管理您的 API 访问令牌" />
      <div className="flex-1 overflow-y-auto scrollbar-thin">
        <div className="mx-auto max-w-6xl space-y-6 px-6 py-6">

          {/* Actions bar */}
          <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
            <div className="relative max-w-sm flex-1">
              <Search className="absolute left-3 top-1/2 h-3.5 w-3.5 -translate-y-1/2 text-muted-foreground" />
              <Input
                placeholder="按名称或密钥搜索..."
                value={search}
                onChange={handleSearchChange}
                className="pl-9"
              />
            </div>
            <Button onClick={() => { resetCreateForm(); setCreateOpen(true); }}>
              <Plus className="h-4 w-4" />
              创建密钥
            </Button>
          </div>

          {/* Error state */}
          {error && !loading && (
            <Card>
              <CardContent className="flex items-center justify-center gap-2 py-12">
                <AlertCircle className="h-5 w-5 text-destructive" />
                <span className="text-body-sm text-destructive">{error}</span>
                <Button variant="outline" size="sm" className="ml-4" onClick={fetchTokens}>
                  重试
                </Button>
              </CardContent>
            </Card>
          )}

          {/* Loading state */}
          {loading && (
            <Card>
              <CardContent className="flex items-center justify-center py-20">
                <Loader2 className="h-5 w-5 animate-spin text-muted-foreground" />
                <span className="ml-2 text-body-sm text-muted-foreground">加载中...</span>
              </CardContent>
            </Card>
          )}

          {/* Tokens table */}
          {!loading && !error && (
            <Card>
              <CardContent className="p-0">
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>名称</TableHead>
                      <TableHead>密钥</TableHead>
                      <TableHead>状态</TableHead>
                      <TableHead>分组</TableHead>
                      <TableHead className="text-right">已用</TableHead>
                      <TableHead className="text-right">额度</TableHead>
                      <TableHead>创建时间</TableHead>
                      <TableHead className="text-right">操作</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {tokens.map((token) => {
                      const variant = statusVariantMap[token.status] ?? "secondary";
                      const label = TokenStatusLabel[token.status] ?? "未知";
                      const revealed = revealedKeys.has(token.id);
                      const isToggling = togglingId === token.id;
                      const isCopied = copiedId === token.id;

                      return (
                        <TableRow key={token.id}>
                          <TableCell className="font-medium">{token.name}</TableCell>
                          <TableCell>
                            <div className="flex items-center gap-2">
                              <code className="rounded bg-muted px-1.5 py-0.5 font-mono text-body-sm">
                                {revealed && token.key ? token.key : maskKey(token.key)}
                              </code>
                              <button
                                onClick={() => toggleReveal(token.id)}
                                className="text-muted-foreground hover:text-foreground cursor-pointer"
                              >
                                {revealed ? <EyeOff className="h-3.5 w-3.5" /> : <Eye className="h-3.5 w-3.5" />}
                              </button>
                            </div>
                          </TableCell>
                          <TableCell>
                            <Badge variant={variant}>{label}</Badge>
                          </TableCell>
                          <TableCell>
                            <Badge variant={/vip/i.test(token.group) ? "warning" : "secondary"}>
                              {token.group || "default"}
                            </Badge>
                          </TableCell>
                          <TableCell className="text-right tabular-nums">
                            ${formatQuota(token.used_quota)}
                          </TableCell>
                          <TableCell className="text-right tabular-nums">
                            {token.unlimited_quota ? "无限制" : `$${formatQuota(token.remain_quota)}`}
                          </TableCell>
                          <TableCell className="text-muted-foreground">
                            {formatTime(token.created_time)}
                          </TableCell>
                          <TableCell className="text-right">
                            <div className="flex items-center justify-end gap-1">
                              <Button
                                variant="ghost"
                                size="icon"
                                className="h-8 w-8"
                                title="复制密钥"
                                onClick={() => handleCopyKey(token)}
                              >
                                {isCopied
                                  ? <Check className="h-3.5 w-3.5 text-success" />
                                  : <Copy className="h-3.5 w-3.5" />
                                }
                              </Button>
                              <Button
                                variant="ghost"
                                size="icon"
                                className="h-8 w-8"
                                title={token.status === TokenStatus.ENABLED ? "禁用" : "启用"}
                                disabled={isToggling}
                                onClick={() => handleToggleStatus(token)}
                              >
                                {isToggling ? (
                                  <Loader2 className="h-3.5 w-3.5 animate-spin" />
                                ) : token.status === TokenStatus.ENABLED ? (
                                  <ToggleRight className="h-3.5 w-3.5" />
                                ) : (
                                  <ToggleLeft className="h-3.5 w-3.5" />
                                )}
                              </Button>
                              <Button
                                variant="ghost"
                                size="icon"
                                className="h-8 w-8 text-destructive hover:text-destructive"
                                title="删除"
                                onClick={() => setDeleteTarget(token)}
                              >
                                <Trash2 className="h-3.5 w-3.5" />
                              </Button>
                            </div>
                          </TableCell>
                        </TableRow>
                      );
                    })}
                    {tokens.length === 0 && (
                      <TableRow>
                        <TableCell colSpan={8} className="py-12 text-center">
                          <div className="flex flex-col items-center gap-2">
                            <AlertCircle className="h-5 w-5 text-muted-foreground" />
                            <span className="text-body-sm text-muted-foreground">
                              {search ? "未找到匹配的令牌" : "暂无令牌，点击上方按钮创建"}
                            </span>
                          </div>
                        </TableCell>
                      </TableRow>
                    )}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          )}

          {/* Pagination */}
          {!loading && !error && total > 0 && (
            <div className="flex items-center justify-between">
              <p className="text-body-sm text-muted-foreground">
                显示 {rangeStart}-{rangeEnd} 条，共 {total} 条结果
              </p>
              <div className="flex items-center gap-1">
                <Button
                  variant="outline"
                  size="icon"
                  className="h-8 w-8"
                  disabled={page <= 1}
                  onClick={() => setPage((p) => p - 1)}
                >
                  <ChevronLeft className="h-4 w-4" />
                </Button>
                {renderPageButtons()}
                <Button
                  variant="outline"
                  size="icon"
                  className="h-8 w-8"
                  disabled={page >= totalPages}
                  onClick={() => setPage((p) => p + 1)}
                >
                  <ChevronRight className="h-4 w-4" />
                </Button>
              </div>
            </div>
          )}

        </div>
      </div>

      {/* Create Token Dialog */}
      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>创建 API 密钥</DialogTitle>
            <DialogDescription>创建新的 API 密钥以访问服务。</DialogDescription>
          </DialogHeader>
          <div className="space-y-4 py-2">
            <div className="space-y-1.5">
              <label className="text-sm font-medium">名称</label>
              <Input
                placeholder="例如：生产环境"
                value={createName}
                onChange={(e) => setCreateName(e.target.value)}
              />
            </div>
            <div className="space-y-1.5">
              <div className="flex items-center justify-between">
                <label className="text-sm font-medium">额度限制</label>
                <label className="flex items-center gap-2 text-sm text-muted-foreground cursor-pointer">
                  <input
                    type="checkbox"
                    checked={createUnlimited}
                    onChange={(e) => setCreateUnlimited(e.target.checked)}
                    className="rounded border-border"
                  />
                  无限额度
                </label>
              </div>
              {!createUnlimited && (
                <Input
                  type="number"
                  placeholder="500000（内部额度单位）"
                  value={createQuota}
                  onChange={(e) => setCreateQuota(e.target.value)}
                />
              )}
            </div>
            <div className="space-y-1.5">
              <label className="text-sm font-medium">过期时间</label>
              <Input
                type="datetime-local"
                value={createExpired}
                onChange={(e) => setCreateExpired(e.target.value)}
              />
              <p className="text-caption text-muted-foreground">留空表示永不过期</p>
            </div>
            <div className="space-y-1.5">
              <label className="text-sm font-medium">令牌分组</label>
              {Object.keys(groups).length > 0 ? (
                <select
                  value={createGroup}
                  onChange={(e) => setCreateGroup(e.target.value)}
                  className="flex h-9 w-full rounded-md border border-input bg-transparent px-3 py-1 text-sm shadow-sm transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring"
                >
                  <option value="">默认（跟随用户分组）</option>
                  {Object.entries(groups).map(([key, info]) => (
                    <option key={key} value={key}>
                      {key}{info.desc ? ` - ${info.desc}` : ""}{info.ratio ? ` (倍率: ${info.ratio})` : ""}
                    </option>
                  ))}
                </select>
              ) : (
                <select disabled className="flex h-9 w-full rounded-md border border-input bg-muted px-3 py-1 text-sm text-muted-foreground">
                  <option>管理员未设置可选分组</option>
                </select>
              )}
              <p className="text-caption text-muted-foreground">选择令牌使用的渠道分组</p>
            </div>
            <div className="space-y-1.5">
              <label className="text-sm font-medium">允许的模型（可选）</label>
              <Input
                placeholder="gpt-4o, claude-3.5-sonnet"
                value={createModelLimits}
                onChange={(e) => setCreateModelLimits(e.target.value)}
              />
              <p className="text-caption text-muted-foreground">逗号分隔，留空表示不限制</p>
            </div>
            {createError && (
              <p className="text-body-sm text-destructive">{createError}</p>
            )}
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setCreateOpen(false)} disabled={creating}>
              取消
            </Button>
            <Button onClick={handleCreate} disabled={creating}>
              {creating && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
              创建
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Delete Confirmation Dialog */}
      <Dialog open={!!deleteTarget} onOpenChange={(open) => { if (!open) setDeleteTarget(null); }}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>确认删除</DialogTitle>
            <DialogDescription>
              确定要删除令牌「{deleteTarget?.name}」吗？此操作不可撤销。
            </DialogDescription>
          </DialogHeader>
          <DialogFooter>
            <Button variant="outline" onClick={() => setDeleteTarget(null)} disabled={deleting}>
              取消
            </Button>
            <Button variant="destructive" onClick={handleDelete} disabled={deleting}>
              {deleting && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
              删除
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </>
  );
}
