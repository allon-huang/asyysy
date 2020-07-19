package cn.asyysy.asyysy.platform.config;

import cn.asyysy.asyysy.app.intercepter.MyWebSocketHandler;
import cn.asyysy.asyysy.platform.interceptor.WebSocketInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

/**
 * 首先注入一个ServerEndpointExporterBean,该Bean会自动注册使用@ServerEndpoint注解申明的websocket endpoint
 * @author wanghao
 */
@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer{

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(new MyWebSocketHandler(), "/socket/imserver/{ID}")
                .setAllowedOrigins("*")
                .addInterceptors(new WebSocketInterceptor());
    }
}