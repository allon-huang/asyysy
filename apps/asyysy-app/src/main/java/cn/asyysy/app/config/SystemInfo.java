package cn.asyysy.app.config;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;

/**
 * 系统对应配置
 */
@Data
public class SystemInfo {
    /**
     * 全站domain
     */
    @Value("${domain.domain}")
    private String domain;

    /**
     * 短网址domain
     */
    @Value("${domain.short-url.domain}")
    private String shortUrlDomain;

    /**
     * 新型肺炎请求地址
     */
    @Value("${domain.tianqiapi_com.ncp_api_url}")
    private String ncpApiUrl;

    /**
     * tianqiapi appid
     */
    @Value("${domain.tianqiapi_com.appid}")
    private String weatherAppid;

    /**
     *  tianqiapi appsecret
     */
    @Value("${domain.tianqiapi_com.appsecret}")
    private String weatherAppSecret;

    @Value("${domain.tianqiapi_com.ncp_data_timeout}")
    private int ncpDataTimeout;

    /**
     * 新型肺炎接口版本号参数
     */
    @Value("${domain.tianqiapi_com.ncp_api_version}")
    private String ncpApiVersion;

    /**
     * 项目名称
     */
    @Value("${server.servlet.context-path}")
    private String contextPath;

    /**
     * 微信token
     */
    @Value("${domain.wx.token}")
    private String wxToken;

    /**
     * 微信appid
     */
    @Value("${domain.wx.appid}")
    private String wxAppid;

    /**
     * 微信appsecret
     */
    @Value("${domain.wx.appsecret}")
    private String wxAppsecret;

    @Value("${domain.qq.app_id}")
    private String qqAppId;

    @Value("${domain.qq.app_key}")
    private String qqAppKey;

    @Value("${domain.qq.redirect_uri}")
    private String qqRedirectUri;

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
