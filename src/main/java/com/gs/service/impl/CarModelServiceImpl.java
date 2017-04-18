package com.gs.service.impl;

import com.gs.bean.CarModel;
import com.gs.dao.CarModelDAO;
import com.gs.service.CarModelService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

import com.gs.common.bean.Pager;
/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:54:18
*@des 汽车车型Service实现
*/
@Service
public class CarModelServiceImpl implements CarModelService {

	@Resource
	private CarModelDAO carModelDAO;

	public int insert(CarModel carModel) { return carModelDAO.insert(carModel); }
	public int batchInsert(List<CarModel> list) { return carModelDAO.batchInsert(list); }
	public int delete(CarModel carModel) { return carModelDAO.delete(carModel); }
	public int deleteById(String id) {
        return carModelDAO.deleteById(id);
    }
	public int batchDelete(List<CarModel> list) { return carModelDAO.batchDelete(list); }
	public int update(CarModel carModel) { return carModelDAO.update(carModel); }
	public int batchUpdate(List<CarModel> list) { return carModelDAO.batchUpdate(list); }
	public List<CarModel> queryAll() { return carModelDAO.queryAll(); }

	@Override
	public List<CarModel> queryAll(String status) {
		return carModelDAO.queryAll();
	}

	public List<CarModel> queryByStatus(String status) { return carModelDAO.queryAll(status); }
	public CarModel query(CarModel carModel) { return carModelDAO.query(carModel); }
	public CarModel queryById(String id) { return carModelDAO.queryById(id); }
	public List<CarModel> queryByPager(Pager pager) { return carModelDAO.queryByPager(pager); }
	public int count() { return carModelDAO.count(); }
	public int inactive(String id) { return carModelDAO.inactive(id); }
	public int active(String id) { return carModelDAO.active(id); }

}