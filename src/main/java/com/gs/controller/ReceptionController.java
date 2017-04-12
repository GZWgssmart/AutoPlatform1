package com.gs.controller;

import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by 小蜜蜂 on 2017-04-11.
 * 维修保养接待管理页面跳转
 */
@Controller
@RequestMapping("/maintenanceJieDaiGuanLi")
public class ReceptionController {

    private Logger logger = (Logger) LoggerFactory.getLogger(ReceptionController.class);

    /**
     * 接待登记管理
     * @return
     */
    @RequestMapping(value="reception",method= RequestMethod.GET)
    public String reception() {
        logger.info("跳转到接待登记管理页面");
        return "maintenanceJieDaiGuanLi/reception";
    }

    /**
     * 维修保养明细管理
     * @return
     */
    @RequestMapping("subsidiary")
    public String subsidiary() {
        logger.info("跳转到维修保养明细管理");
        return "maintenanceJieDaiGuanLi/subsidiary";
    }

}
