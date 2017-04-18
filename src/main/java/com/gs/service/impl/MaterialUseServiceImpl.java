package com.gs.service.impl;

import com.gs.bean.MaterialUse;
import com.gs.dao.MaterialUseDAO;
import com.gs.service.MaterialUseService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

import com.gs.common.bean.Pager;
/**
*由Wjhsmart技术支持
*
*@author Wjhsmart
*@since 2017-04-17 16:08:03
*@des 领料信息Service实现
*/
@Service
public class MaterialUseServiceImpl implements MaterialUseService {

	@Resource
	private MaterialUseDAO materialUseDAO;

	public int insert(MaterialUse materialUse) { return materialUseDAO.insert(materialUse); }
	public int batchInsert(List<MaterialUse> list) { return materialUseDAO.batchInsert(list); }
	public int delete(MaterialUse materialUse) { return materialUseDAO.delete(materialUse); }
	public int deleteById(String id) {
        return materialUseDAO.deleteById(id);
    }
	public int batchDelete(List<MaterialUse> list) { return materialUseDAO.batchDelete(list); }
	public int update(MaterialUse materialUse) { return materialUseDAO.update(materialUse); }
	public int batchUpdate(List<MaterialUse> list) { return materialUseDAO.batchUpdate(list); }
	public List<MaterialUse> queryAll() { return materialUseDAO.queryAll(); }

	@Override
	public List<MaterialUse> queryAll(String status) {
		return materialUseDAO.queryAll();
	}

	public List<MaterialUse> queryByStatus(String status) { return materialUseDAO.queryAll(status); }
	public MaterialUse query(MaterialUse materialUse) { return materialUseDAO.query(materialUse); }
	public MaterialUse queryById(String id) { return materialUseDAO.queryById(id); }
	public List<MaterialUse> queryByPager(Pager pager) { return materialUseDAO.queryByPager(pager); }
	public int count() { return materialUseDAO.count(); }
	public int inactive(String id) { return materialUseDAO.inactive(id); }
	public int active(String id) { return materialUseDAO.active(id); }

}