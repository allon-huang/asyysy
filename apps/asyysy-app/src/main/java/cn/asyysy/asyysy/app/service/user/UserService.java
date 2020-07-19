package cn.asyysy.asyysy.app.service.user;

import cn.asyysy.asyysy.app.model.core.User;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author huangyaoyu
 * @since 2019-05-08
 */
public interface UserService extends IService<User> {

    Page<User> selectPage(User user, Page<User> page);
}
