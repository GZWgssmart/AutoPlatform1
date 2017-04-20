package com.gs.service;

import com.gs.bean.Supply;
import com.gs.common.bean.Pager;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:11:27
*@des 
*/
public interface SupplyService extends BaseService<String, Supply>{

    /**
     * 分页查询被禁用的记录
     */
    public List<Supply> queryByPagerDisable(Pager pager);
    /**
     * 分页查询被禁用的记录
     */
    public int countByDisable();

}