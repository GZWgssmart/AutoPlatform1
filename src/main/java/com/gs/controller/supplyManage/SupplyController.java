package com.gs.controller.supplyManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.AccessoriesBuy;
import com.gs.bean.Supply;
import com.gs.common.bean.ControllerResult;
import com.gs.service.AccessoriesBuyService;
import com.gs.service.SupplyService;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * 钟燕玲 供应商管理
 *
 * Created by Administrator on 2017/4/18.
 */
@Controller
@RequestMapping("/supply")
public class SupplyController {


    @Resource
    private SupplyService supplyService;

    private Logger logger = (Logger) LoggerFactory.getLogger(SupplyController.class);

    /**
     * 查询所有的供应商
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "queryAllSupply", method = RequestMethod.POST)
    public List<Supply> queryAllSupply() {
        List<Supply> supplyList = supplyService.queryAll();
        if (supplyList != null && !supplyList.equals("")) {
            return supplyList;
        }
        return null;
    }

    /**
     * 添加供应商
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "addSupply", method = RequestMethod.POST)
    public ControllerResult addSupply(Supply supply) {
        if (supply != null && !supply.equals("")) {
            System.out.println(supply.toString());
            supplyService.insert(supply);
            logger.info("添加成功");
            return ControllerResult.getSuccessResult("添加成功");
        } else {
            return ControllerResult.getFailResult("添加失败，请输入必要的信息");
        }
    }

    /**
     * 删除供应商
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "removeSupply", method = RequestMethod.POST)
    public ControllerResult removeSupply(String id) {
        if (id != null && !id.equals("")) {
            supplyService.deleteById(id);
            logger.info("删除成功");
            return ControllerResult.getSuccessResult("删除成功");
        } else {
            return ControllerResult.getFailResult("删除失败");
        }
    }

    /**
     * 修改供应商信息
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "updateSupply", method = RequestMethod.POST)
    public ControllerResult updateSupply(Supply supply) {
        if (supply != null && !supply.equals("")) {
            supplyService.update(supply);
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
    public ControllerResult inactive(String supplyId,String supplyStatus){
        if(supplyId!=null&&!supplyId.equals("")&&supplyStatus!=null&&!supplyStatus.equals("")){
            if (supplyStatus.equals("N")){
                supplyService.active(supplyId);
                logger.info("激活成功");
                return ControllerResult.getSuccessResult("激活成功");
            }else{
                supplyService.inactive(supplyId);
                logger.info("禁用成功");
                return ControllerResult.getSuccessResult("禁用成功");
            }
        }else{
            return ControllerResult.getFailResult("操作失败");
        }
    }

}
