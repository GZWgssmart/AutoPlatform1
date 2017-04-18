package com.gs.service.impl;

import com.gs.bean.MaintainFixAcc;
import com.gs.dao.MaintainFixAccDAO;
import com.gs.service.MaintainFixAccService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

import com.gs.common.bean.Pager;
/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:03:19
*@des 维修保养项目配件关联Service实现
*/
@Service
public class MaintainFixAccServiceImpl implements MaintainFixAccService {

	@Resource
	private MaintainFixAccDAO maintainFixAccDAO;

	public int insert(MaintainFixAcc maintainFixAcc) { return maintainFixAccDAO.insert(maintainFixAcc); }
	public int batchInsert(List<MaintainFixAcc> list) { return maintainFixAccDAO.batchInsert(list); }
	public int delete(MaintainFixAcc maintainFixAcc) { return maintainFixAccDAO.delete(maintainFixAcc); }
	public int deleteById(String id) {
        return maintainFixAccDAO.deleteById(id);
    }
	public int batchDelete(List<MaintainFixAcc> list) { return maintainFixAccDAO.batchDelete(list); }
	public int update(MaintainFixAcc maintainFixAcc) { return maintainFixAccDAO.update(maintainFixAcc); }
	public int batchUpdate(List<MaintainFixAcc> list) { return maintainFixAccDAO.batchUpdate(list); }
	public List<MaintainFixAcc> queryAll() { return maintainFixAccDAO.queryAll(); }
	public List<MaintainFixAcc> queryByStatus(String status) { return maintainFixAccDAO.queryAll(status); }
	public MaintainFixAcc query(MaintainFixAcc maintainFixAcc) { return maintainFixAccDAO.query(maintainFixAcc); }
	public MaintainFixAcc queryById(String id) { return maintainFixAccDAO.queryById(id); }
	public List<MaintainFixAcc> queryByPager(Pager pager) { return maintainFixAccDAO.queryByPager(pager); }
	public int count() { return maintainFixAccDAO.count(); }
	public int inactive(String id) { return maintainFixAccDAO.inactive(id); }
	public int active(String id) { return maintainFixAccDAO.active(id); }

}