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
    public List<IncomingOutgoing> queryByDate(@Param("start") String start, @Param("end") String end);

    /**
     * 根据年去查找
     */
    public List<IncomingOutgoing> queryByYear(@Param("start") String start, @Param("end")String end);

    /**
     * 根据月去查找
     */
    public List<IncomingOutgoing> queryByMonth(@Param("start") String start, @Param("end")String end);

    /**
     * 根据日去查找
     */
    public List<IncomingOutgoing> queryByDay(@Param("start") String start, @Param("end")String end);

    /**
     * 根据季度查找
     */
    public List<IncomingOutgoing> queryByQuarter(@Param("start") String start, @Param("end")String end);

    /**
     * 根据周查找
     */
    public List<IncomingOutgoing> queryByWeek(@Param("start") String start, @Param("end")String end);
}