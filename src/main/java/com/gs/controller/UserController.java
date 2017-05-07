package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.User;
import com.gs.common.bean.ControllerResult;
import com.gs.common.util.EncryptUtil;
import com.gs.service.UserService;
import org.apache.ibatis.annotations.Param;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {
    private Logger logger = (Logger) LoggerFactory.getLogger(UserController.class);

    @Resource
    private UserService userService;

    private Subject subject;

    @RequestMapping(value = "loginPage", method = RequestMethod.GET)
    public String loginPage() {
        return "user/login";
    }

    /**
     * 登陆方法。
     *
     * @param user1
     * @param session
     * @param checkCode
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "login", method = RequestMethod.POST)
    public ControllerResult userLogin(User user1, HttpSession session, HttpServletRequest req, @Param("checkCode") String checkCode) {
        String codeSession = (String) session.getAttribute("checkCode");
        if (checkCode != null && checkCode.equals(codeSession)) {
            subject = SecurityUtils.getSubject();
            try {
                subject.login(new UsernamePasswordToken(user1.getUserEmail(), EncryptUtil.md5Encrypt(user1.getUserPwd())));
                if (subject.hasRole("systemSuperAdmin") || subject.hasRole("systemOrdinaryAdmin")
                        || subject.hasRole("companySuperAdmin") || subject.hasRole("companyOrdinaryAdmin")
                        || subject.hasRole("systemOrdinaryAdmin") || subject.hasRole("systemOrdinaryAdmin")
                        || subject.hasRole("companyReceptionist") || subject.hasRole("companyTotalTC")
                        || subject.hasRole("companyTechnician") || subject.hasRole("companyApprentice")
                        || subject.hasRole("companySales") || subject.hasRole("companyFinancial")
                        || subject.hasRole("companyProcurement") || subject.hasRole("companyLibraryTube")
                        || subject.hasRole("companyHR") || subject.hasRole("otherPersonnel")) {
                    logger.info("登录成功");
                    User user = userService.queryUser(user1.getUserEmail());
                    session.setAttribute("user", user);
                    return ControllerResult.getSuccessResult("登录成功");
                }else {
                    logger.info("抱歉，你的账号角色并不授权。请联系管理员激活账号！");
                    return ControllerResult.getFailResult("抱歉，你的账号角色并不授权。请联系管理员激活账号！");
                }
            } catch (UnknownAccountException e) {//未知的账号异常
                logger.info("登陆失败，请检查你的账号是否存在或是否可用！");
                return ControllerResult.getFailResult("登陆失败，请检查你的账号是否存在或是否可用！");
            } catch (IncorrectCredentialsException e) {//未知的凭证异常
                logger.info("登陆失败，请检查你的账号密码是否正确！");
                return ControllerResult.getFailResult("登陆失败，请检查你的账号密码是否正确！");
            } catch (LockedAccountException e) {//锁定的账号异常
                logger.info("登陆失败，你的账号已被冻结，暂时无法使用！");
                return ControllerResult.getFailResult("登陆失败，你的账号已被冻结，暂时无法使用！");
            }
        } else {
            logger.info("验证码输入错误，请输入正确的验证码！");
            return ControllerResult.getFailResult("验证码输入错误，请输入正确的验证码！");
        }
    }
}
