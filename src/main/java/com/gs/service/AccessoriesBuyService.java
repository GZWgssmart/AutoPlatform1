package com.gs.service;

import com.gs.bean.AccessoriesBuy;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:44:49
*@des 配件采购Service
*/
public interface AccessoriesBuyService extends BaseService<String, AccessoriesBuy>{
    /**
     * 分页查询被禁用的记录
     */
    public List<AccessoriesBuy> queryByPagerDisable(Pager pager);
    /**
     * 分页查询被禁用的记录
     */
    public int countByDisable();

    /**
     * 下单统计
     */
    public List<AccessoriesBuy> queryByCondition( String start,String end, String companyId,String type);


    /**
     * 支付统计
     */

    public List<AccessoriesBuy> queryByPayCondition( String start,String end, String companyId,String type);

}