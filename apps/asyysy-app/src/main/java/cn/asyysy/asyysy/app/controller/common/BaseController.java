package cn.asyysy.asyysy.app.controller.common;

import cn.asyysy.asyysy.app.service.common.CommonService;
import cn.asyysy.asyysy.app.model.SystemInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;

/**
 * 基础Controller
 * @author hyy
 */
public class BaseController {
    /**
     * log日志
     */
    public static Logger logger = (Logger) LoggerFactory.getLogger(BaseController.class);

    @Autowired
    public CommonService commonService;

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

    public Environment environment() {
        return env;
    }


}
