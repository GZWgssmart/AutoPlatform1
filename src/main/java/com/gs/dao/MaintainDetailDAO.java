package com.gs.dao;

import com.gs.bean.MaintainDetail;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:01:15
*@des 维修保养明细dao
*/
@Repository
public interface MaintainDetailDAO extends BaseDAO<String, MaintainDetail>{
    public List<MaintainDetail> queryByDetailByPager(@Param("pager")Pager pager, @Param("maintainRecordId") String maintainRecordId);
    public int countByDetail(@Param("maintainRecordId") String maintainRecordId);
    public List<MaintainDetail> queryByRecordId(@Param("maintainRecordId") String maintainRecordId);

    /**
     * 根据维修项目查询维修记录
     * @param start
     * @param end
     * @param companyId
     * @param maintainId
     * @param type
     * @return
     */
    public List<MaintainDetail> queryByCondition(@Param("start") String start, @Param("end") String end, @Param("companyId")String companyId, @Param("maintainId")String maintainId, @Param("type")String type);

}