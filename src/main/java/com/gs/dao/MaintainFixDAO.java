package com.gs.dao;

import com.gs.bean.MaintainFix;
import com.gs.common.bean.Pager;
import org.activiti.engine.impl.Page;
import org.springframework.stereotype.Repository;
import sun.applet.Main;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:02:40
*@des 维修保养项目dao
*/
@Repository
public interface MaintainFixDAO extends BaseDAO<String, MaintainFix>{
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

}