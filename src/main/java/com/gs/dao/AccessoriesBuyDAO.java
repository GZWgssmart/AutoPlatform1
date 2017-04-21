package com.gs.dao;

import com.gs.bean.AccessoriesBuy;
import com.gs.common.bean.Pager;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:44:30
*@des 配件采购dao
*/
@Repository
public interface AccessoriesBuyDAO extends BaseDAO<String, AccessoriesBuy>{
    /**
     * 分页查询被禁用的记录
     */
    public List<AccessoriesBuy> queryByPagerDisable(Pager pager);
    /**
     * 分页查询被禁用的记录
     */
    public int countByDisable();
}