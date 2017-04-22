package com.gs.controller;

/**
 * @author Administrator
 * @create 2017-04-22 10:06
 */

import ch.qos.logback.classic.Logger;
import com.gs.bean.Permission;
import com.gs.bean.Role;
import com.gs.controller.RoleController;
import com.gs.service.PermissionService;
import com.gs.service.RolePermissionService;
import com.gs.service.RoleService;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 *  角色controller
 */
@Controller
@RequestMapping("/permission")
public class PermissionController {
    private Logger logger = (Logger) LoggerFactory.getLogger(RoleController.class);
    @Resource
    private RoleService roleService;
    @Resource
    private PermissionService permissionService;
    @Resource
    private RolePermissionService rolePermissionService;

    @ResponseBody
    @RequestMapping(value = "queryAll")
    public List<Permission> queryAll(){
        return permissionService.queryAll();
    }

    @ResponseBody
    @RequestMapping(value = "canUse")
    public List<Permission> canUse(){
        return permissionService.queryAll("Y");
    }

    @ResponseBody
    @RequestMapping(value = "recycle")
    public List<Permission> recycle(){
        return permissionService.queryAll("N");
    }
}
