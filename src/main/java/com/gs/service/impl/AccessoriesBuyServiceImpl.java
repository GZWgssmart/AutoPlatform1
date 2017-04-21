package com.gs.service.impl;

import com.gs.bean.AccessoriesBuy;
import com.gs.dao.AccessoriesBuyDAO;
import com.gs.service.AccessoriesBuyService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;
import com.gs.common.bean.Pager;
/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:45:35
*@des 配件采购Service实现
*/
@Service
public class AccessoriesBuyServiceImpl implements AccessoriesBuyService {

	@Resource
	private AccessoriesBuyDAO accessoriesBuyDAO;

	public int insert(AccessoriesBuy accessoriesBuy) { return accessoriesBuyDAO.insert(accessoriesBuy); }
	public int batchInsert(List<AccessoriesBuy> list) { return accessoriesBuyDAO.batchInsert(list); }
	public int delete(AccessoriesBuy accessoriesBuy) { return accessoriesBuyDAO.delete(accessoriesBuy); }
	public int deleteById(String id) {
        return accessoriesBuyDAO.deleteById(id);
    }
	public int batchDelete(List<AccessoriesBuy> list) { return accessoriesBuyDAO.batchDelete(list); }
	public int update(AccessoriesBuy accessoriesBuy) { return accessoriesBuyDAO.update(accessoriesBuy); }
	public int batchUpdate(List<AccessoriesBuy> list) { return accessoriesBuyDAO.batchUpdate(list); }
	public List<AccessoriesBuy> queryAll() { return accessoriesBuyDAO.queryAll(); }


	public List<AccessoriesBuy> queryAll(String status) {
		return accessoriesBuyDAO.queryAll();
	}

	public List<AccessoriesBuy> queryByStatus(String status) { return accessoriesBuyDAO.queryAll(status); }
	public AccessoriesBuy query(AccessoriesBuy accessoriesBuy) { return accessoriesBuyDAO.query(accessoriesBuy); }
	public AccessoriesBuy queryById(String id) { return accessoriesBuyDAO.queryById(id); }
	public List<AccessoriesBuy> queryByPager(Pager pager) { return accessoriesBuyDAO.queryByPager(pager); }
	public int count() { return accessoriesBuyDAO.count(); }
	public int inactive(String id) { return accessoriesBuyDAO.inactive(id); }
	public int active(String id) { return accessoriesBuyDAO.active(id); }

	@Override
	public List<AccessoriesBuy> queryByPagerDisable(Pager pager) {
		return accessoriesBuyDAO.queryByPagerDisable(pager);
	}

	@Override
	public int countByDisable() {
		return accessoriesBuyDAO.countByDisable();
	}
}