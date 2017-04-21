package com.gs.controller.basicInfoManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.CarColor;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.service.CarColorService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 汽车颜色管理
 * Created by yaoyong on 2017/4/18.
 */

@Controller
@RequestMapping("/carColor")
public class CarColorController {

    @Resource
    private CarColorService carColorService;

    private Logger logger = (Logger) LoggerFactory.getLogger(CarColorController.class);

    @ResponseBody
    @RequestMapping(value = "queryAllCarColor",method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryAll(){
        logger.info("查询所有汽车颜色");
        List<CarColor> carColors = carColorService.queryAll();
        List<ComboBox4EasyUI> comboxs = new ArrayList<ComboBox4EasyUI>();
        for(CarColor c : carColors){
            ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
            comboBox4EasyUI.setId(c.getColorId());
            comboBox4EasyUI.setText(c.getColorName());
            comboxs.add(comboBox4EasyUI);
        }
        return comboxs;
    }

    @ResponseBody
    @RequestMapping(value="queryByPagerCarColor", method = RequestMethod.GET)
    public Pager4EasyUI<CarColor> queryByPager(@Param("pageNumber")String pageNumber, @Param("pageSize")String pageSize) {
        logger.info("分页查询所有汽车颜色");
        Pager pager = new Pager();
        pager.setPageNo(Integer.valueOf(pageNumber));
        pager.setPageSize(Integer.valueOf(pageSize));
        pager.setTotalRecords(carColorService.count());
        List<CarColor> carColors = carColorService.queryByPager(pager);
        return new Pager4EasyUI<CarColor>(pager.getTotalRecords(), carColors);
    }

    @ResponseBody
    @RequestMapping(value = "addCarColor")
    public ControllerResult add(CarColor carColor){
        if (carColor != null && !carColor.equals("")) {
            logger.info("添加汽车颜色");
            carColorService.insert(carColor);
            return ControllerResult.getSuccessResult("添加成功");
        }else{
            return ControllerResult.getFailResult("添加失败，请输入必要的信息");
        }
    }


    @ResponseBody
    @RequestMapping(value = "updateCarColor",method = RequestMethod.POST)
    public ControllerResult update(CarColor carColor) {
        if (carColor != null && !carColor.equals("")) {
            logger.info("修改汽车颜色");
            carColorService.update(carColor);
            return ControllerResult.getSuccessResult("修改成功");
        }else {
            return ControllerResult.getFailResult("修改失败，请输入必要的信息");
        }
    }
}
