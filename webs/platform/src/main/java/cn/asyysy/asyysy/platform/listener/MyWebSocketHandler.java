package cn.asyysy.asyysy.platform.listener;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import com.alibaba.fastjson.JSONObject;
import lombok.extern.slf4j.Slf4j;

/**
 * @author hyy
 */
@Service
@Slf4j
public class MyWebSocketHandler implements WebSocketHandler{

    /**
     * 在线用户列表
     */
    private static final Map<String, WebSocketSession> users;

    static {
        users = new HashMap<>();
    }

    /**
     * ① afterConnectionEstablished（接口提供的）：建立新的socket连接后回调的方法。主要逻辑是：将成功建立连接的webSocketSssion放到定义好的常量[private static final Map<String, WebSocketSession> users;]中去。这里也截取客户端访问的URL的字符串，拿到标识，以键值对的形式讲每一个webSocketSession存到users里，以记录每个Socket。
     * ————————————————
     * 版权声明：本文为CSDN博主「wangtuoyuan」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
     * 原文链接：https://blog.csdn.net/qq_34912469/java/article/details/94006301
     * @param session
     * @throws Exception
     */
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        log.info("connect websocket successful!");
        String ID = session.getUri().toString().split("ID=")[1];
        log.info(ID);
        if (ID != null) {
            users.put(ID, session);
            session.sendMessage(new TextMessage("{\"message\":\"socket successful connection!\"}"));
            log.info("id:" + ID + ",session:" + session + "");
        }
        log.info("current user number is:"+users.size());
    }

    /**
     * ② handleMessage（接口提供的）：接收客户端发送的Socket。主要逻辑是：获取客户端发送的信息。这里之所以可以获取本次Socket的ID，是因为客户端在第一次进行连接时，拦截器进行拦截后，设置好ID，这样也说明，双方在相互通讯的时候，只是对第一次建立好的socket持续进行操作。
     * ————————————————
     * 版权声明：本文为CSDN博主「wangtuoyuan」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
     * 原文链接：https://blog.csdn.net/qq_34912469/java/article/details/94006301
     * @param session
     * @param message
     * @throws Exception
     */
    @Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
        try{
            JSONObject jsonobject = JSONObject.parseObject((String)message.getPayload());
            log.info("receive message:" + jsonobject);
			log.info(jsonobject.get("message")+":来自"+(String)session.getAttributes().get("WEBSOCKET_USERID")+"的消息");
            //jsonobject.get("id")
            sendMessageToUser(2+"", new TextMessage("{\"message\":\"server received message,hello!\"}"));
        }catch (Exception e) {
            log.error("e",e);
        }
    }

    /**
     * ⑤handleTransportError（接口提供的）：连接出错时，回调的方法。主要逻辑是：一旦有连接出错的Socket,就从users里进行移除，有提供该Socket的参数，可直接获取ID，进行移除。这个在客户端没有正常关闭连接时，会进来，所以在开发客户端时，记得关闭连接
     * @param session
     * @param exception
     * @throws Exception
     */
    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        if (session.isOpen()) {
            session.close();
        }
        log.error("connect error", exception);
        users.remove(getClientId(session));
    }

    /**
     * ⑥afterConnectionClosed（接口提供的）：连接关闭时，回调的方法。主要逻辑：一旦客户端/服务器主动关闭连接时，将个socket从users里移除，有提供该Socket的参数，可直接获取ID，进行移除。
     * @param session
     * @param closeStatus
     * @throws Exception
     */
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
        log.error("connection closed: " + closeStatus);
        users.remove(getClientId(session));
    }

    @Override
    public boolean supportsPartialMessages() {
        return false;
    }

    /**
     * 发送信息给指定用户
     * @param clientId
     * @param message
     * @return
     */
    // ③ sendMessageToUser（自己定义的）：发送给指定用户信息。主要逻辑是：根据用户ID从常量users(记录每一个Socket)中，获取Socket,往该Socket里发送消息，只要客户端还在线，就能收到该消息。
    public boolean sendMessageToUser(String clientId, TextMessage message) {
        if (users.get(clientId) == null) {
            return false;
        }
        WebSocketSession session = users.get(clientId);
        log.info("sendMessage:" + message);
        if (!session.isOpen()) {
            return false;
        }
        try {
            session.sendMessage(message);
        } catch (IOException e) {
            log.error("e", e);
            return false;
        }
        return true;
    }

    /**
     * 广播信息
     * @param message
     * @return
     */
    // ④sendMessageToAllUsers （自己定义的）：这个广播消息，发送信息给所有socket。主要逻辑是：跟③类型，只不过是遍历整个users获取每一个socket,给每一个socket发送消息即可完广播发送
    public boolean sendMessageToAllUsers(TextMessage message) {
        boolean allSendSuccess = true;
        Set<String> clientIds = users.keySet();
        WebSocketSession session = null;
        for (String clientId : clientIds) {
            try {
                session = users.get(clientId);
                if (session.isOpen()) {
                    session.sendMessage(message);
                }
            } catch (IOException e) {
                log.error("e", e);
                allSendSuccess = false;
            }
        }
        return allSendSuccess;
    }

    /**
     * 获取用户标识
     * @param session
     * @return
     */
    private String getClientId(WebSocketSession session) {
        try {
            String clientId = (String) session.getAttributes().get("WEBSOCKET_USERID");
            return clientId;
        } catch (Exception e) {
            log.error("e", e);
            return null;
        }
    }
    /**
     * 获取在线人数
     * @return
     */
    public synchronized int getOnlineNum(){
        return users.size();
    }
}