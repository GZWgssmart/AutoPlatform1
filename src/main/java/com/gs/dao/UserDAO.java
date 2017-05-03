package com.gs.dao;

import com.gs.bean.User;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*@author 小蜜蜂
*@since 2017-04-17 16:12:01
*@des 
*/
@Repository
public interface UserDAO extends BaseDAO<String, User>{

//  分页查询全部，不分状态
    public Pager4EasyUI queryByPagerAll(Pager pager);

    /**
     * 根据维修保养记录查询到用户的email发送邮件提醒车主进行提车
     */
    public List<User> queryEmail(String ids);
}