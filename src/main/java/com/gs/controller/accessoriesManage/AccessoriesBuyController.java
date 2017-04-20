package com.gs.controller.accessoriesManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.AccessoriesBuy;
import com.gs.common.bean.ControllerResult;
import com.gs.service.AccessoriesBuyService;
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
 * 王怡 配件采购
 * Created by Administrator on 2017/4/18.
 */
@Controller
@RequestMapping("/accBuy")
public class AccessoriesBuyController {

    @Resource
    private AccessoriesBuyService accessoriesBuyService;

    private Logger logger = (Logger) LoggerFactory.getLogger(AccessoriesBuyController.class);

    /**
     * 查询所有的采购记录
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "queryAllAccBuy", method = RequestMethod.POST)
    public List<AccessoriesBuy> queryAllAccBuy() {
        List<AccessoriesBuy> accessoriesBuyList = accessoriesBuyService.queryAll();
        if (accessoriesBuyList != null && !accessoriesBuyList.equals("")) {
            return accessoriesBuyList;
        }
        return null;
    }

    /**
     * 添加采购记录
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "addAccBuy", method = RequestMethod.POST)
    public ControllerResult addAccBuy(AccessoriesBuy accessoriesBuy) {
        if (accessoriesBuy != null && !accessoriesBuy.equals("")) {
            System.out.println("传到后天的数据为：" + accessoriesBuy.toString());
            System.out.println(accessoriesBuy.toString());
            accessoriesBuyService.insert(accessoriesBuy);
            logger.info("添加成功");
            return ControllerResult.getSuccessResult("添加成功");
        } else {
            return ControllerResult.getFailResult("添加失败，请输入必要的信息");
        }
    }

    /**
     * 删除采购记录
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "removeAccBuy", method = RequestMethod.POST)
    public ControllerResult removeAccBuy(String id) {
        if (id != null && !id.equals("")) {
            accessoriesBuyService.deleteById(id);
            logger.info("删除成功");
            return ControllerResult.getSuccessResult("删除成功");
        } else {
            return ControllerResult.getFailResult("删除失败");
        }
    }

    /**
     * 修改采购记录
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "updateAccBuy", method = RequestMethod.POST)
    public ControllerResult updateAccBuy(AccessoriesBuy accessoriesBuy) {
        if (accessoriesBuy != null && !accessoriesBuy.equals("")) {
            accessoriesBuyService.update(accessoriesBuy);
            logger.info("修改成功");
            return ControllerResult.getSuccessResult("修改成功");
        } else {
            return ControllerResult.getFailResult("修改失败");
        }
    }

    @ResponseBody
    @RequestMapping(value = "queryAccBuyStatus", method = RequestMethod.POST)
    public List<AccessoriesBuy> queryInactiveAccBuy(String accBuyStatus) {
        if (accBuyStatus != null && !accBuyStatus.equals("")) {
            List<AccessoriesBuy> accessoriesBuyList = accessoriesBuyService.queryAllStatus(accBuyStatus);
            if (accessoriesBuyList != null && !equals("")) {
                logger.info("查询状态成功");
                return accessoriesBuyList;
            }
            return null;
        }
        return null;
    }

    /**
     * 对状态的激活和启用，只使用一个方法进行切换。
     */
    @ResponseBody
    @RequestMapping(value = "statusOperate", method = RequestMethod.POST)
    public ControllerResult inactive(String accBuyId, String accBuyStatus) {
        if (accBuyId != null && !accBuyId.equals("") && accBuyStatus != null && !accBuyStatus.equals("")) {
            if (accBuyStatus.equals("N")) {
                accessoriesBuyService.active(accBuyId);
                logger.info("激活成功");
                return ControllerResult.getSuccessResult("激活成功");
            } else {
                accessoriesBuyService.inactive(accBuyId);
                logger.info("禁用成功");
                return ControllerResult.getSuccessResult("禁用成功");
            }
        } else {
            return ControllerResult.getFailResult("操作失败");
        }
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
}
