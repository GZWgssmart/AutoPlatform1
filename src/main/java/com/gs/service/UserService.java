package com.gs.service;

import com.gs.bean.User;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:12:02
*@des 
*/
public interface UserService extends BaseService<String, User>{

    //  分页查询全部，不分状态
    public Pager4EasyUI queryByPagerAll(Pager pager);

}