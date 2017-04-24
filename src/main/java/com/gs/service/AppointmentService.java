package com.gs.service;

import com.gs.bean.Appointment;
import com.gs.common.bean.Pager;

import java.util.List;

/**
 *由CSWangBin技术支持
 *
 *@author CSWangBin
 *@since 2017-04-17 15:51:10
 *@des 预约service
 */
public interface AppointmentService extends BaseService<String, Appointment>{

    /**
     * 分页查询被禁用的记录
     */
    public List<Appointment> queryByPagerDisable(Pager pager);
    /**
     * 分页查询被禁用的记录
     */
    public int countByDisable();
    /**
     * 模糊查询
     */
    public List<Appointment> blurredQuery(Pager pager, String cloumn, String value);
    /**
     * 模糊查询的记录数
     */
    public int countByBlurred();
}