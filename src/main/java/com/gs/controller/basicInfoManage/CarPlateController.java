package com.gs.controller.basicInfoManage;

import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 汽车车牌管理
 * Created by yaoyong on 2017/4/18.
 */
@Controller
@RequestMapping("/carPlate")
public class CarPlateController {

    private Logger logger = (Logger) LoggerFactory.getLogger(CarPlateController.class);
}
