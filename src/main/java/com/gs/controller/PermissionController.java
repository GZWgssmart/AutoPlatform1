package com.gs.controller;

/**
 * @author Administrator
 * @create 2017-04-22 10:06
 */

import ch.qos.logback.classic.Logger;
import com.gs.bean.Permission;
import com.gs.bean.Role;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.controller.RoleController;
import com.gs.service.PermissionService;
import com.gs.service.RolePermissionService;
import com.gs.service.RoleService;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;

/**
 *
 *
 * @author 程燕
 * @create 2017-04-23 18:57
 * @des 权限Controller
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
    public Pager4EasyUI queryByPager(@RequestParam("pageNumber") int pageNumber, @RequestParam("pageSize") int pageSize){
        final String status = "Y";
        Pager pager = new Pager();
        pager.setPageNo(pageNumber);
        pager.setPageSize(pageSize);
        List rows = permissionService.queryByPager(status,pager);
        int total = permissionService.count(status);
        Pager4EasyUI pager4EasyUI = new Pager4EasyUI();
        pager4EasyUI.setRows(rows);
        pager4EasyUI.setTotal(total);
        return pager4EasyUI;
    }


    @ResponseBody
    @RequestMapping(value = "noStatusQueryAll")
    public List noStatusQueryAll(){
        return permissionService.queryAll();
    }

    @ResponseBody
    @RequestMapping(value = "queryRecycle")
    public Pager4EasyUI recycleByPager(@RequestParam("pageNumber") int pageNumber, @RequestParam("pageSize") int pageSize){
        final String status = "N";
        Pager pager = new Pager();
        pager.setPageNo(pageNumber);
        pager.setPageSize(pageSize);
        List rows = permissionService.queryByPager(status,pager);
        int total = permissionService.count(status);
        Pager4EasyUI pager4EasyUI = new Pager4EasyUI();
        pager4EasyUI.setRows(rows);
        pager4EasyUI.setTotal(total);
        return pager4EasyUI;
    }

    @ResponseBody
    @RequestMapping(value = "update")
    public ControllerResult update(Permission permission){
        int updCount = permissionService.update(permission);
        if(updCount == 1) {
            return ControllerResult.getSuccessResult("更改成功");
        }
        return ControllerResult.getFailResult("更改失败");
    }

    @ResponseBody
    @RequestMapping(value = "insert")
    public ControllerResult insert(Permission permission){
        int addCount = permissionService.insert(permission);
        if(addCount == 1) {
            return ControllerResult.getSuccessResult("添加成功");
        }
        return ControllerResult.getFailResult("添加失败");
    }

    @ResponseBody
    @RequestMapping(value = "updateStatus")
    public ControllerResult updateStatus(@RequestParam("permissionId") String permissionId , @RequestParam("permissionStatus")String permissionStatus) {
        permissionStatus = newStatus(permissionStatus);
        final String split = ",";
        List id = Arrays.asList(idsStr2ids(permissionId,split));
        int updCount =permissionService.updateStatus(id, permissionStatus);
        if(updCount == 1) {
            return  ControllerResult.getSuccessResult("修改状态成功");
        }
        return ControllerResult.getFailResult("修改状态失败");
    }

    @ResponseBody
    @RequestMapping(value = "updateStatuses")
    public ControllerResult updateStatuses(@RequestParam("permissionIdsStr") String permissionIdsStr, @RequestParam("status")String permissionStatus) {
        final String split = ",";
        permissionStatus = newStatus(permissionStatus);
        List ids = Arrays.asList(idsStr2ids(permissionIdsStr,split));
        int updCount =permissionService.updateStatus(ids, permissionStatus);
        if(updCount == ids.size()) {
            return  ControllerResult.getSuccessResult("修改状态成功");
        }
        return ControllerResult.getFailResult("修改状态失败");
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

    private String newStatus(String oldStatus){
        if(oldStatus.equals("Y")){
            return "N";
        }
        return "Y";
    }

    private String[] idsStr2ids(String idsStr,String split){
        return idsStr.split(split);
    }



}
