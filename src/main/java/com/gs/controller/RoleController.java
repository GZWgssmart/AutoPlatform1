package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Permission;
import com.gs.common.bean.ControllerResult;
import com.gs.service.PermissionService;
import com.gs.service.RoleService;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

/**
 *  角色controller
 */
@Controller
@RequestMapping("/role")
public class RoleController {
    private Logger logger = (Logger) LoggerFactory.getLogger(RoleController.class);
    @Resource
    private RoleService roleService;
    @Resource
    private PermissionService permissionService;

    @RequestMapping(value = "roleIndex" ,method = RequestMethod.GET)
    public ModelAndView tableIndex(){
       ModelAndView mav = new ModelAndView("role/role");
       return mav;
    }

    @ResponseBody
    @RequestMapping(value = "/permission/{id}" ,method = RequestMethod.POST)
    public List<Permission> insert(@PathVariable("id") int id){
        logger.info("展示角色权限");
        List<Permission> ps = permissionService.queryAll();
        System.out.print(ps+"__________");
        List<Permission> ps1 = permissionService.queryPermissionById(id);
        System.out.print(ps1+"__________");
        for(Permission p : ps){
            for (Permission p1 : ps1){
                if(p.getPermissionId() == p1.getPermissionId()){
                    p.setStatus("true");
                }
            }
        }
        System.out.print(ps+"__________");
        return ps;
    }

    @ResponseBody
    @RequestMapping(value = "/addPermission/{roleId}/{permissionId}" ,method = RequestMethod.GET)
    public ControllerResult addPermission(@PathVariable("roleId") int roleId, @PathVariable("permissionId") int permissionId){
        logger.info("添加角色权限");
        permissionService.addPermission(roleId, permissionId);
        return ControllerResult.getSuccessResult("添加权限成功");
    }

    @ResponseBody
    @RequestMapping(value = "/removePermission/{roleId}/{permissionId}" ,method = RequestMethod.GET)
    public ControllerResult removePermission(@PathVariable("roleId") int roleId, @PathVariable("permissionId") int permissionId){
        logger.info("删除角色权限");
        permissionService.removePermission(roleId, permissionId);
        return ControllerResult.getSuccessResult("删除权限成功");
    }

}
