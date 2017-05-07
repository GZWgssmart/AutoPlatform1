package com.gs.service;

import com.gs.bean.Checkin;
import com.gs.bean.IncomingOutgoing;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:59:05
*@des 收支表Service
*/
public interface IncomingOutgoingService extends BaseService<String, IncomingOutgoing>{

    /**
     * 分页查询被禁用的记录
     */
    public List<IncomingOutgoing> queryByPagerDisable(Pager pager);
    /**
     * 分页查询被禁用的记录
     */
    public int countByDisable();

    /**
     * 根据时间段去查找
     */
    public List<IncomingOutgoing> queryByDate(String start,  String end);


    /*
* 根据年，月，季度，周，日查询所有收支记录
* */
    public List<IncomingOutgoing> queryByCondition(String start,String end,String inOutType, String type);


}