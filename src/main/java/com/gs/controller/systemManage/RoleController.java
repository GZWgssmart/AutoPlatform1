package com.gs.controller.systemManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Permission;
import com.gs.bean.Role;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.PermissionService;
import com.gs.service.RolePermissionService;
import com.gs.service.RoleService;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
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
    @RequestMapping(value = "insert" )
    public ControllerResult insert(Role role){
        int resultCount = roleService.insert(role);
        if(resultCount>0){
            return  ControllerResult.getSuccessResult("添加成功");
        }
        return ControllerResult.getFailResult("添加失败");

    }
    @ResponseBody
    @RequestMapping(value = "edit" )
    public ControllerResult edit(Role role){
        int resultCount = roleService.update(role);
        if(resultCount>0){
            return  ControllerResult.getSuccessResult("修改成功");
        }
        return ControllerResult.getFailResult("修改失败");
    }

    @ResponseBody
    @RequestMapping("updateStatus")
    public ControllerResult updateStatus(Role role) {
        String status = role.getRoleStatus();
        String newStatus = getNewStatus(status);
        role.setRoleStatus(newStatus);
        int countResult = roleService.updateStatus(role);
        if(countResult == 1) {
            return ControllerResult.getSuccessResult("修改状态成功");
        }
        return ControllerResult.getFailResult("修改状态失败");
    }

    @ResponseBody
    @RequestMapping(value = "queryAll")
    public List<Role> queryAll(){
        return roleService.queryAll("Y");
    }

    @ResponseBody
    @RequestMapping(value = "recycle")
    public Pager4EasyUI queryRecycle(@RequestParam("pageNumber") int pageNumber, @RequestParam("pageSize") int pageSize){
        final String status = "N";
        int total = roleService.count(status);
        Pager pager = new Pager();
        pager.setPageNo(pageNumber);
        pager.setPageSize(pageSize);

        Pager4EasyUI pager4EasyUI = new Pager4EasyUI();
        pager4EasyUI.setRows(roleService.queryByPager(status, pager));
        pager4EasyUI.setTotal(total);
        return pager4EasyUI;

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

    @ResponseBody
    @RequestMapping(value = "/updatePermission" )
    public ControllerResult updatePermission(@RequestParam("roleId") String roleId, @RequestParam("added") String addedPerIdsStr, @RequestParam("removed")String removedPerIdsStr){
        logger.info("删除角色权限");
        List<String> removedPerIds = Arrays.asList(perIdsStr2perIds(removedPerIdsStr,"-"));
        List<String> addedPerIds = Arrays.asList(perIdsStr2perIds(addedPerIdsStr,"-"));
        removedPerIds = removeEmpStr(removedPerIds);
        addedPerIds = removeEmpStr(addedPerIds);
        int addedResultCount = 0;
        if(addedPerIds.size()>0){
            addedResultCount = rolePermissionService.insertList(roleId,addedPerIds);
        }
        int removeResultCount = 0;

        for(String perId: removedPerIds) {
            removeResultCount+= rolePermissionService.removePermission(roleId, perId);
        }
        int removeCount = removedPerIds.size();
        int addCount = addedPerIds.size();
        if (removedPerIds.size() == removeResultCount && addedPerIds.size() == addedResultCount) {
            return ControllerResult.getSuccessResult("修改权限成功");
        }
        return ControllerResult.getFailResult("修改权限失败");
    }


    private String[] perIdsStr2perIds(String perIdsStr,String split){
        return perIdsStr.split(split);
    }
    private List<String> removeEmpStr(List addedPerIds){
        ArrayList newaddedPerIds = new ArrayList(addedPerIds);
        for(int i = 0,len = newaddedPerIds.size(); i<len; i++) {
            String curStr = (String) newaddedPerIds.get(i);
            if(newaddedPerIds.get(i).equals("")){
                newaddedPerIds.remove(i);
            }
        }
        return newaddedPerIds;
    }

    public static void main(String[] args) {
        List list = new ArrayList();
        list.add("");
        if(list.get(0).equals("")) {
            System.out.println(list.remove(0));
            System.out.println(list.size());
        }

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
    public ControllerResult addPermission(@PathVariable("roleId") String roleId, @PathVariable("permissionId") String permissionId){
        logger.info("添加角色权限");
        rolePermissionService.addPermission(roleId, permissionId);
        return ControllerResult.getSuccessResult("添加权限成功");
    }

    @ResponseBody
    @RequestMapping(value = "/removePermission/{roleId}/{permissionId}" ,method = RequestMethod.GET)
    public ControllerResult removePermission(@PathVariable("roleId") String roleId, @PathVariable("permissionId") String permissionId){
        logger.info("删除角色权限");
        rolePermissionService.removePermission(roleId, permissionId);
        return ControllerResult.getSuccessResult("删除权限成功");
    }


    public String getNewStatus(String status){
        if(status.equals("N")){
            return "Y";
        } else {
            return "N";
        }
    }


}
