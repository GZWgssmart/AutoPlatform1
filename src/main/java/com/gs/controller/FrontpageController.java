package com.gs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by 郭昶 on 2017/4/12.
 * 链接到前台页面
 */

@Controller
@RequestMapping("/front")
public class FrontpageController {
    /**
     * 前台主页
     */
    @RequestMapping(value = "/home",method = RequestMethod.GET)
    public String GoHome() {
        return "Frontpage/home";
    }
}
