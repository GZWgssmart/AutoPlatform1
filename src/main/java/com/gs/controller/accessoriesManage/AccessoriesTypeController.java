package com.gs.controller.accessoriesManage;

import com.gs.bean.AccessoriesType;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.AccessoriesTypeService;
import org.activiti.engine.impl.Page;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import ch.qos.logback.classic.Logger;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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

//    @ResponseBody
//    @RequestMapping(value = "queryAllAccType",method = RequestMethod.POST)
//    public List<AccessoriesType> queryAllAccSale(){
//        List<AccessoriesType> accessoriesTypes=accessoriesTypeService.queryAll();
//        if(accessoriesTypes!=null&&!accessoriesTypes.equals("")){
//            return accessoriesTypes;
//        }
//        return null;
//    }


    /**
     * 查询全部的配件分类
     */
    @ResponseBody
    @RequestMapping(value = "queryAllAccType", method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryAllAccType() {
        logger.info("查询所有配件分类信息");
        List<AccessoriesType> accessoriesTypes = accessoriesTypeService.queryAll();
        List<ComboBox4EasyUI> comboxs = new ArrayList<ComboBox4EasyUI>();
        for (AccessoriesType c : accessoriesTypes) {
            ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
            comboBox4EasyUI.setId(c.getAccTypeId());
            comboBox4EasyUI.setText(c.getAccTypeName());
            comboxs.add(comboBox4EasyUI);
        }
        return comboxs;
    }

    /**
     * 分页查询配件分类信息
     */
    @ResponseBody
    @RequestMapping(value = "queryByPage", method = RequestMethod.GET)
    public Pager4EasyUI queryByPager(@Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(accessoriesTypeService.count());
        logger.info("分页查询配件分类信息成功");
        List<AccessoriesType> accTypes = accessoriesTypeService.queryByPager(pager);
        return new Pager4EasyUI<AccessoriesType>(pager.getTotalRecords(), accTypes);
    }


    /**
     * 添加配件分类
     *
     * @param accessoriesType
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "addAccType", method = RequestMethod.POST)
    public ControllerResult addAccType(AccessoriesType accessoriesType) {
        if (accessoriesType != null && !accessoriesType.equals("")) {
            accessoriesTypeService.insert(accessoriesType);
            logger.info("添加成功");
            return ControllerResult.getSuccessResult("添加成功");
        } else {
            return ControllerResult.getFailResult("添加失败");
        }
    }

    /**
     * 删除配件分类
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "removeAccType", method = RequestMethod.POST)
    public ControllerResult removeAccType(String id) {
        if (id != null && !id.equals("")) {
            accessoriesTypeService.deleteById(id);
            logger.info("添加成功");
            return ControllerResult.getSuccessResult("删除成功");
        } else {
            return ControllerResult.getFailResult("删除失败");
        }
    }

    /**
     * 更新配件分类信息
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "updateAccType", method = RequestMethod.POST)
    public ControllerResult updateAccType(AccessoriesType accessoriesType) {
        if (accessoriesType != null && !accessoriesType.equals("")) {
            accessoriesTypeService.update(accessoriesType);
            logger.info("更新成功");
            return ControllerResult.getSuccessResult("更新成功");
        } else {
            return ControllerResult.getSuccessResult("更新失败");
        }
    }


    /**
     * 查询所有被禁用的登记记录
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "queryByPagerDisable", method = RequestMethod.GET)
    public Pager4EasyUI<AccessoriesType> queryByPagerDisable(@Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        logger.info("分页查询所有被禁用登记记录");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(accessoriesTypeService.countByDisable());
        List<AccessoriesType> accessoriesTypes = accessoriesTypeService.queryByPagerDisable(pager);
        return new Pager4EasyUI<AccessoriesType>(pager.getTotalRecords(), accessoriesTypes);
    }


    /**
     * 对状态的激活和启用，只使用一个方法进行切换。
     */
    @ResponseBody
    @RequestMapping(value = "statusOperate", method = RequestMethod.POST)
    public ControllerResult inactive(String accTypeId, String accTypeStatus) {
        if (accTypeId != null && !accTypeId.equals("") && accTypeStatus != null && !accTypeStatus.equals("")) {
            if (accTypeStatus.equals("N")) {
                accessoriesTypeService.active(accTypeId);
                logger.info("激活成功");
                return ControllerResult.getSuccessResult("激活成功");
            } else {
                accessoriesTypeService.inactive(accTypeId);
                logger.info("禁用成功");
                return ControllerResult.getSuccessResult("禁用成功");
            }
        } else {
            return ControllerResult.getFailResult("操作失败");
        }
    }


    @ResponseBody
    @RequestMapping(value = "blurredQuery", method = RequestMethod.GET)
    public Pager4EasyUI<AccessoriesType> blurredQuery(HttpServletRequest request, @Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        logger.info("配件分类模糊查询");
        String text = request.getParameter("text");
        String value = request.getParameter("value");
        if (text != null && !text.equals("") && value != null && !value.equals("")) {
            Pager pager = new Pager();
            pager.setPageNo(Integer.parseInt(pageNumber));
            pager.setPageSize(Integer.parseInt(pageSize));
            List<AccessoriesType> accessoriesTypes = null;
            AccessoriesType accessoriesType = new AccessoriesType();
            if (text.equals("所属公司/配件分类名称")) {
                accessoriesType.setCompanyId(value);
                accessoriesType.setAccTypeName(value);
            } else if (text.equals("所属公司")) {
                accessoriesType.setCompanyId(value);
            } else if (text.equals("配件分类名称")) {
                accessoriesType.setAccTypeName(value);
            }
            accessoriesTypes = accessoriesTypeService.blurredQuery(pager, accessoriesType);
            pager.setTotalRecords(accessoriesTypeService.countByBlurred(accessoriesType));
            return new Pager4EasyUI<AccessoriesType>(pager.getTotalRecords(), accessoriesTypes);
        } else {
            return null;
        }
    }


    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
}
