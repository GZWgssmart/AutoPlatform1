package com.gs.service.impl;

import com.gs.bean.Supply;
import com.gs.dao.SupplyDAO;
import com.gs.service.SupplyService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

import com.gs.common.bean.Pager;
/**
*由Wjhsmart技术支持
*
*@author Wjhsmart
*@since 2017-04-17 16:11:28
*@des 
*/
@Service
public class SupplyServiceImpl implements SupplyService {

	@Resource
	private SupplyDAO supplyDAO;

	public int insert(Supply supply) { return supplyDAO.insert(supply); }
	public int batchInsert(List<Supply> list) { return supplyDAO.batchInsert(list); }
	public int delete(Supply supply) { return supplyDAO.delete(supply); }
	public int deleteById(String id) {
        return supplyDAO.deleteById(id);
    }
	public int batchDelete(List<Supply> list) { return supplyDAO.batchDelete(list); }
	public int update(Supply supply) { return supplyDAO.update(supply); }
	public int batchUpdate(List<Supply> list) { return supplyDAO.batchUpdate(list); }
	public List<Supply> queryAll() { return supplyDAO.queryAll(); }

	@Override
	public List<Supply> queryAll(String status) {
		return supplyDAO.queryAll();
	}

	public List<Supply> queryByStatus(String status) { return supplyDAO.queryAll(status); }
	public Supply query(Supply supply) { return supplyDAO.query(supply); }
	public Supply queryById(String id) { return supplyDAO.queryById(id); }
	public List<Supply> queryByPager(Pager pager) { return supplyDAO.queryByPager(pager); }
	public int count() { return supplyDAO.count(); }
	public int inactive(String id) { return supplyDAO.inactive(id); }
	public int active(String id) { return supplyDAO.active(id); }

}