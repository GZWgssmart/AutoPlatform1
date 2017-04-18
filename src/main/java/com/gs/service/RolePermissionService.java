package com.gs.service;

import java.util.Collection;

/**
 *由CSWangBin技术支持
 *
 *@author CSWangBin
 *@since 2017-04-17 16:11:01
 *@des
 */
public interface RolePermissionService{
    Collection<org.apache.shiro.authz.Permission> queryAllPermissionByRoleName(String roleName);
}