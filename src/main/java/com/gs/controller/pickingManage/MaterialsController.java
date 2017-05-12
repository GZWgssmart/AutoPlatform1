package com.gs.controller.pickingManage;

import com.gs.bean.MaterialList;
import com.gs.bean.MaterialReturn;
import com.gs.bean.MaterialUse;
import com.gs.bean.view.MaterialURTemp;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.UUIDUtil;
import com.gs.service.MaterialListService;
import com.gs.service.MaterialReturnService;
import com.gs.service.MaterialUseService;
import com.gs.service.WorkInfoService;
import org.activiti.engine.*;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.impl.persistence.entity.HistoricProcessInstanceEntity;
import org.activiti.engine.impl.persistence.entity.HistoricVariableInstanceEntity;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @Resource
    private RepositoryService repositoryService;
    @Resource
    private RuntimeService runtimeService;
    @Resource
    private TaskService taskService;
    @Resource
    private FormService formService;
    @Resource
    private HistoryService historyService;
    @Resource
    private ManagementService managementService;
    @Resource
    private IdentityService identityService;



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
        setFlowingVars(list);
        pager4EasyUI.setRows(list);
        return pager4EasyUI;
    }

    private void setFlowingVars(List<MaterialList> list) {
        for(MaterialList mater: list){
            String recordId = mater.getRecord().getRecordId();
            String accId = mater.getAccId();
            MaterialURTemp temp = materialListService.queryFlowVarsByRecordId(recordId, accId);
            Map map = new HashMap();
            map.put("materialURTemp", temp);
            mater.setOther(map);
        }
    }


    @ResponseBody
    @RequestMapping("doReview")
    public ControllerResult doReview(MaterialURTemp materialUse, HttpServletRequest req){ // 审核退料与领料申请
        TaskQuery taskQuery = taskService.createTaskQuery();
        final String curUserID = "2";

        String proInsId = materialUse.getProcessInstanceId();
        Task task = taskQuery.processInstanceId(proInsId).singleResult();


        boolean isOK  = Boolean.parseBoolean(req.getParameter("isOK"));
        String respMsg = materialUse.getRespMsg();

        Map map = new HashMap();
        map.put("isOK",isOK ); map.put("respMsg", respMsg);
        String resultPre = "拒绝";
        if(isOK) {
            resultPre = "同意";

        }
        taskService.setAssignee(task.getId(), curUserID);
        return nextTask(proInsId, task.getId(), map, resultPre);
    }

    private ControllerResult nextTask(String proInsId, String taskId, Map map, String otherMsg) {
        HistoricProcessInstance hisProInst = historyService.createHistoricProcessInstanceQuery().processInstanceId(proInsId).singleResult();
        Map varMap = taskService.getVariables(taskId);
        String recordId = varMap.get("recordId").toString();
        String accId = varMap.get("accId").toString();
        int accCount = Integer.parseInt(varMap.get("accCount").toString());
        String startUserId = hisProInst.getStartUserId();
        try {
            taskService.complete(taskId, map);
            if(addMaterialUseAReturnTable(varMap,startUserId)) {
                return ControllerResult.getSuccessResult(otherMsg + "成功");
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return ControllerResult.getSuccessResult(otherMsg + "失败");
    }


    /**
     * 原本用于上方,需要用到,这是领料申请成功后所做的事
     * @return
     */
    public boolean addMaterialUseAReturnTable(Map varMap, String startUserId ) {
        String recordId = varMap.get("recordId").toString();
        String accId = varMap.get("accId").toString();
        int accCount = Integer.parseInt(varMap.get("accCount").toString());
        int resultCount = 0;
        MaterialUse materialUse = new MaterialUse();
        materialUse.setMaterialUseId(UUIDUtil.uuid());
        if(accCount>0) {
            materialUse.setMatainRecordId(recordId);
            materialUse.setAccId(accId);
            materialUse.setAccCount(Math.abs(accCount));
            materialUse.setMuCreatedTime(new Date());
            materialUse.setMuUseDate(new Date());
            resultCount  = materialUseService.insert(materialUse);
        }else {
            MaterialReturn materialReturn = new MaterialReturn();
            materialReturn.setMaterialReturnId(materialUse.getMaterialUseId());
            materialReturn.setAccCount(Math.abs(accCount));
            materialReturn.setAccId(accId);
            materialReturn.setMatainRecordId(recordId);
            materialReturn.setMrCreatedDate(new Date());
            materialReturn.setMrReturnDate(new Date());
            resultCount  = materialReturnService.insert(materialReturn);
        }
        if(resultCount>0) {
            return true;
        }
        return  false;
    }



    @ResponseBody
    @RequestMapping("insert")
    public ControllerResult insertMaterials(MaterialList materialList){
        int resultCount = materialListService.insert(materialList);
        return isSuc(resultCount,"添加成功","添加失败");
    }

    private ControllerResult isSuc(int resultCount,String sucmsg,String ermsg) {
        if(resultCount>0) {
            return ControllerResult.getSuccessResult(sucmsg);
        }
        return ControllerResult.getFailResult(ermsg);
    }



}
