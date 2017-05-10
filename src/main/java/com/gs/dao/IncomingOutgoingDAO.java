package com.gs.dao;

import com.gs.bean.Checkin;
import com.gs.bean.IncomingOutgoing;
import com.gs.bean.OutgoingType;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:59:05
*@des 收支表dao
*/
@Repository
public interface IncomingOutgoingDAO extends BaseDAO<String, IncomingOutgoing>{

    /**
     * 分页查询被禁用的记录
     */
    public List<IncomingOutgoing> queryByPagerDisable(Pager pager);
    /**
     * 分页查询被禁用的记录
     */
    public int countByDisable();

    /**
     * 根据时间段去查找
     */
    public List<IncomingOutgoing> queryByDate(@Param("inOutType")String inOutType,@Param("companyId")String companyId);


    /*
 * 根据年，月，季度，周，日查询所有收支记录
 * */
    public List<IncomingOutgoing> queryByCondition(@Param("start")String start,@Param("end")String end,@Param("inOutType")String inOutType,@Param("companyId")String companyId,@Param("type")String type);
}