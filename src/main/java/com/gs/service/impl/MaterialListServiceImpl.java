package com.gs.service.impl;

import com.gs.bean.Checkin;
import com.gs.bean.MaterialList;
import com.gs.bean.view.MaterialView;
import com.gs.dao.MaterialListDAO;
import com.gs.service.MaterialListService;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

import com.gs.common.bean.Pager;
/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:06:49
*@des 物料清单Service实现
*/
@Service
public class MaterialListServiceImpl implements MaterialListService {

	@Resource
	private MaterialListDAO materialListDAO;

	public int insert(MaterialList materialList) { return materialListDAO.insert(materialList); }
	public int batchInsert(List<MaterialList> list) { return materialListDAO.batchInsert(list); }
	public int delete(MaterialList materialList) { return materialListDAO.delete(materialList); }
	public int deleteById(String id) {
        return materialListDAO.deleteById(id);
    }
	public int batchDelete(List<MaterialList> list) { return materialListDAO.batchDelete(list); }
	public int update(MaterialList materialList) { return materialListDAO.update(materialList); }
	public int batchUpdate(List<MaterialList> list) { return materialListDAO.batchUpdate(list); }
	public List<MaterialList> queryAll() { return materialListDAO.queryAll(); }

	@Override
	public List<MaterialList> queryAll(String status) {
		return materialListDAO.queryAll();
	}

	public List<MaterialList> queryByStatus(String status) { return materialListDAO.queryAll(status); }
	public MaterialList query(MaterialList materialList) { return materialListDAO.query(materialList); }
	public MaterialList queryById(String id) { return materialListDAO.queryById(id); }
	public List<MaterialList> queryByPager(Pager pager) { return materialListDAO.queryByPager(pager); }
	public int count() { return materialListDAO.count(); }
	public int inactive(String id) { return materialListDAO.inactive(id); }
	public int active(String id) { return materialListDAO.active(id); }

	public List<MaterialList> queryByPagerDisable(Pager pager) {
		return materialListDAO.queryByPagerDisable(pager);
	}

	public int countByDisable() {
		return materialListDAO.countByDisable();
	}

	public List<MaterialList> blurredQuery(Pager pager, MaterialList materialList) {
		return null;
	}

	public int countByBlurred(MaterialList materialList) {
		return 0;
	}

	@Override
	public List<MaterialView> queryByPager(String userId, Pager pager) {
		return materialListDAO.queryByPager(userId,pager);
	}

	@Override
	public int count(String userId) {
		return materialListDAO.count(userId);
	}

	@Override
	public List<MaterialList> recordAccsByPager(String recordId, Pager pager) {
		return materialListDAO.recordAccsByPager(recordId, pager);
	}

	@Override
	public int countRecordAccs(String recordId) {
		return materialListDAO.countRecordAccs(recordId);
	}
}