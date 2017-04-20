package com.gs.controller.FinancialManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.IncomingOutgoing;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.IncomingOutgoingService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by GZWangBin on 2017/4/20.
 */
@Controller
@RequestMapping("incomingOutgoing")
public class IncomingOutgoingController {

    private Logger logger = (Logger) LoggerFactory.getLogger(IncomingOutgoingController.class);

    /**
     * 收入Service
     */
    @Resource
    public IncomingOutgoingService incomingOutgoingService;

    @ResponseBody
    @RequestMapping(value = "queryByPager",method = RequestMethod.GET)
    public Pager4EasyUI<IncomingOutgoing> queryByPager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("收入类型分页查询");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(incomingOutgoingService.count());
        List<IncomingOutgoing> incomingOutgoings = incomingOutgoingService.queryByPager(pager);
        return new Pager4EasyUI<IncomingOutgoing>(pager.getTotalRecords(), incomingOutgoings);
    }

    @ResponseBody
    @RequestMapping(value = "queryByPagerDisable",method = RequestMethod.GET)
    public Pager4EasyUI<IncomingOutgoing> queryByPagerDisable(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("收入类型分页查询");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(incomingOutgoingService.countByDisable());
        List<IncomingOutgoing> incomingOutgoings = incomingOutgoingService.queryByPagerDisable(pager);
        return new Pager4EasyUI<IncomingOutgoing>(pager.getTotalRecords(), incomingOutgoings);
    }


    @ResponseBody
    @RequestMapping(value = "inactive",method = RequestMethod.POST)
    public ControllerResult inactive(String id) {
        logger.info("禁用");
        incomingOutgoingService.inactive(id);
        return ControllerResult.getSuccessResult("禁用成功");
    }

    @ResponseBody
    @RequestMapping(value = "active",method = RequestMethod.POST)
    public ControllerResult active(String id) {
        logger.info("激活");
        incomingOutgoingService.active(id);
        return ControllerResult.getSuccessResult("激活成功");
    }

    @ResponseBody
    @RequestMapping(value = "add",method = RequestMethod.POST)
    public ControllerResult add(IncomingOutgoing incomingOutgoing) {
        logger.info("添加收入类型");
        incomingOutgoingService.insert(incomingOutgoing);
        return ControllerResult.getSuccessResult("添加成功");
    }



    @ResponseBody
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public ControllerResult update(IncomingOutgoing incomingOutgoing) {
        logger.info("修改收入类型");
        incomingOutgoingService.update(incomingOutgoing);
        return ControllerResult.getSuccessResult("修改成功");
    }
}
