package cn.asyysy.app.controller;

import cn.asyysy.app.common.config.SystemInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;

import java.util.logging.Logger;

/**
 * 基础Controller
 * @author hyy
 */
public class BaseController {
    Logger logger = Logger.getLogger("BaseController");

    /**
     * 系统对应配置
     */
    @Autowired
    private SystemInfo systemInfo;

    @Autowired
    private Environment env;

    public SystemInfo systemInfo(){
        return systemInfo;
    }

    public Environment environment(){
        return env;
    }
}
