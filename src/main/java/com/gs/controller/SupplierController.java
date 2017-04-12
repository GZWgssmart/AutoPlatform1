package com.gs.controller;

import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by AngeJob on 2017/4/12.
 */

@Controller
@RequestMapping("/supplier")
public class SupplierController {
    private Logger logger = (Logger) LoggerFactory.getLogger(SystemManageController.class);



    /**
     * 供货商管理
     * @return
     */
    @RequestMapping(value = "supplierInformation", method = RequestMethod.GET)
    public String supplierInformation() {
        logger.info("供货商管理");
        return "supplier/supplierInFormation";
    }

    /**
     * 供货商分类管理
     * @return
     */
    @RequestMapping(value = "supplierType", method = RequestMethod.GET)
    public String supplierType() {
        logger.info("供货商分类管理");
        return "supplier/supplierType";
    }
}
