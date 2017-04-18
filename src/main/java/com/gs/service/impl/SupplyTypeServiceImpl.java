package com.gs.service.impl;

import com.gs.bean.SupplyType;
import com.gs.dao.SupplyTypeDAO;
import com.gs.service.SupplyTypeService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

import com.gs.common.bean.Pager;
/**
*由Wjhsmart技术支持
*
*@author Wjhsmart
*@since 2017-04-17 16:11:40
*@des 
*/
@Service
public class SupplyTypeServiceImpl implements SupplyTypeService {

	@Resource
	private SupplyTypeDAO supplyTypeDAO;

	public int insert(SupplyType supplyType) { return supplyTypeDAO.insert(supplyType); }
	public int batchInsert(List<SupplyType> list) { return supplyTypeDAO.batchInsert(list); }
	public int delete(SupplyType supplyType) { return supplyTypeDAO.delete(supplyType); }
	public int deleteById(String id) {
        return supplyTypeDAO.deleteById(id);
    }
	public int batchDelete(List<SupplyType> list) { return supplyTypeDAO.batchDelete(list); }
	public int update(SupplyType supplyType) { return supplyTypeDAO.update(supplyType); }
	public int batchUpdate(List<SupplyType> list) { return supplyTypeDAO.batchUpdate(list); }
	public List<SupplyType> queryAll() { return supplyTypeDAO.queryAll(); }

	@Override
	public List<SupplyType> queryAll(String status) {
		return supplyTypeDAO.queryAll();
	}

	public List<SupplyType> queryByStatus(String status) { return supplyTypeDAO.queryAll(status); }
	public SupplyType query(SupplyType supplyType) { return supplyTypeDAO.query(supplyType); }
	public SupplyType queryById(String id) { return supplyTypeDAO.queryById(id); }
	public List<SupplyType> queryByPager(Pager pager) { return supplyTypeDAO.queryByPager(pager); }
	public int count() { return supplyTypeDAO.count(); }
	public int inactive(String id) { return supplyTypeDAO.inactive(id); }
	public int active(String id) { return supplyTypeDAO.active(id); }

}