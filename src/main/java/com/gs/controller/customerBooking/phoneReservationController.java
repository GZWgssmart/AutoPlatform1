package com.gs.controller.customerBooking;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Appointment;
import com.gs.common.bean.ControllerResult;
import com.gs.service.AppointmentService;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017/4/18.
 */
@Controller
@RequestMapping("/app")
public class phoneReservationController {

    @Resource
    private AppointmentService appointmentService;

    private Logger logger = (Logger) LoggerFactory.getLogger(phoneReservationController.class);


    /**
     * 查询所有的预约
     * @return
     */
   @ResponseBody
   @RequestMapping(value = "queryAppointment", method = RequestMethod.POST)
   public List<Appointment> queryAppointment(){
       List<Appointment> appointmentList = appointmentService.queryAll();
        if(appointmentList != null && !appointmentList.equals("")){
            return appointmentList;
        }
        return null;
   }


    /**
     *
     * 添加预约
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "addAccBuy", method = RequestMethod.POST)
    public ControllerResult addAccBuy(Appointment appointment) {
        if (appointment != null && !appointment.equals("")) {
            System.out.println(appointment.toString());
            appointmentService.insert(appointment);
            logger.info("添加成功");
            return ControllerResult.getSuccessResult("添加成功");
        } else {
            return ControllerResult.getFailResult("添加失败，请输入必要的信息");
        }
    }


    /**
     *
     * 删除预约
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "removeAppointment", method = RequestMethod.POST)
    public ControllerResult removeAppointment(String id) {
        if (id != null && !id.equals("")) {
            appointmentService.deleteById(id);
            logger.info("删除成功");
            return ControllerResult.getSuccessResult("删除成功");
        } else {
            return ControllerResult.getFailResult("删除失败");
        }
    }

    /**
     *
     * 修改预约
     * @return
     */
   @ResponseBody
   @RequestMapping(value = "updateAppointment", method = RequestMethod.POST)
   public ControllerResult updateAppointment(Appointment appointment){
       if(appointment != null && !appointment.equals("")){
           appointmentService.update(appointment);
           logger.info("修改成功");
           return ControllerResult.getSuccessResult("修改成功");
       }else {
           return ControllerResult.getFailResult("修改失败");
       }
   }

}
