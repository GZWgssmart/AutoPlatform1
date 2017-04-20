package com.gs.dao;

import com.gs.bean.AccessoriesBuy;
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
    public List<AccessoriesBuy> queryAllStatus(String accBuyStatus);
}