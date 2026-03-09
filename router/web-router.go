package router

import (
	"embed"
	"net/http"
	"strings"

	"github.com/QuantumNous/new-api/common"
	"github.com/QuantumNous/new-api/controller"
	"github.com/QuantumNous/new-api/middleware"
	"github.com/gin-contrib/gzip"
	"github.com/gin-contrib/sessions"
	"github.com/gin-contrib/static"
	"github.com/gin-gonic/gin"
)

func SetWebRouter(router *gin.Engine, buildFS embed.FS, indexPage []byte, frontendBaseUrl string) {
	router.Use(gzip.Gzip(gzip.DefaultCompression))
	router.Use(middleware.GlobalWebRateLimit())
	router.Use(middleware.Cache())
	router.Use(static.Serve("/", common.EmbedFolder(buildFS, "web/dist")))
	router.NoRoute(func(c *gin.Context) {
		c.Set(middleware.RouteTagKey, "web")
		uri := c.Request.RequestURI
		if strings.HasPrefix(uri, "/v1") || strings.HasPrefix(uri, "/api") || strings.HasPrefix(uri, "/assets") {
			controller.RelayNotFound(c)
			return
		}
		// 如果设置了 FRONTEND_BASE_URL，根据用户身份决定是否重定向
		if frontendBaseUrl != "" {
			path := uri
			if idx := strings.IndexByte(uri, '?'); idx != -1 {
				path = uri[:idx]
			}
			path = strings.TrimSuffix(path, "/")

			// /login 始终 serve 旧 SPA（管理员登录入口）
			if path != "/login" {
				// 读取 session 判断是否为管理员
				session := sessions.Default(c)
				role, _ := session.Get("role").(int)
				if role < common.RoleAdminUser {
					// 非管理员（包括未登录）→ 重定向到用户端前端
					c.Redirect(http.StatusMovedPermanently, frontendBaseUrl+uri)
					return
				}
			}
		}
		c.Header("Cache-Control", "no-cache")
		c.Data(http.StatusOK, "text/html; charset=utf-8", indexPage)
	})
}
