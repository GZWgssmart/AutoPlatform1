package com.gs.service;

import com.gs.bean.AccessoriesBuy;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:44:49
*@des 配件采购Service
*/
public interface AccessoriesBuyService extends BaseService<String, AccessoriesBuy>{
    public List<AccessoriesBuy> queryAllStatus(String accBuyStatus);
}