package router

import (
	"embed"
	"fmt"
	"net/http"
	"os"
	"strings"

	"github.com/QuantumNous/new-api/common"

	"github.com/gin-gonic/gin"
)

func SetRouter(router *gin.Engine, buildFS embed.FS, indexPage []byte) {
	SetApiRouter(router)
	SetDashboardRouter(router)
	SetRelayRouter(router)
	SetVideoRouter(router)
	frontendBaseUrl := os.Getenv("FRONTEND_BASE_URL")
	if frontendBaseUrl != "" {
		frontendBaseUrl = strings.TrimSuffix(frontendBaseUrl, "/")
		if common.IsMasterNode {
			// master 节点：同时 serve 管理后台并重定向非管理员路径到用户端
			common.SysLog("FRONTEND_BASE_URL is set, non-admin web paths will redirect to " + frontendBaseUrl)
			SetWebRouter(router, buildFS, indexPage, frontendBaseUrl)
		} else {
			// slave 节点：全部重定向
			router.NoRoute(func(c *gin.Context) {
				c.Redirect(http.StatusMovedPermanently, fmt.Sprintf("%s%s", frontendBaseUrl, c.Request.RequestURI))
			})
		}
	} else {
		SetWebRouter(router, buildFS, indexPage, "")
	}
}
