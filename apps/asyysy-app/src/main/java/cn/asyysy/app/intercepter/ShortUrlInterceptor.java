package cn.asyysy.app.intercepter;

import cn.asyysy.app.config.PropUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.lang.Nullable;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 短网址专属拦截器
 * @author huangyaoyu
 */
public class ShortUrlInterceptor extends HandlerInterceptorAdapter {
    /**
     * 短网址domain
     * @auther huangyaoyu
     */
    private static final String shortUrlDomain = PropUtil.get("short-url");
    /** log日志. */
    private static Logger logger = (Logger) LoggerFactory.getLogger(ShortUrlInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object object) throws Exception {
        // 当前请求路径
        String requestUrl = request.getScheme()+"://" + request.getServerName();
        // 是否短网址请求
        boolean result = requestUrl.equals(shortUrlDomain);
        //String url = request.getScheme()+"://"+ request.getServerName()+request.getRequestURI()+"?"+request.getQueryString();
        //logger.info("获取全路径（协议类型：//域名/项目名/命名空间/action名称?其他参数）url={}", url);
        //+request.getRequestURI();
        /*String url2=request.getScheme()+"://"+ request.getServerName();
        logger.info("协议名：//域名={}", url2);
        logger.info("获取项目名="+request.getContextPath());
        logger.info("获取参数="+request.getQueryString());
        logger.info("获取全路径="+request.getRequestURL());
        // 获取web项目的路径
        logger.info("获取web项目的路径="+request.getSession().getServletContext().getRealPath("/"));
        //获取类的当前目录
        logger.info("获取类的当前目录="+this.getClass().getResource("/").getPath());*/
        if(result) {
            // 已是短网址路径直接可访问
            if(request.getRequestURL().toString().contains("/d/")) {
                return true;
            }
            // 转发到短网址
            response.sendRedirect("/d");
        }
        // 非短网址请求转发到index
        //response.sendRedirect("/index");
        return true;
    }

    // 请求处理之后进行调用，但是在视图被渲染之前（Controller方法调用之后）
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable ModelAndView modelAndView) throws Exception {

    }

    // 在整个请求结束之后被调用，也就是在DispatcherServlet 渲染了对应的视图之后执行（主要是用于进行资源清理工作）
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable Exception ex) throws Exception {

    }
}
