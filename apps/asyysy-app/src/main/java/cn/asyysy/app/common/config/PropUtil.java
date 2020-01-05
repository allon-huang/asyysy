package cn.asyysy.app.common.config;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Properties;
import java.util.regex.Pattern;

/**
 * 配置文件工具类
 *
 * @author Luo Yong
 * @date 2014-03-12
 */
public final class PropUtil {

    private static final Logger logger = LoggerFactory.getLogger(PropUtil.class.getName());
    /** FIXME 找扩展名为properties的文件*/
    private static final String REGEX_PROPERTIES = "^(.*).yml$";
    /** 查找文件的匹配正则*/
    private static final Pattern PATTERN_PROPERTIES = Pattern.compile(REGEX_PROPERTIES);
    private static Properties properties = new Properties();
    private static ClassLoader classLoader = getDefaultClassLoader();

    static {
        init();
    }

    /**
     * 获取配置文件
     *
     * @param key
     * @return
     */
    public static String get(final String key) {
        return getProperties().getProperty(key);
    }

    /**
     * 获取配置文件，为空时，返回默认值
     *
     * @param key
     * @param defaultValue
     * @return
     */
    public static String get(final String key, final String defaultValue) {
        String value = getProperties().getProperty(key);
        if (value == null || value.trim().isEmpty()) {
            return defaultValue;
        }
        return value;
    }

    private static Properties getProperties() {
          return properties;
    }

    /**
     * 初始化配置文件
     */
    private static void init() {
        // 获取classpath
        String classpath = getClasspath();
        if (classpath != null) {
            // 从classpath的父节点开始查找
            File baseDir = new File(classpath).getParentFile();
            loadDir(baseDir);
        }
    }

    /**
     * 获取classpath
     */
    private static String getClasspath() {
        String classpath = null;
        try {
            classpath = classLoader.getResource("/").getPath();
        } catch (Exception e) {
            try {
                classpath = classLoader.getResource("").getPath();
            } catch (Exception ex) {
                logger.error(" classpath 初始化失败：", ex);
            }
        }
        return classpath;
    }

    /**
     * copy from org.springframework.util.ClassUtils
     */
    private static ClassLoader getDefaultClassLoader() {
        ClassLoader cl = null;
        try {
            cl = Thread.currentThread().getContextClassLoader();
        } catch (Exception ex) {
            logger.error(" Thread.currentThread() 获取 ClassLoader 出错：", ex);
        }
        if (cl == null) {
            cl = PropUtil.class.getClassLoader();
            if (cl == null) {
                try {
                    cl = ClassLoader.getSystemClassLoader();
                } catch (Exception ex) {
                    logger.error(" ClassLoader.getSystemClassLoader() 获取 ClassLoader 出错：", ex);
                }
            }
        }
        return cl;
    }

    /**
     * 递归查找配置文件<br/>
     *
     * @param baseDir 查找的文件夹
     */
    private static void loadDir(File baseDir) {
        // 判断目录是否存在
        if (!baseDir.exists() || !baseDir.isDirectory()) {
            return;
        }
        String tempPath;
        File[] files = baseDir.listFiles();
        for (File file : files) {
            if (file.isFile()) {
                tempPath = file.getAbsolutePath();
                if (PATTERN_PROPERTIES.matcher(tempPath).matches()) {
                    // 匹配成功，将文件路径添加到结果集
                    load(file);
                }
            } else if (file.isDirectory()) {
                loadDir(file);
            }
        }
    }

    /**
     * 读取配置文件
     *
     * @param file
     */
    private static void load(File file) {
        try (InputStream is = new FileInputStream(file);
             InputStreamReader isr = new InputStreamReader(is, StandardCharsets.UTF_8)) {
            getProperties().load(isr);
        } catch (IOException e) {
            throw new RuntimeException("读取配置文件" + file.getName() + "出现异常", e);
        }
    }

    /**
     * 通过配置文件路径和名称，热加载Properties
     */
    public static void load(String propsName) {
        try (InputStream is = classLoader.getResourceAsStream(propsName)) {
            getProperties().load(is);
        } catch (IOException e) {
            throw new RuntimeException("读取配置文件" + propsName + "出现异常", e);
        }
    }

    private PropUtil() {
    }
}