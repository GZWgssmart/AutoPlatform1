package com.gs.service.impl;

import com.gs.bean.MaterialUse;
import com.gs.bean.User;
import com.gs.bean.view.RecordBaseView;
import com.gs.common.bean.Pager;
import com.gs.dao.MaterialUseDAO;
import com.gs.service.MaterialUseService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
/**
*由CSWangBin技术支持
*
*@author 程燕
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

	public List<MaterialUse> queryByPagerDisable(Pager pager) {
		return materialUseDAO.queryByPagerDisable(pager);
	}

	public int countByDisable() {
		return materialUseDAO.countByDisable();
	}

	public List<MaterialUse> blurredQuery(Pager pager, MaterialUse materialUse) {
		return null;
	}

	public int countByBlurred(MaterialUse materialUse) {
		return 0;
	}

	/**
	 *
	 * 不是应该放在这个Bean中的,但是会与其他人的有碰撞,所以放在这里
	 *
	 */
	@Override
	public List<RecordBaseView> queryNoUseRecord(String companyId, Pager pager) {
		return materialUseDAO.queryNoUseRecord(companyId, pager);
	}
	@Override
	public int countNoUseRecord(String companyId) {
		return materialUseDAO.countNoUseRecord(companyId);
	}
	public List<User> companyEmps(String companyId){
		return materialUseDAO.companyEmps(companyId);
	}



}