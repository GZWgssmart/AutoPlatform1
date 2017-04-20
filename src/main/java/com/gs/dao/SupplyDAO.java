package com.gs.dao;

import com.gs.bean.Supply;
import com.gs.common.bean.Pager;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:11:26
*@des 
*/
@Repository
public interface SupplyDAO extends BaseDAO<String, Supply>{

    /**
     * 分页查询被禁用的记录
     */
    public List<Supply> queryByPagerDisable(Pager pager);
    /**
     * 分页查询被禁用的记录
     */
    public int countByDisable();

}