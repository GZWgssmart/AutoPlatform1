package com.gs.controller.supplyManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.SupplyType;
import com.gs.common.bean.ControllerResult;
import com.gs.service.SupplyService;
import com.gs.service.SupplyTypeService;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
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

    /**
     * 查询所有的供应商类型
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "queryAllSupplyType", method = RequestMethod.POST)
    public List<SupplyType> queryAllSupplyType() {
        List<SupplyType> supplyTypeList = supplyTypeService.queryAll();
        if (supplyTypeList != null && !supplyTypeList.equals("")) {
            return supplyTypeList;
        }
        return null;
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
     * 删除供应商类型
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "removeSupplyType", method = RequestMethod.POST)
    public ControllerResult removeSupplyType(String id) {
        if (id != null && !id.equals("")) {
            supplyTypeService.deleteById(id);
            logger.info("删除成功");
            return ControllerResult.getSuccessResult("删除成功");
        } else {
            return ControllerResult.getFailResult("删除失败");
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
