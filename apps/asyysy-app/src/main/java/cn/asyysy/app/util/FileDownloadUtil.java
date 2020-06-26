package cn.asyysy.app.util;

import cn.asyysy.app.exception.BaseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.net.ssl.*;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

/**
 * 下载文件工具类
 */
public class FileDownloadUtil {
    private static final Logger logger = LoggerFactory.getLogger(FileDownloadUtil.class);

    /**
     * 根据url下载文件(返回byte[])
     *
     * @param urlStr   URL
     * @param fileName 文件名
     * @return byte[]
     * @throws MalformedURLException <br>-----------------------------------------------------<br>
     * @author: huangyaoyu
     * @date: 2019-1-15 上午10:22:18
     */
    public static byte[] downloadNetByUrl(String urlStr, String fileName) {
        // 下载网络文件
        int bytesum = 0;
        int byteread = 0;
        // 创建一个输入流
        InputStream inStream = null;
        // 创建一个字节数组输出流
        ByteArrayOutputStream outStream = null;
        // 创建一个BufferedOutputStream
        BufferedOutputStream bos = null;
        try {
            logger.info("#######FileDownloadUtil.downloadNetByUrl#####开始下载:" + fileName + "—文件...");
            // URL中包含中文时fileNotFoundException解决方式
            urlStr = URLEncoder.encode(urlStr, "utf-8");
            urlStr = urlStr.replace("%2F", "/");
            urlStr = urlStr.replace("%3A", ":");
            URL url = new URL(urlStr);
            // 判断https
            if (urlStr.startsWith("https:")) {
               /* HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
                // 创建SSLContext
                SSLContext sslContext = SSLContext.getInstance("SSL");
                //TrustManager[] tm = {new MyX509TrustManager()};
                // 初始化
                sslContext.init(null, tm, new java.security.SecureRandom());
                // 获取SSLSocketFactory对象
                SSLSocketFactory ssf = sslContext.getSocketFactory();
                // 设置当前实例使用的SSLSoctetFactory
                conn.setSSLSocketFactory(ssf);
                // 解决java.io.IOException: HTTPS hostname wrong: should be
                conn.setHostnameVerifier(new FileDownloadUtil().new TrustAnyHostnameVerifier());
                // 获取一个输入流
                inStream = conn.getInputStream();*/
            } else {
                URLConnection conn = url.openConnection();
                // 获取一个输入流
                inStream = conn.getInputStream();
            }

            // 创建BufferedInputStream 对象
            inStream = new BufferedInputStream(inStream, 4);
            // 创建一个字节数组输出流
            outStream = new ByteArrayOutputStream();
            // 创建BufferedOutputStream 对象
            bos = new BufferedOutputStream(outStream, 4);
            // 创建一个byte[]数组
            byte[] buffer = new byte[1204];
            while ((byteread = inStream.read(buffer)) != -1) {
                bytesum += byteread;
                // 写流
                bos.write(buffer, 0, byteread);
            }
            logger.info("#######FileDownloadUtil.downloadNetByUrl#####下载完成BYTE[]长度：" + bytesum + ",URL:" + urlStr);
            // 返回byte数组数据
            return outStream.toByteArray();
        } catch (FileNotFoundException e) {
            logger.error("FileNotFoundException:{}", e.getMessage(), e);
            throw new BaseException("文件不存在 #####异常信息:" + e.getMessage());
        } catch (IOException e) {
            logger.error("IOException:{}", e.getMessage(), e);
            throw new BaseException("异常#####异常信息:" + e.getMessage());
        } catch (Exception e) {
            logger.error("Exception:{}", e.getMessage(), e);
            throw new BaseException("异常#####异常信息:" + e.getMessage());
        } finally {
            // 关流处理
            try {
                // 关闭BufferedOutputStream流
                if (bos != null) {
                    bos.close();
                }
                // 关闭字节数组输出流
                if (outStream != null) {
                    outStream.close();
                }
                // 关闭输入流
                if (inStream != null) {
                    inStream.close();
                }
            } catch (IOException e) {
                logger.error("IOException:{}", e.getMessage(), e);
            }
        }
    }
    /**
    * 解决java.io.IOException: HTTPS hostname wrong: should be
    * <br>-----------------------------------------------------<br>
    *
    * @author: huangyaoyu
    * @date: 2019-5-20 下午2:20:06
    */
    public class TrustAnyHostnameVerifier implements HostnameVerifier {
        public boolean verify(String hostname, SSLSession session) {
            // 直接返回true
            return true;
        }
    }
}
