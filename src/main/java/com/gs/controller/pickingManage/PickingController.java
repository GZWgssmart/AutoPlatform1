package com.gs.controller.pickingManage;

import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by yaoyong 2017/4/11.
 * 派工领料管理
 */

@Controller
@RequestMapping("/pickingControll")
public class PickingController {

    private Logger logger = (Logger) LoggerFactory.getLogger(PickingController.class);

    /**
     * 物料清单
     */
    @RequestMapping(value = "materialsIndex",method = RequestMethod.GET)
    public String materialsIndex(){
        logger.info("跳转到物料清单页面");
        return "picking/materials";
    }

    /**
     * 指派员工
     */
    @RequestMapping(value = "assignstaffIndex",method = RequestMethod.GET)
    public String assignstaffIndex(){
        logger.info("跳转到指派员工页面");
        return "picking/assignstaff";
    }

    /**
     * 领料管理
     */
    @RequestMapping(value="acquisitionIndex",method = RequestMethod.GET)
    public String acquisitionIndex(){
        logger.info("跳转到领料管理页面");
        return "picking/acquisition";
    }

    /**
     * 退料管理
     */
    @RequestMapping(value = "returnedIndex",method = RequestMethod.GET)
    public String returnedIndex(){
        logger.info("跳转到退料管理页面");
        return "picking/returned";
    }
}
