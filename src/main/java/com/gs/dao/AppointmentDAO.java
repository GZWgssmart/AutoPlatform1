package com.gs.dao;

import com.gs.bean.Appointment;
import com.gs.common.bean.Pager;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 *由CSWangBin技术支持
 *
 *@author CSWangBin
 *@since 2017-04-17 15:51:08
 *@des 预约dao
 */
@Repository
public interface AppointmentDAO extends BaseDAO<String, Appointment>{

    /**
     * 分页查询被禁用的记录
     */
    public List<Appointment> queryByPagerDisable(Pager pager);
    /**
     * 分页查询被禁用的记录
     */
    public int countByDisable();
}