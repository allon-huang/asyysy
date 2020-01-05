package cn.asyysy.platform.config;

import cn.asyysy.app.common.config.SystemInfo;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 系统配置初始化配置
 */
@Configuration
public class InitConfiguration {

    @Bean
    public SystemInfo getSystemInfo(){
        return new SystemInfo();
    }
}
