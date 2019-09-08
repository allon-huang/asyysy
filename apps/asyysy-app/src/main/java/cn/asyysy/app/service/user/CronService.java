package cn.asyysy.app.service.user;

import cn.asyysy.app.model.Cron;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author huangyaoyu
 * @since 2019-06-04
 */
public interface CronService extends IService<Cron> {
    String getCron();
}
