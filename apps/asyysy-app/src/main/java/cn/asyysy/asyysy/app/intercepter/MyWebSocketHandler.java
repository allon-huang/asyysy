package cn.asyysy.asyysy.app.intercepter;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.AbstractWebSocketHandler;

public class MyWebSocketHandler extends AbstractWebSocketHandler {

    //    重写文本类型的消息处理器
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

//        1. 收到消息，从消息中取出下层交付上来的内容
        System.out.println("收到消息"+ message.getPayload());


        
//        3. 发送文本消息给客户端
        System.out.println("发送消息: Hello world!");
        session.sendMessage(new TextMessage("hello world"));
    }

    //    连接建立时的处理器
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
//        super.afterConnectionEstablished(session);
        System.out.println("建立连接");
        session.sendMessage(new TextMessage("欢迎"));
    }

    //    ；连接关闭时的处理器
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
//        super.afterConnectionClosed(session, status);
        System.out.println("关闭连接");
    }

}