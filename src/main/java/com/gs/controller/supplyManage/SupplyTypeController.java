package com.gs.controller.supplyManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.CarColor;
import com.gs.bean.Supply;
import com.gs.bean.SupplyType;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.SupplyTypeService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 钟燕玲 供应商类型管理
 * Created by Administrator on 2017/4/18.
 */
@Controller
@RequestMapping("/supplyType")
public class SupplyTypeController {


    @Resource
    private SupplyTypeService supplyTypeService;
    private Logger logger = (Logger) LoggerFactory.getLogger(SupplyTypeController.class);

    /*
        查询全部供应商类型
     */
    @ResponseBody
    @RequestMapping(value = "queryAllSupplyType",method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryAll(){
        logger.info("查询全部供应商类型");
        List<SupplyType> supplyTypes = supplyTypeService.queryAll();
        List<ComboBox4EasyUI> comboxs = new ArrayList<ComboBox4EasyUI>();
        for(SupplyType st : supplyTypes){
            ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
            comboBox4EasyUI.setId(st.getSupplyTypeId());
            comboBox4EasyUI.setText(st.getSupplyTypeName());
            comboxs.add(comboBox4EasyUI);
        }
        return comboxs;
    }


    /**
     * 分页查询所有的供应商类型
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "queryByPager",method = RequestMethod.GET)
    public Pager4EasyUI<SupplyType> queryByPager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("供应商类型分页查询");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(supplyTypeService.count());
        List<SupplyType> supplyTypeList = supplyTypeService.queryByPager(pager);
        return new Pager4EasyUI<SupplyType>(pager.getTotalRecords(), supplyTypeList);
    }

    @ResponseBody
    @RequestMapping(value = "queryByPagerDisable",method = RequestMethod.GET)
    public Pager4EasyUI<SupplyType> queryByPagerDisable(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("供应商类型禁用分页查询");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(supplyTypeService.countByDisable());
        List<SupplyType> supplyTypeList = supplyTypeService.queryByPagerDisable(pager);
        return new Pager4EasyUI<SupplyType>(pager.getTotalRecords(), supplyTypeList);
    }

    /**
     * 添加供应商类型
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "addSupplyType", method = RequestMethod.POST)
    public ControllerResult addSupplyType(SupplyType supplyType) {
        if (supplyType != null && !supplyType.equals("")) {
            System.out.println(supplyType.toString());
            supplyTypeService.insert(supplyType);
            logger.info("添加成功");
            return ControllerResult.getSuccessResult("添加成功");
        } else {
            return ControllerResult.getFailResult("添加失败，请输入必要的信息");
        }
    }


    /**
     * 修改供应商类型信息
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "updateSupplyType", method = RequestMethod.POST)
    public ControllerResult updateSupplyType(SupplyType supplyType) {
        if (supplyType != null && !supplyType.equals("")) {
            supplyTypeService.update(supplyType);
            logger.info("修改成功");
            return ControllerResult.getSuccessResult("修改成功");
        } else {
            return ControllerResult.getFailResult("修改失败");
        }
    }

    /**
     * 对状态的激活和启用，只使用一个方法进行切换。
     */
    @ResponseBody
    @RequestMapping(value = "statusOperate",method = RequestMethod.POST)
    public ControllerResult inactive(String supplyTypeId,String supplyTypeStatus){
        if(supplyTypeId!=null&&!supplyTypeId.equals("")&&supplyTypeStatus!=null&&!supplyTypeStatus.equals("")){
            if (supplyTypeStatus.equals("N")){
                supplyTypeService.active(supplyTypeId);
                logger.info("激活成功");
                return ControllerResult.getSuccessResult("激活成功");
            }else{
                supplyTypeService.inactive(supplyTypeId);
                logger.info("禁用成功");
                return ControllerResult.getSuccessResult("禁用成功");
            }
        }else{
            return ControllerResult.getFailResult("操作失败");
        }
    }

}
