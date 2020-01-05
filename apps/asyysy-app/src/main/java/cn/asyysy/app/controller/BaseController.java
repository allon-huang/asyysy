package cn.asyysy.app.controller;

import cn.asyysy.app.common.config.SystemInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;

import java.util.logging.Logger;

public class BaseController {
    Logger logger = Logger.getLogger("BaseController");

    /**
     * 系统对应配置
     */
    @Autowired
    private SystemInfo systemInfo;

    @Autowired
    private Environment env;

    SystemInfo getSystem(){
        logger.info("获取系统参数:" + systemInfo);
        return systemInfo;
    }

    Environment getEnv(){
        logger.info("获取系统env参数:" + env);
        return env;
    }
}
