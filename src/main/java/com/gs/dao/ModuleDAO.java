package com.gs.dao;

import com.gs.bean.Module;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author 程燕
*@since 2017-04-17 16:09:51
*@des 模块DAO
*/
@Repository
public interface ModuleDAO extends BaseDAO<String, Module>{
    public List<Module> queryAll(@Param("moduleStatus")String moduleStatus);
}