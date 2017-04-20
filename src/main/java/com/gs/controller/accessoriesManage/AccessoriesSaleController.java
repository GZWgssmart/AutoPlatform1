package com.gs.controller.accessoriesManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Accessories;
import com.gs.bean.AccessoriesSale;
import com.gs.common.bean.ControllerResult;
import com.gs.service.AccessoriesSaleService;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 王怡 配件销售
 * Created by Administrator on 2017/4/18.
 */
@Controller
@RequestMapping("/accSale")
public class AccessoriesSaleController {

    private Logger logger = (Logger) LoggerFactory.getLogger(AccessoriesSaleController.class);


    @Resource
    private AccessoriesSaleService accessoriesSaleService;

    /**
     * 查询所有的配件销售记录
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "queryAllAccSale",method = RequestMethod.POST)
    public List<AccessoriesSale> queryAllAccSale(){
        List<AccessoriesSale> accessoriesSaleList=accessoriesSaleService.queryAll();
        if(accessoriesSaleList!=null&&!accessoriesSaleList.equals("")){
            return accessoriesSaleList;
        }
        return null;
    }
    /**
     * 添加配件销售记录
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "addAccSale", method = RequestMethod.POST)
    public ControllerResult addAccSale(AccessoriesSale accessoriesSale) {
        if (accessoriesSale!=null&&!accessoriesSale.equals("")){
            accessoriesSaleService.insert(accessoriesSale);
            logger.info("添加成功");
            return ControllerResult.getSuccessResult("添加成功");
        }else{
            return ControllerResult.getSuccessResult("添加成功");
        }
    }

    /**
     * 删除配件销售记录
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "removeAccSale", method = RequestMethod.POST)
    public ControllerResult removeAccSale(String id) {
        if(id!=null&&!id.equals("")){
            accessoriesSaleService.deleteById(id);
            logger.info("删除成功");
            return ControllerResult.getSuccessResult("删除成功");
        }else{
            return ControllerResult.getFailResult("删除失败");
        }
    }

    /**
     * 修改配件销售记录
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "updateAccSale", method = RequestMethod.POST)
    public ControllerResult updateAccSale(AccessoriesSale accessoriesSale) {
        if(accessoriesSale!=null&&!accessoriesSale.equals("")){
            accessoriesSaleService.update(accessoriesSale);
            logger.info("更新成功");
            return ControllerResult.getSuccessResult("更新成功");
        }else{
            return ControllerResult.getFailResult("更新失败");
        }
    }

    /**
     * 对状态的激活和启用，只使用一个方法进行切换。
     */
    @ResponseBody
    @RequestMapping(value = "statusOperate",method = RequestMethod.POST)
    public ControllerResult inactive(String accSaleId,String accSaleStatus){
        if(accSaleId!=null&&!accSaleId.equals("")&&accSaleStatus!=null&&!accSaleStatus.equals("")){
            if (accSaleStatus.equals("N")){
                accessoriesSaleService.active(accSaleId);
                logger.info("激活成功");
                return ControllerResult.getSuccessResult("激活成功");
            }else{
                accessoriesSaleService.inactive(accSaleId);
                logger.info("禁用成功");
                return ControllerResult.getSuccessResult("禁用成功");
            }
        }else{
            return ControllerResult.getFailResult("操作失败");
        }
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
}