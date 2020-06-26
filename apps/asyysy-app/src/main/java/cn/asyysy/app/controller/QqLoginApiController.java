package cn.asyysy.app.controller;

import cn.asyysy.app.controller.common.BaseController;
import cn.asyysy.app.exception.BaseException;
import cn.asyysy.app.model.common.ApiResponse;
import cn.asyysy.app.model.core.User;
import cn.asyysy.app.service.user.UserService;
import cn.asyysy.app.util.HttpClientUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/api/qq")
public class QqLoginApiController extends BaseController {
    @Autowired
    UserService userService;


    @RequestMapping("callback")
    public String callback(HttpServletRequest request, HttpServletResponse response){
        try {
            String a = request.getHeader("code");
            String code = request.getParameter("code");
            /*
            String userName = "admin";
            EntityWrapper<User> entityWrapper = new EntityWrapper();
            entityWrapper.where("user_name={0}",userName);
            User user = userService.selectOne(entityWrapper);
            request.getSession().setAttribute(BaseConsts.COMMON.SESSION_API_USER_KEY, user);
            String token = TokenUtil.createJwtToken(userName);
            System.out.println("______________________token:" + token);
            // Cookie
            Cookie cookie = new Cookie("token", token);
            //单位：秒
            cookie.setMaxAge(60*60*24);
            response.addCookie(cookie);*/
            return "redirect:" + systemInfo().getDomain() + "/index";
        } catch (BaseException e){
            logger.error(e.getMessage(), e);
            return "redirect:" + systemInfo().getDomain() + "/login";
        } catch (Exception e){
            logger.error(e.getMessage(), e);
            return "redirect:" + systemInfo().getDomain() + "/login";
        }
    }


    @RequestMapping("saveQqInfo")
    @ResponseBody
    public ApiResponse saveQqInfo(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, String> params) {
        try {
            String openId = params.get("openId");
            String accessToken = params.get("accessToken");
            EntityWrapper ew = new EntityWrapper<User>();
            ew.setEntity(new User());
            ew.where("qq_open_id={0}", openId);
            // 查询用户
            User user = userService.selectOne(ew);
            // 未关联用户创建新用户
            if (null == user) {
                Map<String, String> map = new HashMap<>();
                map.put("access_token", accessToken);
                map.put("oauth_consumer_key", systemInfo().getQqAppId());
                map.put("openid", openId);
                // 获取用户信息
                String result = HttpClientUtil.doPost("https://graph.qq.com/user/get_user_info", map);
                logger.info("###############-{}",result);
                JSONObject jsonObject = JSON.parseObject(result);
                // 接口状态
                Integer ret = jsonObject.getInteger("ret");
                // 判断返回请求是否为空
                if (null == ret || 0!= ret.intValue()) {
                    throw new BaseException(jsonObject.getString("msg"));
                }
                // 姓名
                String nickname = jsonObject.getString("nickname");
                // 性别 男女
                String gender = jsonObject.getString("gender");
                // 姓名
                String gender_type = jsonObject.getString("gender_type");
                // 省份
                String province = jsonObject.getString("province");
                // 城市
                String city = jsonObject.getString("city");
                // 出生年份
                String year = jsonObject.getString("year");
                String figureurl = jsonObject.getString("figureurl");
                String figureurl_1 = jsonObject.getString("figureurl_1");
                String figureurl_2 = jsonObject.getString("figureurl_2");
                String figureurl_qq_1 = jsonObject.getString("figureurl_qq_1");
                String figureurl_qq_2 = jsonObject.getString("figureurl_qq_2");
                String figureurl_qq = jsonObject.getString("figureurl_qq");
                User bean = new User();
                bean.setUserName(nickname);
                bean.setPassword("123456");
                bean.setCreateDate(new Date());
                bean.setUpdateDate(new Date());
                bean.setQqOpenId(openId);
                bean.setQqAccessToken(accessToken);
                try {
                    // 获取unionid
                    String unionid = this.getQqUnionId(accessToken);
                }  catch (Exception e)     {
                    logger.error(e.getMessage(), e);
                }
                userService.insert(bean);
            }
            // 更新accessToken
            if (StringUtils.isEmpty(user.getQqAccessToken()) || !user.getQqAccessToken().equals(accessToken)) {
                user.setQqAccessToken(accessToken);
                ew.where("qq_access_token={0}", openId);
                userService.update(user, ew);
            }
            if (StringUtils.isEmpty(user.getQqUnionId())) {
                // 获取unionid
                String unionid = this.getQqUnionId(accessToken);
                user.setQqUnionId(unionid);
                userService.update(user, ew);
            }
            return ApiResponse.SUCCESS("success");
        } catch (BaseException e) {
            logger.error(e.getMessage(), e);
            return ApiResponse.ERROR(e.getMessage());
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return ApiResponse.ERROR(e.getMessage());
        }
    }

    private String getQqUnionId(String accessToken) {
        // 获取unionid
        Map<String, String> map = new HashMap<>();
        map.put("access_token", accessToken);
        map.put("unionid", "1");
        // 获取用户信息
        String result = HttpClientUtil.doPost("https://graph.qq.com/oauth2.0/me", map);
        logger.info("请求unionId接口返回数据：{}" , result);
        result = result.replace("callback(","");
        result = result.replace(");","");
        JSONObject jsonObject = JSON.parseObject(result);
        boolean unionidFlag = jsonObject.containsKey("unionid");
        if (!unionidFlag) {
          throw new BaseException("unionId不存在");
        }
        return jsonObject.getString("unionid");
    }
}
