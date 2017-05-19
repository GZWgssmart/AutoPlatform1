package com.gs.controller.basicInfoManage;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.JsonProcessingException;
import ch.qos.logback.classic.Logger;
import com.gs.bean.CarBrand;
import com.gs.bean.Checkin;
import com.gs.bean.User;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.RoleUtil;
import com.gs.common.util.SessionUtil;
import com.gs.common.util.UUIDUtil;
import com.gs.service.CarBrandService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 汽车品牌管理
 * Created by yaoyong on 2017/4/18.
 */
@Controller
@RequestMapping("/carBrand")
public class CarBrandController {

    private Logger logger = (Logger) LoggerFactory.getLogger(CarBrandController.class);

    @Resource
    private CarBrandService carBrandService;


    @ResponseBody
    @RequestMapping(value = "queryByPagerCarBrand", method = RequestMethod.GET)
    public Pager4EasyUI<CarBrand> queryAll(HttpSession session, @Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        if (SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司接待员,汽车公司总技师,汽车公司技师,汽车公司学徒,汽车公司销售人员,汽车公司财务人员,汽车公司采购人员,汽车公司库管人员,汽车公司人力资源管理部,车主";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("分页查询所有汽车品牌");
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setPageSize(Integer.valueOf(pageSize));
                pager.setUser((User) session.getAttribute("user"));
                pager.setTotalRecords(carBrandService.count((User) session.getAttribute("user")));
                List<CarBrand> carBrands = carBrandService.queryByPager(pager);
                return new Pager4EasyUI<CarBrand>(pager.getTotalRecords(), carBrands);
            } else {
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        } else {
            logger.info("请先登录");
            return null;
        }
    }

    @ResponseBody
    @RequestMapping(value = "queryAllCarBrand", method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryAll(HttpSession session) {
        if (SessionUtil.isLogin(session) || SessionUtil.isOwnerLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司接待员,车主";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("查询所有汽车品牌");
                List<CarBrand> carBrands = carBrandService.queryAll((User) session.getAttribute("user"));
                List<ComboBox4EasyUI> comboxs = new ArrayList<ComboBox4EasyUI>();
                for (CarBrand c : carBrands) {
                    ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
                    comboBox4EasyUI.setId(c.getBrandId());
                    comboBox4EasyUI.setText(c.getBrandName());
                    comboxs.add(comboBox4EasyUI);
                }
                return comboxs;
            } else {
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        } else {
            logger.info("请先登录");
            return null;
        }
    }

    /**
     * 查询所有被禁用的汽车品牌
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "queryByPagerDisable", method = RequestMethod.GET)
    public Pager4EasyUI<CarBrand> queryByPagerDisable(HttpSession session,@Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        if (SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司接待员,汽车公司总技师,汽车公司技师,汽车公司学徒,汽车公司销售人员,汽车公司财务人员,汽车公司采购人员,汽车公司库管人员,汽车公司人力资源管理部";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("分页查询所有被禁用汽车品牌");
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setPageSize(Integer.valueOf(pageSize));
                pager.setUser((User) session.getAttribute("user"));
                pager.setTotalRecords(carBrandService.countByDisable((User) session.getAttribute("user")));
                List<CarBrand> carBrands = carBrandService.queryByPagerDisable(pager);
                return new Pager4EasyUI<CarBrand>(pager.getTotalRecords(), carBrands);

            } else {
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        } else {
            logger.info("请先登录");
            return null;
        }
    }

    @ResponseBody
    @RequestMapping(value = "addCarBrand", method = RequestMethod.POST)
    public ControllerResult add(CarBrand carBrand,HttpSession session) {
        if (SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员";
            if (RoleUtil.checkRoles(roles)) {
                if (carBrand != null && !carBrand.equals("")) {
                    logger.info("添加汽车品牌");
                    carBrandService.insert(carBrand);
                    return ControllerResult.getSuccessResult("添加汽车品牌成功");
                } else {
                    return ControllerResult.getFailResult("添加汽车品牌失败");
                }
            } else {
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        } else {
            logger.info("请先登录");
            return ControllerResult.getNotLoginResult("登录信息无效，请重新登录");
        }
    }

    @ResponseBody
    @RequestMapping(value = "updateCarBrand", method = RequestMethod.POST)
    public ControllerResult update(CarBrand carBrand,HttpSession session) {
        if (SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员";
            if (RoleUtil.checkRoles(roles)) {
                if (carBrand != null && !carBrand.equals("")) {
                    logger.info("修改汽车品牌");
                    carBrandService.update(carBrand);
                    return ControllerResult.getSuccessResult("修改汽车品牌成功");
                } else {
                    return ControllerResult.getFailResult("修改汽车品牌失败");
                }
            }else {
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        } else {
            logger.info("请先登录");
            return ControllerResult.getNotLoginResult("登录信息无效，请重新登录");
        }
    }


    /**
     * 验证查询此品牌名称是否已存在此品牌名称
     */
    @ResponseBody
    @RequestMapping(value = "querybrandName", method = RequestMethod.GET)
    public String querybrandName(HttpServletRequest req) {
        logger.info("此品牌名称是否已存在此品牌名称");
        String brandName = (String)req.getParameter("brandName");
        boolean result = true;
        String resultString = "";
        Map<String, Boolean> map = new HashMap<String, Boolean>();
        ObjectMapper mapper = new ObjectMapper();
        if (brandName != null && brandName !="") {
            int count = carBrandService.querybrandName(brandName);
            if (count > 1 || count == 1) {
                result = false;
            }
        }
        map.put("valid", result);
        try {
            resultString = mapper.writeValueAsString(map);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return resultString;
    }

    /**
     * 对状态的激活和启用，只使用一个方法进行切换。
     */
    @ResponseBody
    @RequestMapping(value = "statusOperate", method = RequestMethod.POST)
    public ControllerResult inactive(HttpSession session,String id, String status) {
        if (SessionUtil.isLogin(session)) {
            String roles = "系统超级管理员,系统普通管理员";
            if (RoleUtil.checkRoles(roles)) {
                if (id != null && !id.equals("") && status != null && !status.equals("")) {
                    if (status.equals("N")) {
                        carBrandService.active(id);
                        logger.info("激活成功");
                        return ControllerResult.getSuccessResult("激活成功");
                    } else {
                        carBrandService.inactive(id);
                        logger.info("禁用成功");
                        return ControllerResult.getSuccessResult("禁用成功");
                    }
                } else {
                    return ControllerResult.getFailResult("操作失败");
                }
            } else {
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        } else {
            logger.info("请先登录");
            return ControllerResult.getNotLoginResult("登录信息无效，请重新登录");
        }

    }
}
