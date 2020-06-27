package cn.asyysy.platform.controller.api.user;

import cn.asyysy.app.annotation.LoginSystem;
import cn.asyysy.app.annotation.UserToken;
import cn.asyysy.app.common.token.TokenUtil;
import cn.asyysy.app.consts.BaseConsts;
import cn.asyysy.app.exception.BaseException;
import cn.asyysy.app.listener.SessionListener;
import cn.asyysy.app.model.common.ApiResponse;
import cn.asyysy.app.model.core.User;
import cn.asyysy.app.service.user.UserService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.*;

import javax.annotation.PostConstruct;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author huangyaoyu
 * @since 2019-05-08
 */
@RestController
@Api("ApiUserController相关的api")
@RequestMapping("/api/user")
@CrossOrigin
public class ApiUserController {
    /**
     * log日志
     */
    public static Logger logger = (Logger) LoggerFactory.getLogger(ApiUserController.class);

    // Session超时时间
    private static String SESSION_TIMEOUT = "3600";
    @Autowired
    private static Environment env;


    @PostConstruct
    public void init() {
        // Session超时时间
        //SESSION_TIMEOUT =env.getProperty(Constants.CONFIG.SESSION_TIMEOUT,"3600");
    }
    @Autowired
    UserService userService;

    @LoginSystem
    @PostMapping("save")
    public ApiResponse save(@RequestBody User user){
        logger.info("user/save");
        if (null == user) {
            return ApiResponse.ERROR("用户为空");
        }
        if(StringUtils.isEmpty(user.getUserName())){
            return ApiResponse.ERROR("用户名不可为空");
        }
        if(StringUtils.isEmpty(user.getPassword())){
            return ApiResponse.ERROR("用户名密码不可为空");
        }
        EntityWrapper<User> entityWrapper = new EntityWrapper();
        entityWrapper.setEntity(new User());
        entityWrapper.where("user_name={0}",user.getUserName());
        int sum = userService.selectCount(entityWrapper);
        if(sum != 0){
            return ApiResponse.ERROR("用户名已注册");
        }
        // 最后操作时间
        user.setUpdateDate(new Date());
        // 创建时间
        user.setCreateDate(new Date());
        boolean result = userService.insert(user);
        logger.info("用户注册成功" + result);
        return ApiResponse.SUCCESS("用户新增成功",result);
    }

    @LoginSystem
    @PutMapping("update")
    public ApiResponse update(@RequestBody User user){
        logger.info("user/update");
        if (null == user) {
            return ApiResponse.ERROR("用户为空");
        }
        if(StringUtils.isEmpty(user.getUserName())){
            return ApiResponse.ERROR("用户名不可为空");
        }
        if(StringUtils.isEmpty(user.getPassword())){
            return ApiResponse.ERROR("用户名密码不可为空");
        }
        // 最后操作时间
        user.setUpdateDate(new Date());
        EntityWrapper<User> updateWrapper = new EntityWrapper();
        updateWrapper.setEntity(new User());
        // 主键查询
        updateWrapper.where("pkid={0}",user.getPkid());
        boolean result = userService.update(user, updateWrapper);
        logger.info("用户修改" + result);
        return ApiResponse.SUCCESS("用户修改",result);
    }

    @LoginSystem
    @DeleteMapping("delUser")
    public ApiResponse delUser(@RequestParam Long pkid){
        boolean result = userService.deleteById(pkid);
        return ApiResponse.SUCCESS("删除用户",result);
    }

    @LoginSystem
    @GetMapping("list")
    public ApiResponse list(){
        EntityWrapper<User> entityWrapper = new EntityWrapper();
        entityWrapper.setEntity(new User());
        List<User> list = userService.selectList(entityWrapper);
        return ApiResponse.SUCCESS("用户列表",list);
    }

    @LoginSystem
    @GetMapping("listPage")
    public ApiResponse listPage(@RequestBody User user){
        EntityWrapper<User> entityWrapper = new EntityWrapper();
        entityWrapper.setEntity(new User());
        Page<User> page = new Page();
        Page<User> pageResult = userService.selectPage(user, page);
        return ApiResponse.SUCCESS("用户列表",pageResult);
    }

    @PostMapping("register")
    public ApiResponse register(@RequestBody User user){
        logger.info("user/register");
        try {
            if(StringUtils.isEmpty(user.getUserName())){
                throw new BaseException("用户名不可为空");
            }
            if(StringUtils.isEmpty(user.getPassword())){
                throw new BaseException("用户名密码不可为空");
            }
            EntityWrapper<User> entityWrapper = new EntityWrapper();
            entityWrapper.setEntity(new User());
            entityWrapper.where("user_name={0}",user.getUserName());
            int sum = userService.selectCount(entityWrapper);
            if(sum != 0){
                throw new BaseException("用户名已注册数量:" + sum);
            }
            // 最后操作时间
            user.setUpdateDate(new Date());
            // 创建时间
            user.setCreateDate(new Date());
            boolean result = userService.insert(user);
            if (!result) {
                throw new BaseException("用户名注册保存失败:" + sum);
            }
            logger.info("用户注册成功" + result);
            return ApiResponse.SUCCESS("用户注册成功", user);
        } catch (BaseException e){
            logger.error(e.getMessage(), e);
            return ApiResponse.ERROR(e.getMessage(), e);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return ApiResponse.ERROR("【注册】系统错误请稍后重试");
        }
    }

    @ApiOperation(value = "用户登录", notes = "用户登录")
    @ApiImplicitParam(name = "userIn", value = "用户实体", paramType = "path", required = true, dataType = "Integer")
    @PostMapping("login")
    public ApiResponse login(HttpServletRequest request, HttpServletResponse response, @RequestBody User userIn){
        try {
            HttpSession session = request.getSession();
            String sessionId = session.getId();
            logger.info("user/login-sessisID:" + sessionId);
            String userName = userIn.getUserName();
            String password = userIn.getPassword();
            Object userObj = session.getAttribute(BaseConsts.COMMON.SESSION_API_USER_KEY);
            if (null != userObj) {
                User userLogin = (User)userObj;
                if (!userIn.getUserName().equals(userLogin.getUserName())) {
                    throw new BaseException("用户:" + userLogin.getUserName() + "已登录");
                }
                throw new BaseException("已登录");
            }
            if(StringUtils.isEmpty(userName)){
                throw new BaseException("用户名不可为空");
            }
            if(StringUtils.isEmpty(password)){
                throw new BaseException("用户名密码不可为空");
            }

            EntityWrapper<User> entityWrapper = new EntityWrapper();
            entityWrapper.where("user_name={0}",userName);
            //entityWrapper.where("password={0}",password);
            User user = userService.selectOne(entityWrapper);
            if (user == null) {
                throw new BaseException("用户不存在");
            }
            if(!password.equals(user.getPassword())){
                throw new BaseException("用户密码错误");
            }
            String token = TokenUtil.createJwtToken(userName);
            System.out.println("______________________token:" + token);
            // session超时时间
            session.setMaxInactiveInterval(Integer.valueOf(SESSION_TIMEOUT));
            session.setAttribute(BaseConsts.COMMON.SESSION_API_USER_KEY, user);
            // Cookie
            Cookie cookie = new Cookie("token", token);
            //单位：秒
            cookie.setMaxAge(60*60*24);
            response.addCookie(cookie);
            AtomicInteger userCount = SessionListener.userCount;
            userCount.set(userCount.getAndIncrement()+1);
            return ApiResponse.SUCCESS("登录成功", token);
        } catch (BaseException e){
            logger.error(e.getMessage(), e);
            return ApiResponse.ERROR(e.getMessage(), e);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return ApiResponse.ERROR("【登录】系统错误请稍后重试");
        }
    }

    @UserToken
    @RequestMapping("logout")
    public ApiResponse  logout(HttpServletRequest request){

        // 已登录获取user
        //User user = (User)session.getAttribute(Constants.COMMON.SESSION_API_USER_KEY);
/*
        if(null == user){
            return ApiResponse.ERROR(Constants.MSG.PLEASE_LOGIN,null);
        }
        session.removeAttribute(Constants.COMMON.SESSION_API_USER_KEY);
        //session.invalidate();
        return new JsonResult(JsonResult.SUCCESS,"退出登录成功",null);
*/

        Claims claims;
        try{
            HttpSession session = request.getSession();
            logger.info("user/logout-sessisID:" + session.getId());
            Object userObj = session.getAttribute(BaseConsts.COMMON.SESSION_API_USER_KEY);
            if (null == userObj) {
                return ApiResponse.ERROR("请登录");
            }
            // 退出登录
            session.removeAttribute(BaseConsts.COMMON.SESSION_API_USER_KEY);
            AtomicInteger userCount = SessionListener.userCount;
            userCount.set(userCount.getAndIncrement()-1);
           /* HttpSession session = request.getSession();
            // 已登录获取user
            Object user = session.getAttribute(Constants.COMMON.SESSION_API_USER_KEY);
            boolean loginFlag = (null == user);
            logger.info("user/getUser-是否登录：" + !loginFlag);
            // 未登录
            if (loginFlag) {
                return ApiResponse.ERROR(Constants.MSG.UN_ON_LINE,null);
            }*/
            //获取请求头的token
           /* String token=request.getHeader("Authorization");
            //token=null;
            if(StringUtils.isEmpty(token)) {
                throw new BaseException("TOKEN为空");
            }
            //获取token中的用户信息
            claims = TokenUtil.parseJWT(token);*/
            return ApiResponse.SUCCESS("退出登录成功");
        }catch (BaseException e){
            return ApiResponse.ERROR( BaseConsts.MSG.PLEASE_LOGIN,"业务异常:" +  e.getMessage());
        }catch (ExpiredJwtException e){
            return ApiResponse.ERROR(BaseConsts.MSG.PLEASE_LOGIN,"401,token失效:" +  e.getMessage());
        }catch (Exception e){
            return ApiResponse.ERROR(BaseConsts.MSG.PLEASE_LOGIN,"系统异常:" +  e.getMessage());
        }
    }

    /**
     * 获取用户登录状态
     * @param request
     * @return
     */
    @RequestMapping("getUser")
    public ApiResponse getUser(HttpServletRequest request){
        try{
            // 校验是否登录
            User user = userService.checkLoginThrowException(request);
            return ApiResponse.SUCCESS(BaseConsts.MSG.ON_LINE, user.getUserName());
        }catch (BaseException e){
            return ApiResponse.ERROR(BaseConsts.MSG.UN_ON_LINE,"业务异常:" +  e.getMessage());
        }catch (ExpiredJwtException e){
            return ApiResponse.ERROR(BaseConsts.MSG.UN_ON_LINE,"401,token失效:" +  e.getMessage());
        }catch (Exception e){
            return ApiResponse.ERROR(BaseConsts.MSG.UN_ON_LINE,"系统异常:" +  e.getMessage());
        }
    }

    /**
     * 在线人数
     * @param request
     * @return
     **/
    @PostMapping("getOnLineCount")
    public ApiResponse getOnLineCount(HttpServletRequest request){
        // 在线人数
        AtomicInteger userCount = SessionListener.userCount;
        return ApiResponse.SUCCESS(BaseConsts.MSG.ON_LINE_SUM, userCount);
    }
}

