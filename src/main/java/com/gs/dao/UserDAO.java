package com.gs.dao;

import com.gs.bean.User;
import org.springframework.stereotype.Repository;

/**
 * Created by Wang Genshen on 2017-03-22.
 */
@Repository
public interface UserDAO extends BaseDAO<String, User> {

}
