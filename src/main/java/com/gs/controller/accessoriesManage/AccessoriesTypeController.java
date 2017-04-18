package com.gs.controller.accessoriesManage;

import com.gs.bean.AccessoriesType;
import com.gs.common.bean.ControllerResult;
import com.gs.service.AccessoriesTypeService;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import ch.qos.logback.classic.Logger;
import javax.annotation.Resource;
import java.util.List;

/**
 * 王怡 配件分类管理
 * Created by Administrator on 2017/4/18.
 */
@Controller
@RequestMapping("/accType")
public class AccessoriesTypeController {

    private Logger logger = (Logger) LoggerFactory.getLogger(AccessoriesTypeController.class);

    @Resource
    private AccessoriesTypeService accessoriesTypeService;


    @ResponseBody
    @RequestMapping(value = "queryAllAccType",method = RequestMethod.POST)
    public List<AccessoriesType> queryAllAccType(){
        List<AccessoriesType> accessoriesTypeList=accessoriesTypeService.queryAll();
        if (accessoriesTypeList!=null&&!accessoriesTypeList.equals("")){
            return accessoriesTypeList;
        }
        return null;
    }


    /**
     * 添加配件分类
     * @param accessoriesType
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "addAccType",method = RequestMethod.POST)
    public ControllerResult addAccType(AccessoriesType accessoriesType){
        if(accessoriesType!=null&&!accessoriesType.equals("")){
            accessoriesTypeService.insert(accessoriesType);
            logger.info("添加成功");
            return ControllerResult.getSuccessResult("添加成功");
        }else{
            return ControllerResult.getFailResult("添加失败");
        }
    }

    /**
     * 删除配件分类
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "removeAccType",method = RequestMethod.POST)
    public ControllerResult removeAccType(String id){
        if(id!=null&&!id.equals("")){
            accessoriesTypeService.deleteById(id);
            logger.info("添加成功");
            return ControllerResult.getSuccessResult("删除成功");
        }else{
            return ControllerResult.getFailResult("删除失败");
        }
    }

    /**
     * 更新配件分类信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "updateAccType",method = RequestMethod.POST)
    public ControllerResult updateAccType(AccessoriesType accessoriesType){
        if(accessoriesType!=null&&!accessoriesType.equals("")){
            accessoriesTypeService.update(accessoriesType);
            logger.info("更新成功");
            return ControllerResult.getSuccessResult("更新成功");
        }else{
            return ControllerResult.getSuccessResult("更新失败");
        }
    }

}
