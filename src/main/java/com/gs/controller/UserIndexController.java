package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.User;
import com.gs.common.Constants;
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
import org.omg.CORBA.Request;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by 不曾有黑夜 on 2017/5/9.
 * 用户个人中心页面
 */

@Controller
@RequestMapping("/")
public class UserIndexController {

    private Subject subject;

    private Logger logger = (Logger) LoggerFactory.getLogger(UserIndexController.class);

    @Resource
    private UserService userService;

    /*欢迎页面*/
    @RequestMapping(value = "welcome",method = RequestMethod.GET)
    public String welcome(){
        return "Frontpage/Personalcenter/AccountSettings/welcome";
    }


    /*账号信息页面*/
    @RequestMapping(value = "accountinfo",method = RequestMethod.GET)
    public String accountinfo(){
        return "Frontpage/Personalcenter/AccountSettings/accountinformation";
    }

    /*修改密码页面*/
    @RequestMapping(value = "editpwd",method = RequestMethod.GET)
    public String editpwd(){
        return "Frontpage/Personalcenter/AccountSettings/editpwd";
    }

    /*我的预约*/
    @RequestMapping(value = "myrese",method = RequestMethod.GET)
    public String myrese(){
        return "Frontpage/Personalcenter/reservation/reservation";
    }

    /*维修保养记录*/
    @RequestMapping(value = "userrese",method = RequestMethod.GET)
    public String userrese(){
        return "Frontpage/Personalcenter/maintain/reserecording";
    }

    /*维修保养提醒*/
    @RequestMapping(value = "prompt",method = RequestMethod.GET)
    public String prompt(){
        return "Frontpage/Personalcenter/maintain/prompt";
    }

    /*维修保养进度*/
    @RequestMapping(value = "schedule",method = RequestMethod.GET)
    public String schedule(){
        return "Frontpage/Personalcenter/maintain/schedule";
    }
    /*维修保养明细*/
    @RequestMapping(value ="details",method = RequestMethod.GET)
    public String details(){
        return "Frontpage/Personalcenter/maintain/details";
    }
    /*消费记录*/
    @RequestMapping(value = "conrecord",method = RequestMethod.GET)
    public String conrecord(){
        return "Frontpage/Personalcenter/Consumptionstatistics/Consumptionrecord";
    }

    /*收费单据*/
    @RequestMapping(value = "cdocument",method = RequestMethod.GET)
    public String cdocument(){
        return "Frontpage/Personalcenter/Consumptionstatistics/Chargedocuments";
    }

    /*我的评价*/
    @RequestMapping(value="mycomment",method = RequestMethod.GET)
    public String myComment(){
        return "Frontpage/Personalcenter/Consumptionstatistics/mycomment";
    }

    /*修改账号信息*/
    @RequestMapping(value ="editinfomation",method=RequestMethod.GET)
    public String editinfo(){
        return "Frontpage/Personalcenter/AccountSettings/EditInfomation";
    }

    @ResponseBody
    @RequestMapping(value = "userlogin", method = RequestMethod.POST)
    public ControllerResult userLogin(User user1, HttpSession session, HttpServletRequest req, @Param("checkCode") String checkCode) {
        String codeSession = (String) session.getAttribute("checkCode");
        if (checkCode != null && checkCode.equals(codeSession)) {
            subject = SecurityUtils.getSubject();
            try {
                subject.login(new UsernamePasswordToken(user1.getUserEmail(), EncryptUtil.md5Encrypt(user1.getUserPwd())));
                if (subject.hasRole(Constants.role_owner)) {
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
