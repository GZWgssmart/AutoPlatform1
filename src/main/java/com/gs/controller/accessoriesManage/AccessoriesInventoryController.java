package com.gs.controller.accessoriesManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Accessories;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.AccessoriesService;
import com.gs.service.AccessoriesTypeService;
import org.apache.ibatis.annotations.Param;
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
 * Created by Administrator on 2017/4/20.
 */
@Controller
@RequestMapping("/accInv")
public class AccessoriesInventoryController {
    private Logger logger = (Logger) LoggerFactory.getLogger(AccessoriesInventoryController.class);

    @Resource
    private AccessoriesService accessoriesService;

    /**
     * 查询所有的配件库存信息
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "queryAllAccInv", method = RequestMethod.POST)
    public List<Accessories> queryAllAccInv() {
        List<Accessories> accessoriesList = accessoriesService.queryAll();
        if (accessoriesList != null && !accessoriesList.equals("")) {
            return accessoriesList;
        }
        return null;
    }

    /**
     * 分页查询配件库存信息
     */
    @ResponseBody
    @RequestMapping(value="queryByPage", method = RequestMethod.GET)
    public Pager4EasyUI queryByPager(@Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(accessoriesService.count());
        logger.info("分页查询配件库存信息成功");
        List<Accessories> accessories = accessoriesService.queryByPager(pager);
        return new Pager4EasyUI<Accessories>(pager.getTotalRecords(), accessories);
    }

    /**
     * 添加添加配件到库存
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "addAccInv", method = RequestMethod.POST)
    public ControllerResult addAccInv(Accessories accessories) {
        if(accessories!=null&&!accessories.equals("")){
            accessoriesService.insert(accessories);
            logger.info("添加成功");
            return ControllerResult.getSuccessResult("添加成功");
        }else{
            return ControllerResult.getFailResult("添加失败");
        }
    }

    /**
     * 移除库存
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "removeAccInv", method = RequestMethod.POST)
    public ControllerResult removeAccInv(String accId) {
        if(accId!=null&&!accId.equals("")){
            accessoriesService.deleteById(accId);
            logger.info("删除成功");
            return ControllerResult.getSuccessResult("删除成功");
        }else{
            return ControllerResult.getFailResult("删除失败");
        }
    }

    /**
     * 更新库存信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "updateAccInv", method = RequestMethod.POST)
    public ControllerResult updateAccInv(Accessories accessories) {
        if(accessories!=null&&!accessories.equals("")){
            accessoriesService.update(accessories);
            logger.info("更新成功");
            return ControllerResult.getSuccessResult("更新成功");
        }else{
            return ControllerResult.getFailResult("更新失败");
        }
    }

    /**
     * 查询所有被禁用的登记记录
     * @return
     */
    @ResponseBody
    @RequestMapping(value="queryByPagerDisable", method = RequestMethod.GET)
    public Pager4EasyUI<Accessories> queryByPagerDisable(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("分页查询所有被禁用登记记录");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(accessoriesService.countByDisable());
        List<Accessories> accessories = accessoriesService.queryByPagerDisable(pager);
        return new Pager4EasyUI<Accessories>(pager.getTotalRecords(), accessories);
    }

    /**
     * 对状态的激活和启用，只使用一个方法进行切换。
     */
    @ResponseBody
    @RequestMapping(value = "statusOperate", method = RequestMethod.POST)
    public ControllerResult inactive(String accId, String accStatus) {
        if (accId != null && !accId.equals("") && accStatus != null && !accStatus.equals("")) {
            if (accStatus.equals("N")) {
                accessoriesService.active(accId);
                logger.info("激活成功");
                return ControllerResult.getSuccessResult("激活成功");
            } else {
                accessoriesService.inactive(accId);
                logger.info("禁用成功");
                return ControllerResult.getSuccessResult("禁用成功");
            }
        } else {
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
