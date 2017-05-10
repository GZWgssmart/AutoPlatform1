package com.gs.controller;

import org.omg.CORBA.Request;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by 不曾有黑夜 on 2017/5/9.
 * 用户个人中心页面
 */

@Controller
@RequestMapping("/")
public class UserIndexController {

    /*欢迎页面*/
    @RequestMapping(value = "welcome",method = RequestMethod.GET)
    public String welcome(){
        return "Frontpage/Personalcenter/AccountSettings/welcome";
    }


    /*账号信息页面*/
    @RequestMapping(value = "accountinfo",method = RequestMethod.GET)
    public String accountinfo(){
        return "Frontpage/Personalcenter/AccountSettings/accountinformation";
    }

    /*修改密码页面*/
    @RequestMapping(value = "editpwd",method = RequestMethod.GET)
    public String editpwd(){
        return "Frontpage/Personalcenter/AccountSettings/editpwd";
    }

    /*我的预约*/
    @RequestMapping(value = "myrese",method = RequestMethod.GET)
    public String myrese(){
        return "Frontpage/Personalcenter/reservation/reservation";
    }

    /*维修保养记录*/
    @RequestMapping(value = "userrese",method = RequestMethod.GET)
    public String userrese(){
        return "Frontpage/Personalcenter/maintain/reserecording";
    }

    /*维修保养提醒*/
    @RequestMapping(value = "prompt",method = RequestMethod.GET)
    public String prompt(){
        return "Frontpage/Personalcenter/maintain/prompt";
    }

    /*维修保养进度*/
    @RequestMapping(value = "schedule",method = RequestMethod.GET)
    public String schedule(){
        return "Frontpage/Personalcenter/maintain/schedule";
    }
    /*维修保养明细*/
    @RequestMapping(value ="details",method = RequestMethod.GET)
    public String details(){
        return "Frontpage/Personalcenter/maintain/details";
    }
    /*消费记录*/
    @RequestMapping(value = "conrecord",method = RequestMethod.GET)
    public String conrecord(){
        return "Frontpage/Personalcenter/Consumptionstatistics/Consumptionrecord";
    }

    /*收费单据*/
    @RequestMapping(value = "cdocument",method = RequestMethod.GET)
    public String cdocument(){
        return "Frontpage/Personalcenter/Consumptionstatistics/Chargedocuments";
    }

    /*我的评价*/
    @RequestMapping(value="mycomment",method = RequestMethod.GET)
    public String myComment(){
        return "Frontpage/Personalcenter/Consumptionstatistics/mycomment";
    }
}
