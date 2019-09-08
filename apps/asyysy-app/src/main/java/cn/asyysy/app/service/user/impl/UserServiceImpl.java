package cn.asyysy.app.service.user.impl;

import cn.asyysy.app.mapper.user.UserMapper;
import cn.asyysy.app.service.user.UserService;
import cn.asyysy.app.model.core.User;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author huangyaoyu
 * @since 2019-05-08
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Override
    public Page<User> selectPage(User user, Page<User> page) {

        return null;
    }
}
