package com.gs.dao;

import com.gs.bean.CarModel;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:54:15
*@des 汽车车型dao
*/
@Repository
public interface CarModelDAO extends BaseDAO<String, CarModel>{

    public List<CarModel> queryByBrandId(String id);
}