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
@RequestMapping("/systemManage")
public class SystemManageController {

    private Logger logger = (Logger) LoggerFactory.getLogger(SystemManageController.class);

    /**
     * 模块管理
     */
    @RequestMapping(value = "moduleIndex", method = RequestMethod.GET)
    public String moduleIndex() {
        logger.info("跳转到模块管理页面");
        return "systemManage/flowManage";
    }

    /**
     * 权限管理
     */
    @RequestMapping(value = "perManageIndex", method = RequestMethod.GET)
    public String perManageIndex() {
        logger.info("跳转到权限管理页面");
        return "systemManage/permissionsManage";
    }

    /**
     * 权限分配
     */
    @RequestMapping(value = "perDistributionIndex", method = RequestMethod.GET)
    public String backstageHome() {
        logger.info("跳转到权限分配页面");
        return "systemManage/permissionsDistribution";
    }

    /**
     * 流程管理
     */
    @RequestMapping(value = "flowIndex", method = RequestMethod.GET)
    public String flowIndex() {
        logger.info("跳转到流程管理页面");
        return "systemManage/flowManage";
    }

}
