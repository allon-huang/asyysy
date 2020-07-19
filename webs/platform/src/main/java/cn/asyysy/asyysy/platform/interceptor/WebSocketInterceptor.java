package cn.asyysy.asyysy.platform.interceptor;

import java.util.Map;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import lombok.extern.slf4j.Slf4j;
@Slf4j
public class WebSocketInterceptor implements HandshakeInterceptor{

    // 在握手之前执行该方法, 继续握手返回true, 中断握手返回false. 通过attributes参数设置WebSocketSession的属性
    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
        if (request instanceof ServletServerHttpRequest) {
            String requestURI = ((ServletServerHttpRequest) request).getServletRequest().getRequestURI();
            String[] split = requestURI.split("/");
            String ID = split[split.length - 1];
            log.info("current session id is:"+ID);
            attributes.put("WEBSOCKET_USERID",ID);
        }
        return true;
    }

    @Override
    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Exception exception) {
        log.info("coming webSocketInterceptor afterHandshake method...");
    }

}