package cn.asyysy.asyysy.app.service.user.impl;

import cn.asyysy.asyysy.app.mapper.user.UserMapper;
import cn.asyysy.asyysy.app.model.core.User;
import cn.asyysy.asyysy.app.service.user.UserService;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author huangyaoyu
 * @since 2019-05-08
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {
    /**
     * log日志
     */
    public static Logger logger = (Logger) LoggerFactory.getLogger(UserServiceImpl.class);

    @Autowired
    private UserMapper userMapper;

    @Override
    public Page<User> selectPage(User user, Page<User> page) {

        return null;
    }
}
