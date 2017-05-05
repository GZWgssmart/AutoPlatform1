package com.gs.service;

import com.gs.bean.Complaint;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:58:15
*@des 投诉表Service
*/
public interface ComplaintService extends BaseService<String, Complaint>{

    public List<Complaint> queryByPagerName(@Param("pager") Pager pager, @Param("complaint") Complaint complaint);

    public int countName(@Param("complaint") Complaint complaint);
}