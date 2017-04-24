package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Permission;
import com.gs.bean.Role;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.service.PermissionService;
import com.gs.service.RolePermissionService;
import com.gs.service.RoleService;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 *
 *
 * @author 程燕
 * @create 2017-04-23 18:57
 * @des 角色Controller
 */
@Controller
@RequestMapping("/role")
public class RoleController {
    private Logger logger = (Logger) LoggerFactory.getLogger(RoleController.class);
    @Resource
    private RoleService roleService;
    @Resource
    private PermissionService permissionService;
    @Resource
    private RolePermissionService rolePermissionService;

    @RequestMapping(value = "roleIndex" ,method = RequestMethod.GET)
    public ModelAndView tableIndex(){
       ModelAndView mav = new ModelAndView("role/role");
       return mav;
    }

    @ResponseBody
    @RequestMapping(value = "queryAll")
    public List<Role> queryAll(){
        return roleService.queryAll("Y");
    }

    @ResponseBody
    @RequestMapping(value = "recycle")
    public List<Role> queryRecycle(){
        return roleService.queryAll("N");
    }

    @ResponseBody
    @RequestMapping(value = "role2CheckBox")
    public  List<ComboBox4EasyUI> queryAll2CheckBox(){
        List<Role> roles= roleService.queryAll("Y");
        List<ComboBox4EasyUI> comboBoxes = new ArrayList<ComboBox4EasyUI>();
        for(Role role: roles) {
            ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
            comboBox4EasyUI.setId(role.getRoleId());
            comboBox4EasyUI.setText(role.getRoleName());
            comboBoxes.add(comboBox4EasyUI);
        }
        return comboBoxes;
    }


    @ResponseBody
    @RequestMapping(value = "/permissions/{id}")
    public List<Permission> queryPermissions(@PathVariable("id") String id){
        return rolePermissionService.queryPermissions(id, "Y");
    }




//    @ResponseBody
//    @RequestMapping(value = "/permission/{id}" ,method = RequestMethod.GET)
//    public List<Permission> insert(@PathVariable("id") int id){
//        logger.info("展示角色权限");
//        List<Permission> ps = permissionService.queryAll();
//        System.out.print(ps+"__________");
//        List<Permission> ps1 = permissionService.queryPermissionById(id);
//        System.out.print(ps1+"__________");
//        for(Permission p : ps){
//            for (Permission p1 : ps1){
//                if(p.getPermissionId() == p1.getPermissionId()){
//                    p.setStatus("true");
//                }
//            }
//        }
//        System.out.print(ps+"__________");
//        return ps;
//    }

    @ResponseBody
    @RequestMapping(value = "/addPermission/{roleId}/{permissionId}" ,method = RequestMethod.GET)
    public ControllerResult addPermission(@PathVariable("roleId") int roleId, @PathVariable("permissionId") int permissionId){
        logger.info("添加角色权限");
        rolePermissionService.addPermission(roleId, permissionId);
        return ControllerResult.getSuccessResult("添加权限成功");
    }

    @ResponseBody
    @RequestMapping(value = "/removePermission/{roleId}/{permissionId}" ,method = RequestMethod.GET)
    public ControllerResult removePermission(@PathVariable("roleId") int roleId, @PathVariable("permissionId") int permissionId){
        logger.info("删除角色权限");
        rolePermissionService.removePermission(roleId, permissionId);
        return ControllerResult.getSuccessResult("删除权限成功");
    }

}
