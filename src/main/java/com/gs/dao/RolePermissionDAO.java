package com.gs.dao;

import com.gs.bean.Permission;
import com.gs.bean.RolePermission;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

/**
*由Wjhsmart技术支持
*
*@author Wjhsmart
*@since 2017-04-17 16:11:01
*@des 
*/
@Repository
public interface RolePermissionDAO extends BaseDAO<String, RolePermission>{
    List<String> queryAllPermissionByRoleName(String roleName);
}