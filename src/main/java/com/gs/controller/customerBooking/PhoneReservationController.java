package com.gs.controller.customerBooking;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Appointment;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
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
import javax.servlet.http.HttpServletRequest;
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
    private Logger logger = (Logger) LoggerFactory.getLogger(PhoneReservationController.class);

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
    @RequestMapping(value = "add",method = RequestMethod.POST)
    public ControllerResult add(Appointment appointment){
        System.out.println("前台数据为："+appointment.toString());
        logger.info("添加电话预约");
        appointment.setCompanyId("c515f5d623e011e7a97af832e40312b3");
        appointmentService.insert(appointment);
        return ControllerResult.getSuccessResult("添加成功");
    }

    /**
     *
     * 修改电话预约
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public ControllerResult update(Appointment appointment){
        logger.info("修改电话预约");
        appointment.setCompanyId("c515f5d623e011e7a97af832e40312b3");
        appointmentService.update(appointment);
        return ControllerResult.getSuccessResult("修改成功");
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
    @RequestMapping(value="blurredQuery", method = RequestMethod.GET)
    public Pager4EasyUI<Appointment> blurredQuery(HttpServletRequest request, @Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("登记记录模糊查询");
        String column = request.getParameter("column");
        String value = request.getParameter("value");
        if(column != null && value != null) {
            Pager pager = new Pager();
            pager.setPageNo(Integer.valueOf(pageNumber));
            pager.setPageSize(Integer.valueOf(pageSize));
            pager.setTotalRecords(appointmentService.countByBlurred());
            List<Appointment> appointments;
            if(column.equals("all")){
                String column1 = "userName";
                String column2 = "companyId";
                String column3 = "plateId";
                appointments = appointmentService.blurredQuery(pager, column, value);
            }else{
                appointments = appointmentService.blurredQuery(pager, column, value);
            }
            return new Pager4EasyUI<Appointment>(pager.getTotalPages(), appointments);
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
