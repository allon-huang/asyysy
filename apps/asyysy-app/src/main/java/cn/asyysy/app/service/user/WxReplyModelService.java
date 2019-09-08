package cn.asyysy.app.service.user;

import cn.asyysy.app.model.WxReplyModel;
import com.baomidou.mybatisplus.service.IService;

import java.util.List;

public interface WxReplyModelService extends IService<WxReplyModel> {
    /**
     * 查询回复模板
     * @param keyword
     * @return
     */
    public List<WxReplyModel> selectWxReplyModelByKeyword(String keyword);
    /**
     * 查询全部回复模板
     * @return
     */
    public List<WxReplyModel> selectWxReplyModelList();
    /**
     * 更新发送次数
     * @param pkid
     * @return
     */
    public int updateReplyModelSendTime(Long pkid);
}
