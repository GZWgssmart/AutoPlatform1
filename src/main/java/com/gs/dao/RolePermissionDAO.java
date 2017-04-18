package com.gs.dao;

import com.gs.bean.RolePermission;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:11:01
*@des 
*/
@Repository
public interface RolePermissionDAO extends BaseDAO<String, RolePermission>{
    /**
     * 根据角色名获取角色对应的权限信息
     * @param roleName
     * @return
     */
    public List<String> queryAllPermissionByRoleName(@Param("roleName")String roleName);
}