package com.gs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by 郭昶 on 2017/4/12.
 * 链接到前台页面
 */

@Controller
@RequestMapping("/")
public class FrontpageController {

    /*下载页面*/
    @RequestMapping(value ="platformIntro",method = RequestMethod.GET)
    public String Goplatform(){
        return "Frontpage/PlatformIntro";
    }

    /*主页面*/
    @RequestMapping(value ="home",method = RequestMethod.GET)
    public String Home(){
        return "Frontpage/Frontindex";
    }

    /*商家列表页面*/
    @RequestMapping(value ="factorypage",method = RequestMethod.GET)
    public String Homes(){
        return "Frontpage/Factorypage";
    }

    /*商家详情页面*/
    @RequestMapping(value = "factorydeta",method = RequestMethod.GET)
    public String deta(){
        return "Frontpage/Factorydeta";
    }

    /*预约页面*/
    @RequestMapping(value ="resepage",method=RequestMethod.GET)
    public String resepage(){
        return "Frontpage/resepage";
    }

    /*用户登录注册页面*/
    @RequestMapping(value ="reg",method = RequestMethod.GET)
    public String reg(){
        return "Frontpage/registered";
    }
}
