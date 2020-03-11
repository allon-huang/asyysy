package cn.asyysy.app.config;

import cn.asyysy.app.intercepter.ShortUrlInterceptor;
import cn.asyysy.app.intercepter.SystemInterceptor;
import cn.asyysy.app.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

@EnableWebMvc
@Configuration
public class MvcConfig implements WebMvcConfigurer {
    //service注入在拦截器的注册器中
    /**
     * 系统对应配置
     */
    @Autowired
    private SystemInfo systemInfo;

    @Autowired
    private Environment env;
    @Autowired
    private UserService userService;

    /*@Autowired
    private https://weui.io/ shortUrlInterceptor;*/

   /* @Bean
    public ShortUrlInterceptor getShortUrlInterceptor(){
        return new ShortUrlInterceptor();
    }*/

    // 再拦截器中使用了RedisUtil bean类，但是拦截器执行实在spring容器bean初始化之前的
    // RedisUtil 将无法注入，为了解决该问题，将JwtInterceptor拦截器先配置为一个bean
    // 在注册拦截器时，直接使用配置的bean
    /*@Bean
    public JwtInterceptor jwtInterceptor(){
        return new JwtInterceptor();
    }*/

    // 这个方法是用来配置静态资源的，比如html，js，css，等等
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        //第一个方法设置访问路径前缀，第二个方法设置资源路径
        registry.addResourceHandler("/static/**").addResourceLocations("classpath:/static/");

        // swagger
        registry.addResourceHandler("/documentation/swagger-ui.html**").addResourceLocations("classpath:/META-INF/resources/swagger-ui.html");
        registry.addResourceHandler("/documentation/webjars/**").addResourceLocations("classpath:/META-INF/resources/webjars/");
    }

    // 这个方法用来注册拦截器，我们自己写好的拦截器需要通过这里添加注册才能生效
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // addPathPatterns 需要拦截的路径/** 为全部    excludePathPatterns 拦截路径下排除的路径
        registry.addInterceptor(new SystemInterceptor(systemInfo, env, userService)).addPathPatterns("/**").excludePathPatterns("/documentation**");
        registry.addInterceptor(new ShortUrlInterceptor()).addPathPatterns("/**");
        // 注册Token拦截器
        //registry.addInterceptor(new ApiSignatureInterceptor());
        //registry.addInterceptor(new JwtInterceptor()) .addPathPatterns("/tp_store/logout");


    }

    /*开启WebSocket支持*/
    @Bean
    public ServerEndpointExporter serverEndpointExporter() {
        return new ServerEndpointExporter();
    }

}