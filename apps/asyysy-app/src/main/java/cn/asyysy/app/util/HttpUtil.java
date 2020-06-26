package cn.asyysy.app.util;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

/**
 * Filename:    HttpUtils.java
 * Description: http请求类
 * Copyright:   Copyright (c) 2012-2018 All Rights Reserved.
 * @author:     huangyaoyu
 * @version:    1.0
 * Create at:   2019-2-22 下午2:01:56
 *
 * Modification History:
 * Date         Author      Version     Description
 * ------------------------------------------------------------------
 * 2019-2-22    huangyaoyu      1.0         1.0 Version
 *
 */
public class HttpUtil {
    /** log日志. */
    private static Logger logger = (Logger) LoggerFactory.getLogger(HttpUtil.class);
    /**
     * 连接超时限制时间
     */
    private static int connectTimeOut = 5000;

    /**
     * 响应超时限制时间
     */
    private static int readTimeOut = 10000;

    /**
     * 编码集
     */
    private static String requestEncoding = "UTF-8";

    /**
     * 向指定URL发送GET方法的请求
     *
     * @param url   发送请求的URL
     * @param param 请求参数，请求参数应该是 name1=value1&name2=value2 的形式。
     * @return URL 所代表远程资源的响应结果
     */
    public static String sendGet(String url, String param, String encoding) {
        String result = "";
        BufferedReader in = null;
        try {
            if (StringUtils.isEmpty(encoding)) {
                encoding = requestEncoding;
            }
            String urlNameString = url + "?" + param;
            logger.info("HttpUtils.sendGet 请求路径及参数：{}", urlNameString);
            URL realUrl = new URL(new String(urlNameString.getBytes("ISO8859-1"),"UTF-8"));
            // 打开和URL之间的连接
            URLConnection connection = realUrl.openConnection();
            // 设置通用的请求属性
            connection.setRequestProperty("accept", "*/*");
            connection.setRequestProperty("connection", "Keep-Alive");
            connection.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            // 建立实际的连接
            connection.connect();
            // 定义 BufferedReader输入流来读取URL的响应
            in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String line;
            while ((line = in.readLine()) != null) {
                result += line;
            }

            // Java把\开头的Unicode编码转换成汉字
            result = StringUtil.unicodeToCn(result);
            logger.info("HttpUtils.sendGet 请求返回结果：" + result);
            return result;
        } catch (Exception e) {
            logger.error("HttpUtils.sendGet--发送GET请求出现异常{}", e.getMessage(), e);
        }
        // 使用finally块来关闭输入流
        finally {
            if (in != null) {
                try {
                    in.close();
                } catch (Exception e2) {
                    logger.error("HttpUtils.sendGet--关流异常{}", e2.getMessage(), e2);
                }
            }
        }
        return result;
    }

    /**
     * POST 请求工具方法
     * @param reqUrl 请求地址
     * @param parameters 参数map
     * @param recvEncoding 编码（默认UTF-8）
     * @return
     * <br>-----------------------------------------------------<br>
     * @author:	huangyaoyu
     * @date:	2019-2-26 下午1:52:03
     */
    public static String doPost(String reqUrl, Map<String, Object> parameters, String recvEncoding) {

        HttpURLConnection url_con = null;
        // 响应内容
        String responseContent = null;
        // 创建输入流
        InputStream in = null;
        // 创建字符缓冲输入流
        BufferedReader rd = null;
        try {
            // 参数处理
            StringBuilder params = new StringBuilder();
            for (Iterator<?> iter = parameters.entrySet().iterator(); iter.hasNext();) {
                Entry<?, ?> element = (Entry<?, ?>) iter.next();
                params.append(element.getKey().toString());
                params.append("=");
                params.append(URLEncoder.encode(element.getValue().toString(), HttpUtil.requestEncoding));
                params.append("&");
            }

            // 长度判断
            if (params.length() > 0) {
                // 删除最后一个"字符"
                params = params.deleteCharAt(params.length() - 1);
            }

            URL url = new URL(reqUrl);
            // 是否https
            if("https".equalsIgnoreCase(url.getProtocol())){
                // TODO 兼容https
                // SslUtils.ignoreSsl();
            }

            // 打开一个新的连接
            url_con = (HttpURLConnection) url.openConnection();

            // post请求方式
            url_con.setRequestMethod("POST");
            // 设置连接超时限制时间
            System.setProperty("sun.net.client.defaultConnectTimeout", String.valueOf(HttpUtil.connectTimeOut));
            // 设置响应超时限制时间
            System.setProperty("sun.net.client.defaultReadTimeout", String.valueOf(HttpUtil.readTimeOut));
            /*
             * 设置是否向httpUrlConnection输出，因为这个是post请求，参数要放在
             *	http正文内，因此需要设为true, 默认情况下是false;
             */
            url_con.setDoOutput(true);
            // 请求返回403 服务器不支持Java程序
            url_con.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");

            // 参数转byte数组处理
            byte[] b = params.toString().getBytes();
            // 写入输出流
            url_con.getOutputStream().write(b, 0, b.length);
            // 输出流清空
            url_con.getOutputStream().flush();
            // 参数输出流关闭
            url_con.getOutputStream().close();
            // 获取InputStream
            in = url_con.getInputStream();

            // 创建 字符缓冲输入流
            rd = new BufferedReader(new InputStreamReader(in, recvEncoding));
            // 返回数据
            String tempLine = rd.readLine();
            // 返回数据拼接StringBuilder
            StringBuilder tempStr = new StringBuilder();
            // 获取换行符
            String crlf = System.getProperty("line.separator");
            // 处理返回内容
            while (tempLine != null) {
                tempStr.append(tempLine);
                tempStr.append(crlf);
                tempLine = rd.readLine();
            }
            // 响应信息
            responseContent = tempStr.toString();
        }
        catch (IOException e) {
            logger.error("HttpUtil.doPost方法IO异常{}", e.getMessage(), e);
        } catch (Exception e) {
            logger.error("HttpUtil.doPost方法异常{}", e.getMessage(), e);
        } finally {
            // 关流操作
            if (rd != null) {
                try {
                    rd.close();
                } catch (IOException e) {
                    logger.error("HttpUtil.doPost.BufferedReader方法关流异常{}", e.getMessage(), e);
                }
            }
            if (in != null) {
                try {
                    in.close();
                } catch (IOException e) {
                    logger.error("HttpUtil.doPost.InputStream方法关流异常{}", e.getMessage(), e);
                }
            }
            if (url_con != null) {
                try {
                    url_con.disconnect();
                } catch (Exception e) {
                    logger.error("HttpUtil.doPost.HttpURLConnection方法关流异常{}", e.getMessage(), e);
                }
            }
        }
        return responseContent;
    }
}

