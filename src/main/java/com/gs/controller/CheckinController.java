package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Checkin;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.CheckinService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

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

    @Resource
    private CheckinService checkinService;

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
        checkin.setCompanyId("c515f5d623e011e7a97af832e40312b3");
        checkinService.insert(checkin);
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
     * 禁用
     */
    @ResponseBody
    @RequestMapping(value = "inactive",method = RequestMethod.POST)
    public ControllerResult inactive(String id) {
        logger.info("禁用");
        if(id !=null) {
            checkinService.inactive(id);
            return ControllerResult.getSuccessResult("禁用成功");
        }else{
            return ControllerResult.getFailResult("禁用失败");
        }
    }

    /**
     * 激活
     */
    @ResponseBody
    @RequestMapping(value = "active",method = RequestMethod.POST)
    public ControllerResult active(String id) {
        logger.info("激活");
        if(id !=null) {
            checkinService.active(id);
            return ControllerResult.getSuccessResult("激活成功");
        }else{
            return ControllerResult.getFailResult("激活失败");
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
        String column = request.getParameter("column");
        String value = request.getParameter("value");
        if(column != null && value != null) {
            Pager pager = new Pager();
            pager.setPageNo(Integer.valueOf(pageNumber));
            pager.setPageSize(Integer.valueOf(pageSize));
            pager.setTotalRecords(checkinService.countByBlurred());
            List<Checkin> checkins;
            if(column.equals("all")){
                String column1 = "userName";
                String column2 = "companyId";
                String column3 = "plateId";
                checkins = checkinService.blurredQuery(pager, column, value);
            }else{
                checkins = checkinService.blurredQuery(pager, column, value);
            }
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
