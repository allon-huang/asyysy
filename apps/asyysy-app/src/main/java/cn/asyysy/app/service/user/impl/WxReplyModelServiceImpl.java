package cn.asyysy.app.service.user.impl;

import cn.asyysy.app.mapper.user.WxReplyModelMapper;
import cn.asyysy.app.service.user.WxReplyModelService;
import cn.asyysy.app.model.wechat.WxReplyModel;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WxReplyModelServiceImpl extends ServiceImpl<WxReplyModelMapper , WxReplyModel> implements WxReplyModelService {

    @Autowired
    private WxReplyModelMapper replyModelMapper;

    @Override
    public List<WxReplyModel> selectWxReplyModelByKeyword(String keyword) {
        return replyModelMapper.selectWxReplyModelByKeyword(keyword);
    }

    @Override
    public List<WxReplyModel> selectWxReplyModelList(){
        return replyModelMapper.selectWxReplyModelList();
    }

    @Override
    public int updateReplyModelSendTime(Long pkid) {
        return replyModelMapper.updateReplyModelSendTime(pkid);
    }
}
