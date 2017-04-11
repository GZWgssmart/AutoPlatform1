package com.gs.service;

import org.apache.shiro.authz.Permission;

import java.util.Collection;

/**
 * 根据角色名称获取权限字符串
 *
 */
public interface RolePermissionService {
	
	public Collection<Permission> queryAllPermissionByRoleName(String roleName);

}
