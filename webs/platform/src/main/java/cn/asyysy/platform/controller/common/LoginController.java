package cn.asyysy.platform.controller.common;

import cn.asyysy.app.annotation.PassToken;
import cn.asyysy.app.controller.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController extends BaseController {


    @PassToken
    @RequestMapping("/login")
    public String login() {
        return "login";
    }
}
