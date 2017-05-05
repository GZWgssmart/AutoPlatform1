package com.gs.controller.custManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Complaint;
import com.gs.bean.MaintainRecord;
import com.gs.bean.User;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.ComplaintService;
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
import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by XiaoQiao on 2017/4/25.
 */

/**
 * 投诉管理
 */
@Controller
@RequestMapping("/complaint")
public class ComplaintController {

    private Logger logger = (Logger) LoggerFactory.getLogger(ComplaintController.class);

    @Autowired
    private HttpServletRequest req;

    @Resource
    private ComplaintService complaintService;

    @Resource
    private UserService userService;

    @ResponseBody
    @RequestMapping("queryByPager")
    public Pager4EasyUI<Complaint> queryByPager(@Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        logger.info("分页查看投诉记录");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        int count = complaintService.count();
        pager.setTotalRecords(count);
        List<Complaint> queryList = complaintService.queryByPager(pager);
        return new Pager4EasyUI<Complaint>(pager.getTotalRecords(), queryList);
    }

    @ResponseBody
    @RequestMapping("queryName")
    public Pager4EasyUI<Complaint> queryName(@Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize, Complaint complaint) {
        logger.info("模糊查询投诉记录");
        String text = req.getParameter("text");
        String value = req.getParameter("value");
        if(text != null && text != "") {
            Pager pager = new Pager();
            pager.setPageNo(Integer.valueOf(pageNumber));
            pager.setPageSize(Integer.valueOf(pageSize));
            if(text.equals("投诉人")) {
                complaint.setUserId(value);
            } else if (text.equals("投诉内容")) {
                complaint.setComplaintContent(value);
            } else if (text.equals("投诉回复人")) {
                complaint.setComplaintReplyUser(value);
            } else if (text.equals("投诉回复内容")) {
                complaint.setComplaintReply(value);
            }
            int count = complaintService.countName(complaint);
            pager.setTotalRecords(count);
            List<Complaint> queryList = complaintService.queryByPagerName(pager,complaint);
            return new Pager4EasyUI<Complaint>(pager.getTotalRecords(), queryList);
        }
        return null;
    }

    @ResponseBody
    @RequestMapping("queryCombox")
    public List<ComboBox4EasyUI> queryCombox() {
        logger.info("查看用户");
        List<User> users = userService.queryAll();
        List<ComboBox4EasyUI> combo = new ArrayList<ComboBox4EasyUI>();
        for(User user : users) {
            ComboBox4EasyUI co = new ComboBox4EasyUI();
            co.setId(user.getUserId());
            co.setText(user.getUserName());
            String userId = req.getParameter("userId");
            if(user.getUserId().equals(userId)) {
                co.setSelected(true);
            }
            combo.add(co);
        }
        return combo;
    }

    @ResponseBody
    @RequestMapping(value = "insert", method = RequestMethod.POST)
    public ControllerResult insert(Complaint complaint) {
        logger.info("投诉记录添加操作");
        complaintService.insert(complaint);
        return ControllerResult.getSuccessResult("添加成功");
    }

    @ResponseBody
    @RequestMapping(value = "updateReply", method = RequestMethod.POST)
    public ControllerResult updateReply(Complaint complaint) {
        logger.info("投诉记录回复操作");
        complaintService.update(complaint);
        return ControllerResult.getSuccessResult("回复成功");
    }

    @ResponseBody
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public ControllerResult update(Complaint complaint) {
        logger.info("投诉记录修改操作");
        complaintService.update(complaint);
        return ControllerResult.getSuccessResult("修改成功");
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
