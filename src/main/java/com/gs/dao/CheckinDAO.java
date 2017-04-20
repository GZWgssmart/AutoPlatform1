package com.gs.dao;

import com.gs.bean.Checkin;
import com.gs.common.bean.Pager;
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
     * 分页查询被禁用的记录
     */
    public List<Checkin> queryByPagerDisable(Pager pager);
    /**
     * 分页查询被禁用的记录
     */
    public int countByDisable();
}