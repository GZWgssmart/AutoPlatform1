<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <meta charset="utf-8">
    <title>提车提醒管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
</head>
<body>
<%@include file="../backstage/contextmenu.jsp"%>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;"  >
        <!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table"
               data-toggle="table"
               data-toolbar="#toolbar"
               data-url="/table/query"
               data-method="post"
               data-query-params="queryParams"
               data-pagination="true"
               data-search="true"
               data-show-refresh="true"
               data-show-toggle="true"
               data-show-columns="true"
               data-page-size="10"
               data-height="550"
               data-id-field="id"
               data-page-list="[5, 10, 20]"
               data-cach="false"
               data-single-select="false"
               data-click-to-select="true">
            <thead>
            <tr>
                <th data-checkBox="true" data-field="status"></th>
                <th  data-field="name">工单编号</th>
                <th  data-field="name">工单创建时间</th>
                <th data-field="price">工单指派时间</th>
                <th data-field="price">维修保养记录编号</th>
                <th data-field="price">维修保养记录开始时间</th>
                <th data-field="price">维修保养记录预估时间</th>
                <th data-field="price">维修保养记录描述</th>
                <th data-field="price">车主手机</th>
                <th data-field="price">车主姓名</th>
                <th data-field="price">工单状态</th>
            </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <button id="btn_bell" type="button" class="btn btn-default" onclick="showBell();">
                <span class="glyphicon glyphicon-bell" aria-hidden="true"></span>提醒
            </button>
            <button id="btn_bellAll" type="button" class="btn btn-default" onclick="showBellAll();">
                <span class="glyphicon glyphicon-bell" aria-hidden="true"></span>全部提醒
            </button>
        </div>
    </div>
</div>
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script src="/static/js/jquery.formFill.js"></script>
<script src="/static/js/select2/select2.js"></script>
<script src="/static/js/sweetalert/sweetalert.min.js"></script>
<script src="/static/js/contextmenu.js"></script>
<script src="/static/js/backstage/clearingOut/carRemind.js"></script>
</body>
</html>
