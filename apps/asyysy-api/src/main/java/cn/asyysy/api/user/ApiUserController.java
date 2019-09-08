package cn.asyysy.api.user;


import cn.asyysy.annotation.PassToken;
import cn.asyysy.annotation.UserToken;
import cn.asyysy.app.model.core.User;
import cn.asyysy.app.service.user.UserService;
import cn.asyysy.common.JsonResult;
import cn.asyysy.common.token.TokenUtil;
import cn.asyysy.consts.BaseConsts;
import cn.asyysy.exception.BaseException;
import cn.asyysy.listener.SessionListener;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang.StringUtils;
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
import java.util.logging.Logger;

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
    Logger logger = Logger.getLogger("ApiUserController");

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

    @PostMapping("save")
    public Object save(@RequestBody User user){
        logger.info("user/save");
        if (null == user) {
            return new JsonResult(JsonResult.ERROR,"用户为空");
        }
        if(StringUtils.isEmpty(user.getUserName())){
            return new JsonResult(JsonResult.ERROR,"用户名不可为空");
        }
        if(StringUtils.isEmpty(user.getPassword())){
            return new JsonResult(JsonResult.ERROR,"用户名密码不可为空");
        }
        EntityWrapper<User> entityWrapper = new EntityWrapper();
        entityWrapper.setEntity(new User());
        entityWrapper.where("user_name={0}",user.getUserName());
        int sum = userService.selectCount(entityWrapper);
        if(sum != 0){
            return new JsonResult(JsonResult.ERROR,"用户名已注册数量:" + sum);
        }
        // 最后操作时间
        user.setUpdateDate(new Date());
        // 创建时间
        user.setCreateDate(new Date());
        boolean result = userService.insert(user);
        logger.info("用户注册成功" + result);
        return new JsonResult(JsonResult.SUCCESS,"用户新增成功",result);
    }

    @PutMapping("update")
    public Object update(@RequestBody User user){
        logger.info("user/update");
        if (null == user) {
            return new JsonResult(JsonResult.ERROR,"用户为空");
        }
        if(StringUtils.isEmpty(user.getUserName())){
            return new JsonResult(JsonResult.ERROR,"用户名不可为空");
        }
        if(StringUtils.isEmpty(user.getPassword())){
            return new JsonResult(JsonResult.ERROR,"用户名密码不可为空");
        }
        // 最后操作时间
        user.setUpdateDate(new Date());
        EntityWrapper<User> updateWrapper = new EntityWrapper();
        updateWrapper.setEntity(new User());
        // 主键查询
        updateWrapper.where("pkid={0}",user.getPkid());
        boolean result = userService.update(user, updateWrapper);
        logger.info("用户修改" + result);
        return new JsonResult(JsonResult.SUCCESS,"用户修改",result);
    }

    @DeleteMapping("delUser")
    public Object delUser(@RequestParam Long pkid){
        boolean result = userService.deleteById(pkid);
        return new JsonResult(JsonResult.SUCCESS,"删除用户",result);
    }

    @GetMapping("list")
    public Object list(){
        EntityWrapper<User> entityWrapper = new EntityWrapper();
        entityWrapper.setEntity(new User());
        List<User> list = userService.selectList(entityWrapper);
        return new JsonResult(JsonResult.SUCCESS,"用户列表",list);
    }

    @GetMapping("listPage")
    public JsonResult listPage(@RequestBody User user){
        EntityWrapper<User> entityWrapper = new EntityWrapper();
        entityWrapper.setEntity(new User());
        Page<User> page = new Page();
        Page<User> pageResult = userService.selectPage(user, page);
        return new JsonResult(JsonResult.SUCCESS,"用户列表",pageResult);
    }

    @PassToken
    @PostMapping("register")
    public Object register(@RequestBody User user){
        logger.info("user/update");
        if (null == user) {
            return new JsonResult(JsonResult.ERROR,"用户为空");
        }
        if(StringUtils.isEmpty(user.getUserName())){
            return new JsonResult(JsonResult.ERROR,"用户名不可为空");
        }
        if(StringUtils.isEmpty(user.getPassword())){
            return new JsonResult(JsonResult.ERROR,"用户名密码不可为空");
        }
        EntityWrapper<User> entityWrapper = new EntityWrapper();
        entityWrapper.setEntity(new User());
        entityWrapper.where("user_name={0}",user.getUserName());
        int sum = userService.selectCount(entityWrapper);
        if(sum != 0){
            return new JsonResult(JsonResult.ERROR,"用户名已注册数量:" + sum);
        }
        // 最后操作时间
        user.setUpdateDate(new Date());
        // 创建时间
        user.setCreateDate(new Date());
        boolean result = userService.insert(user);
        logger.info("用户注册成功" + result);
        return new JsonResult(JsonResult.SUCCESS,"用户注册成功",result);
    }

    @ApiOperation(value = "用户登录", notes = "用户登录")
    @ApiImplicitParam(name = "userIn", value = "用户实体", paramType = "path", required = true, dataType = "Integer")
    @PassToken
    @PostMapping("login")
    public Object login(HttpServletRequest request, HttpServletResponse response, @RequestBody User userIn){
        HttpSession session = request.getSession();
        String sessionId = session.getId();
        logger.info("user/login-sessisID:" + sessionId);
        Object userObj = session.getAttribute("user");
        if (null != userObj) {
            return new JsonResult(JsonResult.ERROR,"用户已登录");
        }
        String userName = userIn.getUserName();
        String password = userIn.getPassword();
        String token = TokenUtil.createJwtToken(userName);
        System.out.println("______________________token:" + token);
        if(StringUtils.isEmpty(userName)){
            return  new JsonResult(JsonResult.ERROR,"用户名不可为空");
        }
        if(StringUtils.isEmpty(password)){
            return new JsonResult(JsonResult.ERROR,"用户名密码不可为空");
        }

        EntityWrapper<User> entityWrapper = new EntityWrapper();
        entityWrapper.where("user_name={0}",userName);
        //entityWrapper.where("password={0}",password);
        User user = userService.selectOne(entityWrapper);
        if (user == null) {
           return new JsonResult(JsonResult.ERROR,"用户不存在");
        }
        if(!password.equals(user.getPassword())){
            return new JsonResult(JsonResult.ERROR,"用户密码错误");
        }
        // session超时时间
        session.setMaxInactiveInterval(Integer.valueOf(SESSION_TIMEOUT));
        session.setAttribute(BaseConsts.COMMON.SESSION_API_USER_KEY, user);

        // Cookie
        Cookie cookie = new Cookie(userName, token);
        //单位：秒
        cookie.setMaxAge(60*60*24);
        response.addCookie(cookie);
        return new JsonResult(JsonResult.SUCCESS,"登录成功",token);
    }

    @UserToken
    @RequestMapping("logout")
    public Object logout(HttpServletRequest request){

        // 已登录获取user
        //User user = (User)session.getAttribute(Constants.COMMON.SESSION_API_USER_KEY);
/*
        if(null == user){
            return new JsonResult(JsonResult.ERROR,Constants.MSG.PLEASE_LOGIN,null);
        }
        session.removeAttribute(Constants.COMMON.SESSION_API_USER_KEY);
        //session.invalidate();
        return new JsonResult(JsonResult.SUCCESS,"退出登录成功",null);
*/

        Claims claims;
        try{
            HttpSession session = request.getSession();
            logger.info("user/logout-sessisID:" + session.getId());
           /* HttpSession session = request.getSession();
            // 已登录获取user
            Object user = session.getAttribute(Constants.COMMON.SESSION_API_USER_KEY);
            boolean loginFlag = (null == user);
            logger.info("user/getUser-是否登录：" + !loginFlag);
            // 未登录
            if (loginFlag) {
                return new JsonResult(JsonResult.ERROR,Constants.MSG.UN_ON_LINE,null);
            }*/
            //获取请求头的token
            String token=request.getHeader("Authorization");
            //token=null;
            if(StringUtils.isEmpty(token)) {
                throw new BaseException("TOKEN为空");
            }
            //获取token中的用户信息
            claims = TokenUtil.parseJWT(token);
            return new JsonResult(JsonResult.SUCCESS,"退出登录成功", claims.getId());
        }catch (BaseException e){
            return new JsonResult(JsonResult.ERROR,BaseConsts.MSG.PLEASE_LOGIN,"业务异常:" +  e.getMessage());
        }catch (ExpiredJwtException e){
            return new JsonResult(JsonResult.ERROR,BaseConsts.MSG.PLEASE_LOGIN,"401,token失效:" +  e.getMessage());
        }catch (Exception e){
            return new JsonResult(JsonResult.ERROR,BaseConsts.MSG.PLEASE_LOGIN,"系统异常:" +  e.getMessage());
        }
    }

    /**
     * 获取用户登录状态
     * @param request
     * @return
     */
    @PassToken
    @RequestMapping("getUser")
    public Object getUser(HttpServletRequest request){
        Claims claims;
        try{
           /* HttpSession session = request.getSession();
            // 已登录获取user
            Object user = session.getAttribute(Constants.COMMON.SESSION_API_USER_KEY);
            boolean loginFlag = (null == user);
            logger.info("user/getUser-是否登录：" + !loginFlag);
            // 未登录
            if (loginFlag) {
                return new JsonResult(JsonResult.ERROR,Constants.MSG.UN_ON_LINE,null);
            }*/
            //获取请求头的token
            String token=request.getHeader("Authorization");
            //token=null;
            if(StringUtils.isEmpty(token)) {
                throw new BaseException("TOKEN为空");
            }
            //获取token中的用户信息
            claims = TokenUtil.parseJWT(token);
            return new JsonResult(JsonResult.SUCCESS,BaseConsts.MSG.ON_LINE, claims.getId());
        }catch (BaseException e){
            return new JsonResult(JsonResult.ERROR,BaseConsts.MSG.UN_ON_LINE,"业务异常:" +  e.getMessage());
        }catch (ExpiredJwtException e){
            return new JsonResult(JsonResult.ERROR,BaseConsts.MSG.UN_ON_LINE,"401,token失效:" +  e.getMessage());
        }catch (Exception e){
            return new JsonResult(JsonResult.ERROR,BaseConsts.MSG.UN_ON_LINE,"系统异常:" +  e.getMessage());
        }
    }

    /**
     * 在线人数
     * @param request
     * @return
     */
    @PassToken
    @PostMapping("getOnLineCount")
    public Object getOnLineCount(HttpServletRequest request){
        // 在线人数
        AtomicInteger userCount = SessionListener.userCount;
        return new JsonResult(JsonResult.SUCCESS,BaseConsts.MSG.ON_LINE_SUM, userCount);
    }
}

