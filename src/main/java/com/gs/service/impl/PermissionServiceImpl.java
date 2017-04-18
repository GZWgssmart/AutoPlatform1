package com.gs.service.impl;

import com.gs.bean.Permission;
import com.gs.common.bean.Pager;
import com.gs.dao.PermissionDAO;
import com.gs.service.PermissionService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
/**
*由Wjhsmart技术支持
*
*@author Wjhsmart
*@since 2017-04-17 16:10:27
*@des 模块表Service实现
*/
@Service
public class PermissionServiceImpl implements PermissionService {

	@Resource
	private PermissionDAO permissionDAO;

	public int insert(Permission permission) { return permissionDAO.insert(permission); }
	public int batchInsert(List<Permission> list) { return permissionDAO.batchInsert(list); }
	public int delete(Permission permission) { return permissionDAO.delete(permission); }
	public int deleteById(String id) {
        return permissionDAO.deleteById(id);
    }
	public int batchDelete(List<Permission> list) { return permissionDAO.batchDelete(list); }
	public int update(Permission permission) { return permissionDAO.update(permission); }
	public int batchUpdate(List<Permission> list) { return permissionDAO.batchUpdate(list); }
	public List<Permission> queryAll() { return permissionDAO.queryAll(); }

	@Override
	public List<Permission> queryAll(String status) {
		return permissionDAO.queryAll();
	}

	public List<Permission> queryByStatus(String status) { return permissionDAO.queryAll(status); }
	public Permission query(Permission permission) { return permissionDAO.query(permission); }
	public Permission queryById(String id) { return permissionDAO.queryById(id); }
	public List<Permission> queryByPager(Pager pager) { return permissionDAO.queryByPager(pager); }
	public int count() { return permissionDAO.count(); }
	public int inactive(String id) { return permissionDAO.inactive(id); }
	public int active(String id) { return permissionDAO.active(id); }

	public List<Permission> queryPermissionById(Integer id) {
		return permissionDAO.queryPermissionById(id);
	}

	public void addPermission(int roleId, int permissionId) {
		permissionDAO.addPermission(roleId, permissionId);
	}

	public void removePermission(int roleId, int permissionId) {
		permissionDAO.removePermission(roleId, permissionId);
	}
}