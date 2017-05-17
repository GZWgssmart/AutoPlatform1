package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.User;
import com.gs.common.Constants;
import com.gs.common.bean.ControllerResult;
import com.gs.common.util.EncryptUtil;
import com.gs.common.util.RoleUtil;
import com.gs.common.util.SessionUtil;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

@Controller
@RequestMapping("/user")
public class UserController {
    private Logger logger = (Logger) LoggerFactory.getLogger(UserController.class);

    @Resource
    private UserService userService;

    private Subject subject;

    @RequestMapping(value = "loginPage", method = RequestMethod.GET)
    public String loginPage() {
        return "Frontpage/registered";
    }

    @RequestMapping(value = "redirectLogin", method = RequestMethod.GET)
    public void redirectLoginPage(HttpServletResponse response) throws IOException {
        response.getWriter().print("<html><script type='text/JavaScript'>top.location = \"/user/loginPage\";</script></html>");
        response.setContentType("text/html");
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
                if (subject.hasRole(Constants.role_systemSuperAdmin) || subject.hasRole(Constants.role_systemOrdinaryAdmin)
                        || subject.hasRole(Constants.role_companySuperAdmin) || subject.hasRole(Constants.role_companyOrdinaryAdmin)
                        || subject.hasRole(Constants.role_companyReceptionist) || subject.hasRole(Constants.role_companyTotalTC)
                        || subject.hasRole(Constants.role_companyTechnician) || subject.hasRole(Constants.role_companyApprentice)
                        || subject.hasRole(Constants.role_companySales) || subject.hasRole(Constants.role_companyFinancial)
                        || subject.hasRole(Constants.role_companyProcurement) || subject.hasRole(Constants.role_companyLibraryTube)
                        || subject.hasRole(Constants.role_companyHR)) {
                    logger.info("登录成功");
                    User user = userService.queryUser(user1.getUserEmail());
                    session.setAttribute("user", user);
                    session.setAttribute("userLoginedTime", new Date());
                    return ControllerResult.getSuccessResult("登录成功");
                }else if(subject.hasRole(Constants.role_owner)){
                    logger.info("登录成功");
                    User user = userService.queryUser(user1.getUserEmail());
                    session.setAttribute("frontUser", user);
                    return ControllerResult.getIsOwnerResult("登录成功");
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

    @ResponseBody
    @RequestMapping(value = "register", method = RequestMethod.POST)
    public ControllerResult register(User user){
        if(user!=null) {
            userService.insert(user);
            return ControllerResult.getSuccessResult("注册成功, 正在跳转..");
        }else{
            return ControllerResult.getFailResult("注册失败");
        }
    }

    /**
     * 退出登录
     */
    @RequestMapping(value="logout",method=RequestMethod.GET)
    public String logout(HttpSession session) {
        Subject currentUser = SecurityUtils.getSubject();
        if(SessionUtil.isLogin(session)) {
            User user = (User) session.getAttribute("user");
            user.setUserLoginedTime((Date) session.getAttribute("userLoginedTime"));
            userService.update(user);
        }
        currentUser.logout();
        return "Frontpage/registered";
    }

    /**
     * 验证是否登录
     */
    @RequestMapping(value="isLogin/{roles}",method=RequestMethod.POST)
    @ResponseBody
    public ControllerResult isLogin(@PathVariable("roles") String roles, HttpSession session) {
        if(SessionUtil.isLogin(session)) {
            if(RoleUtil.checkRoles(roles)){
                return ControllerResult.getSuccessResult("拥有角色");
            }else{
                logger.info("无进入方法角色");
                return ControllerResult.getNotRoleResult("权限不足");
            }
        }else{
            logger.info("请先登录");
            return ControllerResult.getNotLoginResult("登录信息无效，请重新登录");
        }
    }
}
