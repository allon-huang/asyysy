package cn.asyysy.app.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 系统配置初始化配置
 * @author hyy
 */
@Configuration
public class InitConfiguration {

    @Bean
    public SystemInfo getSystemInfo(){
        return new SystemInfo();
    }
}
