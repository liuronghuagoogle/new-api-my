"use client";

import React, { useState, useRef, useEffect, useCallback } from "react";
import Topbar from "@/components/layout/topbar";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Separator } from "@/components/ui/separator";
import {
  Send,
  Settings2,
  RotateCcw,
  User,
  Bot,
  Loader2,
  AlertCircle,
  Square,
} from "lucide-react";
import { cn } from "@/lib/utils";
import { getModels } from "@/lib/api-hooks";
import { fetchStream } from "@/lib/api";

interface Message {
  role: "system" | "user" | "assistant";
  content: string;
}

export default function PlaygroundPage() {
  const [messages, setMessages] = useState<Message[]>([]);
  const [input, setInput] = useState("");
  const [models, setModels] = useState<string[]>([]);
  const [modelsLoading, setModelsLoading] = useState(true);
  const [modelsError, setModelsError] = useState("");
  const [selectedModel, setSelectedModel] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [showSettings, setShowSettings] = useState(false);
  const [temperature, setTemperature] = useState("0.7");
  const [maxTokens, setMaxTokens] = useState("2048");
  const [systemPrompt, setSystemPrompt] = useState("");
  const [errorMsg, setErrorMsg] = useState("");
  const messagesEndRef = useRef<HTMLDivElement>(null);
  const abortControllerRef = useRef<AbortController | null>(null);

  // Scroll to bottom when messages change
  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages]);

  // Fetch models on mount
  useEffect(() => {
    let cancelled = false;
    async function fetchModels() {
      setModelsLoading(true);
      setModelsError("");
      try {
        const data = await getModels();
        if (cancelled) return;
        setModels(data);
        if (data.length > 0) {
          setSelectedModel(data[0]);
        }
      } catch (err: unknown) {
        if (cancelled) return;
        const message =
          err instanceof Error ? err.message : "Failed to load models";
        setModelsError(message);
      } finally {
        if (!cancelled) setModelsLoading(false);
      }
    }
    fetchModels();
    return () => {
      cancelled = true;
    };
  }, []);

  // Stop ongoing generation
  const handleStop = useCallback(() => {
    if (abortControllerRef.current) {
      abortControllerRef.current.abort();
      abortControllerRef.current = null;
    }
    setIsLoading(false);
  }, []);

  // Send message and stream response
  const handleSend = useCallback(async () => {
    const text = input.trim();
    if (!text || isLoading || !selectedModel) return;

    setErrorMsg("");
    const userMsg: Message = { role: "user", content: text };
    setInput("");

    setMessages((prev) => [...prev, userMsg]);
    setIsLoading(true);

    // Build message list for API
    const apiMessages: { role: string; content: string }[] = [];
    if (systemPrompt.trim()) {
      apiMessages.push({ role: "system", content: systemPrompt.trim() });
    }
    // Include all previous messages (excluding system — we add it above)
    const allMessages = [...messages, userMsg];
    for (const msg of allMessages) {
      if (msg.role !== "system") {
        apiMessages.push({ role: msg.role, content: msg.content });
      }
    }

    const controller = new AbortController();
    abortControllerRef.current = controller;

    try {
      const res = await fetchStream("/pg/chat/completions", {
        method: "POST",
        signal: controller.signal,
        body: JSON.stringify({
          model: selectedModel,
          messages: apiMessages,
          stream: true,
          temperature: parseFloat(temperature),
          max_tokens: parseInt(maxTokens, 10),
        }),
      });

      if (!res.body) {
        throw new Error("Response body is empty");
      }

      // Append an empty assistant message that we'll stream into
      const assistantIdx = messages.length + 1; // index in the new messages array
      setMessages((prev) => [...prev, { role: "assistant", content: "" }]);

      const reader = res.body.getReader();
      const decoder = new TextDecoder();
      let buffer = "";
      let fullContent = "";

      while (true) {
        const { done, value } = await reader.read();
        if (done) break;

        buffer += decoder.decode(value, { stream: true });

        // Process complete SSE lines
        const lines = buffer.split("\n");
        // Keep the last potentially incomplete line in the buffer
        buffer = lines.pop() || "";

        for (const line of lines) {
          const trimmed = line.trim();
          if (!trimmed || trimmed.startsWith(":")) continue;

          if (trimmed === "data: [DONE]") {
            continue;
          }

          if (trimmed.startsWith("data: ")) {
            const jsonStr = trimmed.slice(6);
            try {
              const parsed = JSON.parse(jsonStr);
              const delta = parsed?.choices?.[0]?.delta;
              if (delta?.content) {
                fullContent += delta.content;
                const updatedContent = fullContent;
                setMessages((prev) => {
                  const updated = [...prev];
                  const idx = assistantIdx;
                  if (idx < updated.length) {
                    updated[idx] = {
                      ...updated[idx],
                      content: updatedContent,
                    };
                  }
                  return updated;
                });
              }
            } catch {
              // Skip malformed JSON chunks
            }
          }
        }
      }

      // Process any remaining buffer
      if (buffer.trim()) {
        const trimmed = buffer.trim();
        if (
          trimmed.startsWith("data: ") &&
          trimmed !== "data: [DONE]"
        ) {
          const jsonStr = trimmed.slice(6);
          try {
            const parsed = JSON.parse(jsonStr);
            const delta = parsed?.choices?.[0]?.delta;
            if (delta?.content) {
              fullContent += delta.content;
              const updatedContent = fullContent;
              setMessages((prev) => {
                const updated = [...prev];
                if (assistantIdx < updated.length) {
                  updated[assistantIdx] = {
                    ...updated[assistantIdx],
                    content: updatedContent,
                  };
                }
                return updated;
              });
            }
          } catch {
            // ignore
          }
        }
      }
    } catch (err: unknown) {
      if (err instanceof DOMException && err.name === "AbortError") {
        // User cancelled — no error needed
      } else {
        const message =
          err instanceof Error ? err.message : "Unknown error";
        setErrorMsg(message);
        // Remove the empty assistant message if nothing was streamed
        setMessages((prev) => {
          const last = prev[prev.length - 1];
          if (last && last.role === "assistant" && last.content === "") {
            return prev.slice(0, -1);
          }
          return prev;
        });
      }
    } finally {
      abortControllerRef.current = null;
      setIsLoading(false);
    }
  }, [input, isLoading, selectedModel, systemPrompt, messages, temperature, maxTokens]);

  // Reset conversation
  const handleReset = useCallback(() => {
    if (isLoading) {
      handleStop();
    }
    setMessages([]);
    setErrorMsg("");
  }, [isLoading, handleStop]);

  return (
    <>
      <Topbar title="在线对话" description="测试和体验 AI 模型" />
      <div className="flex flex-1 overflow-hidden">
        {/* Chat area */}
        <div className="flex flex-1 flex-col">
          {/* Model selector bar */}
          <div className="flex items-center gap-3 border-b border-border px-6 py-3">
            {modelsLoading ? (
              <div className="flex items-center gap-2 text-sm text-muted-foreground">
                <Loader2 className="h-3.5 w-3.5 animate-spin" />
                加载模型列表...
              </div>
            ) : modelsError ? (
              <div className="flex items-center gap-2 text-sm text-destructive">
                <AlertCircle className="h-3.5 w-3.5" />
                {modelsError}
                <Button
                  variant="ghost"
                  size="sm"
                  onClick={() => window.location.reload()}
                >
                  重试
                </Button>
              </div>
            ) : (
              <select
                value={selectedModel}
                onChange={(e) => setSelectedModel(e.target.value)}
                className="rounded-md border border-border bg-transparent px-3 py-1.5 text-sm font-medium"
              >
                {models.map((m) => (
                  <option key={m} value={m}>
                    {m}
                  </option>
                ))}
              </select>
            )}
            <Badge variant="secondary">
              温度：{temperature}
            </Badge>
            <Badge variant="secondary">
              最大：{maxTokens}
            </Badge>
            <div className="flex-1" />
            <Button
              variant="ghost"
              size="sm"
              onClick={() => setShowSettings(!showSettings)}
            >
              <Settings2 className="h-3.5 w-3.5" /> 设置
            </Button>
            <Button variant="ghost" size="sm" onClick={handleReset}>
              <RotateCcw className="h-3.5 w-3.5" /> 清空
            </Button>
          </div>

          {/* Messages */}
          <div className="flex-1 overflow-y-auto scrollbar-thin">
            <div className="mx-auto max-w-5xl space-y-1 px-6 py-6">
              {messages.length === 0 && !isLoading && (
                <div className="flex flex-col items-center justify-center py-20 text-muted-foreground">
                  <Bot className="mb-4 h-10 w-10 opacity-30" />
                  <p className="text-sm">
                    选择模型并发送消息开始对话
                  </p>
                </div>
              )}
              {messages
                .filter((msg) => msg.role !== "system")
                .map((msg, i) => (
                  <div
                    key={i}
                    className={cn(
                      "flex gap-3 rounded-lg px-4 py-4",
                      msg.role === "user"
                        ? "bg-transparent"
                        : "bg-muted/40"
                    )}
                  >
                    <div
                      className={cn(
                        "flex h-7 w-7 shrink-0 items-center justify-center rounded-md text-xs",
                        msg.role === "user"
                          ? "bg-foreground/10 text-foreground"
                          : "bg-primary/10 text-primary"
                      )}
                    >
                      {msg.role === "user" ? (
                        <User className="h-3.5 w-3.5" />
                      ) : (
                        <Bot className="h-3.5 w-3.5" />
                      )}
                    </div>
                    <div className="flex-1 text-sm leading-relaxed whitespace-pre-wrap">
                      {msg.content}
                      {isLoading &&
                        msg.role === "assistant" &&
                        i ===
                          messages.filter((m) => m.role !== "system")
                            .length -
                            1 && (
                          <span className="ml-0.5 inline-block h-4 w-1.5 animate-pulse bg-foreground/60" />
                        )}
                    </div>
                  </div>
                ))}
              {isLoading &&
                (messages.length === 0 ||
                  messages[messages.length - 1]?.role === "user") && (
                  <div className="flex gap-3 rounded-lg bg-muted/40 px-4 py-4">
                    <div className="flex h-7 w-7 shrink-0 items-center justify-center rounded-md bg-primary/10 text-primary text-xs">
                      <Bot className="h-3.5 w-3.5" />
                    </div>
                    <Loader2 className="h-4 w-4 animate-spin text-muted-foreground mt-0.5" />
                  </div>
                )}
              {errorMsg && (
                <div className="flex items-center gap-2 rounded-lg border border-destructive/30 bg-destructive/5 px-4 py-3 text-sm text-destructive">
                  <AlertCircle className="h-4 w-4 shrink-0" />
                  <span>{errorMsg}</span>
                </div>
              )}
              <div ref={messagesEndRef} />
            </div>
          </div>

          {/* Input */}
          <div className="border-t border-border px-6 py-4">
            <div className="mx-auto flex max-w-5xl gap-2">
              <Input
                value={input}
                onChange={(e) => setInput(e.target.value)}
                onKeyDown={(e) => {
                  if (e.key === "Enter" && !e.shiftKey) {
                    e.preventDefault();
                    handleSend();
                  }
                }}
                placeholder="输入消息..."
                className="flex-1"
                disabled={isLoading}
              />
              {isLoading ? (
                <Button onClick={handleStop} variant="destructive">
                  <Square className="h-4 w-4" />
                </Button>
              ) : (
                <Button
                  onClick={handleSend}
                  disabled={
                    !input.trim() || !selectedModel || modelsLoading
                  }
                >
                  <Send className="h-4 w-4" />
                </Button>
              )}
            </div>
          </div>
        </div>

        {/* Settings panel */}
        {showSettings && (
          <div className="w-72 border-l border-border bg-panel p-5 space-y-5 overflow-y-auto">
            <h3 className="font-display text-sm font-semibold">
              参数
            </h3>
            <div className="space-y-4">
              <div className="space-y-1.5">
                <label className="text-caption font-medium">温度</label>
                <Input
                  type="number"
                  step="0.1"
                  min="0"
                  max="2"
                  value={temperature}
                  onChange={(e) => setTemperature(e.target.value)}
                />
                <input
                  type="range"
                  min="0"
                  max="2"
                  step="0.1"
                  value={temperature}
                  onChange={(e) => setTemperature(e.target.value)}
                  className="w-full accent-primary"
                />
              </div>
              <div className="space-y-1.5">
                <label className="text-caption font-medium">
                  最大 Token 数
                </label>
                <Input
                  type="number"
                  min="1"
                  max="128000"
                  value={maxTokens}
                  onChange={(e) => setMaxTokens(e.target.value)}
                />
              </div>
              <Separator />
              <div className="space-y-1.5">
                <label className="text-caption font-medium">
                  系统提示词
                </label>
                <textarea
                  className="w-full rounded-md border border-border bg-transparent p-2 text-sm placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring/40"
                  rows={4}
                  placeholder="你是一个有帮助的助手..."
                  value={systemPrompt}
                  onChange={(e) => setSystemPrompt(e.target.value)}
                />
              </div>
            </div>
          </div>
        )}
      </div>
    </>
  );
}
