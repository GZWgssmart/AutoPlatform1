package com.gs.service;

import com.gs.bean.User;
import com.gs.common.bean.Pager;

import java.util.List;
import java.util.Set;

/**
 * 由CSWangBin技术支持
 *
 * @author CSWangBin
 * @des
 * @since 2017-04-17 16:12:02
 */
public interface UserService extends BaseService<String, User> {

    //  分页查询全部，不分状态
    public List<User> queryByPagerAll(Pager pr);

    //  分页查询被禁用的记录
    public List<User> queryByPagerDisable(Pager pager);

    public List<User> queryEmail(String ids);

    //根据用户的email查询用户所拥有的权限。
    public Set<String> queryPermissions(String email);

    //根据用户email查询用户所拥有的角色
    public Set<String> queryRoles(String email);

    /**
     * 根据用户输入的邮箱或者手机号判断成功时, 查询到此用户所有信息
     */
    public User queryUser(String email);

    /**
     * 根据邮箱查询用户对应的id
     *
     * @param email
     * @return
     */
    public User queryByEmail(String email);


    public User queryByPhone(String userPhone);

    public int updIcon(String userId,String userIcon);

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

    public void updatePwd(User user);

    /**
     * 计数可用的
     * @return
     */
    public int countOK(User user);

    /**
     * 计数不可用的
     * @return
     */
    public int countNO(User user);

    /**
     * 查询此手机号是否已存在此手机
     */
    public int queryPhoneByOne(String phone);

    /**
     * 查询此手机号是否已存在此手机
     */
    public int queryIsPhoneByOne(String phone, String userId);

    /**
     * 查询此email是否已存在此email
     */
    public int queryIsEmailByOne(String userEmail, String userId);

    /**
     * 查询此identity是否已存在此identity
     */
    public int queryIsIdentityByOne(String userIdentity, String userId);
}