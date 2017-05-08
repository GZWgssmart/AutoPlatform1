<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 不曾有黑夜
  Date: 2017/4/26
  Time: 19:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商家列表</title>
</head>
<link rel="stylesheet" href="/static/css/bootstrap.css">
<link rel="stylesheet" href="/static/css/animate.css">
<link rel="stylesheet" href="/static/css/TopBtm.css">
<link rel="stylesheet" href="/static/css/paging.css">
<link rel="stylesheet" href="/static/css/FactoryPageStyle.css">
<body>
    <%--

        厂家列表页面

    --%>
    <div class="main">
        <div class="nav nav-first">
            <div class="nav-left">
                <ul class="nav-left-ul">
                    <li>欢迎您，请登录</li>
                    <a href="reg"><li>登录</li></a>
                    <a href="reg"><li>绑定手机号</li></a>
                    <a href="userpage" class="right-ul"><li>我的中心</li></a>
                    <div class="clearfix"></div>
                </ul>
            </div>
            <div class="clearfix"></div>
        </div>
        <div class="nav nav-two" id="navbar-two">
            <ul class="nav-two-ul">
                <a href="home"><li>首页</li></a>
                <a href="factorypage"><li class="actives">找商家</li></a>
                <a href="resepage"><li>我要预约</li></a>
                <a href="javaScript:;"><li>首页</li></a>
                <a href="javaScript:;"><li>首页</li></a>
                <a href="javaScript:;"><li>首页</li></a>
            </ul>
        </div>
        <%--主内容区--%>
        <div class="content">
            <div class="search-box">
                <form method="get" name="search">
                    <div class="form-search">
                        <input type="text" class="input-text" placeholder="请输入车型、品牌或商家关键字"/>
                        <button type="submit" class="btn">
                            <span>
                                搜索
                            </span>
                        </button>
                    </div>
                </form>
            </div>
            <%--商家列表--%>
            <div class="showfactory">
                <div class="hot-factory">
                    <div class="title">
                        <span class="hot-icon"></span>
                        <h3><a href="factorypage" style="text-decoration: none;">商家大全</a></h3>
                        <div class="sorting">
                            <a id="opens" data-toggle="dropdown" href="javaScript:;" style="text-decoration: none;">按评分排序 <span class="glyphicon glyphicon-chevron-down"></span></a>
                            <ul class="dropdown-menu" aria-labelledby="opens">
                                <li>
                                    <a href="javaScript:;">从高到低</a>
                                </li>
                                <li>
                                    <a href="javaScript:;">从低到高</a>
                                </li>
                            </ul>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                <c:choose>
                    <c:when test="${requestScope.company} == null">
                        <h1>暂无数据</h1>
                    </c:when>
                    <c:when test="${requestScope.company} != null">
                    <c:forEach items="${requestScope.company}" var="c">
                        <div class="factory">
                            <div class="f-img">
                                <a href="factorydeta">
                                    <img src=""/>
                                </a>
                            </div>
                            <div class="f-des">
                                <div class="company-name">
                                    <span class="cns">
                                        <a class="cns-a" href="javaScript:;" title="${c.companyName}">
                                            <i class="glyphicon glyphicon-bookmark"></i> ${c.companyName}
                                        </a>
                                        <div style="float: right;margin-right: 15px">
                                            <img src="/static/img/Frontpage/xun-lv.png"/>
                                            <img src="/static/img/Frontpage/xun-lv.png"/>
                                        </div>
                                        <div class="clearfix"></div>
                                    </span>
                                </div>
                                <div class="company-des">
                                    <span class="com-des" title="${c.companyDes}">
                                        <i class="glyphicon glyphicon-edit"></i> ${c.companyDes}
                                    </span>
                                </div>
                                <div class="company-address">
                                    <span class="com-address" title="${c.companyAddress}">
                                        <i class="glyphicon glyphicon-map-marker"></i> ${c.companyAddress}
                                    </span>
                                </div>
                                <div class="com-icon">
                                    <div class="icon-t">
                                        <i class="ms glyphicon glyphicon-thumbs-up" title="五星好评"></i>
                                        <i class="hp glyphicon glyphicon-hourglass" title="闪电发货"></i>
                                        <span class="tuij" title="五星店铺">
                                            <i class="glyphicon glyphicon-star" style="width: 14px;height: 16px;"></i> 推荐
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    </c:when>
                </c:choose>
                </div>
            </div>
            <%--分页--%>
            <div class="container large">
                <div class="pagination">
                    <ul class="paging-ul">
                        <li class="paging-li"><a href="#">上一页</a></li>
                        <li class="active paging-li"><a href="#"></a></li>
                        <li class="paging-li"><a href="#"></a></li>
                    </ul>
                </div>
            </div>
        </div>
        <%--底部模块--%>
        <div class="index-bottom">
            <div class="bottom-main">
                <div class="bottom-bs">
                    <div class="bg"></div>
                    <a href="javaScript:;" style="text-decoration: none;">
                        <div class="btm-title">原厂品质正品配件</div>
                        <div class="btm-des">
                            <span>深厚的产业背景和厂商资源，严格控制进货渠道，杜绝一切假冒伪劣配件</span>
                        </div>
                    </a>
                </div>
                <div class="bottom-bs">
                    <div class="bg-two"></div>
                    <a href="javaScript:;" style="text-decoration: none;">
                        <div class="btm-title">保养省钱，安心便捷</div>
                        <div class="btm-des">
                            <span>优惠的配件价格，合理的安装人工费，汽车保养省钱之道</span>
                        </div>
                    </a>
                </div>
                <div class="bottom-bs">
                    <div class="bg-three"></div>
                    <a href="javaScript:;" style="text-decoration: none;">
                        <div class="btm-title">汽车保养专家系统</div>
                        <div class="btm-des">
                            <span>要保养什么，用什么配件，用多少？智能汽车保养专家系统，让您轻松养车</span>
                        </div>
                    </a>
                </div>
                <div class="bottom-bs">
                    <div class="bg-four"></div>
                    <a href="javaScript:;" style="text-decoration: none;">
                        <div class="btm-title">全里程保养保障</div>
                        <div class="btm-des">
                            <span> 针对汽车从上路到报废整个期间所有需要保养的项目都可以提供全面服务</span>
                        </div>
                    </a>
                </div>
                <div class="bottom-bs">
                    <div class="bg-five"></div>
                    <a href="javaScript:;" style="text-decoration: none;">
                        <div class="btm-title">线下安装服务承诺</div>
                        <div class="btm-des">
                            <span>到店安装、特约安装店全部经过严格筛选，定期对技术资质和服务能力评估</span>
                        </div>
                    </a>
                </div>
                <div class="bottom-bs">
                    <div class="bg-six"></div>
                    <a href="javaScript:;" style="text-decoration: none;">
                        <div class="btm-title">汽车保养服务保障</div>
                        <div class="btm-des">
                            <span>从养车无忧网购买配件到特约安装店更换，出现任何问题，统一协调解决</span>
                        </div>
                    </a>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="btm-two">
                <ul class="btm-ul">
                    <li>
                        <div style="margin: 15px 20px;">
                            <div style="font-size: 20px;">联系我们：</div>
                            <span style="display: block;line-height: 3;color: #0e9aef;font-size: 22px;"><img src="/static/img/Frontpage/phone.png"/> 4000-5875200</span>
                            <span style="font-size: 18px">Email: qweasdxzc102@qq.com</span>
                        </div>
                    </li>
                    <li>
                        <div style="margin: 15px 20px;text-align: center;">
                            <span style="font-size: 20px;">扫码关注</span>
                            <ul class="saoma">
                                <li>
                                    <img src="/static/img/Frontpage/pcode-4.png"/>
                                </li>
                                <li>
                                    <img src="/static/img/Frontpage/pcode-4.png"/>
                                </li>
                                <li>
                                    <img src="/static/img/Frontpage/pcode-4.png"/>
                                </li>
                                <div class="clearfix"></div>
                            </ul>
                        </div>
                    </li>
                    <li>
                        <div class="btm-an">
                            <a class="ruzhu" href="javaScript:;" >汽修厂入驻</a>
                            <a class="jiam" href="platformIntro">商家加盟</a>
                        </div>
                    </li>
                    <div class="clearfix"></div>
                </ul>
            </div>
            <div class="t-bottom">
                <span style="font-size: 19px;">© 2011-2016 赣州宏图预科班 版权所有 ｜ 赣ICP备11018683-3</span>
            </div>
        </div>
        <a href="#top" class="go-top" id="backtop" style="display:none;"></a>
    </div>
</body>
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/jquery.cxselect.min.js"></script>
<script src="/static/js/general.js"></script>

</html>
