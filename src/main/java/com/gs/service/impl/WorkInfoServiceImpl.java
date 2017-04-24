package com.gs.service.impl;

import com.gs.bean.WorkInfo;
import com.gs.common.bean.Pager;
import com.gs.dao.WorkInfoDAO;
import com.gs.service.WorkInfoService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:12:26
*@des 
*/
@Service
public class WorkInfoServiceImpl implements WorkInfoService {

	@Resource
	private WorkInfoDAO workInfoDAO;

	public int insert(WorkInfo workInfo) { return workInfoDAO.insert(workInfo); }
	public int batchInsert(List<WorkInfo> list) { return workInfoDAO.batchInsert(list); }
	public int delete(WorkInfo workInfo) { return workInfoDAO.delete(workInfo); }
	public int deleteById(String id) {
        return workInfoDAO.deleteById(id);
    }
	public int batchDelete(List<WorkInfo> list) { return workInfoDAO.batchDelete(list); }
	public int update(WorkInfo workInfo) { return workInfoDAO.update(workInfo); }
	public int batchUpdate(List<WorkInfo> list) { return workInfoDAO.batchUpdate(list); }
	public List<WorkInfo> queryAll() { return workInfoDAO.queryAll(); }

	@Override
	public List<WorkInfo> queryAll(String status) {
		return workInfoDAO.queryAll();
	}

	public List<WorkInfo> queryByStatus(String status) { return workInfoDAO.queryAll(status); }
	public WorkInfo query(WorkInfo workInfo) { return workInfoDAO.query(workInfo); }
	public WorkInfo queryById(String id) { return workInfoDAO.queryById(id); }
	public List<WorkInfo> queryByPager(Pager pager) { return workInfoDAO.queryByPager(pager); }
	public int count() { return workInfoDAO.count(); }
	public int inactive(String id) { return workInfoDAO.inactive(id); }
	public int active(String id) { return workInfoDAO.active(id); }

	public List<WorkInfo> queryByPagerDisable(Pager pager) {
		return workInfoDAO.queryByPagerDisable(pager);
	}

	public int countByDisable() {
		return workInfoDAO.countByDisable();
	}

	public List<WorkInfo> blurredQuery(Pager pager, WorkInfo workInfo) {
		return null;
	}

	public int countByBlurred(WorkInfo workInfo) {
		return 0;
	}
}