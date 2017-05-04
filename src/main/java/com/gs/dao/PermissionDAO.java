package com.gs.dao;

import com.gs.bean.Permission;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
*由CSWangBin技术支持
*
*@author 程燕
*@since 2017-04-17 16:10:25
*@des 权限DAO
*/
@Repository
public interface PermissionDAO extends BaseDAO<String, Permission>{
    public List<Permission> queryAll();



    public List<Permission> queryByPager(Map paramsMap);
    public int count(Map paramsMap);

    public int updateStatus(Map paramsMap);
}