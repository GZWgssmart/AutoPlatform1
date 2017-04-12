package com.gs.controller;

import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 系统管理
 */
@Controller
@RequestMapping("/custManage")
public class CustomerManageController {

    private Logger logger = (Logger) LoggerFactory.getLogger(CustomerManageController.class);

    /**
     * 维修保养记录管理
     */
    @RequestMapping(value = "maintenanceIndex", method = RequestMethod.GET)
    public String maintenanceIndex() {
        logger.info("跳转到维修保养记录管理");
        return "custManage/maintenance";
    }

    /**
     * 维修保养提醒
     */
    @RequestMapping(value = "mainreminderIndex", method = RequestMethod.GET)
    public String mainreminderIndex() {
        logger.info("跳转到维修保养提醒");
        return "custManage/mainreminder";
    }

    /**
     * 短信群发提醒
     */
    @RequestMapping(value = "smsalertsIndex", method = RequestMethod.GET)
    public String smsalertsIndex() {
        logger.info("跳转到短信群发提醒");
        return "custManage/smsalerts";
    }


    /**
     * 投诉管理
     */
    @RequestMapping(value = "complaintIndex", method = RequestMethod.GET)
    public String complaintIndex() {
        logger.info("跳转到投诉管理");
        return "custManage/complaint";
    }

    /**
     * 跟踪回访管理
     */
    @RequestMapping(value = "fllowUpIndex", method = RequestMethod.GET)
    public String fllowUpIndex() {
        logger.info("跳转到跟踪回访管理");
        return "custManage/fllowUp";
    }

}
