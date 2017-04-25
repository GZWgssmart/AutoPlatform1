package com.gs.dao;

import com.gs.bean.Accessories;
import com.gs.common.bean.Pager;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:42:38
*@des 配件表dao
*/
@Repository
public interface AccessoriesDAO extends BaseDAO<String, Accessories>{
    /**
     * 模糊查询
     */
    public List<Accessories> blurredQuery(@Param("pager")Pager pager, @Param("accInv")Accessories accessories);

    /**
     * 模糊查询的记录数
     */
    public int countByBlurred(@Param("accInv")Accessories accessories);
}