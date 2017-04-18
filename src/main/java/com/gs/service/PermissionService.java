package com.gs.service;

import com.gs.bean.Permission;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:10:26
*@des 模块表Service
*/
public interface PermissionService extends BaseService<String, Permission>{
    public List<Permission> queryPermissionById(Integer id);
    public void addPermission(int roleId, int permissionId);
    public void removePermission(int roleId, int permissionId);
    public List<Permission> queryAll();
}