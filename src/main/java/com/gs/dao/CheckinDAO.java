package com.gs.dao;

import com.gs.bean.Checkin;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:56:47
*@des 登记表dao
*/
@Repository
public interface CheckinDAO extends BaseDAO<String, Checkin>{
    /**
     * 模糊查询
     */
    public List<Checkin> blurredQuery(@Param("pager")Pager pager, @Param("checkin")Checkin checkin);

    /**
     * 模糊查询的记录数
     */
    public int countByBlurred(@Param("checkin")Checkin checkin);
}