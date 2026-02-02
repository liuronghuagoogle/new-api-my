FROM caddy:2-alpine

# 复制 Caddy 配置
COPY Caddyfile /etc/caddy/Caddyfile

# 暴露端口（Render 会自动处理，但写上好）
EXPOSE 80

# Caddy 默认启动命令，不需要额外 CMD