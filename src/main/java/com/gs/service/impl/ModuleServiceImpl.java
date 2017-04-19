package com.gs.service.impl;

import com.gs.bean.Module;
import com.gs.dao.ModuleDAO;
import com.gs.service.ModuleService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

import com.gs.common.bean.Pager;
/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:09:52
*@des 模块表Service实现
*/
@Service
public class ModuleServiceImpl implements ModuleService {

	@Resource
	private ModuleDAO moduleDAO;

	public int insert(Module module) { return moduleDAO.insert(module); }
	public int batchInsert(List<Module> list) { return moduleDAO.batchInsert(list); }
	public int delete(Module module) { return moduleDAO.delete(module); }
	public int deleteById(String id) {
        return moduleDAO.deleteById(id);
    }
	public int batchDelete(List<Module> list) { return moduleDAO.batchDelete(list); }
	public int update(Module module) { return moduleDAO.update(module); }
	public int batchUpdate(List<Module> list) { return moduleDAO.batchUpdate(list); }
	public List<Module> queryAll() { return moduleDAO.queryAll(); }

	@Override
	public List<Module> queryAll(String status) {
		return moduleDAO.queryAll();
	}

	public List<Module> queryByStatus(String status) { return moduleDAO.queryAll(status); }
	public Module query(Module module) { return moduleDAO.query(module); }
	public Module queryById(String id) { return moduleDAO.queryById(id); }
	public List<Module> queryByPager(Pager pager) { return moduleDAO.queryByPager(pager); }
	public int count() { return moduleDAO.count(); }
	public int inactive(String id) { return moduleDAO.inactive(id); }
	public int active(String id) { return moduleDAO.active(id); }

}