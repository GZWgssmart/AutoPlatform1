package com.gs.dao;

import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 根据角色名称获取权限字符串
 *
 */
@Repository
public interface RolePermissionDAO {
	
	public List<String> queryAllPermissionByRoleName(String roleName);

}
