package com.gs.controller.basicInfoManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.CarModel;
import com.gs.service.CarBrandService;
import com.gs.service.CarModelService;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
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
    @RequestMapping(value = "queryAll")
    public List<CarModel> queryAll(){
        logger.info("查询所有车型");
        List<CarModel> carModelList = carModelService.queryAll();
        return carModelList;
    }
}
