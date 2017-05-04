package com.gs.service;

import com.gs.bean.MaintainRecord;
import com.gs.common.bean.Pager;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:04:53
*@des 维修保养记录Service
*/
public interface MaintainRecordService extends BaseService<String, MaintainRecord>{
    /**
     * 此模糊查询为提车提醒的
     */
    public List<MaintainRecord> blurredQueryByRemind(Pager pager, MaintainRecord maintainRecord);

    /**
     * 此模糊查询的记录数为提车提醒的
     */
    public int countByBlurredByRemind(MaintainRecord maintainRecord);

}