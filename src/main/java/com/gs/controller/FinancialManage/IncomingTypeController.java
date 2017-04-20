package com.gs.controller.FinancialManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Checkin;
import com.gs.bean.IncomingType;
import com.gs.bean.OutgoingType;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.UUIDUtil;
import com.gs.controller.FinancialViewController;
import com.gs.service.IncomingTypeService;
import com.gs.service.OutgoingTypeService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by GZWangBin on 2017/4/18.
 */
@Controller
@RequestMapping("/incomingType")
public class IncomingTypeController {

    private Logger logger = (Logger) LoggerFactory.getLogger(IncomingTypeController.class);

    /**
     * 收入Service
     */
    @Resource
    public IncomingTypeService incomingTypeService;

    @ResponseBody
    @RequestMapping(value = "queryByPager",method = RequestMethod.GET)
    public Pager4EasyUI<IncomingType> queryByPager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("收入类型分页查询");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(incomingTypeService.count());
        List<IncomingType> incomingTypes = incomingTypeService.queryByPager(pager);
        return new Pager4EasyUI<IncomingType>(pager.getTotalRecords(), incomingTypes);
    }

    @ResponseBody
    @RequestMapping(value = "queryByPagerDisable",method = RequestMethod.GET)
    public Pager4EasyUI<IncomingType> queryByPagerDisable(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("收入类型分页查询");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(incomingTypeService.countByDisable());
        List<IncomingType> incomingTypes = incomingTypeService.queryByPagerDisable(pager);
        return new Pager4EasyUI<IncomingType>(pager.getTotalRecords(), incomingTypes);
    }


    @ResponseBody
    @RequestMapping(value = "inactive",method = RequestMethod.POST)
    public ControllerResult inactive(String id) {
        logger.info("禁用");
        incomingTypeService.inactive(id);
        return ControllerResult.getSuccessResult("禁用成功");
    }

    @ResponseBody
    @RequestMapping(value = "active",method = RequestMethod.POST)
    public ControllerResult active(String id) {
        logger.info("激活");
        incomingTypeService.active(id);
        return ControllerResult.getSuccessResult("激活成功");
    }

    @ResponseBody
    @RequestMapping(value = "add",method = RequestMethod.POST)
    public ControllerResult add(IncomingType incomingType) {
        logger.info("添加收入类型");
        incomingType.setInTypeId(UUIDUtil.uuid());
        incomingType.setInTypeStatus("Y");
        incomingTypeService.insert(incomingType);
        return ControllerResult.getSuccessResult("添加成功");
    }

    /**
     * 验证收入类型名称
     * @param inTypeName
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "checkInTypeName", method = RequestMethod.GET)
    public boolean checkInTypeName(String inTypeName) {
        IncomingType incomingType = incomingTypeService.queryById(inTypeName);
        if(incomingType != null){
            return true;
        }
        return false;
    }


    @ResponseBody
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public ControllerResult update(IncomingType incomingType) {
        logger.info("修改收入类型");
        incomingTypeService.update(incomingType);
        return ControllerResult.getSuccessResult("修改成功");
    }


}
