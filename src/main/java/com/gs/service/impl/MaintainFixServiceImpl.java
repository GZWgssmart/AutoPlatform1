package com.gs.service.impl;

import com.gs.bean.MaintainFix;
import com.gs.dao.MaintainFixDAO;
import com.gs.service.MaintainFixService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

import com.gs.common.bean.Pager;
/**
*由Wjhsmart技术支持
*
*@author Wjhsmart
*@since 2017-04-17 16:02:41
*@des 维修保养项目Service实现
*/
@Service
public class MaintainFixServiceImpl implements MaintainFixService {

	@Resource
	private MaintainFixDAO maintainFixDAO;

	public int insert(MaintainFix maintainFix) { return maintainFixDAO.insert(maintainFix); }
	public int batchInsert(List<MaintainFix> list) { return maintainFixDAO.batchInsert(list); }
	public int delete(MaintainFix maintainFix) { return maintainFixDAO.delete(maintainFix); }
	public int deleteById(String id) {
        return maintainFixDAO.deleteById(id);
    }
	public int batchDelete(List<MaintainFix> list) { return maintainFixDAO.batchDelete(list); }
	public int update(MaintainFix maintainFix) { return maintainFixDAO.update(maintainFix); }
	public int batchUpdate(List<MaintainFix> list) { return maintainFixDAO.batchUpdate(list); }
	public List<MaintainFix> queryAll() { return maintainFixDAO.queryAll(); }
	public List<MaintainFix> queryByStatus(String status) { return maintainFixDAO.queryAll(status); }
	public MaintainFix query(MaintainFix maintainFix) { return maintainFixDAO.query(maintainFix); }
	public MaintainFix queryById(String id) { return maintainFixDAO.queryById(id); }
	public List<MaintainFix> queryByPager(Pager pager) { return maintainFixDAO.queryByPager(pager); }
	public int count() { return maintainFixDAO.count(); }
	public int inactive(String id) { return maintainFixDAO.inactive(id); }
	public int active(String id) { return maintainFixDAO.active(id); }

}