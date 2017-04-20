package com.gs.service;

import com.gs.bean.Checkin;
import com.gs.bean.IncomingOutgoing;
import com.gs.common.bean.Pager;

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


}