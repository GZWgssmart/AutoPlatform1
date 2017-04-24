package com.gs.service.impl;

import com.gs.bean.Checkin;
import com.gs.bean.Permission;
import com.gs.common.bean.Pager;
import com.gs.dao.PermissionDAO;
import com.gs.service.PermissionService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
/**
*由CSWangBin技术支持
*
*@author 程燕
*@since 2017-04-17 16:10:27
*@des 权限Service实现
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
		return permissionDAO.queryAll(status);
	}

	public List<Permission> queryByStatus(String status) { return permissionDAO.queryAll(status); }
	public Permission query(Permission permission) { return permissionDAO.query(permission); }
	public Permission queryById(String id) { return permissionDAO.queryById(id); }
	public List<Permission> queryByPager(Pager pager) { return permissionDAO.queryByPager(pager); }
	public int count() { return permissionDAO.count(); }
	public int inactive(String id) { return permissionDAO.inactive(id); }
	public int active(String id) { return permissionDAO.active(id); }

	public List<Permission> queryByPagerDisable(Pager pager) {
		return permissionDAO.queryByPagerDisable(pager);
	}

	public int countByDisable() {
		return permissionDAO.countByDisable();
	}

	public List<Checkin> blurredQuery(Pager pager, Permission permission) {
		return null;
	}

	public int countByBlurred(Permission permission) {
		return 0;
	}
}