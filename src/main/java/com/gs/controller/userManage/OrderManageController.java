package com.gs.controller.userManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.WorkInfo;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.UUIDUtil;
import com.gs.service.WorkInfoService;
import org.apache.ibatis.annotations.Param;
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
 * Created by jyy on 2017/4/20.
 */
@Controller
@RequestMapping("/Order")
public class OrderManageController {

    private Logger logger= (Logger) LoggerFactory.getLogger(OrderManageController.class);

    @Resource
    private WorkInfoService workInfoService;

  /* *
     * 查询所有订单
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "queryAll",method = RequestMethod.GET)
    public List<WorkInfo> queryAllWork(){
        logger.info("查询所有订单");
        List<WorkInfo> workInfosList = workInfoService.queryAll();
        return workInfosList;
    }


    /**
     * 分页查询
     * @param pageNumber
     * @param pageSize
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "queryByPager",method = RequestMethod.GET)
    public Pager4EasyUI<WorkInfo> queryByPager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("收入类型分页查询");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(workInfoService.count());
        List<WorkInfo> workInfosList = workInfoService.queryByPager(pager);
        return new Pager4EasyUI<WorkInfo>(pager.getTotalRecords(), workInfosList);
    }

    /**
     *添加订单
     * @param workInfo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "add",method = RequestMethod.GET)
    public ControllerResult addWork(WorkInfo workInfo) {
        logger.info("添加订单");
        workInfo.setUserId(UUIDUtil.uuid());
        workInfo.setWorkStatus("N");
        workInfoService.insert(workInfo);
        return ControllerResult.getSuccessResult("添加成功");
    }

    /**
     * 修改订单
     * @param workInfo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "edit", method = RequestMethod.GET)
    public ControllerResult updateWork(WorkInfo workInfo) {
        logger.info("修改订单");
        workInfoService.update(workInfo);
        return ControllerResult.getSuccessResult("修改成功");
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "deleteById", method = RequestMethod.GET)
    public ControllerResult deleteWork(String id) {
        logger.info("删除");
        workInfoService.deleteById(id);
        return ControllerResult.getSuccessResult("删除成功");
    }

    /**
     * 对状态的激活和启用，只使用一个方法进行切换。
     */
    @ResponseBody
    @RequestMapping(value = "statusWork",method = RequestMethod.GET)
    public ControllerResult inactive(String workId,String workStatus){
        if(workId!=null&&!workId.equals("")&&workStatus!=null&&!workStatus.equals("")){
            if (workStatus.equals("N")){
                workInfoService.active(workId);
                logger.info("激活成功");
                return ControllerResult.getSuccessResult("激活成功");
            }else{
                workInfoService.inactive(workId);
                logger.info("禁用成功");
                return ControllerResult.getSuccessResult("禁用成功");
            }
        }else{
            return ControllerResult.getFailResult("操作失败");
        }
    }

    /**
     *日期格式
     * @param binder
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
}
