package com.gs.controller;

import com.gs.bean.User;
import com.gs.bean.WorkInfo;
import com.gs.bean.view.RecordBaseView;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.MaterialReturnService;
import com.gs.service.MaterialUseService;
import com.gs.service.PermissionService;
import com.gs.service.WorkInfoService;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;

/**
 * 派工领料
 *
 * @author 程燕
 * @create 2017-04-23 18:57
 * @des 派工Controller
 */
@Controller
@RequestMapping("/dispatching")
public class WorkingDispatchingController {
    @Resource
    private MaterialUseService materialUseService;

    @Resource
    private MaterialReturnService materialReturnService;

    @Resource
    private WorkInfoService workInfoService;

    @ResponseBody
    @RequestMapping("queryRecordByPager")
    public Pager4EasyUI records(@RequestParam("pageNumber")String pageNo, @RequestParam("pageSize")String pageSize){
        final  String companyId = "11";
        Pager pager = new Pager();
        pager.setPageNo(str2int(pageNo));
        pager.setPageSize(str2int(pageSize));
        int total = materialUseService.countNoUseRecord(companyId);
        List<RecordBaseView> rbvs = materialUseService.queryNoUseRecord(companyId, pager);
        Pager4EasyUI pager4EasyUI = new Pager4EasyUI(total, rbvs);
        System.out.println("进入了这个方法里");
        return pager4EasyUI;
    }

    @ResponseBody
    @RequestMapping("queryRecrodAccByPager") // 可能不会使用到
    public Pager4EasyUI accInfos(@RequestParam("pageNumber")String pageNo, @RequestParam("pageSize")String pageSize, @RequestParam("recordId")String recordId) {
        Pager pager = new Pager();
        pager.setPageNo(str2int(pageNo));
        pager.setPageSize(str2int(pageSize));
        return null;
    }

    @ResponseBody
    @RequestMapping("userWorksByPager") // 用于页面显示员工工单,员工通过这个页面会点击查询该工单所需要的零件
    public Pager4EasyUI userWorks(@RequestParam("pageNumber")String pageNo, @RequestParam("pageSize")String pageSize) {
        final String tempUserid = "1";
        Pager pager = new Pager();
        pager.setPageNo(str2int(pageNo));
        pager.setPageSize(str2int(pageSize));
        List workInfos = materialUseService.userWorksStatusByPager(tempUserid, "Y",pager);
        int total = materialUseService.countUserWorksStatus(tempUserid,"Y");
        Pager4EasyUI pager4EasyUI = new Pager4EasyUI();
        pager4EasyUI.setRows(workInfos);
        pager4EasyUI.setTotal(total);
        return pager4EasyUI;
    }

    @ResponseBody
    @RequestMapping("emps") // 可能不会使用到
    public List<ComboBox4EasyUI> emps() {
        final String companyId = "11";
        List<User> users = materialUseService.companyEmps(companyId);
        List<ComboBox4EasyUI> comboBoxs = new ArrayList<ComboBox4EasyUI>();
        for(User user: users) {
            ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
            comboBox4EasyUI.setId(user.getUserId());
            comboBox4EasyUI.setText(user.getUserName());
            comboBoxs.add(comboBox4EasyUI);
        }
        return comboBoxs;
    }

    @ResponseBody
    @RequestMapping("insert")
    public ControllerResult insert(@RequestParam("recordId")String recordId, @RequestParam("userId")String userId) {
        WorkInfo workInfo = new WorkInfo();
        workInfo.setRecordId(recordId);
        workInfo.setUserId(userId);
        workInfo.setWorkCreatedTime(new Date());
        workInfo.setWorkAssignTime(new Date());
        int result = materialUseService.insertWorkInfo(workInfo);
        if(result < 1) {
            return ControllerResult.getFailResult("添加失败");
        }
        return ControllerResult.getSuccessResult("添加成功");
    }



    private int str2int(String str){
        try{
            int num = Integer.valueOf(str);
            return num;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }



}
