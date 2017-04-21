package com.gs.service;

import com.gs.bean.Checkin;
import com.gs.common.bean.Pager;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:56:48
*@des 登记表Service
*/
public interface CheckinService extends BaseService<String, Checkin>{
    /**
     * 分页查询被禁用的记录
     */
    public List<Checkin> queryByPagerDisable(Pager pager);
    /**
     * 分页查询被禁用的记录数
     */
    public int countByDisable();

    /**
     * 模糊查询
     */
    public List<Checkin> blurredQuery(Pager pager,String cloumn, String value);
    /**
     * 模糊查询的记录数
     */
    public int countByBlurred();
}