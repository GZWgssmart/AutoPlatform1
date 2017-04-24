package com.gs.service.impl;

import com.gs.bean.Checkin;
import com.gs.bean.MaterialReturn;
import com.gs.dao.MaterialReturnDAO;
import com.gs.service.MaterialReturnService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

import com.gs.common.bean.Pager;
/**
*由CSWangBin技术支持
*
*@author 程燕
*@since 2017-04-17 16:07:27
*@des 退料信息Service实现
*/
@Service
public class MaterialReturnServiceImpl implements MaterialReturnService {

	@Resource
	private MaterialReturnDAO materialReturnDAO;

	public int insert(MaterialReturn materialReturn) { return materialReturnDAO.insert(materialReturn); }
	public int batchInsert(List<MaterialReturn> list) { return materialReturnDAO.batchInsert(list); }
	public int delete(MaterialReturn materialReturn) { return materialReturnDAO.delete(materialReturn); }
	public int deleteById(String id) {
        return materialReturnDAO.deleteById(id);
    }
	public int batchDelete(List<MaterialReturn> list) { return materialReturnDAO.batchDelete(list); }
	public int update(MaterialReturn materialReturn) { return materialReturnDAO.update(materialReturn); }
	public int batchUpdate(List<MaterialReturn> list) { return materialReturnDAO.batchUpdate(list); }
	public List<MaterialReturn> queryAll() { return materialReturnDAO.queryAll(); }

	@Override
	public List<MaterialReturn> queryAll(String status) {
		return materialReturnDAO.queryAll();
	}

	public List<MaterialReturn> queryByStatus(String status) { return materialReturnDAO.queryAll(status); }
	public MaterialReturn query(MaterialReturn materialReturn) { return materialReturnDAO.query(materialReturn); }
	public MaterialReturn queryById(String id) { return materialReturnDAO.queryById(id); }
	public List<MaterialReturn> queryByPager(Pager pager) { return materialReturnDAO.queryByPager(pager); }
	public int count() { return materialReturnDAO.count(); }
	public int inactive(String id) { return materialReturnDAO.inactive(id); }
	public int active(String id) { return materialReturnDAO.active(id); }

	public List<MaterialReturn> queryByPagerDisable(Pager pager) {
		return materialReturnDAO.queryByPagerDisable(pager);
	}

	public int countByDisable() {
		return materialReturnDAO.countByDisable();
	}

	public List<MaterialReturn> blurredQuery(Pager pager, MaterialReturn materialReturn) {
		return null;
	}

	public int countByBlurred(MaterialReturn materialReturn) {
		return 0;
	}
}