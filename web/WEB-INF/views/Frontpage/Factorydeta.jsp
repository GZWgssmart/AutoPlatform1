<%--
  Created by IntelliJ IDEA.
  User: 不曾有黑夜
  Date: 2017/4/27
  Time: 15:19
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>厂商详情</title>
</head>
<link rel="stylesheet" href="/static/css/bootstrap.css">
<link rel="stylesheet" href="/static/css/animate.css">
<link rel="stylesheet" href="/static/css/TopBtm.css">
<link rel="stylesheet" href="/static/css/Factorydatestyle.css">
<body>
    <%--厂家详情页面--%>
    <div class="main">
        <%--导航栏--%>
        <div class="nav nav-first">
            <div class="nav-left">
                <ul class="nav-left-ul">
                    <c:choose>
                        <c:when test="${sessionScope.frontUser != null}">
                            <c:if test="${sessionScope.frontUser.userName != null}">
                                <li id="placelogin">欢迎您，${sessionScope.frontUser.userName}</li>
                                <a href="userpage" class="right-ul"><li>我的中心</li></a>
                                <a href="outusers"><li>退出</li></a>
                                <div class="clearfix"></div>
                            </c:if>
                            <c:if test="${sessionScope.frontUser.userName == null}">
                                <li id="placelogin">欢迎您，${sessionScope.frontUser.userPhone}</li>
                                <a href="userpage" class="right-ul"><li>我的中心</li></a>
                                <a href="outusers"><li>退出</li></a>
                                <div class="clearfix"></div>
                            </c:if>
                        </c:when>

                        <c:otherwise>
                            <li id="placelogin">欢迎您，请登录</li>
                            <a href="reg" id="loginreg"><li>登录/注册</li></a>
                            <div class="clearfix"></div>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
            <div class="clearfix"></div>
        </div>
        <div class="nav nav-two" id="navbar-two">
            <ul class="nav-two-ul">
                <a href="home"><li>首页</li></a>
                <a href="factorypage"><li class="actives">商家</li></a>
                <a href="resepage"><li>预约</li></a>
                <a href="javaScript:;"><li>配件商城</li></a>
                <a href="javaScript:;"><li>保养项目</li></a>
            </ul>
        </div>
        <%--主内容区开始--%>
        <div class="content" style="padding: 50px 200px;">

            <div class="content-main">
                <h2>赣州市天道有限公司</h2>
                <div class="showdata" style="padding: 30px;">
                    <div class="show-left">
                        <div>
                            <label>公司地址：</label>
                            <span>天知道在哪天知道在哪天知道在哪天知道在哪</span>
                        </div>
                        <div>
                            <label>联系电话：</label>
                            <span>15779094094</span>
                        </div>
                        <div>
                            <label>负责人：</label>
                            <span>天知道在哪wwwwwwwwwwwwwwwwwww</span>
                        </div>
                        <div>
                            <label>网站地址：</label>
                            <span>天知道在哪</span>
                        </div>
                        <div>
                            <label>公司成立时间：</label>
                            <span>公元397年</span>
                        </div>
                        <div>
                            <label>公司规模：</label>
                            <span>200</span>
                        </div>
                        <div>
                            <label>公司描述：</label>
                            <span>这。。。。</span>
                        </div>
                    </div>
                    <div class="show-right">
                        <div class="company-logo">
                            <img src="/static/img/Frontpage/u29.png"/>
                        </div>
                        <div class="rese-btn">
                            <a href="resepage" class="btn">我要预约</a>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <%--底部模块--%>
        <div class="index-bottom">
            <div class="bottom-main" style="margin-top: 0">
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
