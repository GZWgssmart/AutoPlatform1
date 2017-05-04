package com.gs.controller.maintainScheduleManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.MaintainSchedule;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.MaintainScheduleService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by jyy on 2017/5/4.
 */

@Controller
@RequestMapping("/maintainSchedule")
public class MaintainScheduleController {

    @Resource
    private MaintainScheduleService maintainScheduleService;
    private Logger logger = (Logger) LoggerFactory.getLogger(MaintainScheduleController.class);

    /**
     * 查询全部维修保养进度管理
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "queryALLschedule", method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryAllSchedule(){
        logger.info("查询全部维修保养进度管理");
        List<MaintainSchedule> maintainSchedules = maintainScheduleService.queryAll();
        List<ComboBox4EasyUI> comboxs = new ArrayList<ComboBox4EasyUI>();
        for(MaintainSchedule m : maintainSchedules){
            ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
            comboBox4EasyUI.setId(m.getMaintainScheduleId());
            comboBox4EasyUI.setText(m.getMaintainScheduleId());
        }
        return comboxs;
    }

    /**
     * 分页查询进度管理
     * @param pageNumber
     * @param PageSize
     * @return
     */
    @ResponseBody
    @RequestMapping(value="queryByPage", method=RequestMethod.GET)
    public Pager4EasyUI queryByPager(@Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize){
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(maintainScheduleService.count());
        logger.info("分页查询维修保养进度管理成功");
        List<MaintainSchedule> maintainSchedules = maintainScheduleService.queryByPager(pager);
        return new Pager4EasyUI<MaintainSchedule>(pager.getTotalRecords(), maintainSchedules);
    }

}
