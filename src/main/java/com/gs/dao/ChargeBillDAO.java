package com.gs.dao;

import com.gs.bean.ChargeBill;
import com.gs.common.bean.Pager;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:55:59
*@des 收费单据dao
*/
@Repository
public interface ChargeBillDAO extends BaseDAO<String, ChargeBill>{

    /**
     * 分页查询被禁用的记录
     */
    public List<ChargeBill> queryByPagerDisable(Pager pager);
    /**
     * 分页查询被禁用的记录
     */
    public int countByDisable();

}