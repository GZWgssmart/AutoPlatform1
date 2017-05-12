package com.gs.service;

import com.gs.bean.CarPlate;
import com.gs.bean.User;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:55:06
*@des 汽车车牌Service
*/
public interface CarPlateService extends BaseService<String, CarPlate>{

    //模糊查询
    public List<CarPlate> blurredQuery(@Param("pager")Pager pager, @Param("carPlate")CarPlate carPlate);

    //模糊查询记录
    public int countByBlurred(@Param("carPlate")CarPlate carPlate,@Param("user")User user);
}