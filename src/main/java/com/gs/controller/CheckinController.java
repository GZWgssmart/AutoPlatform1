package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Checkin;
import com.gs.bean.MaintainRecord;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.UUIDUtil;
import com.gs.service.CheckinService;
import com.gs.service.MaintainRecordService;
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
import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 接待登记管理controller， 张文星
 */
@Controller
@RequestMapping("/checkin")
public class CheckinController {

    private Logger logger = (Logger) LoggerFactory.getLogger(CheckinController.class);

    // 登记service
    @Resource
    private CheckinService checkinService;
    // 维修保养记录service
    @Resource
    private MaintainRecordService maintainRecordService;

    /**
     * 查询所有登记记录
     * @return
     */
    @ResponseBody
    @RequestMapping(value="queryByPager", method = RequestMethod.GET)
    public Pager4EasyUI<Checkin> queryByPager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("分页查询所有登记记录");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(checkinService.count());
        List<Checkin> checkins = checkinService.queryByPager(pager);
        return new Pager4EasyUI<Checkin>(pager.getTotalRecords(), checkins);
    }

    /**
     * 查询所有被禁用的登记记录
     * @return
     */
    @ResponseBody
    @RequestMapping(value="queryByPagerDisable", method = RequestMethod.GET)
    public Pager4EasyUI<Checkin> queryByPagerDisable(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("分页查询所有被禁用登记记录");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(checkinService.countByDisable());
        List<Checkin> checkins = checkinService.queryByPagerDisable(pager);
        return new Pager4EasyUI<Checkin>(pager.getTotalRecords(), checkins);
    }

    @ResponseBody
    @RequestMapping(value = "add", method = RequestMethod.POST)
    public ControllerResult addCheckin(Checkin checkin) {
        logger.info("添加登记记录");
        checkin.setCheckinId(UUIDUtil.uuid());
        checkin.setCompanyId("c515f5d623e011e7a97af832e40312b3");
        checkinService.insert(checkin);
        MaintainRecord maintainRecode = new MaintainRecord();
        maintainRecode.setCheckinId(checkin.getCheckinId());

        maintainRecordService.insert(maintainRecode);
        return ControllerResult.getSuccessResult("添加成功");
    }

    @ResponseBody
    @RequestMapping(value = "edit", method = RequestMethod.POST)
    public ControllerResult editCheckin(Checkin checkin) {
        logger.info("修改登记记录");
        checkin.setCompanyId("c515f5d623e011e7a97af832e40312b3");
        checkinService.update(checkin);
        return ControllerResult.getSuccessResult("修改成功");
    }

    /**
     * 对状态的激活和启用，只使用一个方法进行切换。
     */
    @ResponseBody
    @RequestMapping(value = "statusOperate", method = RequestMethod.POST)
    public ControllerResult inactive(String id, String status) {
        if (id != null && !id.equals("") && status != null && !status.equals("")) {
            if (status.equals("N")) {
                checkinService.active(id);
                logger.info("激活成功");
                return ControllerResult.getSuccessResult("激活成功");
            } else {
                checkinService.inactive(id);
                logger.info("禁用成功");
                return ControllerResult.getSuccessResult("禁用成功");
            }
        } else {
            return ControllerResult.getFailResult("操作失败");
        }
    }

    /**
     * 登记记录模糊查询
     * @return
     */
    @ResponseBody
    @RequestMapping(value="blurredQuery", method = RequestMethod.GET)
    public Pager4EasyUI<Checkin> blurredQuery(HttpServletRequest request, @Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("登记记录模糊查询");
        String text = request.getParameter("text");
        String value = request.getParameter("value");
        System.out.print(text+value+"-------------------");
        if(text != null && text!="") {
            Pager pager = new Pager();
            pager.setPageNo(Integer.valueOf(pageNumber));
            pager.setPageSize(Integer.valueOf(pageSize));
            List<Checkin> checkins = null;
            Checkin checkin = new Checkin();
            if(text.equals("车主/电话/汽车公司/车牌号")){ // 当多种模糊搜索条件时
                checkin.setUserName(value);
                checkin.setCompanyId(value);
                checkin.setCarPlate(value);
                checkin.setUserPhone(value);
            }else if(text.equals("车主")){
                checkin.setUserName(value);
            }else if(text.equals("汽车公司")){
                checkin.setCompanyId(value);
            }else if(text.equals("车牌号")){
                checkin.setCarPlate(value);
            }else if(text.equals("电话")){
                checkin.setUserPhone(value);
            }
            checkins = checkinService.blurredQuery(pager, checkin);
            pager.setTotalRecords(checkinService.countByBlurred(checkin));
            System.out.print(checkins);
            return new Pager4EasyUI<Checkin>(pager.getTotalRecords(), checkins);
        }else{
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
