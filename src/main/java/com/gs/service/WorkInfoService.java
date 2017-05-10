package com.gs.service;

import com.gs.bean.WorkInfo;
import com.gs.common.bean.Pager;

import java.util.List;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 16:12:25
*@des 
*/
public interface WorkInfoService extends BaseService<String, WorkInfo>{

    public List<WorkInfo> queryByCondition(String start, String end,String userId, String type);

    public List<WorkInfo> queryByPagerschelude(Pager pager);

}