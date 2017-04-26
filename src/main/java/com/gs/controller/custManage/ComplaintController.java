package com.gs.controller.custManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Complaint;
import com.gs.bean.MaintainRecord;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.ComplaintService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
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

    @Resource
    private ComplaintService complaintService;

    @ResponseBody
    @RequestMapping("queryByPager")
    public Pager4EasyUI<Complaint> queryByPager(@Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        logger.info("分布查看投诉记录");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        int count = complaintService.count();
        pager.setTotalRecords(count);
        List<Complaint> queryList = complaintService.queryByPager(pager);
        return new Pager4EasyUI<Complaint>(pager.getTotalRecords(), queryList);
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
