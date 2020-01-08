package cn.asyysy.platform;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.server.ConfigurableWebServerFactory;
import org.springframework.boot.web.server.ErrorPage;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.http.HttpStatus;
import org.springframework.web.WebApplicationInitializer;

@SpringBootApplication
/**
 * mybatis/mybatis plus 扫描包
 */
@MapperScan("cn.asyysy.app.mapper")
/**
 * 多个module spring扫描包需指定
 * 关于spring boot自动注入出现Consider defining a bean of type 'xxx' in your configuration问题解决方案
 *1 .将接口与对应的实现类放在与application启动类的同一个目录或者他的子目录下，这样注解可以被扫描到，这是最省事的办法
 * 　　2 .在指定的application类上加上这么一行注解，手动指定application类要扫描哪些包下的注解（SpringBootApplication 启动文件 @ComponentScan(basePackages={"cn.asyysy.app.service"})）
 *
 * https://blog.csdn.net/a532672728/article/details/77702772/
 */
@ComponentScan(basePackages={"cn.asyysy"})
public class PlatformApplication extends SpringBootServletInitializer implements WebApplicationInitializer {

    @Override
    /*intellij下将springboot项目打成war包发布到远程tomcat服务器上   需  extends SpringBootServletInitializer implements WebApplicationInitializer start*/
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application){
        return application.sources(PlatformApplication.class);
    }
    /*intellij下将springboot项目打成war包发布到远程tomcat服务器上   需  extends SpringBootServletInitializer implements WebApplicationInitializer end*/

    public static void main(String[] args) {
        SpringApplication.run(PlatformApplication.class, args);
    }

    /**
     * Spring Boot2.0以上版本EmbeddedServletContainerCustomizer被WebServerFactoryCustomizer<ConfigurableWebServerFactory>替代
     * https://www.jianshu.com/p/b973476ccfd6
     * @return
     */
    @Bean
    public WebServerFactoryCustomizer<ConfigurableWebServerFactory> containerCustomizer() {
        return (container -> {
            ErrorPage error401Page = new ErrorPage(HttpStatus.UNAUTHORIZED, "/401");
            ErrorPage error404Page = new ErrorPage(HttpStatus.NOT_FOUND, "/errorPage/404");
            ErrorPage error500Page = new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, "/errorPage/500");
            container.addErrorPages(error401Page, error404Page, error500Page);
        });
    }
}
