package com.gs.controller;

import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 系统管理, 张文星
 */
@Controller
@RequestMapping("/systemManage")
public class SystemManageController {

    private Logger logger = (Logger) LoggerFactory.getLogger(SystemManageController.class);

    /**
     * 人员角色管理
     */
    @RequestMapping(value = "userRoleManageIndex", method = RequestMethod.GET)
    public String userRoleManage() {
        logger.info("跳转到人员角色管理页面");
        return "systemManage/userRoleManage";
    }

    /**
     * 模块管理
     */
    @RequestMapping(value = "moduleManageIndex", method = RequestMethod.GET)
    public String moduleManage() {
        logger.info("跳转到模块管理页面");
        return "systemManage/flowManage";
    }

    /**
     * 权限管理
     */
    @RequestMapping(value = "perManageIndex", method = RequestMethod.GET)
    public String perManage() {
        logger.info("跳转到权限管理页面");
        return "systemManage/permissionsManage";
    }

    /**
     * 权限分配
     */
    @RequestMapping(value = "perDistributionIndex", method = RequestMethod.GET)
    public String perDistribution() {
        logger.info("跳转到权限分配页面");
        return "systemManage/permissionsDistribution";
    }

    /**
     * 流程管理
     */
    @RequestMapping(value = "flowIndex", method = RequestMethod.GET)
    public String flow() {
        logger.info("跳转到流程管理页面");
        return "systemManage/flowManage";
    }

}
