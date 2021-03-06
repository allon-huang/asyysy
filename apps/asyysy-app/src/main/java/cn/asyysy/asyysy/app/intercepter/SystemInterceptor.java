package cn.asyysy.asyysy.app.intercepter;

import cn.asyysy.asyysy.app.annotation.LoginSystem;
import cn.asyysy.asyysy.app.dto.UserLoginDTO;
import cn.asyysy.asyysy.app.model.SystemInfo;
import cn.asyysy.asyysy.app.service.common.LoginService;
import cn.asyysy.asyysy.common.utils.HttpServletUtil;
import cn.asyysy.asyysy.common.utils.IpUtils;
import cn.asyysy.asyysy.common.exception.BaseException;
import cn.asyysy.asyysy.common.rest.common.BaseResponse;
import cn.asyysy.asyysy.common.utils.StringUtil;
import com.alibaba.fastjson.JSON;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.lang.Nullable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

/**
 * 系统层次拦截器
 */
public class SystemInterceptor extends HandlerInterceptorAdapter {
    /**
     * log日志.
     */
    private static Logger logger = (Logger) LoggerFactory.getLogger(SystemInterceptor.class);
    /**
     * 系统对应配置
     */
    @Autowired
    private SystemInfo systemInfo;

    @Autowired
    private Environment env;

    /**
     * 登录逻辑
     */
    @Autowired
    LoginService loginService;

    public SystemInterceptor(SystemInfo systemInfo, Environment env, LoginService loginService) {
        this.systemInfo = systemInfo;
        this.env = env;
        this.loginService = loginService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object object) throws Exception {
        // 设置允许哪些域名应用进行ajax访问
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Origin", StringUtil.removeUrlHttp(systemInfo.getDomain()));
        response.setHeader("Access-Control-Allow-Methods", "GET,PUT,POST,DELETE");
        response.setHeader("Access-Control-Allow-Headers", " Origin, X-Requested-With, content-Type, Accept, Authorization");
        response.setHeader("Access-Control-Max-Age", "3600");

        request.setAttribute("sys", systemInfo);
        if (request.getRequestURI().contains("/static")) {
            return true;
        }

        Date now = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
        String ip = IpUtils.getIpAddress(request);
        StringBuilder paramsStr = new StringBuilder();
        Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String key = parameterNames.nextElement();
            paramsStr.append("\n########### ASYYSY #################参数：")
                    .append(key).append("=").append(request.getParameter(key));
        }
        if ((null == paramsStr || StringUtils.isEmpty(paramsStr.toString())) && StringUtils.isNotEmpty(request.getQueryString())) {
            paramsStr = new StringBuilder(request.getQueryString());
        }
        boolean logFlag = request.getRequestURI().indexOf("/common") == -1;
        
        StringBuilder msg = new StringBuilder("\n########### ASYYSY #################    START   #################")
                .append("\n########### ASYYSY #################    请求时间:").append(sdf.format(now))
                .append(" - ip：").append(StringUtils.isEmpty(ip) ? request.getRemoteAddr() : ip)
                .append("\n########### ASYYSY #################    请求：   ").append(request.getRequestURI());
        if (StringUtil.isNotEmpty(paramsStr.toString())) {
            msg.append("\n").append(paramsStr);    
        }

        //如果不是映射到方法直接通过
        if (!(object instanceof HandlerMethod)) {
            log(msg, logFlag);
            return true;
        }
        HandlerMethod handlerMethod = (HandlerMethod) object;
        Method method = handlerMethod.getMethod();
        // LoginSystem，有则验证是否登录
        if (method.isAnnotationPresent(LoginSystem.class)) {
            // 登录自己
            LoginSystem loginSystem = method.getAnnotation(LoginSystem.class);
            // 判断是否登录
            if (loginSystem.isLogo()) {
                try {
                    // 校验是否登录
                    UserLoginDTO user = loginService.checkLogin();
                    if (null == user) {
                        throw new BaseException("未登录");
                    }
                    logger.info("用户:{}-一登陆登录", user.getUserName());
                } catch (Exception e) {
                    msg.append("\n########### ASYYSY #################    Error：   ").append(e.getMessage());
                    log(msg, logFlag);
                    // 是否json响应
                    if (checkRestControllerOrResponseBody(handlerMethod)) {
                        this.redirectJson(response, BaseResponse.ERROR("请登录"));
                    } else {
                        // 未登录重定向页面
                        response.sendRedirect(systemInfo.getDomain() + systemInfo.getNoLoginUrl());
                        // 拦截器重定向后要return false
                        return false;
                    }
                }
            }
        }
        log(msg, logFlag);
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

    /**
     * 打印拦截器日志 结尾部分
     * @param msg
     */
    private void log(StringBuilder msg, boolean logFlag){
        if (!logFlag) {
            return;
        }
        // request
        HttpServletRequest request = HttpServletUtil.getRequest();
        // 获取authorization
        String[] authorization = HttpServletUtil.getAuthorization(request);
        if (null != authorization) {
            msg.append("\n########### ASYYSY #################    authorization：").append(authorization[0]);
            msg.append("\n########### ASYYSY #################    authorization type：").append(authorization[1]);
        }
        msg.append("\n########### ASYYSY #################    END     #################\n");
        logger.info(msg.toString());
    }
    /**
     * 响应json
     */
    private void redirectJson(HttpServletResponse response, BaseResponse data) {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=utf-8");
        PrintWriter out = null;
        try {
            out = response.getWriter();
            out.append(JSON.toJSONString(data));
        } catch (IOException e) {
            logger.error("拦截器ResponseBody 响应io异常：{}", e.getMessage(), e);
        } finally {
            if (out != null) {
                out.close();
            }
        }
    }

    /**
     * 校验是否RestContrller（类注解）或ResponseBody（方法）
     *
     * @param handlerMethod
     * @return
     */
    private boolean checkRestControllerOrResponseBody(HandlerMethod handlerMethod) {
        if (null == handlerMethod) {
            return false;
        }
        RestController restController = handlerMethod.getBeanType().getAnnotation(RestController.class);
        Method method = handlerMethod.getMethod();
        // 方法注解
        boolean annotationResponseBody = method.isAnnotationPresent(ResponseBody.class);
        if (null != restController || annotationResponseBody) {
            return true;
        }
        return false;
    }
}
