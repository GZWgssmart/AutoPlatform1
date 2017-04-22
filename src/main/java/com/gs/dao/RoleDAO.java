package com.gs.dao;

import com.gs.bean.Permission;
import com.gs.bean.Role;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:10:46
*@des 
*/
@Repository
public interface RoleDAO extends BaseDAO<String, Role>{
    public List<Role> queryAll(@Param("roleStatus") String roleStatus);
}