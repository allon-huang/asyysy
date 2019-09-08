package cn.asyysy.platform.controller;

import cn.asyysy.common.JsonResult;
import cn.asyysy.common.config.SystemInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
//@RequestMapping("")
public class IndexController {

    /**
     * 系统对应配置
     */
    @Autowired
    SystemInfo systemInfo;

    @RequestMapping("index")
    public Object index () {
        System.out.println(systemInfo.SHORT_URL_DOAMIN);
        return new JsonResult(1,"哈哈");
    }
}
