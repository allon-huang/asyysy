package cn.asyysy.platform.controller;

import cn.asyysy.app.annotation.LoginSystem;
import cn.asyysy.app.consts.BaseConsts;
import cn.asyysy.app.controller.common.BaseController;
import cn.asyysy.common.rest.common.BaseResponse;
import cn.asyysy.app.model.core.User;
import cn.asyysy.app.model.wechat.WxReplyModel;
import cn.asyysy.app.service.redis.RedisBaseService;
import cn.asyysy.app.service.short_url.ShortUrlService;
import cn.asyysy.app.service.user.UserService;
import cn.asyysy.app.service.user.WxReplyModelService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * @author hyy21
 */
@Controller
public class IndexController extends BaseController {

    @Autowired
    private  WxReplyModelService wxReplyModelService;

    @Autowired
    private RedisBaseService redisBaseService;

    @Autowired
    private ShortUrlService shortUrlService;
    @Autowired
    UserService userService;

    @RequestMapping("/")
    public String root() {
        return "redirect:/index";
    }

    @RequestMapping(value = "index")
    public String index(@RequestParam Map<String,Object> params, HttpServletRequest request) {
        // 微信回复模板
        List<WxReplyModel> wxReplys =  wxReplyModelService.selectWxReplyModelList();
        request.setAttribute("list",wxReplys);
        // 短网址
        request.setAttribute("shortUrlList", shortUrlService.selectList(new EntityWrapper<>()
        //.eq("gender",1)
        //.like("name", "霸")
        //.or()//SELECT id AS id,`name`,email,gender,age FROM employee WHERE (gender = ? AND name LIKE ? OR email LIKE ?)
        //.orNew()//SELECT id AS id,`name`,email,gender,age FROM employee WHERE (gender = ? AND name LIKE ?) OR (email LIKE ?)
        //.like("email", "123")
        ));
        return  "index";
    }

    @RequestMapping(value = "h5")
    public String index1(@RequestParam Map<String,Object> params, HttpServletRequest request) {
        return  "h5";
    }

    @LoginSystem
    @RequestMapping(value = "chat")
    public String chat(@RequestParam Map<String,Object> params, HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute(BaseConsts.COMMON.SESSION_API_USER_KEY);
        request.setAttribute("user", user);
        EntityWrapper<User> ew = new EntityWrapper<User>();
        ew.setEntity(new User());
        ew.ne("pkid", user.getPkid());
        List<User> list = userService.selectList(ew);
        request.setAttribute("list", list);
        return  "chat";
    }

    @RequestMapping(value = "chatList")
    @ResponseBody
    public Object chatList(HttpServletRequest request, @RequestBody User vo) {
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute(BaseConsts.COMMON.SESSION_API_USER_KEY);
        EntityWrapper<User> ew = new EntityWrapper<User>();
        ew.setEntity(new User());
        ew.ne("pkid", user.getPkid());
        // 模糊查询
        if (StringUtils.isNotEmpty(vo.getUserName())) {
            ew.and().like("user_name", vo.getUserName());
        }
        List<User> list = userService.selectList(ew);
        return BaseResponse.SUCCESS("获取用户列表成功", list);
    }


    @RequestMapping(value = "api")
    public String api(){
        return "redirect:/documentation/swagger-ui.html";
    }
}
