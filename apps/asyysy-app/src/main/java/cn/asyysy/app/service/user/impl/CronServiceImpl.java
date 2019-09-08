package cn.asyysy.app.service.user.impl;

import cn.asyysy.app.mapper.user.CronMapper;
import cn.asyysy.app.service.user.CronService;
import cn.asyysy.app.model.Cron;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author huangyaoyu
 * @since 2019-06-04
 */
@Service
public class CronServiceImpl extends ServiceImpl<CronMapper, Cron> implements CronService {

    @Autowired
    CronMapper cronMapper;

    @Override
    public String getCron() {
        return cronMapper.getCron();
    }
}
