<%--
  Created by IntelliJ IDEA.
  User: 不曾有黑夜
  Date: 2017/5/9
  Time: 20:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>主页</title>
</head>
<link rel="stylesheet" href="/static/css/bootstrap.css">
<link rel="stylesheet" href="/static/css/animate.css">
<link rel="stylesheet" href="/static/css/TopBtm.css">
<link rel="stylesheet" href="/static/css/paging.css">
<link rel="stylesheet" href="/static/css/FactoryPageStyle.css">
<body>
<div class="content" style="padding:15px 15px;margin: 0;background:#fff;height: 100%;">
    <%--商家列表--%>
    <div class="showfactory" style="padding:0;margin: 0;">
        <div class="hot-factory">
            <div class="title">
                <h3>热门商家</h3>
            </div>

                    <c:forEach items="${requestScope.companys}" var="c">
                        <div class="factory">
                            <div class="f-img">
                                <a href="factorydeta">
                                    <img src="${c.companyLogo}"/>
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
                                <span class="tuijian" title="预约">
                                    <a href="/appointmenting" style="width: auto;" class="btn btn-info btn-block">预约</a>
                                </span>
                            </div>
                        </div>
                    </c:forEach>
        </div>
    </div>
</body>
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/jquery.cxselect.min.js"></script>

</html>
