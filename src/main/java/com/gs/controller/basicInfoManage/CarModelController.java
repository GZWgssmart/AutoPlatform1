package com.gs.controller.basicInfoManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.CarModel;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.CarBrandService;
import com.gs.service.CarModelService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 汽车品牌管理
 * Created by yaoyong on 2017/4/18.
 */

@Controller
@RequestMapping("/carModel")
public class CarModelController {

    private Logger logger = (Logger) LoggerFactory.getLogger(CarModelController.class);

    @Resource
    private CarModelService carModelService;

    @ResponseBody
    @RequestMapping(value = "queryAllCarBrand",method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryAll(){
        logger.info("查询所有汽车品牌");
        List<CarModel> carModels = carModelService.queryAll();
        List<ComboBox4EasyUI> comboxs = new ArrayList<ComboBox4EasyUI>();
        for(CarModel c : carModels){
            ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
            comboBox4EasyUI.setId(c.getModelId());
            comboBox4EasyUI.setText(c.getModelName());
            comboxs.add(comboBox4EasyUI);
        }
        return comboxs;
    }

    @ResponseBody
    @RequestMapping(value="queryByPagerCarModel",method = RequestMethod.GET)
    public Pager4EasyUI<CarModel> queryByPager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("分页查询所有车型");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(carModelService.count());
        List<CarModel> carModels = carModelService.queryByPager(pager);
        return new Pager4EasyUI<CarModel>(pager.getTotalRecords(), carModels);
    }

    @ResponseBody
    @RequestMapping(value = "queryByBrandId/{id}", method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryByBrandId(@PathVariable ("id") String id){
        List<CarModel> carModels = carModelService.queryByBrandId(id);
        List<ComboBox4EasyUI> comboxs = new ArrayList<ComboBox4EasyUI>();
        for(CarModel c : carModels){
            ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
            comboBox4EasyUI.setId(c.getModelId());
            comboBox4EasyUI.setText(c.getModelName());
            comboxs.add(comboBox4EasyUI);
        }
        return comboxs;
    }

    @ResponseBody
    @RequestMapping(value = "addCarModel",method = RequestMethod.POST)
    public ControllerResult add(CarModel carModel){
        if (carModel != null && !carModel.equals("")) {
            logger.info("添加汽车车型");
            carModelService.insert(carModel);
            return ControllerResult.getSuccessResult("添加成功");
        }else {
            return ControllerResult.getFailResult("添加失败，请输入必要的信息");
        }
    }


    @ResponseBody
    @RequestMapping(value = "updateCarModel",method = RequestMethod.POST)
    public ControllerResult update(CarModel carModel){
        if (carModel != null && !carModel.equals("")) {
            logger.info("修改汽车车型");
            carModelService.update(carModel);
            return ControllerResult.getSuccessResult("修改成功");
        }else {
            return ControllerResult.getFailResult("修改失败，请输入必要的信息");
        }
    }
}
