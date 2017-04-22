package com.gs.service.impl;

import com.gs.bean.Permission;
import com.gs.bean.Role;
import com.gs.dao.RoleDAO;
import com.gs.service.RoleService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

import com.gs.common.bean.Pager;
/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:10:47
*@des 
*/
@Service
public class RoleServiceImpl implements RoleService {

	@Resource
	private RoleDAO roleDAO;

	public int insert(Role role) { return roleDAO.insert(role); }
	public int batchInsert(List<Role> list) { return roleDAO.batchInsert(list); }
	public int delete(Role role) { return roleDAO.delete(role); }
	public int deleteById(String id) {
        return roleDAO.deleteById(id);
    }
	public int batchDelete(List<Role> list) { return roleDAO.batchDelete(list); }
	public int update(Role role) { return roleDAO.update(role); }
	public int batchUpdate(List<Role> list) { return roleDAO.batchUpdate(list); }
	public List<Role> queryAll() { return roleDAO.queryAll(); }

	@Override
	public List<Role> queryAll(String status) {
		return roleDAO.queryAll(status);
	}



	public List<Role> queryByStatus(String status) { return roleDAO.queryAll(status); }
	public Role query(Role role) { return roleDAO.query(role); }
	public Role queryById(String id) { return roleDAO.queryById(id); }
	public List<Role> queryByPager(Pager pager) { return roleDAO.queryByPager(pager); }
	public int count() { return roleDAO.count(); }
	public int inactive(String id) { return roleDAO.inactive(id); }
	public int active(String id) { return roleDAO.active(id); }




}