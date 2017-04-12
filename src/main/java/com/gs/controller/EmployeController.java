package com.gs.controller;

import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by AngeJob on 2017/4/11.
 */

@Controller
@RequestMapping("/emp")
public class EmployeController {

    private Logger logger = (Logger) LoggerFactory.getLogger(EmployeController.class);

    /**
     * 员工基本信息跳转页面
     */
    @RequestMapping(value = "empInformation", method = RequestMethod.GET)
    public String empInformation() {
        logger.info("员工基本信息跳转页面");
        return "emp/empInformation";
    }

    /**
     * 员工工单跳转页面
     */
    @RequestMapping(value = "workInfo", method = RequestMethod.GET)
    public String workInfo() {
        logger.info("员工工单跳转页面");
        return "emp/workInfo";
    }
}
