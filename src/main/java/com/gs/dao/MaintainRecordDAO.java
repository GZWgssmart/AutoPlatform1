package com.gs.dao;

import com.gs.bean.MaintainRecord;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;
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
     * 模糊查询
     */
    public List<MaintainRecord> blurredQuery(@Param("pager")Pager pager, @Param("maintainRecord")MaintainRecord maintainRecord);

    /**
     * 模糊查询的记录数
     */
    public int countByBlurred(@Param("maintainRecord")MaintainRecord maintainRecord);
    /**
     * 模糊查询
     */
    public List<MaintainRecord> blurredQueryByRemind(@Param("pager")Pager pager, @Param("maintainRecord")MaintainRecord maintainRecord);

    /**
     * 模糊查询的记录数
     */
    public int countByBlurredByRemind(@Param("maintainRecord")MaintainRecord maintainRecord);

    /**
     *  维修记录报表
     */
    public List<MaintainRecord> queryByCondition(@Param("start") String start,@Param("end") String end, @Param("companyId") String companyId,@Param("maintainOrFix")String maintainOrFix, @Param("type") String type);

}