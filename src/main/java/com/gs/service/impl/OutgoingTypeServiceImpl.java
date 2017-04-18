package com.gs.service.impl;

import com.gs.bean.OutgoingType;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.dao.OutgoingTypeDAO;
import com.gs.service.OutgoingTypeService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

import com.gs.common.bean.Pager;
/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:10:14
*@des 模块表Service实现
*/
@Service
public class OutgoingTypeServiceImpl implements OutgoingTypeService {

	@Resource
	private OutgoingTypeDAO outgoingTypeDAO;

	public int insert(OutgoingType outgoingType) { return outgoingTypeDAO.insert(outgoingType); }
	public int batchInsert(List<OutgoingType> list) { return outgoingTypeDAO.batchInsert(list); }
	public int delete(OutgoingType outgoingType) { return outgoingTypeDAO.delete(outgoingType); }
	public int deleteById(String id) {
        return outgoingTypeDAO.deleteById(id);
    }
	public int batchDelete(List<OutgoingType> list) { return outgoingTypeDAO.batchDelete(list); }
	public int update(OutgoingType outgoingType) { return outgoingTypeDAO.update(outgoingType); }
	public int batchUpdate(List<OutgoingType> list) { return outgoingTypeDAO.batchUpdate(list); }
	public List<OutgoingType> queryAll() { return outgoingTypeDAO.queryAll(); }

	@Override
	public List<OutgoingType> queryAll(String status) {
		return outgoingTypeDAO.queryAll();
	}

	public List<OutgoingType> queryByStatus(String status) { return outgoingTypeDAO.queryAll(status); }
	public OutgoingType query(OutgoingType outgoingType) { return outgoingTypeDAO.query(outgoingType); }
	public OutgoingType queryById(String id) { return outgoingTypeDAO.queryById(id); }
	public List<OutgoingType> queryByPager(Pager pager) { return outgoingTypeDAO.queryByPager(pager); }
	public int count() { return outgoingTypeDAO.count(); }
	public int inactive(String id) { return outgoingTypeDAO.inactive(id); }
	public int active(String id) { return outgoingTypeDAO.active(id); }



}