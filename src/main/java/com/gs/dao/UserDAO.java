package com.gs.dao;

import com.gs.bean.User;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

/**
*@author 小蜜蜂
*@since 2017-04-17 16:12:01
*@des 
*/
@Repository
public interface UserDAO extends BaseDAO<String, User>{

//  分页查询全部，不分状态
    public List<User> queryByPagerAll(Pager pager);

    //  分页查询被禁用的记录
    public List<User> queryByPagerDisable(Pager pager);

    /**
     * 根据维修保养记录查询到用户的email发送邮件提醒车主进行提车
     */
    public List<User> queryEmail(@Param("ids")String ids);

    /**
     *根据邮箱查询用户对应的id
     * @param email
     * @return
     */
    public User queryByEmail(String email);


    public User queryByPhone(String userPhone);

    public int updIcon(@Param("userId")String userId,@Param("userIcon")String userIcon);

    //根据用户的email查询用户所拥有的权限。
    public Set<String> queryPermissions(String email);

    //根据用户email查询用户所拥有的角色
    public Set<String> queryRoles(String email);
    /**
     * 根据用户输入的邮箱或者手机号判断成功时, 查询到此用户所有信息
     */
    public User queryUser(String email);

    /**
     * 根据roleName查询人员基本信息
     * @param roleName
     * @return
     */
    public List<User> queryByRoleName(String roleName);

    /**
     * 根据id查询 只查询t_user表
     * @param id
     * @return
     */
    public User queryInfoById(String id);
}