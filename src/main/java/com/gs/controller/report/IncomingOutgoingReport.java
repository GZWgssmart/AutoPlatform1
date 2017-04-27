package com.gs.controller.report;

import com.gs.bean.IncomingOutgoing;
import com.gs.service.IncomingOutgoingService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Shinelon on 2017/4/27.
 */
@Controller
@RequestMapping("ioReport")
public class IncomingOutgoingReport  {

    @Resource
    private IncomingOutgoingService incomingOutgoingService;

    @ResponseBody
    @RequestMapping("queryAll")
    public List<IncomingOutgoing> queryAll() {
        List<IncomingOutgoing> list = incomingOutgoingService.queryAll();
        return list;
    }

    @ResponseBody
    @RequestMapping(value = "queryByTime", method = RequestMethod.GET)
    public List<IncomingOutgoing> queyrByTime(String start, String end) {
        List<IncomingOutgoing> incomingOutgoings = incomingOutgoingService.queryByDate(start, end);
        return incomingOutgoings;
    }

}



