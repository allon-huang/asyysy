package cn.asyysy.app.consts;

/**
 * 公共常量类
 */
public class BaseConsts {

    /**
     * Redis的key
     */
    public static class REDIS_KEY{
        /**
         * 短网址redis的key
         */
        public final static String SHORT_URL = "D_ASYYSY_D_";

        /**
         * 新型冠状病毒数据
         */
        public final static String NCP_DATA = "NCP_DATA";

        /**
         * 微信信息
         */
        public final static String WX_INFO = "WX_INFO";

    }

    /**
     * 公共常量
     */
    public static class COMMON{
        // api user session 登录Key
        public static final String SESSION_API_USER_KEY = "user";
    }

    /**
     * 信息
     */
    public static class MSG{
        // 在线人数
        public static final String ON_LINE_SUM = "在线人数";
        // 用户登陆已登录
        public static final String ON_LINE = "用户已登录";
        // 用户登陆未登录
        public static final String UN_ON_LINE = "用户未登录";
        // 请登录
        public static final String PLEASE_LOGIN = "请登录";
        // "无token，请重新登录"
        public static final String UN_LOGIN_TOKEN = "无token，请重新登录";
        // "用户不存在，请重新登录"
        public static final String UNDEFIND_LOGIN_USER = "用户不存在，请重新登录";
    }

    /**
     * 配置
     */
    class CONFIG{
        // session.timeout session超时时间
        public static final String SESSION_TIMEOUT = "server.servlet.session.timeout";
    }
}
