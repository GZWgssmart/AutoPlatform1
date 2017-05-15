package com.gs.controller.accessoriesManage;

import ch.qos.logback.classic.Logger;
import com.gs.bean.Accessories;
import com.gs.bean.AccessoriesSale;
import com.gs.bean.User;
import com.gs.common.bean.ComboBox4EasyUI;
import com.gs.common.bean.ControllerResult;
import com.gs.common.bean.Pager;
import com.gs.common.bean.Pager4EasyUI;
import com.gs.common.util.RoleUtil;
import com.gs.common.util.SessionUtil;
import com.gs.service.AccessoriesSaleService;
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
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 王怡 配件销售
 * Created by Administrator on 2017/4/18.
 */
@Controller
@RequestMapping("/accSale")
public class AccessoriesSaleController {

    private Logger logger = (Logger) LoggerFactory.getLogger(AccessoriesSaleController.class);

    @Resource
    private AccessoriesSaleService accessoriesSaleService;

    @ResponseBody
    @RequestMapping(value = "queryAllAccSale", method = RequestMethod.GET)
    public List<ComboBox4EasyUI> queryAllAccSale(HttpSession session) {
        if (SessionUtil.isLogin(session)) {
            String roles="公司超级管理员,公司普通管理员,汽车公司销售人员,系统超级管理员,系统普通管理员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("所有配件销售信息");
                List<AccessoriesSale> accessoriesSales = accessoriesSaleService.queryAll((User) session.getAttribute("user"));
                List<ComboBox4EasyUI> comboxs = new ArrayList<ComboBox4EasyUI>();
                for (AccessoriesSale c : accessoriesSales) {
                    ComboBox4EasyUI comboBox4EasyUI = new ComboBox4EasyUI();
                    comboBox4EasyUI.setId(c.getAccSaleId());
                    comboBox4EasyUI.setText(c.getAccSaleId());
                    comboxs.add(comboBox4EasyUI);
                }
                return comboxs;
            } else {
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        } else {
            logger.info("请先登陆");
            return null;
        }
    }


    /**
     * 分页查询配件销售信息
     */
    @ResponseBody
    @RequestMapping(value = "queryByPage", method = RequestMethod.GET)
    public Pager4EasyUI<AccessoriesSale> queryByPager(HttpSession session, @Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        if (SessionUtil.isLogin(session)) {
            String roles="公司超级管理员,公司普通管理员,汽车公司销售人员,系统超级管理员,系统普通管理员";
            if (RoleUtil.checkRoles(roles)) {
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setPageSize(Integer.valueOf(pageSize));
                pager.setUser((User) session.getAttribute("user"));
                pager.setTotalRecords(accessoriesSaleService.count((User) session.getAttribute("user")));
                logger.info("分页查询配件销售信息成功");
                List<AccessoriesSale> accessoriesSales = accessoriesSaleService.queryByPager(pager);
                return new Pager4EasyUI<AccessoriesSale>(pager.getTotalRecords(), accessoriesSales);
            } else {
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        } else {
            logger.info("请先登陆");
            return null;
        }
    }

    /**
     * 添加配件销售记录
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "addAccSale", method = RequestMethod.POST)
    public ControllerResult addAccSale(HttpSession session, AccessoriesSale accessoriesSale) {
        if (SessionUtil.isLogin(session)) {
            String roles="公司超级管理员,公司普通管理员,汽车公司销售人员";
            if (RoleUtil.checkRoles(roles)) {
                if (accessoriesSale != null && !accessoriesSale.equals("")) {
                    accessoriesSaleService.insert(accessoriesSale);
                    logger.info("添加成功");
                    return ControllerResult.getSuccessResult("添加成功");
                } else {
                    return ControllerResult.getSuccessResult("添加成功");
                }
            } else {
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        } else {
            logger.info("请先登陆");
            return null;
        }
    }

    /**
     * 修改配件销售记录
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "updateAccSale", method = RequestMethod.POST)
    public ControllerResult updateAccSale(HttpSession session, AccessoriesSale accessoriesSale) {
        if (SessionUtil.isLogin(session)) {
            String roles="公司超级管理员,公司普通管理员,汽车公司销售人员";
            if (RoleUtil.checkRoles(roles)) {
                if (accessoriesSale != null && !accessoriesSale.equals("")) {
                    accessoriesSaleService.update(accessoriesSale);
                    logger.info("更新成功");
                    return ControllerResult.getSuccessResult("更新成功");
                } else {
                    return ControllerResult.getFailResult("更新失败");
                }
            } else {
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        } else {
            logger.info("请先登陆");
            return null;
        }
    }


    /**
     * 查询所有被禁用的登记记录
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "queryByPagerDisable", method = RequestMethod.GET)
    public Pager4EasyUI<AccessoriesSale> queryByPagerDisable(HttpSession session, @Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        if (SessionUtil.isLogin(session)) {
            String roles="公司超级管理员,公司普通管理员,汽车公司销售人员,系统超级管理员,系统普通管理员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("分页查询所有被禁用登记记录");
                Pager pager = new Pager();
                pager.setPageNo(Integer.valueOf(pageNumber));
                pager.setPageSize(Integer.valueOf(pageSize));
                pager.setUser((User) session.getAttribute("user"));
                pager.setTotalRecords(accessoriesSaleService.countByDisable());
                List<AccessoriesSale> accessoriesSales = accessoriesSaleService.queryByPagerDisable(pager);
                return new Pager4EasyUI<AccessoriesSale>(pager.getTotalRecords(), accessoriesSales);
            } else {
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        } else {
            logger.info("请先登陆");
            return null;
        }
    }


    /**
     * 对状态的激活和启用，只使用一个方法进行切换。
     */
    @ResponseBody
    @RequestMapping(value = "statusOperate", method = RequestMethod.POST)
    public ControllerResult inactive(HttpSession session, String accSaleId, String accSaleStatus) {
        if (SessionUtil.isLogin(session)) {
            String roles="公司超级管理员,公司普通管理员,汽车公司销售人员";
            if (RoleUtil.checkRoles(roles)) {
                if (accSaleId != null && !accSaleId.equals("") && accSaleStatus != null && !accSaleStatus.equals("")) {
                    if (accSaleStatus.equals("N")) {
                        accessoriesSaleService.active(accSaleId);
                        logger.info("激活成功");
                        return ControllerResult.getSuccessResult("激活成功");
                    } else {
                        accessoriesSaleService.inactive(accSaleId);
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
            logger.info("请先登陆");
            return null;
        }
    }

    /**
     * 销售记录的模糊查询
     *
     * @param request
     * @param pageNumber
     * @param pageSize
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "blurredQuery", method = RequestMethod.GET)
    public Pager4EasyUI<AccessoriesSale> blurredQuery(HttpSession session, HttpServletRequest request, @Param("pageNumber") String pageNumber, @Param("pageSize") String pageSize) {
        if (SessionUtil.isLogin(session)) {
            String roles="公司超级管理员,公司普通管理员,汽车公司销售人员,系统超级管理员,系统普通管理员";
            if (RoleUtil.checkRoles(roles)) {
                logger.info("配件销售记录模糊查询");
                String text = request.getParameter("text");
                String value = request.getParameter("value");
                if (text != null && !text.equals("") && value != null && !value.equals("")) {
                    Pager pager = new Pager();
                    pager.setUser((User) session.getAttribute("user"));
                    pager.setPageNo(Integer.parseInt(pageNumber));
                    pager.setPageSize(Integer.parseInt(pageSize));
                    List<AccessoriesSale> accessoriesSales = null;
                    AccessoriesSale accessoriesSale = new AccessoriesSale();
                    if (text.equals("汽车公司/配件名称")) {
                        accessoriesSale.setCompanyId(value);
                        accessoriesSale.setAccId(value);
                    } else if (text.equals("汽车公司")) {
                        accessoriesSale.setCompanyId(value);
                    } else if (text.equals("配件名称")) {
                        accessoriesSale.setAccId(value);
                    }
                    accessoriesSales = accessoriesSaleService.blurredQuery(pager, accessoriesSale);
                    pager.setTotalRecords(accessoriesSaleService.countByBlurred(accessoriesSale, (User) session.getAttribute("user")));
                    return new Pager4EasyUI<AccessoriesSale>(pager.getTotalRecords(), accessoriesSales);
                } else {
                    return null;
                }
            } else {
                logger.info("此用户无拥有此方法角色");
                return null;
            }
        } else {
            logger.info("请先登陆");
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
