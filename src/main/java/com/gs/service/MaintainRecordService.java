package com.gs.service;

import com.gs.bean.MaintainRecord;
import com.gs.bean.User;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;

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
    public int countByBlurredByRemind(MaintainRecord maintainRecord, User user);

    /**
     * 提车提醒未提醒维修保养记录查询
     */
    public List<MaintainRecord> queryByPagerRemindNo(Pager pager);

    public int countByRemindNo(User user);

    /**
     *  维修记录报表
     */
    public List<MaintainRecord> queryByCondition(String start,String end, String companyId,String maintainOrFix, String type);

    /**
     * 修改维修保养记录当前状态
     */
    public void updateCurrentStatus(String currentStatus, String recordId);

    /**
     * 提车提醒已提醒维修保养记录查询
     */
    public int countByRemindYes(User user);

    public List<MaintainRecord> queryByPagerRemindYes(Pager pager);

    public List<MaintainRecord> queryByPagerSix(@Param("actualEndTime") String actualEndTime);
}