package cn.asyysy.app.intercepter;


import cn.asyysy.app.annotation.PassToken;
import cn.asyysy.app.config.SystemInfo;
import cn.asyysy.app.consts.BaseConsts;
import cn.asyysy.app.model.common.ApiResponse;
import cn.asyysy.app.model.core.User;
import cn.asyysy.app.util.IpUtils;
import com.alibaba.fastjson.JSON;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.lang.Nullable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 系统层次拦截器
 */
public class SystemInterceptor extends HandlerInterceptorAdapter {
    /** log日志. */
    private static Logger logger = (Logger) LoggerFactory.getLogger(SystemInterceptor.class);
    /**
     * 系统对应配置
     */
    @Autowired
    private SystemInfo systemInfo;

    @Autowired
    private Environment env;

    public SystemInterceptor(SystemInfo systemInfo, Environment env){
        this.systemInfo =systemInfo;
        this.env =env;
    }
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object object) throws Exception {

        request.setAttribute("sys", systemInfo);
        if (request.getRequestURI().contains("/static/js/config/sysConfig.js")) {
        }

        if (!request.getRequestURI().contains("static")) {
           Date now = new Date();
           SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
           String ip = IpUtils.getIpAddress(request);
           logger.info("\n请求时间:{} ip：{}\n请求：{}\n参数：{}",
                   sdf.format(now),
                   StringUtils.isEmpty(ip)? request.getRemoteAddr() : ip,
                   request.getRequestURI(),
                   (null == request.getParameterMap() ? "" : request.getParameterMap())) ;
        }
        HttpSession session = request.getSession();
        //如果不是映射到方法直接通过
        if(!(object instanceof HandlerMethod)){
            return true;
        }
        HandlerMethod handlerMethod=(HandlerMethod) object;
        Method method=handlerMethod.getMethod();
        //检查是否有passToken注释，有则跳过验证
        if(method.isAnnotationPresent(PassToken.class)){
            PassToken passToken=method.getAnnotation(PassToken.class);
            if(passToken.required()){
                return true;
            }
        }
        Object userObj = session.getAttribute(BaseConsts.COMMON.SESSION_API_USER_KEY);
        if (userObj == null) {
            //检查是否有ResponseBody注释，有则跳过验证
            if(method.isAnnotationPresent(ResponseBody.class)){
                response.setCharacterEncoding("UTF-8");
                response.setContentType("application/json; charset=utf-8");
                PrintWriter out = null;
                try {
                    out = response.getWriter();
                    out.append(JSON.toJSONString(ApiResponse.ERROR("请登录")));
                } catch (IOException e) {
                    e.printStackTrace();
                } finally {
                    if (out != null) {
                        out.close();
                    }
                }
                return true;
            }
            response.sendRedirect( "login");
            return true;
        }
        User user = (User)userObj;
        logger.info("用户:{}-一登陆登录", user.getUserName());
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
