package com.gs.service.impl;

import com.gs.bean.User;
import com.gs.dao.UserDAO;
import com.gs.service.UserService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

import com.gs.common.bean.Pager;
/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:12:03
*@des 
*/
@Service
public class UserServiceImpl implements UserService {

	@Resource
	private UserDAO userDAO;

	public int insert(User user) { return userDAO.insert(user); }
	public int batchInsert(List<User> list) { return userDAO.batchInsert(list); }
	public int delete(User user) { return userDAO.delete(user); }
	public int deleteById(String id) {
        return userDAO.deleteById(id);
    }
	public int batchDelete(List<User> list) { return userDAO.batchDelete(list); }
	public int update(User user) { return userDAO.update(user); }
	public int batchUpdate(List<User> list) { return userDAO.batchUpdate(list); }
	public List<User> queryAll() { return userDAO.queryAll(); }

	@Override
	public List<User> queryAll(String status) {
		return userDAO.queryAll();
	}

	public List<User> queryByStatus(String status) { return userDAO.queryAll(status); }
	public User query(User user) { return userDAO.query(user); }
	public User queryById(String id) { return userDAO.queryById(id); }
	public List<User> queryByPager(Pager pager) { return userDAO.queryByPager(pager); }
	public int count() { return userDAO.count(); }
	public int inactive(String id) { return userDAO.inactive(id); }
	public int active(String id) { return userDAO.active(id); }

}