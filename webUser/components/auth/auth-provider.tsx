"use client";

import React, { createContext, useContext, useState, useEffect, useCallback } from "react";
import {
  type User,
  type SystemStatus,
  getStoredUser,
  setStoredUser,
  clearStoredUser,
  fetchStatus,
  fetchSelf,
  logout as apiLogout,
} from "@/lib/auth";

interface AuthState {
  user: User | null;
  status: SystemStatus | null;
  loading: boolean;
  login: (user: User) => void;
  logout: () => Promise<void>;
  refreshUser: () => Promise<void>;
}

const AuthContext = createContext<AuthState>({
  user: null,
  status: null,
  loading: true,
  login: () => {},
  logout: async () => {},
  refreshUser: async () => {},
});

export function useAuth() {
  return useContext(AuthContext);
}

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [status, setStatus] = useState<SystemStatus | null>(null);
  const [loading, setLoading] = useState(true);

  // 初始化：从 localStorage 恢复用户，加载系统状态
  useEffect(() => {
    const stored = getStoredUser();
    if (stored) setUser(stored);

    fetchStatus()
      .then(setStatus)
      .catch(() => {})
      .finally(() => setLoading(false));
  }, []);

  const login = useCallback((u: User) => {
    setStoredUser(u);
    setUser(u);
  }, []);

  const logout = useCallback(async () => {
    await apiLogout();
    setUser(null);
  }, []);

  const refreshUser = useCallback(async () => {
    try {
      const u = await fetchSelf();
      setUser(u);
    } catch {
      clearStoredUser();
      setUser(null);
    }
  }, []);

  return (
    <AuthContext.Provider value={{ user, status, loading, login, logout, refreshUser }}>
      {children}
    </AuthContext.Provider>
  );
}
