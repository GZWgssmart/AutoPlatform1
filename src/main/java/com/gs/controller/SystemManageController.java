package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Role;
import com.gs.service.RoleService;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

/**
 * 系统管理, 张文星
 */
@Controller
@RequestMapping("/systemManage")
public class SystemManageController {

    private Logger logger = (Logger) LoggerFactory.getLogger(SystemManageController.class);

    @Resource
    private RoleService roleService;
    /**
     * 人员角色管理
     */
    @RequestMapping(value = "roleManageIndex", method = RequestMethod.GET)
    public String userRoleManage() {
        logger.info("跳转到人员角色管理页面");
        return "systemManage/roleManage";
    }

    /**
     * 模块管理
     */
    @RequestMapping(value = "moduleManageIndex", method = RequestMethod.GET)
    public ModelAndView moduleManage() {
        logger.info("跳转到模块管理页面");
        List<Role> rs = roleService.queryAll();
        ModelAndView mav = new ModelAndView("systemManage/moduleManage");
        mav.addObject("roles", rs);
        return mav;
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
    public ModelAndView perDistribution() {
        logger.info("跳转到权限分配页面");
        List<Role> rs = roleService.queryAll();
        ModelAndView mav = new ModelAndView("systemManage/permissionsDistribution");
        mav.addObject("roles", rs);
        return mav;
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
