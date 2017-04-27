package com.gs.controller.basicInfoManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.CarPlate;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.UUIDUtil;
import com.gs.service.CarPlateService;
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
 * 汽车车牌管理
 * Created by yaoyong on 2017/4/18.
 */
@Controller
@RequestMapping("/carPlate")
public class CarPlateController {

    private Logger logger = (Logger) LoggerFactory.getLogger(CarPlateController.class);

    @Resource
    private CarPlateService carPlateService;

    @ResponseBody
    @RequestMapping(value="queryByPagerCarPlate", method = RequestMethod.GET)
    public Pager4EasyUI<CarPlate> queryByPager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("分页查询所有车牌");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(carPlateService.count());
        List<CarPlate> carPlates = carPlateService.queryByPager(pager);
        return new Pager4EasyUI<CarPlate>(pager.getTotalRecords(), carPlates);
    }

    @ResponseBody
    @RequestMapping(value = "queryAllCarPlate", method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryAll(){
        logger.info("查询所有车牌");
        List<CarPlate> carPlates = carPlateService.queryAll();
        List<ComboBox4EasyUI> comboxs = new ArrayList<ComboBox4EasyUI>();
        for(CarPlate c : carPlates){
            ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
            comboBox4EasyUI.setId(c.getPlateId());
            comboBox4EasyUI.setText(c.getPlateName());
            comboxs.add(comboBox4EasyUI);
        }
        return comboxs;
    }

    @ResponseBody
    @RequestMapping(value = "addCarPlate",method = RequestMethod.POST)
    public ControllerResult add(CarPlate carPlate) {
        if (carPlate != null && !carPlate.equals("")) {
            logger.info("添加车牌信息");
            carPlateService.insert(carPlate);
            return ControllerResult.getSuccessResult("添加成功");
        }else {
            return ControllerResult.getFailResult("添加失败，请输入必要的信息");
        }
    }

    @ResponseBody
    @RequestMapping(value = "updateCarPlate", method = RequestMethod.POST)
    public ControllerResult updateCarPlate(CarPlate carPlate) {
        if (carPlate != null && !carPlate.equals("")) {
            logger.info("修改车牌信息");
            carPlateService.update(carPlate);
            return ControllerResult.getSuccessResult("修改成功");
        }else {
            return ControllerResult.getFailResult("修改失败，请输入必要的信息");
        }
    }

    /**
     * 查询所有被禁用的汽车车牌
     * @return
     */
    @ResponseBody
    @RequestMapping(value="queryByPagerDisable", method = RequestMethod.GET)
    public Pager4EasyUI<CarPlate> queryByPagerDisable(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("分页查询所有被禁用汽车车牌");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(carPlateService.countByDisable());
        List<CarPlate> carPlates = carPlateService.queryByPagerDisable(pager);
        return new Pager4EasyUI<CarPlate>(pager.getTotalRecords(), carPlates);
    }

    /**
     * 对状态的激活和启用，只使用一个方法进行切换。
     */
    @ResponseBody
    @RequestMapping(value = "statusOperate", method = RequestMethod.POST)
    public ControllerResult inactive(String id, String status) {
        if (id != null && !id.equals("") && status != null && !status.equals("")) {
            if (status.equals("N")) {
                carPlateService.active(id);
                logger.info("激活成功");
                return ControllerResult.getSuccessResult("激活成功");
            } else {
                carPlateService.inactive(id);
                logger.info("禁用成功");
                return ControllerResult.getSuccessResult("禁用成功");
            }
        } else {
            return ControllerResult.getFailResult("操作失败");
        }
    }
}
