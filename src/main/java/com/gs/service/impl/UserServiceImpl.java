package com.gs.service.impl;

import com.gs.bean.User;
import com.gs.common.bean.Pager;
import com.gs.dao.UserDAO;
import com.gs.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2017-04-11.
 */
@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserDAO userDAO;

    public int insert(User user) {
        return 0;
    }

    public int batchInsert(List<User> list) {
        return 0;
    }

    public int delete(User user) {
        return 0;
    }

    public int deleteById(String id) {
        return 0;
    }

    public int batchDelete(List<User> list) {
        return 0;
    }

    public int update(User user) {
        return 0;
    }

    public int batchUpdate(List<User> list) {
        return 0;
    }

    public List<User> queryAll() {
        return null;
    }

    public List<User> queryAll(String status) {
        return null;
    }

    public User query(User user) {
        return null;
    }

    public User queryById(String id) {
        return null;
    }

    public List<User> queryByPager(Pager pager) {
        return null;
    }

    public int count() {
        return 0;
    }

    public int inactive(String id) {
        return 0;
    }

    public int active(String id) {
        return 0;
    }
}
