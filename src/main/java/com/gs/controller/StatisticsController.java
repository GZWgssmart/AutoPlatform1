package com.gs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * statistic modul page
 *
 * @author chengyan
 * @create 2017-04-11 16:13
 */
@Controller
@RequestMapping("/statistics")
public class StatisticsController {
    @RequestMapping("finance")
    public ModelAndView financePage(){
        ModelAndView mav = new ModelAndView("statistics/finance");
        return mav;
    }

    @RequestMapping("maintaintype")
    public ModelAndView maintainTypePage(){
        ModelAndView mav = new ModelAndView("statistics/maintaintype");
        return mav;
    }

    @RequestMapping("maintain")
    public ModelAndView maintainPage(){
        ModelAndView mav = new ModelAndView("statistics/maintain");
        return mav;
    }

    @RequestMapping("client")
    public ModelAndView clientPage(){
        ModelAndView mav = new ModelAndView("statistics/client");
        return mav;
    }

    @RequestMapping("stock")
    public ModelAndView stockPage(){
        ModelAndView mav = new ModelAndView("statistics/stock");
        return mav;
    }

    @RequestMapping("usematerials")
    public ModelAndView useMaterialsPage(){
        ModelAndView mav = new ModelAndView("statistics/usematerials");
        return mav;
    }
    @RequestMapping("workorder")
    public ModelAndView workOrderPage(){
        ModelAndView mav = new ModelAndView("statistics/workorder");
        return mav;
    }

    @RequestMapping("paysup")
    public ModelAndView paySupPage(){
        ModelAndView mav = new ModelAndView("statistics/paysup");
        return mav;
    }
    @RequestMapping("purchase")
    public ModelAndView purchasePage(){
        ModelAndView mav = new ModelAndView("statistics/purchase");
        return mav;
    }

    @RequestMapping("test")
    public ModelAndView test(){
        ModelAndView mav = new ModelAndView("statistics/test");
        return mav;
    }
}
