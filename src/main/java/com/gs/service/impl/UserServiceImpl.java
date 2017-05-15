package com.gs.service.impl;

import com.gs.bean.User;
import com.gs.common.bean.Pager;
import com.gs.dao.UserDAO;
import com.gs.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;

/**
 * 由CSWangBin技术支持
 *
 * @author CSWangBin
 * @des
 * @since 2017-04-17 16:12:03
 */
@Service
public class UserServiceImpl implements UserService {

    @Resource
    private UserDAO userDAO;

    public int insert(User user) {
        return userDAO.insert(user);
    }

    public int batchInsert(List<User> list) {
        return userDAO.batchInsert(list);
    }

    public int delete(User user) {
        return userDAO.delete(user);
    }

    public int deleteById(String id) {
        return userDAO.deleteById(id);
    }

    public int batchDelete(List<User> list) {
        return userDAO.batchDelete(list);
    }

    public int update(User user) {
        return userDAO.update(user);
    }

    public int batchUpdate(List<User> list) {
        return userDAO.batchUpdate(list);
    }

    public List<User> queryAll(User user) {
        return userDAO.queryAll(user);
    }

    @Override
    public List<User> queryAll(String status) {
        return userDAO.queryAll(status);
    }

    public List<User> queryByStatus(String status) {
        return userDAO.queryAll(status);
    }

    public User query(User user) {
        return userDAO.query(user);
    }

    public User queryById(String id) {
        return userDAO.queryById(id);
    }

    public List<User> queryByPager(Pager pager) {
        return userDAO.queryByPager(pager);
    }

    public int count(User user) {
        return userDAO.count(user);
    }

    public int inactive(String id) {
        return userDAO.inactive(id);
    }

    public int active(String id) {
        return userDAO.active(id);
    }

    //  分页查询全部，不分状态
    @Override
    public List<User> queryByPagerAll(Pager pager) {
        return userDAO.queryByPagerAll(pager);
    }

    @Override
    public User queryByEmail(String email) {
        return userDAO.queryByEmail(email);
    }

    public List<User> queryByPagerDisable(Pager pager) {
        return userDAO.queryByPagerDisable(pager);
    }

    public int countByDisable(User user) {
        return userDAO.countByDisable(user);
    }

    public List<User> blurredQuery(Pager pager, User user) {
        return null;
    }

    public int countByBlurred(User user,User user1) {
        return countByBlurred(user, user1);
    }

    public List<User> queryEmail(String ids) {
        return userDAO.queryEmail(ids);
    }


    @Override
    public User queryByPhone(String userPhone) {
        return userDAO.queryByPhone(userPhone);
    }

    @Override
    public int updIcon(String userId, String userIcon) {
        return userDAO.updIcon(userId, userIcon);
    }

    @Override
    public User queryUser(String email) {
        return userDAO.queryUser(email);
    }

    @Override
    public Set<String> queryPermissions(String email) {
        return userDAO.queryPermissions(email);
    }

    @Override
    public Set<String> queryRoles(String email) {
        return userDAO.queryRoles(email);
    }
}