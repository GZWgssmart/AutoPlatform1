package com.gs.service.impl;

import com.gs.bean.Checkin;
import com.gs.bean.UserRole;
import com.gs.dao.UserRoleDAO;
import com.gs.service.UserRoleService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

import com.gs.common.bean.Pager;
/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:12:15
*@des 
*/
@Service
public class UserRoleServiceImpl implements UserRoleService {

	@Resource
	private UserRoleDAO userRoleDAO;

	public int insert(UserRole userRole) { return userRoleDAO.insert(userRole); }
	public int batchInsert(List<UserRole> list) { return userRoleDAO.batchInsert(list); }
	public int delete(UserRole userRole) { return userRoleDAO.delete(userRole); }
	public int deleteById(String id) {
        return userRoleDAO.deleteById(id);
    }
	public int batchDelete(List<UserRole> list) { return userRoleDAO.batchDelete(list); }
	public int update(UserRole userRole) { return userRoleDAO.update(userRole); }
	public int batchUpdate(List<UserRole> list) { return userRoleDAO.batchUpdate(list); }
	public List<UserRole> queryAll() { return userRoleDAO.queryAll(); }

	@Override
	public List<UserRole> queryAll(String status) {
		return userRoleDAO.queryAll();
	}

	public List<UserRole> queryByStatus(String status) { return userRoleDAO.queryAll(status); }
	public UserRole query(UserRole userRole) { return userRoleDAO.query(userRole); }
	public UserRole queryById(String id) { return userRoleDAO.queryById(id); }
	public List<UserRole> queryByPager(Pager pager) { return userRoleDAO.queryByPager(pager); }
	public int count() { return userRoleDAO.count(); }
	public int inactive(String id) { return userRoleDAO.inactive(id); }
	public int active(String id) { return userRoleDAO.active(id); }

	public List<UserRole> queryByPagerDisable(Pager pager) {
		return userRoleDAO.queryByPagerDisable(pager);
	}

	public int countByDisable() {
		return userRoleDAO.countByDisable();
	}

	public List<Checkin> blurredQuery(Pager pager, UserRole userRole) {
		return null;
	}

	public int countByBlurred(UserRole userRole) {
		return 0;
	}
}