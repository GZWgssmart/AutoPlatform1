package com.gs.service.impl;

import com.gs.bean.CarColor;
import com.gs.bean.Checkin;
import com.gs.dao.CarColorDAO;
import com.gs.service.CarColorService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

import com.gs.common.bean.Pager;
/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:53:25
*@des 汽车颜色Service实现
*/
@Service
public class CarColorServiceImpl implements CarColorService {

	@Resource
	private CarColorDAO carColorDAO;

	public int insert(CarColor carColor) { return carColorDAO.insert(carColor); }
	public int batchInsert(List<CarColor> list) { return carColorDAO.batchInsert(list); }
	public int delete(CarColor carColor) { return carColorDAO.delete(carColor); }
	public int deleteById(String id) {
        return carColorDAO.deleteById(id);
    }
	public int batchDelete(List<CarColor> list) { return carColorDAO.batchDelete(list); }
	public int update(CarColor carColor) { return carColorDAO.update(carColor); }
	public int batchUpdate(List<CarColor> list) { return carColorDAO.batchUpdate(list); }
	public List<CarColor> queryAll() { return carColorDAO.queryAll(); }

	@Override
	public List<CarColor> queryAll(String status) {
		return carColorDAO.queryAll();
	}

	public List<CarColor> queryByStatus(String status) { return carColorDAO.queryAll(status); }
	public CarColor query(CarColor carColor) { return carColorDAO.query(carColor); }
	public CarColor queryById(String id) { return carColorDAO.queryById(id); }
	public List<CarColor> queryByPager(Pager pager) { return carColorDAO.queryByPager(pager); }
	public int count() { return carColorDAO.count(); }
	public int inactive(String id) { return carColorDAO.inactive(id); }
	public int active(String id) { return carColorDAO.active(id); }

	public List<CarColor> queryByPagerDisable(Pager pager) {
		return carColorDAO.queryByPagerDisable(pager);
	}

	public int countByDisable() {
		return carColorDAO.countByDisable();
	}

	public List<Checkin> blurredQuery(Pager pager, CarColor carColor) {
		return null;
	}

	public int countByBlurred(CarColor carColor) {
		return 0;
	}
}