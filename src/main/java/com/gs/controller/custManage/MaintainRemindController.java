package com.gs.controller.custManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.MaintainRemind;
import com.gs.bean.MessageSend;
import com.gs.bean.User;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.RoleUtil;
import com.gs.common.util.SessionUtil;
import com.gs.service.MaintainRemindService;
import com.gs.service.MessageSendService;
import com.gs.service.UserService;
import org.apache.ibatis.annotations.Param;
import org.joda.time.DateTime;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by XiaoQiao on 2017/5/4.
 */

/**
 * 维修保养提醒
 */

@Controller
@RequestMapping("/maintainRemind")
public class MaintainRemindController {

    private Logger logger = (Logger) LoggerFactory.getLogger(MaintainRemindController.class);

    @Autowired
    private HttpServletRequest req;

    @Resource
    private MaintainRemindService maintainRemindService;

    @Resource
    private UserService userService;

    @Resource
    private MessageSendService messageSendService;

    @ResponseBody
    @RequestMapping(value = "queryByPager", method = RequestMethod.GET)
    public Pager4EasyUI<MaintainRemind> queryByPager(HttpSession session, @Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize, User user) {
        if (SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司接待员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("分页查看维修保养提醒记录");
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setPageSize(Integer.valueOf(pageSize));
                int count = maintainRemindService.count((User) session.getAttribute("user"));
                pager.setTotalRecords(count);
                pager.setUser((User) session.getAttribute("user"));
                List<MaintainRemind> queryList = maintainRemindService.queryByPager(pager);
                return new Pager4EasyUI<MaintainRemind>(pager.getTotalRecords(), queryList);
            } else {
                logger.info("此用户无拥有此方法");
                return null;
            }
        } else {
            logger.info("请先登录");
            return null;
        }
    }

    @ResponseBody
    @RequestMapping(value = "queryByPagerNull", method = RequestMethod.GET)
    public Pager4EasyUI<MaintainRemind> queryByPagerNull(HttpSession session, @Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        if (SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司接待员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("分页查看维修保养提醒记录");
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setPageSize(Integer.valueOf(pageSize));
                int count = maintainRemindService.countNull((User) session.getAttribute("user"));
                pager.setTotalRecords(count);
                pager.setUser((User) session.getAttribute("user"));
                List<MaintainRemind> queryList = maintainRemindService.queryByPagerNull(pager);
                return new Pager4EasyUI<MaintainRemind>(pager.getTotalRecords(), queryList);
            } else {
                logger.info("此用户无拥有此方法");
                return null;
            }
        } else {
            logger.info("请先登录");
            return null;
        }
    }

    @ResponseBody
    @RequestMapping(value = "insert", method = RequestMethod.POST)
    public ControllerResult insert(HttpSession session, MaintainRemind maintainRemind, MessageSend messageSend) {
        if (SessionUtil.isLogin(session)) {
            String roles = "公司超级管理员,公司普通管理员,汽车公司接待员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("维修保养提醒记录添加操作");
                maintainRemindService.update(maintainRemind);
                messageSend.setMessageId(maintainRemind.getRemindId());
                messageSend.setUserId(maintainRemind.getUserId());
                messageSend.setSendTime(maintainRemind.getRemindTime());
                messageSend.setSendMsg(maintainRemind.getRemindMsg());
                messageSend.setSendCreatedTime(new Date());
                messageSendService.insertRemind(messageSend);
                return ControllerResult.getSuccessResult("添加成功");
            } else {
                logger.info("此用户无拥有此方法");
                return null;
            }
        } else {
            logger.info("请先登录");
            return null;
        }
    }

    @ResponseBody
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public ControllerResult update(HttpSession session, MaintainRemind maintainRemind, MessageSend messageSend) {
        if (SessionUtil.isLogin(session)) {
            String roles = "公司超级管理员,公司普通管理员,汽车公司接待员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("维修保养提醒记录修改操作");
                maintainRemindService.update(maintainRemind);
                messageSend.setSendTime(maintainRemind.getRemindTime());
                messageSend.setSendMsg(maintainRemind.getRemindMsg());
                messageSend.setSendCreatedTime(maintainRemind.getRemindCreatedTime());
                messageSendService.update(messageSend);
                return ControllerResult.getSuccessResult("修改成功");
            } else {
                logger.info("此用户无拥有此方法");
                return null;
            }
        } else {
            logger.info("请先登录");
            return null;
        }
    }


    /**
     * 时间格式化
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
}
