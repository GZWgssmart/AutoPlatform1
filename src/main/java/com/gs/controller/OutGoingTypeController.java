package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.OutgoingType;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.PagerUtil;
import com.gs.service.OutgoingTypeService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by GZWangBin on 2017/4/18.
 */
@Controller
@RequestMapping("/outGoingType")
public class OutGoingTypeController {

    private Logger logger = (Logger) LoggerFactory.getLogger(FinancialViewController.class);

    /**
     * 支出Service
     */
    @Resource
    public OutgoingTypeService outgoingTypeService;

    @ResponseBody
    @RequestMapping("queryAll")
    public List<OutgoingType> queryAll() {
        logger.info("支出类型分页查询");
        List<OutgoingType> outgoingTypes =  outgoingTypeService.queryAll();
        for (OutgoingType outgoingType1 : outgoingTypes) {
            System.out.printf(outgoingType1 + "aaaaaaaaaaaaaaaaaaaaaaaaaa");
        }
        return outgoingTypes;
    }




}
