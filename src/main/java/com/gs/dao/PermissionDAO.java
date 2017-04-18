package com.gs.dao;

import com.gs.bean.Permission;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*由Wjhsmart技术支持
*
*@author Wjhsmart
*@since 2017-04-17 16:10:25
*@des 模块表dao
*/
@Repository
public interface PermissionDAO extends BaseDAO<String, Permission>{
    public List<Permission> queryPermissionById(Integer id);
    public void addPermission(@Param("roleId")int roleId, @Param("permissionId")int permissionId);
    public void removePermission(@Param("roleId")int roleId, @Param("permissionId")int permissionId);
}