package com.gs.dao;

import com.gs.bean.Accessories;
import com.gs.common.bean.Pager;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:42:38
*@des 配件表dao
*/
@Repository
public interface AccessoriesDAO extends BaseDAO<String, Accessories>{
    /**
     * 分页查询被禁用的记录
     */
    public List<Accessories> queryByPagerDisable(Pager pager);
    /**
     * 分页查询被禁用的记录
     */
    public int countByDisable();
}