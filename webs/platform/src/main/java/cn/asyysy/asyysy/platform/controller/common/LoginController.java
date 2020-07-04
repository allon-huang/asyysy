package cn.asyysy.asyysy.platform.controller.common;

import cn.asyysy.asyysy.app.controller.common.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class LoginController extends BaseController {



    @RequestMapping("/login")
    public String login(HttpServletRequest request) {
        return "login";
    }
}
