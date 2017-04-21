package com.gs.service;

import com.gs.bean.ChargeBill;
import com.gs.common.bean.Pager;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:56:01
*@des 收费单据Service
*/
public interface ChargeBillService extends BaseService<String, ChargeBill>{

    /**
     * 分页查询被禁用的记录
     */
    public List<ChargeBill> queryByPagerDisable(Pager pager);
    /**
     * 分页查询被禁用的记录
     */
    public int countByDisable();

}