package com.gs.controller.custManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Mail;
import com.gs.bean.MessageSend;
import com.gs.bean.User;
import com.gs.common.Methods;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.mail.MailConfig;
import com.gs.common.util.RoleUtil;
import com.gs.common.util.SessionUtil;
import com.gs.service.MessageSendService;
import com.gs.service.UserService;
import org.apache.ibatis.annotations.Param;
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
import javax.mail.BodyPart;
import javax.mail.Multipart;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by XiaoQiao on 2017/5/6.
 */

@Controller
@RequestMapping("/messageSend")
public class MessageSendController {

    private Logger logger = (Logger) LoggerFactory.getLogger(MessageSendController.class);

    @Autowired
    private HttpServletRequest req;

    @Resource
    private MessageSendService messageSendService;

    @Resource
    private UserService userService;

    @ResponseBody
    @RequestMapping(value = "queryByPager", method = RequestMethod.GET)
    public Pager4EasyUI<MessageSend> queryByPager(HttpSession session, @Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        if (SessionUtil.isLogin(session)) {
            String roles = "公司超级管理员,公司普通管理员,汽车公司接待员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("分页查看短信提醒记录");
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setPageSize(Integer.valueOf(pageSize));
                int count = messageSendService.count((User) session.getAttribute("user"));
                pager.setTotalRecords(count);
                pager.setUser((User) session.getAttribute("user"));
                List<MessageSend> queryList = messageSendService.queryByPager(pager);
                return new Pager4EasyUI<MessageSend>(pager.getTotalRecords(), queryList);
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
    public ControllerResult batchInsert(HttpSession session) {
        if (SessionUtil.isLogin(session)) {
            String roles = "公司超级管理员,公司普通管理员,汽车公司接待员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("短信提醒记录添加操作");
                List<MessageSend> list = new ArrayList<MessageSend>();
                for (MessageSend ms : list) {
                    MessageSend m = new MessageSend();
                    m.setUserId(ms.getUserId());
                    m.setSendMsg(ms.getSendMsg());
                    m.setSendTime(ms.getSendTime());
                    m.setSendCreatedTime(ms.getSendCreatedTime());
                    list.add(m);
                }
                messageSendService.batchInsert(list);
                return ControllerResult.getSuccessResult("添加短信提醒成功");
            } else {
                logger.info("此用户无拥有此方法");
                return null;
            }
        } else {
            logger.info("请先登录");
            return null;
        }

    }

//    Mail mail = new Mail();
//                        mail.setSubject("维修保养记录完工提醒"); // 设置标题
//    // 设置接收者
//    // mail.setRecipients(u.getUserEmail()); 收件人
//    // mail.setCcRecipients(); // 抄送
//                        mail.setBccRecipients(emails); // 密送
//                        logger.info(emails);
//    Multipart multipart = new MimeMultipart();
//    BodyPart part1 = new MimeBodyPart(); // 邮件内容
//    // 设置邮件内容
//                        part1.setContent("尊敬的车主你好, 你的车辆在本店进行的维修保养现已完工好了, 请前来开走车辆","text/html;charset=utf-8");
//                        multipart.addBodyPart(part1); // 把此邮件内容添加到实例化好的邮件中
//                        mail.setMultinart(multipart); // 把此邮件对象添加进邮箱
//    File file = new File(Methods.getRootPath(req) + "WEB-INF/config/mail.properties");
//                        MailConfig.sendMail(file,mail);


    @ResponseBody
    @RequestMapping(value = "queryCombox", method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryCombox(HttpSession session) {
        if (SessionUtil.isLogin(session)) {
            String roles = "公司超级管理员,公司普通管理员,汽车公司接待员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("查看用户");
                List<User> users = userService.queryByRoleName("车主");
                List<ComboBox4EasyUI> combo = new ArrayList<ComboBox4EasyUI>();
                for (User user : users) {
                    ComboBox4EasyUI co = new ComboBox4EasyUI();
                    co.setId(user.getUserId());
                    co.setText(user.getUserName());
                    String userId = req.getParameter("userId");
                    if (user.getUserId().equals(userId)) {
                        co.setSelected(true);
                    }
                    combo.add(co);
                }
                return combo;
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
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
}
