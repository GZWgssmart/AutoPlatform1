package com.gs.controller;

import com.gs.bean.Module;
import com.gs.bean.Permission;
import com.gs.service.ModuleService;
import com.gs.service.PermissionService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author Administrator
 * @create 2017-04-22 10:08 模块管理
 */
@Controller
@RequestMapping("/module")
public class ModuleController {
    @Resource
    private PermissionService permissionService;

    @Resource
    private ModuleService moduleService;

    @ResponseBody
    @RequestMapping(value = "queryAll")
    public List<Module> queryAll(){
        return moduleService.queryAll("Y");
    }

}
