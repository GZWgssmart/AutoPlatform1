package com.gs.dao;

import com.gs.bean.Salary;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:11:15
*@des 
*/
@Repository
public interface SalaryDAO extends BaseDAO<String, Salary>{

    // 批量添加，导入时要用
    public void addInsert(List<Salary> salarys);
}