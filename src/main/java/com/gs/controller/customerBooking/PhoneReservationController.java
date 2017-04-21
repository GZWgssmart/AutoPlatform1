package com.gs.controller.customerBooking;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Appointment;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.controller.CheckinController;
import com.gs.service.AppointmentService;
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
 * 电话预约controller，杨健勇
 */
@Controller
@RequestMapping("/appointment")
public class PhoneReservationController {
    private Logger logger = (Logger) LoggerFactory.getLogger(CheckinController.class);

    @Resource
    private AppointmentService appointmentService;

    /**
     * 查询所有登记记录
     * @return
     */
    @ResponseBody
    @RequestMapping(value="queryByPager", method = RequestMethod.GET)
    public Pager4EasyUI<Appointment> queryByPager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("分页查询所有登记记录");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(appointmentService.count());
        List<Appointment> appointments = appointmentService.queryByPager(pager);
        return new Pager4EasyUI<Appointment>(pager.getTotalRecords(), appointments);
    }

    /**
     * 查询所有被禁用的登记记录
     * @return
     */
    @ResponseBody
    @RequestMapping(value="queryByPagerDisable", method = RequestMethod.GET)
    public Pager4EasyUI<Appointment> queryByPagerDisable(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("分页查询所有被禁用登记记录");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(appointmentService.countByDisable());
        List<Appointment> appointments = appointmentService.queryByPagerDisable(pager);
        return new Pager4EasyUI<Appointment>(pager.getTotalRecords(), appointments);
    }

    /**
     *
     * 添加电话预约
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "addApp",method = RequestMethod.POST)
    public ControllerResult add(Appointment appointment){
        if (appointment != null && !appointment.equals("")) {
            logger.info("添加电话预约");
            appointmentService.insert(appointment);
            return ControllerResult.getSuccessResult("添加成功");
        }else {
            return ControllerResult.getFailResult("添加失败，请输入必要的信息");
        }
    }

    /**
     *
     * 修改电话预约
     * @return
     */
     @ResponseBody
     @RequestMapping(value = "update", method = RequestMethod.POST)
     public ControllerResult update(Appointment appointment){
         if(appointment != null && !appointment.equals("")){
             logger.info("修改电话预约");
             appointmentService.insert(appointment);
             return ControllerResult.getSuccessResult("添加成功");
         }else {
             return ControllerResult.getFailResult("添加失败，请输入必要信息");
         }
     }

    @ResponseBody
    @RequestMapping(value = "inactive",method = RequestMethod.POST)
    public ControllerResult inactive(String id) {
        logger.info("禁用");
        if(id !=null) {
            appointmentService.inactive(id);
            return ControllerResult.getSuccessResult("禁用成功");
        }else{
            return ControllerResult.getFailResult("禁用失败");
        }
    }

    @ResponseBody
    @RequestMapping(value = "active",method = RequestMethod.POST)
    public ControllerResult active(String id) {
        logger.info("激活");
        if(id !=null) {
            appointmentService.active(id);
            return ControllerResult.getSuccessResult("激活成功");
        }else{
            return ControllerResult.getFailResult("激活失败");
        }
    }
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
}
