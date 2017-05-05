package com.gs.service.impl;

import com.gs.bean.Complaint;
import com.gs.common.bean.Pager;
import com.gs.dao.ComplaintDAO;
import com.gs.service.ComplaintService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:58:16
*@des 投诉表Service实现
*/
@Service
public class ComplaintServiceImpl implements ComplaintService {

	@Resource
	private ComplaintDAO complaintDAO;

	public int insert(Complaint complaint) { return complaintDAO.insert(complaint); }
	public int batchInsert(List<Complaint> list) { return complaintDAO.batchInsert(list); }
	public int delete(Complaint complaint) { return complaintDAO.delete(complaint); }
	public int deleteById(String id) {
        return complaintDAO.deleteById(id);
    }
	public int batchDelete(List<Complaint> list) { return complaintDAO.batchDelete(list); }
	public int update(Complaint complaint) { return complaintDAO.update(complaint); }
	public int batchUpdate(List<Complaint> list) { return complaintDAO.batchUpdate(list); }
	public List<Complaint> queryAll() { return complaintDAO.queryAll(); }

	@Override
	public List<Complaint> queryAll(String status) {
		return complaintDAO.queryAll();
	}

	public List<Complaint> queryByStatus(String status) { return complaintDAO.queryAll(status); }
	public Complaint query(Complaint complaint) { return complaintDAO.query(complaint); }
	public Complaint queryById(String id) { return complaintDAO.queryById(id); }
	public List<Complaint> queryByPager(Pager pager) { return complaintDAO.queryByPager(pager); }
	public int count() { return complaintDAO.count(); }
	public int inactive(String id) { return complaintDAO.inactive(id); }
	public int active(String id) { return complaintDAO.active(id); }

	public List<Complaint> queryByPagerDisable(Pager pager) {
		return complaintDAO.queryByPagerDisable(pager);
	}

	public int countByDisable() {
		return complaintDAO.countByDisable();
	}

	public List<Complaint> blurredQuery(Pager pager, Complaint complaint) {
		return null;
	}

	public int countByBlurred(Complaint complaint) {
		return 0;
	}

	@Override
	public List<Complaint> queryByPagerName(Pager pager, Complaint complaint) {
		return complaintDAO.queryByPagerName(pager,complaint);
	}

	@Override
	public int countName(Complaint complaint) {
		return complaintDAO.countName(complaint);
	}
}