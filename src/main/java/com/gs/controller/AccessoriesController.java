package com.gs.controller;

import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by XiaoQiao on 2017/4/11.
 */
@Controller
@RequestMapping("/accessories")
public class AccessoriesController {

    private Logger logger = (Logger) LoggerFactory.getLogger(AccessoriesController.class);

    @RequestMapping("type")
    public ModelAndView accessories_type() {
        return new ModelAndView("accessories/accessories_type");
    }

    @RequestMapping("accessories")
    public ModelAndView accessories() {
        return new ModelAndView("accessories/accessories");
    }

    @RequestMapping("buy")
    public ModelAndView accessories_buy() {
        return new ModelAndView("accessories/accessories_buy");
    }

    @RequestMapping("sale")
    public ModelAndView accessories_sale() {
        return new ModelAndView("accessories/accessories_sale");
    }
}
