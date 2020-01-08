package cn.asyysy.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 错误页面控制器
 * @author hyy
 */
@Controller
@RequestMapping(value = "/errorPage")
public class ErrorController {

    /**
     * 日志管理
     */
    private Logger log = LoggerFactory.getLogger(ErrorController.class);

    /**
     *
     * @Title: notFound
     * @Description: 配置404
     * @return
     */
    /*@RequestMapping(value = "/404")
    @ResponseBody
    public ApiResponse notFound() {
        log.warn("没有找到对应的信息");
        return ApiResponse.createFailResponse("没有找到对应的信息");
    } */

    @RequestMapping(value = "/404")
    public String notFound() {
        log.warn("没有找到对应的信息");
        return "error/404";
    }

    @RequestMapping(value = "/500")
    public String error() {
        log.warn("error");
        return "error/500";
    }
}