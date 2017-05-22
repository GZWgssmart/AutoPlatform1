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
        <div class="col-sm-8" style="margin-left: 16%;">
            <div class="ibox">
                <div class="ibox-content">
                    <div class="clients-list">
                        <div class="tab-content">
                            <div id="tab-1" class="tab-pane active">
                                <div class="full-height-scroll">
                                    <h4>公司员工</h4>
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
                                                    </tr>
                                                    <c:forEach items="${requestScope.userinfo}" var="us">
                                                        <tr>
                                                            <td class="client-avatar">
                                                                <img alt="image" src="/${us.userIcon}" height="30px"
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
                <hr/>
                <div class="ibox-content">
                    <div class="clients-list">
                        <div class="tab-content">
                            <div id="tab-2" class="tab-pane active">
                                <div class="full-height-scroll">
                                    <h4>预约记录</h4>
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
                <hr/>
                <div class="ibox-content">
                    <div class="clients-list">
                        <div class="tab-content">
                            <div id="tab-4" class="tab-pane active">
                                <div class="full-height-scroll">
                                    <h4>已完成的维修保养记录</h4>
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
                <hr/>
                <div class="ibox-content">
                    <div class="clients-list">
                        <div class="tab-content">
                            <div id="tab-5" class="tab-pane active">
                                <div class="full-height-scroll">
                                    <h4>支出记录</h4>
                                    <div class="table-responsive">
                                        <c:choose>
                                            <c:when test="${requestScope.outgoInfo!=null}">
                                                <table class="table table-striped table-hover">
                                                    <tbody>
                                                    <tr>
                                                        <td class="client-avatar">所属用户</td>
                                                        <i class="fa fa-envelope"></i>
                                                        <td class="client-avatar">支出类型</td>
                                                        <i class="fa fa-envelope"></i>
                                                        <td class="client-avatar">支出金额</td>
                                                        <i class="fa fa-envelope"></i>
                                                        <td>创建时间</td>
                                                        <i class="fa fa-envelope"></i>
                                                    </tr>
                                                    <c:forEach items="${requestScope.outgoInfo}" var="out">
                                                        <tr>
                                                            <td class="client-avatar">
                                                                ${out.user.userName}
                                                            </td>
                                                            <td>
                                                                <a data-toggle="tab" href="#contact-1"
                                                                   class="client-link">
                                                                        ${out.outgoingType.outTypeName}
                                                                </a>
                                                            </td>
                                                            <td class="client-avatar">
                                                                    ${out.inOutMoney}
                                                            </td>
                                                            <td class="client-avatar">${out.inOutCreatedTime}</td>
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
                <hr/>
                <div class="ibox-content">
                    <div class="clients-list">
                        <div class="tab-content">
                            <div id="tab-6" class="tab-pane active">
                                <div class="full-height-scroll">
                                    <h4>收入记录</h4>
                                    <div class="table-responsive">
                                        <c:choose>
                                            <c:when test="${requestScope.incomInfo!=null}">
                                                <table class="table table-striped table-hover">
                                                    <tbody>
                                                    <tr>
                                                        <td class="client-avatar">所属用户</td>
                                                        <i class="fa fa-envelope"></i>
                                                        <td class="client-avatar">收入类型</td>
                                                        <i class="fa fa-envelope"></i>
                                                        <td class="client-avatar">收入金额</td>
                                                        <td>创建时间</td>
                                                        <i class="fa fa-envelope"></i>
                                                    </tr>
                                                    <c:forEach items="${requestScope.incomInfo}" var="in">
                                                        <tr>
                                                            <td class="client-avatar">
                                                                    ${in.user.userName}
                                                            </td>
                                                            <td>
                                                                <a data-toggle="tab" href="#contact-1"
                                                                   class="client-link">
                                                                        ${in.incomingType.inTypeName}
                                                                </a>
                                                            </td>
                                                            <td class="client-avatar">
                                                                    ${in.inOutMoney}
                                                            </td>
                                                            <td class="client-avatar">${in.inOutCreatedTime}</td>
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