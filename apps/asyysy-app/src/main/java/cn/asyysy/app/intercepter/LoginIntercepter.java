package cn.asyysy.app.intercepter;


import cn.asyysy.app.annotation.PassToken;
import cn.asyysy.app.annotation.UserToken;
import cn.asyysy.app.common.JsonResult;
import cn.asyysy.app.common.token.TokenUtil;
import cn.asyysy.app.consts.BaseConsts;
import cn.asyysy.app.service.user.UserService;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.util.StringUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;

public class LoginIntercepter extends HandlerInterceptorAdapter {

    @Autowired
    private UserService userService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object object) throws Exception {
        //设置允许哪些域名应用进行ajax访问
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET,PUT,POST,DELETE");
        response.setHeader("Access-Control-Allow-Headers", " Origin, X-Requested-With, content-Type, Accept, Authorization");
        response.setHeader("Access-Control-Max-Age","3600");
        //获取请求头的token
        String token=request.getHeader("Authorization");
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
        //检查是否有需要用户权限的注解
        if(method.isAnnotationPresent(UserToken.class)){
            UserToken userToken=method.getAnnotation(UserToken.class);
            if(userToken.required()){
                //执行认证
                if(StringUtils.isEmpty(token)){
                    //throw new RuntimeException(Constants.MSG.UN_LOGIN_TOKEN);
                    response.sendError(JsonResult.ERROR, BaseConsts.MSG.UN_LOGIN_TOKEN);
                    return false;
                }else {
                    //获取token中的用户信息
                    Claims claims;
                    try{
                        claims= TokenUtil.parseJWT(token);
                    }catch (ExpiredJwtException e){
                        throw new RuntimeException("401,token失效");
                    }
                    String userName = claims.getId();
/*                    EntityWrapper<User> entityWrapper = new EntityWrapper<>();
                    entityWrapper.setEntity(new User());
                    // 主键查询
                    entityWrapper.where("user_name={0}", userName);
                    User user = userService.selectOne(entityWrapper);
                    if(user==null){
                        response.sendError(JsonResult.ERROR,Constants.MSG.UNDEFIND_LOGIN_USER);
                        return false;
                        //throw new RuntimeException(Constants.MSG.UNDEFIND_LOGIN_USER);
                    }*/
                    if(StringUtils.isEmpty(userName)){
                        response.sendError(JsonResult.ERROR, BaseConsts.MSG.UNDEFIND_LOGIN_USER);
                        return false;
                    }
                    request.setAttribute(BaseConsts.COMMON.SESSION_API_USER_KEY,userName);
                    return true;
                }
            }
        }

        return false;
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
