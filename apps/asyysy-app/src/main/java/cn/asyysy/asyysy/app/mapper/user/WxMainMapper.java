package cn.asyysy.asyysy.app.mapper.user;

import cn.asyysy.asyysy.app.model.wechat.WxMessage;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface WxMainMapper extends BaseMapper<WxMessage> {
}
