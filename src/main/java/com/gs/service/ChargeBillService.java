package com.gs.service;

import com.gs.bean.ChargeBill;
import org.apache.ibatis.annotations.Param;

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
     * 查询消费统计记录
     * @param start
     * @param end
     * @param companyId
     * @param maintainOrFix
     * @param type
     * @return
     */
    public List<ChargeBill> queryByCondition( String start,  String end,  String companyId, String maintainOrFix, String type);

}