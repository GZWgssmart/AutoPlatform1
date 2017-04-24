package com.gs.dao;

import com.gs.bean.MaintainRecord;
import com.gs.common.bean.Pager;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:04:52
*@des 维修保养记录dao
*/
@Repository
public interface MaintainRecordDAO extends BaseDAO<String, MaintainRecord>{

    /**
     * 分页查看禁用
     * @param pager
     * @return
     */
    public List<MaintainRecord> queryByPagerDisable(Pager pager);

    /**
     * 分页查看禁用计数
     * @return
     */
    public int countDisable();
}