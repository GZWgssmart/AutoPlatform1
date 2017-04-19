package com.gs.controller.basicInfoManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.CarBrand;
import com.gs.common.bean.ControllerResult;
import com.gs.common.util.UUIDUtil;
import com.gs.service.CarBrandService;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import javax.annotation.Resource;
import java.util.List;

/**
 * 汽车品牌管理
 * Created by yaoyong on 2017/4/18.
 */
@Controller
@RequestMapping("/arBrand")
public class CarBrandController {

    private Logger logger = (Logger) LoggerFactory.getLogger(CarBrandController.class);

    @Resource
    private CarBrandService carBrandService;


    @ResponseBody
    @RequestMapping(value = "queryAll")
    public List<CarBrand> queryAll() {
        logger.info("查询所有汽车品牌");
        List<CarBrand> carBrand = carBrandService.queryAll();
        return carBrand;
    }

    @ResponseBody
    @RequestMapping(value = "add",method = RequestMethod.POST)
    public ControllerResult add(CarBrand carBrand){
        logger.info("添加汽车品牌");
        carBrand.setBrandId(UUIDUtil.uuid());
        carBrand.setBrandStatus("Y");
        carBrandService.insert(carBrand);
        return ControllerResult.getSuccessResult("添加成功");
    }

    @ResponseBody
    @RequestMapping(value = "update",method = RequestMethod.POST)
    public ControllerResult update(CarBrand carBrand){
        logger.info("修改汽车品牌");
        System.out.println(carBrand.getBrandId() + "," + carBrand.getBrandName() + "," + carBrand.getBrandDes() + "修改汽车品牌测试");
        carBrandService.update(carBrand);
        return ControllerResult.getSuccessResult("修改成功");
    }

}
