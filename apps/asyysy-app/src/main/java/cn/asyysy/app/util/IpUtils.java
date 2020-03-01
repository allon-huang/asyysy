package cn.asyysy.app.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import java.util.regex.Pattern;

/**
 * https://blog.csdn.net/linxiang1aa/article/details/81512552
 */
public class IpUtils {

    /**
     * log日志.
     */
    private static Logger logger = (Logger) LoggerFactory.getLogger(IpUtils.class);

    public static final String _255 = "(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)";

    public static final Pattern pattern = Pattern.compile("^(?:" + _255 + "\\.){3}" + _255 + "$");


    public static String longToIpV4(long longIp) {

        int octet3 = (int) ((longIp >> 24) % 256);

        int octet2 = (int) ((longIp >> 16) % 256);

        int octet1 = (int) ((longIp >> 8) % 256);

        int octet0 = (int) ((longIp) % 256);

        return octet3 + "." + octet2 + "." + octet1 + "." + octet0;

    }


    public static long ipV4ToLong(String ip) {

        String[] octets = ip.split("\\.");

        return (Long.parseLong(octets[0]) << 24) + (Integer.parseInt(octets[1]) << 16) + (Integer.parseInt(octets[2]) << 8) + Integer.parseInt(octets[3]);

    }


    public static boolean isIPv4Private(String ip) {
        long longIp = ipV4ToLong(ip);

        return (longIp >= ipV4ToLong("10.0.0.0") && longIp <= ipV4ToLong("10.255.255.255"))

                || (longIp >= ipV4ToLong("172.16.0.0") && longIp <= ipV4ToLong("172.31.255.255"))

                || longIp >= ipV4ToLong("192.168.0.0") && longIp <= ipV4ToLong("192.168.255.255");

    }


    public static boolean isIPv4Valid(String ip) {

        return pattern.matcher(ip).matches();

    }


    /**
     *   * 获取请求主机IP地址,如果通过代理进来，则透过防火墙获取真实IP地址;
     * <p>
     *   *
     * <p>
     *   * @param request
     * <p>
     *   * @return
     * <p>
     *  
     */


    public final static String getIpAddress(HttpServletRequest request) {
        if (request == null) {
            logger.info("IpUtils.getIpAddress request is null");
            return null;
        }
        String headerType = "X-Forwarded-For";
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                headerType = "Proxy-Client-IP";
                ip = request.getHeader("Proxy-Client-IP");
            }
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                headerType = "WL-Proxy-Client-IP";
                ip = request.getHeader("WL-Proxy-Client-IP");
            }

            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                headerType = "HTTP_CLIENT_IP";
                ip = request.getHeader("HTTP_CLIENT_IP");
            }

            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                headerType = "HTTP_X_FORWARDED_FOR";
                ip = request.getHeader("HTTP_X_FORWARDED_FOR");
            }
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                headerType = "getRemoteAddr";
                ip = request.getRemoteAddr();
            }
        } else if (ip.length() > 15) {
            String[] ips = ip.split(",");
            for (int index = 0; index < ips.length; index++) {
                String strIp = (String) ips[index];
                if (!("unknown".equalsIgnoreCase(strIp))) {
                    ip = strIp;
                    break;
                }
            }
        }
        //logger.info("IpUtils.getIpAddress {} ip = {}", headerType, ip);
        if (isIPv4Valid(ip) && !isIPv4Private(ip)) {
            return ip;
        }
        return null;

    }
}
