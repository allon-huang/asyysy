package cn.asyysy.common.config;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;

/**
 * 系统对应配置
 */
@Data
public class SystemInfo {
    /**
     * 短网址domain
     */
    @Value("${domain.short-url}")
    public String  SHORT_URL_DOAMIN;

    /**
     * Springboot初始化系统配置
     * 1、创建系统信息model
     *         1.1 使用@Value  (org.springframework.beans.factory.annotation.Value)  $("${配置文件配置key}")注解在对应字段上
     *         1.2 使用lombok注解@Data
     *
     * 2、新建/修改@Configuration注解修饰的类增加 @Bean
     *      public SystemInfo getSystemInfo(){
     *          return new SystemInfo;
     *      }
     *  3、在使用的地方@Autowired 注入SystemInfo类就可以使用获取的配置信息了
     */
}
