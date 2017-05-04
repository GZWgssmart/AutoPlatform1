package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.User;
import com.gs.common.bean.ControllerResult;
import com.gs.common.util.EncryptUtil;
import com.gs.service.UserService;
import org.apache.ibatis.annotations.Param;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.subject.Subject;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {
    private Logger logger = (Logger) LoggerFactory.getLogger(UserController.class);

    @Resource
    private UserService userService;

    private Subject subject;

    @RequestMapping(value = "loginPage",method = RequestMethod.GET)
    public String loginPage() {
        return "user/login";
    }

    /**
     * 登陆方法。
     * @param user
     * @param session
     * @param checkCode
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "login",method = RequestMethod.POST)
    public ControllerResult userLogin(User user, HttpSession session, @Param("checkCode")String checkCode){
        String codeSession = (String) session.getAttribute("checkCode");
        if (checkCode != null && checkCode.equals(codeSession)) {
            subject = SecurityUtils.getSubject();
            try {
                subject.login(new UsernamePasswordToken(user.getUserEmail(), EncryptUtil.md5Encrypt(user.getUserPwd())));
                if (subject.hasRole("user")) {
                    logger.info("验证是否为user");
                    session.setAttribute("user", userService.queryByEmail(subject.getPrincipal().toString()));
                    logger.info("登陆成功");
                    return ControllerResult.getSuccessResult("登陆成功");
                } else {
                    logger.info("抱歉，你的账号并未正式激活。请联系管理员激活账号！");
                    return ControllerResult.getFailResult("登陆失败");
                }
            } catch (UnknownAccountException e) {//未知的账号异常
                e.printStackTrace();
                return ControllerResult.getFailResult("登陆失败，请检查你的账号是否存在");
            } catch (IncorrectCredentialsException e) {//未知的凭证异常
                e.printStackTrace();
                return ControllerResult.getFailResult("登陆失败，请检查你的账号密码是否正确");
            } catch (LockedAccountException e) {//锁定的账号异常
                e.printStackTrace();
                return ControllerResult.getFailResult("登陆失败，你的账号已被冻结，暂时无法使用");
            } catch (AuthenticationException e) {
                e.printStackTrace();
                return ControllerResult.getFailResult("登陆失败，身份验证时出现错误，请重试");
            }
        } else {
            return ControllerResult.getFailResult("验证码错误，请重新输入验证码！");
        }
    }
}
