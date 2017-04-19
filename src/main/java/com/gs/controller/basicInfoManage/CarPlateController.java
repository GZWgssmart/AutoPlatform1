package com.gs.controller.basicInfoManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.CarPlate;
import com.gs.service.CarPlateService;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Calendar;
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
    @RequestMapping(value = "queryByPager")
    public List<CarPlate> queryAll(){
        logger.info("查询所有车牌");
        List<CarPlate> carPlateList = carPlateService.queryAll();
        return carPlateList;
    }
}
