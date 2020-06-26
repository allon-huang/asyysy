package cn.asyysy.app.mapper;

import cn.asyysy.app.model.Cron;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author huangyaoyu
 * @since 2019-06-04
 */
@Mapper
public interface CronMapper extends BaseMapper<Cron> {
    String getCron();
}
