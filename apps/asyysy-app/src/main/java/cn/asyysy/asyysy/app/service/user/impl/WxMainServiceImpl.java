package cn.asyysy.asyysy.app.service.user.impl;


import cn.asyysy.asyysy.app.mapper.user.WxMainMapper;
import cn.asyysy.asyysy.app.service.user.WxMainService;
import cn.asyysy.asyysy.app.model.wechat.WxMessage;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WxMainServiceImpl extends ServiceImpl<WxMainMapper, WxMessage> implements WxMainService {

    @Autowired
    private WxMainMapper wxMainMapper;

}
