package com.gs.service;

import com.gs.bean.MaintainFix;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:02:40
*@des 维修保养项目Service
*/
public interface MaintainFixService extends BaseService<String, MaintainFix>{
    /**
     * 分页查询被禁用的记录
     */
    public List<MaintainFix> queryByPagerDisable(Pager pager);
    /**
     * 分页查询被禁用的记录
     */
    public int countByDisable();

    public List<MaintainFix> queryByPagerMaintain(Pager pager);

    public List<MaintainFix> queryByPagerAll(Pager pager);

    public List<MaintainFix> queryByPagerDisableService(Pager pager);

    public int countByDisableService();
}