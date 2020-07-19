package cn.asyysy.asyysy.app.config;


import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
public class DefaultView extends WebMvcConfigurerAdapter {



    @Override
    public void addInterceptors(InterceptorRegistry registry) {
         super.addInterceptors(registry);
        //registry.addInterceptor(new LoggerInterceptor()).addPathPatterns("/**");
        //registry.addInterceptor(new SystemInterceptor(systemInfo)).addPathPatterns("/**");
        super.addInterceptors(registry);
    }

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("index");
        registry.setOrder(Ordered.HIGHEST_PRECEDENCE);

        // swagger
        //registry.addRedirectViewController("/documentation/v2/api-docs", "/v2/api-docs?group=restful-api");
        registry.addRedirectViewController("/documentation/swagger-resources/configuration/ui","/swagger-resources/configuration/ui");
        registry.addRedirectViewController("/documentation/v2/api-docs","/v2/api-docs");
        registry.addRedirectViewController("/documentation/swagger-resources/configuration/security","/swagger-resources/configuration/security");
        registry.addRedirectViewController("/documentation/swagger-resources", "/swagger-resources");
        super.addViewControllers(registry);
    }
/*

&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;
    &#x7248;&#x6743;&#x58f0;&#x660e;&#xff1a;&#x672c;&#x6587;&#x4e3a;CSDN&#x535a;&#x4e3b;&#x300c;&#x996d;&#x4e00;&#x7897;&#x300d;&#x7684;&#x539f;&#x521b;&#x6587;&#x7ae0;&#xff0c;&#x9075;&#x5faa; CC 4.0 BY-SA &#x7248;&#x6743;&#x534f;&#x8bae;&#xff0c;&#x8f6c;&#x8f7d;&#x8bf7;&#x9644;&#x4e0a;&#x539f;&#x6587;&#x51fa;&#x5904;&#x94fe;&#x63a5;&#x53ca;&#x672c;&#x58f0;&#x660e;&#x3002;
    &#x539f;&#x6587;&#x94fe;&#x63a5;&#xff1a;https://blog.csdn.net/fanrenxiang/article/details/80830350
*/
}
