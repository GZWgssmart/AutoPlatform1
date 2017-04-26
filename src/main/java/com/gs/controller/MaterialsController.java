package com.gs.controller;

import com.gs.bean.MaterialList;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.MaterialListService;
import com.gs.service.MaterialReturnService;
import com.gs.service.MaterialUseService;
import com.gs.service.WorkInfoService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * 领料与退料
 *
 * @author 程燕
 * @create 2017-04-24 14:53
 */
@Controller
@RequestMapping("/materials")
public class MaterialsController {

    @Resource
    private MaterialListService materialListService;

    @Resource
    private MaterialUseService materialUseService;

    @Resource
    private MaterialReturnService materialReturnService;

    @Resource
    private WorkInfoService workInfoService;

    @ResponseBody       //可能用不到了
    @RequestMapping("queryUserMaterialsByPager")
    public Pager4EasyUI materialsByPager(@RequestParam("pageNumber") int pageNumber, @RequestParam("pageSize") int pageSize){
        final  String userId = "1";
        Pager pager = new Pager();
        Pager4EasyUI pager4EasyUI = new Pager4EasyUI();
        pager.setPageNo(pageNumber);
        pager.setPageSize(pageSize);
        int total = materialListService.count(userId);
        pager4EasyUI.setTotal(total);
        List list = materialListService.queryByPager(userId,pager);
        pager4EasyUI.setRows(list);
        return pager4EasyUI;
    }

    @ResponseBody
    @RequestMapping("history")
    public Pager4EasyUI historyByPager(@RequestParam("pageNumber") int pageNumber, @RequestParam("pageSize") int pageSize){
        final String tempUserId = "1";

        Pager4EasyUI pager4EasyUI = new Pager4EasyUI();
        Pager pager = new Pager();
        //当前以用户1号查询,后期需要判断是否拥有查询所有领用记录才可以使用
        int total = materialUseService.countUserHist(tempUserId);
        pager.setPageNo(pageNumber);
        pager.setPageSize(pageSize);
        pager4EasyUI.setTotal(total);
        List rows = materialUseService.userHistByPager(pager,tempUserId);
        pager4EasyUI.setRows(rows);
        return pager4EasyUI;
    }

    @ResponseBody
    @RequestMapping("recordAccsByPager")
    public Pager4EasyUI recordAccsByPager(@RequestParam("pageNumber") int pageNumber, @RequestParam("pageSize") int pageSize,@RequestParam("recordId")String recordId){
        Pager pager = new Pager();
        pager.setPageNo(pageNumber);
        pager.setPageSize(pageSize);
        int total = materialListService.countRecordAccs(recordId);
        Pager4EasyUI pager4EasyUI = new Pager4EasyUI();
        pager4EasyUI.setTotal(total);
        List list = materialListService.recordAccsByPager(recordId,pager);
        pager4EasyUI.setRows(list);
        return pager4EasyUI;
    }

}
