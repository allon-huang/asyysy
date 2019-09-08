package cn.asyysy.common.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Value;

/**
 * 系统对应配置
 */

@Getter
@Setter
public class SystemConfigUtil {
    /**
     * 短网址domain
     */
    @Value("${domain.short-url}")
    private  String  shortUrlDoamin;

    /**
     * SystemConfigUtil的bean
     */
    private static SystemConfigUtil bean;
    public static SystemConfigUtil get(){
        // 判断bean是否为空
        if (null != bean) {
            return  bean;
        }
        return syncNew();
    };

    /**
     * 同步锁创建SystemConfigUtil
     * @return
     */
    private static SystemConfigUtil syncNew(){
        synchronized (SystemConfigUtil.class){
            return new SystemConfigUtil();
        }
    }
}
