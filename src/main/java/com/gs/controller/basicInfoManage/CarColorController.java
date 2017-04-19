package com.gs.controller.basicInfoManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.CarColor;
import com.gs.service.CarColorService;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * 汽车颜色管理
 * Created by yaoyong on 2017/4/18.
 */

@Controller
@RequestMapping("/carColor")
public class CarColorController {

    @Resource
    private CarColorService carColorService;

    private Logger logger = (Logger) LoggerFactory.getLogger(CarColorController.class);

    @ResponseBody
    @RequestMapping(value = "queryByPager")
    public List<CarColor> queryAll(){
        logger.info("查询所有汽车颜色");
        List<CarColor> carColorList = carColorService.queryAll();
        return carColorList;
    }
}
