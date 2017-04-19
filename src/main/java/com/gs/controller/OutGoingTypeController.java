package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.OutgoingType;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.PagerUtil;
import com.gs.common.util.UUIDUtil;
import com.gs.service.OutgoingTypeService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
    @RequestMapping(value = "queryAll",method = RequestMethod.POST)
    public List<OutgoingType> queryAll() {
        logger.info("支出类型分页查询");
        List<OutgoingType> outgoingTypes =  outgoingTypeService.queryAll();
        return outgoingTypes;
    }

    @RequestMapping(value = "inactive",method = RequestMethod.POST)
    public ModelAndView inactive(String id) {
        logger.info("禁用");
        outgoingTypeService.inactive(id);
        return new ModelAndView("queryAll");
    }

    @RequestMapping(value = "active",method = RequestMethod.POST)
    public ModelAndView active(String id) {
        logger.info("激活");
        outgoingTypeService.active(id);
        return new ModelAndView("queryAll");
    }

    @ResponseBody
    @RequestMapping(value = "add",method = RequestMethod.POST)
    public ControllerResult add(OutgoingType outgoingType) {
        logger.info("添加支出类型");
        outgoingType.setOutTypeId(UUIDUtil.uuid());
        outgoingType.setOutTypeStatus("Y");
        System.out.printf(outgoingType.getOutTypeName() + "ccccccccccccccccc");
        outgoingTypeService.insert(outgoingType);
        return ControllerResult.getSuccessResult("添加成功");
    }

    @ResponseBody
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public ControllerResult update(OutgoingType outgoingType) {
        System.out.printf(outgoingType.getOutTypeId() +"," + outgoingType.getOutTypeName());
        logger.info("修改支出类型");
        outgoingTypeService.update(outgoingType);
        return ControllerResult.getSuccessResult("修改成功");
    }


}
