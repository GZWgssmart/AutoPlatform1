package com.gs.service;

import com.gs.bean.User;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;

import java.util.Set;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:12:02
*@des 
*/
public interface UserService extends BaseService<String, User>{

    //  分页查询全部，不分状态
    public Pager4EasyUI queryByPagerAll(Pager pr);
    public List<User> queryEmail(String ids);
    //根据用户的email查询用户所拥有的权限。
    public Set<String> queryPermissions(String email);

    //根据用户email查询用户所拥有的角色
    public Set<String> queryRoles(String email);

}