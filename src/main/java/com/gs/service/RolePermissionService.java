package com.gs.service;

import com.gs.bean.Permission;

import java.util.Collection;
import java.util.List;

/**
 *由CSWangBin技术支持
 *
 *@author CSWangBin
 *@since 2017-04-17 16:11:01
 *@des
 */
public interface RolePermissionService{
    Collection<org.apache.shiro.authz.Permission> queryAllPermissionByRoleName(String roleName);

    public List<Permission> queryPermissionById(Integer id);
    public void addPermission(int roleId, int permissionId);
    public void removePermission(int roleId, int permissionId);

    public List<Permission> queryPermissions(String roleId, String roleStatus);
}