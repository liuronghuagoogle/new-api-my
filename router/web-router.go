package router

import (
	"embed"
	"net/http"
	"strings"

	"github.com/QuantumNous/new-api/common"
	"github.com/QuantumNous/new-api/controller"
	"github.com/QuantumNous/new-api/middleware"
	"github.com/gin-contrib/gzip"
	"github.com/gin-contrib/static"
	"github.com/gin-gonic/gin"
)

func SetWebRouter(router *gin.Engine, buildFS embed.FS, indexPage []byte, frontendBaseUrl string) {
	router.Use(gzip.Gzip(gzip.DefaultCompression))
	router.Use(middleware.GlobalWebRateLimit())
	router.Use(middleware.Cache())
	router.Use(static.Serve("/", common.EmbedFolder(buildFS, "web/dist")))
	router.NoRoute(func(c *gin.Context) {
		uri := c.Request.RequestURI
		if strings.HasPrefix(uri, "/v1") || strings.HasPrefix(uri, "/api") || strings.HasPrefix(uri, "/assets") {
			controller.RelayNotFound(c)
			return
		}
		// 如果设置了 FRONTEND_BASE_URL，非管理员路径重定向到用户端前端
		if frontendBaseUrl != "" && !isAdminWebPath(uri) {
			c.Redirect(http.StatusMovedPermanently, frontendBaseUrl+uri)
			return
		}
		c.Header("Cache-Control", "no-cache")
		c.Data(http.StatusOK, "text/html; charset=utf-8", indexPage)
	})
}

// isAdminWebPath 判断路径是否为管理员使用的 web 路径（白名单）
func isAdminWebPath(uri string) bool {
	// 去掉 query string
	path := uri
	if idx := strings.IndexByte(uri, '?'); idx != -1 {
		path = uri[:idx]
	}
	path = strings.TrimSuffix(path, "/")

	// 管理员白名单路径
	switch path {
	case "/login", "/panel":
		return true
	}
	if strings.HasPrefix(path, "/panel/") {
		return true
	}
	return false
}
