package com.gs.service;

import com.gs.bean.Salary;
import com.gs.bean.User;
import com.gs.common.bean.Pager;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:11:16
*@des 
*/
public interface SalaryService extends BaseService<String, Salary>{
    // 批量添加，导入时要用
    public boolean addInsert(List<Salary> salarys);

    public List<Salary> querySalary(Pager pager, String start, String end);

    public int countSalary(User user, String start,String end);


}