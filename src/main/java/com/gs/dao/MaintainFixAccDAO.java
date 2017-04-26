package com.gs.dao;

import com.gs.bean.MaintainFixAcc;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:03:17
*@des 维修保养项目配件关联dao
*/
@Repository
public interface MaintainFixAccDAO extends BaseDAO<String, MaintainFixAcc>{
    public List<MaintainFixAcc> queryByRecord(@Param("fixId") String fixId);
}