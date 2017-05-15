package com.gs.service;

import com.gs.bean.MaintainDetail;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:01:17
*@des 维修保养明细Service
*/
public interface MaintainDetailService extends BaseService<String, MaintainDetail>{
    public List<MaintainDetail> queryByDetailByPager(Pager pager, String maintainRecordId);
    public int countByDetail(String maintainRecordId);
    public List<MaintainDetail> queryByRecordId(String maintainRecordId);

    public List<MaintainDetail> queryByCondition(String start, String end, String companyId, String maintainId,String type);


}