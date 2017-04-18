package com.gs.service.impl;

import com.gs.bean.MaintainRecord;
import com.gs.dao.MaintainRecordDAO;
import com.gs.service.MaintainRecordService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

import com.gs.common.bean.Pager;
/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:04:55
*@des 维修保养记录Service实现
*/
@Service
public class MaintainRecordServiceImpl implements MaintainRecordService {

	@Resource
	private MaintainRecordDAO maintainRecordDAO;

	public int insert(MaintainRecord maintainRecord) { return maintainRecordDAO.insert(maintainRecord); }
	public int batchInsert(List<MaintainRecord> list) { return maintainRecordDAO.batchInsert(list); }
	public int delete(MaintainRecord maintainRecord) { return maintainRecordDAO.delete(maintainRecord); }
	public int deleteById(String id) {
        return maintainRecordDAO.deleteById(id);
    }
	public int batchDelete(List<MaintainRecord> list) { return maintainRecordDAO.batchDelete(list); }
	public int update(MaintainRecord maintainRecord) { return maintainRecordDAO.update(maintainRecord); }
	public int batchUpdate(List<MaintainRecord> list) { return maintainRecordDAO.batchUpdate(list); }
	public List<MaintainRecord> queryAll() { return maintainRecordDAO.queryAll(); }
	public List<MaintainRecord> queryByStatus(String status) { return maintainRecordDAO.queryAll(status); }
	public MaintainRecord query(MaintainRecord maintainRecord) { return maintainRecordDAO.query(maintainRecord); }
	public MaintainRecord queryById(String id) { return maintainRecordDAO.queryById(id); }
	public List<MaintainRecord> queryByPager(Pager pager) { return maintainRecordDAO.queryByPager(pager); }
	public int count() { return maintainRecordDAO.count(); }
	public int inactive(String id) { return maintainRecordDAO.inactive(id); }
	public int active(String id) { return maintainRecordDAO.active(id); }

}