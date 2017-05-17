package com.gs.controller.custManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.*;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.RoleUtil;
import com.gs.common.util.SessionUtil;
import com.gs.service.*;
import org.apache.ibatis.annotations.Param;
import org.joda.time.DateTime;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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

    @Resource
    private MaintainRecordService maintainRecordService;

    @ResponseBody
    @RequestMapping(value = "queryByPager", method = RequestMethod.GET)
    public Pager4EasyUI<MaintainRemind> queryByPager(HttpSession session, @Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
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
    @RequestMapping(value = "queryByPagerUser", method = RequestMethod.GET)
    public Pager4EasyUI<MaintainRemind> queryByPagerUser(HttpSession session, @Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        logger.info("分页查看维修保养提醒记录");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        User user = (User) session.getAttribute("user");
        int count = maintainRemindService.countUser(user.getUserId());
        pager.setTotalRecords(count);
        pager.setUser((User) session.getAttribute("user"));
        List<MaintainRemind> queryList = maintainRemindService.queryByPagerUser(pager,user.getUserId());
        return new Pager4EasyUI<MaintainRemind>(pager.getTotalRecords(), queryList);
    }

    @ResponseBody
    @RequestMapping(value = "queryByPagerNull", method = RequestMethod.GET)
    public Pager4EasyUI<MaintainRecord> queryByPagerNull(HttpSession session, @Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        if (SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司接待员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("分页查看维修保养提醒记录");
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setPageSize(Integer.valueOf(pageSize));
                int count = maintainRecordService.countSix(getInsertDateTime());
                pager.setTotalRecords(count);
                pager.setUser((User) session.getAttribute("user"));
                List<MaintainRecord> queryList = maintainRecordService.queryByPagerSix(pager,getInsertDateTime());
//                if(queryList != null) {
//                    List<MaintainRemind> maintainReminds = new ArrayList<MaintainRemind>();
//                    for(MaintainRecord mrs : queryList) {
//                        MaintainRemind mrs1 = new MaintainRemind();
//                        mrs1.setUserId(mrs.getCheckin().getUserId());
//                        mrs1.setLastMaintainTime(mrs.getActualEndTime());
//                        mrs1.setLastMaintainMileage(mrs.getCheckin().getCarMileage());
//                        maintainReminds.add(mrs1);
//                    }
//                    maintainRemindService.insertBatch(maintainReminds);
//                }
                return new Pager4EasyUI<MaintainRecord>(pager.getTotalRecords(), queryList);
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
                maintainRemindService.insert(maintainRemind);
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

//    @ResponseBody
//    @RequestMapping(value = "insertRemind", method = RequestMethod.POST)
//    public ControllerResult insertDate(HttpSession session, MaintainRemind maintainRemind, MessageSend messageSend) {
//        logger.info("维修保养提醒记录添加操作");
//        List<MaintainRecord> maintainRecords = maintainRecordService.queryByPagerSix(pager, getInsertDateTime());
//        if(maintainRecords != null) {
//            List<MaintainRemind> maintainReminds = new ArrayList<MaintainRemind>();
//            for(MaintainRecord mrs : maintainRecords) {
//                MaintainRemind mrs1 = new MaintainRemind();
//                mrs1.setUserId(mrs.getCheckin().getUserId());
//                mrs1.setLastMaintainTime(mrs.getActualEndTime());
//                mrs1.setLastMaintainMileage(mrs.getCheckin().getCarMileage());
//                maintainReminds.add(mrs1);
//            }
//            maintainRemindService.insertBatch(maintainReminds);
//            return ControllerResult.getSuccessResult("添加成功");
//        }
//        return null;
//    }

    public String getInsertDateTime() {
        Calendar c = Calendar.getInstance();//获得一个日历的实例
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String actualEndTime = sdf.format(new Date());
        Date date = null;
        try{
            date = sdf.parse(actualEndTime);//初始日期
        }catch(Exception e){

        }
        c.setTime(date);//设置日历时间
        c.add(Calendar.MONTH,-6);//在日历的月份上增加6个月
        System.out.println(sdf.format(c.getTime()));//的到你想要得6个月后的日期
        return sdf.format(c.getTime());
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
