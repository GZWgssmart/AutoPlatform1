package com.gs.dao;

import com.gs.bean.WorkInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author 程燕
*@since 2017-04-17 16:12:24
*@des 工单DAO
*/
@Repository
public interface WorkInfoDAO extends BaseDAO<String, WorkInfo>{

    public List<WorkInfo> queryByCondition(@Param("start") String start, @Param("end") String end, @Param("userId") String userId, @Param("type") String type);

}