package com.gs.service;

import com.gs.bean.Permission;
import com.gs.bean.RolePermission;

import java.util.Collection;

/**
*由Wjhsmart技术支持
*
*@author Wjhsmart
*@since 2017-04-17 16:11:01
*@des 
*/
public interface RolePermissionService{
    Collection<org.apache.shiro.authz.Permission> queryAllPermissionByRoleName(String roleName);
}