package cn.asyysy.app.service.user;

import cn.asyysy.app.model.WxMessage;
import com.baomidou.mybatisplus.service.IService;

public interface WxMainService extends IService<WxMessage> {
    boolean inserWxInCharge(WxMessage wx);
}
