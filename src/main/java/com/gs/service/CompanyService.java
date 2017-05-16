package com.gs.service;

import com.gs.bean.Company;
import org.apache.ibatis.annotations.Param;

/**
*由CSWangBin技术支持
*
*@author CSWangBin
*@since 2017-04-17 15:57:27
*@des 公司表Service
*/
public interface CompanyService extends BaseService<String, Company>{

    public int updLogo(@Param("userId")String userId, @Param("companyLogo")String companyLogo);
}