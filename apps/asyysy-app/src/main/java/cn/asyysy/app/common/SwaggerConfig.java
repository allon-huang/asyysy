package cn.asyysy.app.common;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * @version V1.0
 * @ClassName：SwaggerConfig
 * @author: hbj
 * @CreateDate：2018/9/4 11:14
 */
@Configuration
@EnableSwagger2
/**
 * 这两个注解，一个是swagger2的配置，一个是项目启动的时候启动swagger2.<br>具体什么意思看下代码就知道了。
 */
public class SwaggerConfig {
    @Bean
    public Docket config() {
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                .select()
                .apis(RequestHandlerSelectors.basePackage("cn.asyysy.core"))
                .build();
    }

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("ASYYSY_Swagger")
                .termsOfServiceUrl("http://www.woshinibaba.cn/")
                .version("0.0.1")
                .build();
    }
}