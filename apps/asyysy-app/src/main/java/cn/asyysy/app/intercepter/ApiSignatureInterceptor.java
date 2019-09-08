package cn.asyysy.app.intercepter;

import org.springframework.util.DigestUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * @Author: perkins
 */
public class ApiSignatureInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                             Object handler) throws Exception {
        Enumeration<String> paramNames = request.getParameterNames();
        String timestamp = request.getHeader("timestamp");

        long timestampDate = Long.valueOf(timestamp) + 1000*60*10;
        long currDate = System.currentTimeMillis();
        // 请求过期
        if (timestampDate < currDate) {
            response.setStatus(403);
            return false;
        }

        String noncestr = request.getHeader("noncestr");
        String signature = request.getParameter("sign");
        System.out.println(signature);

        if (signature == null) {
            response.setStatus(403);
            return false;
        }
        Map map = new HashMap();

        //获取所有的请求参数
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            String[] paramValues = request.getParameterValues(paramName);

            if (paramValues.length > 0) {
                String paramValue = paramValues[0];
                System.out.println(paramName);
                if (paramValue.length() != 0 && !"sign".equals(paramName)) {
                    map.put(paramName, paramValue);
                }
            }
        }

        Set setKey = map.keySet();
        Object[] keys = setKey.toArray();
        // 将请求参数升序排序
        Arrays.sort(keys);

        StringBuilder strBuilder = new StringBuilder();
        for (Object str : keys) {
            strBuilder.append(str.toString());
            strBuilder.append(map.get(str.toString()));
        }

        strBuilder.append("noncestr");
        strBuilder.append(noncestr);
        strBuilder.append("timestamp");
        strBuilder.append(timestamp);

        System.out.println(strBuilder.toString());
        String newSignature = DigestUtils.md5DigestAsHex(strBuilder.toString().getBytes()).toUpperCase();

        if (!signature.equals(newSignature)) {
            response.setStatus(403);
            return false;
        }
        return true;
    }
}


