package cn.asyysy.app.mapper.user;

import cn.asyysy.app.model.WxMessage;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface WxMainMapper extends BaseMapper<WxMessage> {
    boolean inserWxInCharge(WxMessage wx);
}
