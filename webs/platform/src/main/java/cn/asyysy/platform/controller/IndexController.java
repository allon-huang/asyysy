package cn.asyysy.platform.controller;

import cn.asyysy.common.JsonResult;
import cn.asyysy.common.config.SystemConfigUtil;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
//@RequestMapping("")
public class IndexController {
    @RequestMapping("index")
    public Object index () {
        String shortUrlDoamin = SystemConfigUtil.get().getShortUrlDoamin();
        System.out.println(shortUrlDoamin);
        return new JsonResult(1,"哈哈");
    }
}
