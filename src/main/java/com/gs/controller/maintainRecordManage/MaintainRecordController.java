package com.gs.controller.maintainRecordManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.MaintainRecord;
import com.gs.common.bean.ControllerResult;
import com.gs.common.util.UUIDUtil;
import com.gs.controller.accessoriesManage.AccessoriesSaleController;
import com.gs.service.MaintainRecordService;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by jyy on 2017/4/19.
 */
@Controller
@RequestMapping("/schedule")
public class MaintainRecordController {
    private Logger logger = (Logger) LoggerFactory.getLogger(AccessoriesSaleController.class);


    @Resource
    private MaintainRecordService maintainRecordService;

    /**
     * 进度添加
     * @param maintainRecord
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "addSchedule",method = RequestMethod.POST)
    public ControllerResult addSchedule(MaintainRecord maintainRecord){
        logger.info("添加成功");
        maintainRecord.setRecordId(UUIDUtil.uuid());
        maintainRecord.setRecordStatus("Y");
        maintainRecordService.insert(maintainRecord);
        return ControllerResult.getSuccessResult("添加成功");
    }

    /**
     * 查询全部进度
     * @return
     */
    @ResponseBody
    @RequestMapping(value="queryAllSchedule",method = RequestMethod.POST)
    public List<MaintainRecord> queryAllSchedule(){
        logger.info("查询进度");
        List<MaintainRecord> maintainRecordsList =maintainRecordService.queryAll();
        return maintainRecordsList;
    }

    /**
     * 修改进度
     * @param maintainRecord
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "updateSchedule",method = RequestMethod.POST)
    public ControllerResult updateSchedule(MaintainRecord maintainRecord){
        System.out.println(maintainRecord.toString());
        maintainRecordService.update(maintainRecord);
        logger.info("修改成功");
        return ControllerResult.getSuccessResult("修改成功");
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
}
