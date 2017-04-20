package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.IncomingType;
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
    @RequestMapping(value = "queryByPager",method = RequestMethod.GET)
    public Pager4EasyUI<OutgoingType> queryByPager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("支出类型分页查询");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(outgoingTypeService.count());
        List<OutgoingType> outgoingTypes = outgoingTypeService.queryByPager(pager);
        return new Pager4EasyUI<OutgoingType>(pager.getTotalRecords(), outgoingTypes);
    }

    @ResponseBody
    @RequestMapping(value = "queryByPagerDisable",method = RequestMethod.GET)
    public Pager4EasyUI<OutgoingType> queryByPagerDisable(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("支出类型分页查询");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(outgoingTypeService.countByDisable());
        List<OutgoingType> outgoingTypes = outgoingTypeService.queryByPagerDisable(pager);
        return new Pager4EasyUI<OutgoingType>(pager.getTotalRecords(), outgoingTypes);
    }

    @ResponseBody
    @RequestMapping(value = "inactive",method = RequestMethod.POST)
    public ControllerResult inactive(String id) {
        logger.info("禁用");
        outgoingTypeService.inactive(id);
        return ControllerResult.getSuccessResult("禁用成功");
    }

    @ResponseBody
    @RequestMapping(value = "active",method = RequestMethod.POST)
    public ControllerResult active(String id) {
        logger.info("激活");
        outgoingTypeService.active(id);
        return ControllerResult.getSuccessResult("激活成功");
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
