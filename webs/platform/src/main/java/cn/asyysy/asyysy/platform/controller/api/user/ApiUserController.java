package cn.asyysy.asyysy.platform.controller.api.user;

import cn.asyysy.asyysy.app.annotation.LoginSystem;
import cn.asyysy.asyysy.app.dto.UserLoginDTO;
import cn.asyysy.asyysy.app.listener.SessionListener;
import cn.asyysy.asyysy.app.model.core.User;
import cn.asyysy.asyysy.app.service.common.LoginService;
import cn.asyysy.asyysy.app.service.user.UserService;
import cn.asyysy.asyysy.common.constants.BaseConstants;
import cn.asyysy.asyysy.common.exception.BaseException;
import cn.asyysy.asyysy.common.rest.common.BaseResponse;
import cn.asyysy.asyysy.platform.controller.common.CommonController;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import io.jsonwebtoken.ExpiredJwtException;
import io.swagger.annotations.Api;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.*;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author huangyaoyu
 * @since 2019-05-08
 */
@RestController
@Api("ApiUserController相关的api")
@RequestMapping("/api/user")
@CrossOrigin
public class ApiUserController extends CommonController {
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

    /**
     * 用户信息
     */
    @Autowired
    UserService userService;

    /**
     * 登录逻辑
     */
    @Autowired
    LoginService loginService;

    @LoginSystem
    @ResponseBody
    @PostMapping("save")
    public BaseResponse save(@RequestBody User user) {
        logger.info("user/save");
        if (null == user) {
            return BaseResponse.ERROR("用户为空");
        }
        if (StringUtils.isEmpty(user.getUserName())) {
            return BaseResponse.ERROR("用户名不可为空");
        }
        if (StringUtils.isEmpty(user.getPassword())) {
            return BaseResponse.ERROR("用户名密码不可为空");
        }
        EntityWrapper<User> entityWrapper = new EntityWrapper();
        entityWrapper.setEntity(new User());
        entityWrapper.where("user_name={0}", user.getUserName());
        int sum = userService.selectCount(entityWrapper);
        if (sum != 0) {
            return BaseResponse.ERROR("用户名已注册");
        }
        // 最后操作时间
        user.setUpdateDate(new Date());
        // 创建时间
        user.setCreateDate(new Date());
        boolean result = userService.insert(user);
        logger.info("用户注册成功" + result);
        return BaseResponse.SUCCESS("用户新增成功", result);
    }

    @LoginSystem
    @PutMapping("update")
    public BaseResponse update(@RequestBody User user) {
        logger.info("user/update");
        if (null == user) {
            return BaseResponse.ERROR("用户为空");
        }
        if (StringUtils.isEmpty(user.getUserName())) {
            return BaseResponse.ERROR("用户名不可为空");
        }
        if (StringUtils.isEmpty(user.getPassword())) {
            return BaseResponse.ERROR("用户名密码不可为空");
        }
        // 最后操作时间
        user.setUpdateDate(new Date());
        EntityWrapper<User> updateWrapper = new EntityWrapper();
        updateWrapper.setEntity(new User());
        // 主键查询
        updateWrapper.where("pkid={0}", user.getPkid());
        boolean result = userService.update(user, updateWrapper);
        logger.info("用户修改" + result);
        return BaseResponse.SUCCESS("用户修改", result);
    }

    @LoginSystem
    @DeleteMapping("delUser")
    public BaseResponse delUser(@RequestParam Long pkid) {
        boolean result = userService.deleteById(pkid);
        return BaseResponse.SUCCESS("删除用户", result);
    }

    @LoginSystem
    @GetMapping("list")
    public BaseResponse list() {
        EntityWrapper<User> entityWrapper = new EntityWrapper();
        entityWrapper.setEntity(new User());
        List<User> list = userService.selectList(entityWrapper);
        return BaseResponse.SUCCESS("用户列表", list);
    }

    @LoginSystem
    @GetMapping("listPage")
    public BaseResponse listPage(@RequestBody User user) {
        EntityWrapper<User> entityWrapper = new EntityWrapper();
        entityWrapper.setEntity(new User());
        Page<User> page = new Page();
        Page<User> pageResult = userService.selectPage(user, page);
        return BaseResponse.SUCCESS("用户列表", pageResult);
    }

    @PostMapping("register")
    public BaseResponse register(@RequestBody User user) {
        logger.info("user/register");
        try {
            if (StringUtils.isEmpty(user.getUserName())) {
                throw new BaseException("用户名不可为空");
            }
            if (StringUtils.isEmpty(user.getPassword())) {
                throw new BaseException("用户名密码不可为空");
            }
            EntityWrapper<User> entityWrapper = new EntityWrapper();
            entityWrapper.setEntity(new User());
            entityWrapper.where("user_name={0}", user.getUserName());
            int sum = userService.selectCount(entityWrapper);
            if (sum != 0) {
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
            return BaseResponse.SUCCESS("用户注册成功", user);
        } catch (BaseException e) {
            logger.error(e.getMessage(), e);
            return BaseResponse.ERROR(e.getMessage(), e);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return BaseResponse.ERROR("【注册】系统错误请稍后重试");
        }
    }

    @PostMapping("login")
    public BaseResponse login(HttpServletRequest request, HttpServletResponse response, @RequestBody UserLoginDTO userIn) {
        try {
            // 登录
            this.loginService.login(userIn.getUserName(), userIn.getPassword());
            return BaseResponse.SUCCESS("登录成功", this.loginService.getAuthorization());
        } catch (BaseException e) {
            logger.error(e.getMessage(), e);
            return BaseResponse.ERROR(e.getMessage(), e);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return BaseResponse.ERROR("【登录】系统错误请稍后重试");
        }
    }

    @RequestMapping("logout")
    public BaseResponse logout(HttpServletRequest request, HttpServletResponse response) {
        try {
            // 校验是否登录
            this.loginService.checkLogin();
            // 推出登录
            this.loginService.logout();
            return BaseResponse.SUCCESS("退出登录成功");
        } catch (BaseException e) {
            return BaseResponse.ERROR(BaseConstants.MSG.PLEASE_LOGIN, "业务异常:" + e.getMessage());
        } catch (ExpiredJwtException e) {
            return BaseResponse.ERROR(BaseConstants.MSG.PLEASE_LOGIN, "401,token失效:" + e.getMessage());
        } catch (Exception e) {
            return BaseResponse.ERROR(BaseConstants.MSG.PLEASE_LOGIN, "系统异常:" + e.getMessage());
        }
    }

    /**
     * 获取用户登录状态
     *
     * @param request
     * @return
     */
    @RequestMapping("getUser")
    public BaseResponse getUser(HttpServletRequest request, HttpServletResponse response) {
        try {
            // 获取登录用户信息
            UserLoginDTO user = this.loginService.userInfo();
            if (null == user) {
                throw new BaseException("未登录");
            }
            return BaseResponse.SUCCESS(BaseConstants.MSG.ON_LINE, user.getUserName());
        } catch (BaseException e) {
            return BaseResponse.ERROR(BaseConstants.MSG.UN_ON_LINE, "业务异常:" + e.getMessage());
        } catch (ExpiredJwtException e) {
            return BaseResponse.ERROR(BaseConstants.MSG.UN_ON_LINE, "401,token失效:" + e.getMessage());
        } catch (Exception e) {
            return BaseResponse.ERROR(BaseConstants.MSG.UN_ON_LINE, "系统异常:" + e.getMessage());
        }
    }

    /**
     * 在线人数
     *
     * @param request
     * @return
     **/
    @RequestMapping("getOnLineCount")
    public BaseResponse getOnLineCount(HttpServletRequest request) {
        // 在线人数
        AtomicInteger userCount = SessionListener.userCount;
        return BaseResponse.SUCCESS(BaseConstants.MSG.ON_LINE_SUM, userCount);
    }
}

