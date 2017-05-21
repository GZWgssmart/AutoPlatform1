<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link href="/static/css/animate.min.css" rel="stylesheet">
    <style>

    </style>
</head>
<%@include file="contextmenu.jsp" %>
<body class="gray-bg" style="font-size: 0px;">
<div class="wrapper wrapper-content  animated fadeInRight">
    <div class="row">
        <div class="col-sm-10" style="margin-left: 10%;">
            <div class="ibox">
                <div class="ibox-content">
                    <div class="clients-list">
                        <div class="tab-content">
                            <div id="tab-1" class="tab-pane active">
                                <div class="full-height-scroll">
                                    <h3>公司员工</h3>
                                    <div class="table-responsive">
                                        <c:choose>
                                            <c:when test="${requestScope.userinfo!=null}">
                                                <table class="table table-striped table-hover">
                                                    <tbody>
                                                    <tr>
                                                        <td class="client-avatar">头像</td>
                                                        <td class="client-avatar">员工姓名</td>
                                                        <td>手机号</td>
                                                        <td class="contact-type">
                                                            <i class="fa fa-envelope"></i>
                                                        </td>
                                                        <td>邮箱</td>
                                                        <td class="client-status"><span
                                                                class="label label-primary">是否已经验证</span>
                                                        </td>
                                                    </tr>
                                                    <c:forEach items="${requestScope.userinfo}" var="us">
                                                        <tr>
                                                            <td class="client-avatar">
                                                                <img alt="image" src="${us.userIcon}" height="30px"
                                                                     width="30px">
                                                            </td>
                                                            <td>
                                                                <a data-toggle="tab" href="#contact-1"
                                                                   class="client-link">
                                                                        ${us.userName}
                                                                </a>
                                                            </td>
                                                            <td>${us.userPhone}</td>
                                                            <td class="contact-type">
                                                                <i class="fa fa-envelope"></i>
                                                            </td>
                                                            <td>${us.userEmail}</td>
                                                            <td class="client-status">
                                                                <span class="label label-primary">已验证</span>
                                                            </td>
                                                            <br/>
                                                        </tr>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
                                            </c:when>
                                            <c:otherwise>
                                                暂无数据
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr/>
                    <div class="ibox-content">
                        <div class="clients-list">
                            <div class="tab-content">
                                <div id="tab-2" class="tab-pane active">
                                    <div class="full-height-scroll">
                                        <h3>预约记录</h3>
                                        <div class="table-responsive">
                                            <c:choose>
                                                <c:when test="${requestScope.appinfo!=null}">
                                                    <table class="table table-striped table-hover">
                                                        <tbody>
                                                        <tr>
                                                            <td class="client-avatar">车主</td>
                                                            <i class="fa fa-envelope"></i>
                                                            <td class="client-avatar">车主电话</td>
                                                            <i class="fa fa-envelope"></i>
                                                            <i class="fa fa-envelope"></i>
                                                            <td>维修/保养</td>
                                                            <i class="fa fa-envelope"></i>
                                                            <td>预约时间</td>
                                                            <i class="fa fa-envelope"></i>
                                                            <td class="client-status"><span
                                                                    class="label label-primary">是否已经验证</span>
                                                            </td>
                                                        </tr>
                                                        <c:forEach items="${requestScope.appinfo}" var="app">
                                                            <tr>
                                                                <td class="client-avatar">
                                                                        ${app.userName}
                                                                </td>
                                                                <td>
                                                                    <a data-toggle="tab" href="#contact-1"
                                                                       class="client-link">
                                                                            ${app.userPhone}
                                                                    </a>
                                                                </td>
                                                                <td class="client-avatar">${app.maintainOrFix}</td>
                                                                <td class="client-avatar">${app.appCreatedTime}</td>
                                                                <td class="client-status">
                                                                    <span class="label label-primary">已验证</span>
                                                                </td>
                                                                <br/>
                                                            </tr>
                                                        </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </c:when>
                                                <c:otherwise>
                                                    暂无数据
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr/>
                        <div class="ibox-content">
                            <div class="clients-list">
                                <div class="tab-content">
                                    <div id="tab-4" class="tab-pane active">
                                        <div class="full-height-scroll">
                                            <h3>已完成的维修保养记录</h3>
                                            <div class="table-responsive">
                                                <c:choose>
                                                    <c:when test="${requestScope.maininfo!=null}">
                                                        <table class="table table-striped table-hover">
                                                            <tbody>
                                                            <tr>
                                                                <td class="client-avatar">维修保养项目名称</td>
                                                                <i class="fa fa-envelope"></i>
                                                                <td class="client-avatar">项目所需费用</td>
                                                                <i class="fa fa-envelope"></i>
                                                                <td>维修/保养</td>
                                                                <i class="fa fa-envelope"></i>
                                                                <td>维修时间</td>
                                                                <i class="fa fa-envelope"></i>
                                                            </tr>
                                                            <c:forEach items="${requestScope.maininfo}" var="main">
                                                                <tr>
                                                                    <td class="client-avatar">
                                                                            ${main.maintainName}
                                                                    </td>
                                                                    <td>
                                                                        <a data-toggle="tab" href="#contact-1"
                                                                           class="client-link">
                                                                                ${main.maintainMoney}
                                                                        </a>
                                                                    </td>
                                                                    <td class="client-avatar">${main.maintainOrFix}</td>
                                                                    <td class="client-avatar">${main.maintainHour}</td>
                                                                    <br/>
                                                                </tr>
                                                            </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </c:when>
                                                    <c:otherwise>
                                                        暂无数据
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="/static/js/jquery.min.js"></script>
    <script src="/static/js/bootstrap.min.js"></script>
    <script src="/static/js/contextmenu.js"></script>
    <script src="/static/js/content.min.js"></script>
    <script src="/static/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
    <script>
    </script>
</div>
</body>
</html>
