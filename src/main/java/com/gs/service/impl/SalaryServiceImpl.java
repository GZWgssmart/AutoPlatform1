package com.gs.service.impl;

import com.gs.bean.Salary;
import com.gs.dao.SalaryDAO;
import com.gs.service.SalaryService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

import com.gs.common.bean.Pager;
/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:11:17
*@des 
*/
@Service
public class SalaryServiceImpl implements SalaryService {

	@Resource
	private SalaryDAO salaryDAO;

	public int insert(Salary salary) { return salaryDAO.insert(salary); }
	public int batchInsert(List<Salary> list) { return salaryDAO.batchInsert(list); }
	public int delete(Salary salary) { return salaryDAO.delete(salary); }
	public int deleteById(String id) {
        return salaryDAO.deleteById(id);
    }
	public int batchDelete(List<Salary> list) { return salaryDAO.batchDelete(list); }
	public int update(Salary salary) { return salaryDAO.update(salary); }
	public int batchUpdate(List<Salary> list) { return salaryDAO.batchUpdate(list); }
	public List<Salary> queryAll() { return salaryDAO.queryAll(); }
	public List<Salary> queryByStatus(String status) { return salaryDAO.queryAll(status); }
	public Salary query(Salary salary) { return salaryDAO.query(salary); }
	public Salary queryById(String id) { return salaryDAO.queryById(id); }
	public List<Salary> queryByPager(Pager pager) { return salaryDAO.queryByPager(pager); }
	public int count() { return salaryDAO.count(); }
	public int inactive(String id) { return salaryDAO.inactive(id); }
	public int active(String id) { return salaryDAO.active(id); }

}