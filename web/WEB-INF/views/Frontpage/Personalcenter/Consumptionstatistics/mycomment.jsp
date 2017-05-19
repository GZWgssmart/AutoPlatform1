<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/4/11
  Time: 15:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <title>投诉管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/js/plugins/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet/less" href="/static/css/bootstrap-dateTimePicker/datetimepicker.less">
</head>
<body>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;">
        <table id="table">
            <thead>
            <tr>
                <th data-checkbox="true"></th>
                <th data-field="user.userName">投诉人</th>
                <th data-field="complaintCreatedTime" data-formatter="formatterDate">投诉时间</th>
                <th data-field="complaintContent">投诉内容</th>
                <th data-formatter="formatterUserName">投诉回复人</th>
                <th data-field="complaintReplyTime" data-formatter="formatterDate">投诉回复时间</th>
                <th data-field="complaintReply">投诉回复内容</th>
            </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <shiro:hasAnyRoles name="车主">
                <button id="btn_add" type="button" class="btn btn-default" onclick="showAdd();">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
                </button>
            </shiro:hasAnyRoles>

        </div>
    </div>
</div>

<!-- 添加弹窗 -->
<div class="modal fade" id="addWindow" aria-hidden="true" data-backdrop="static" keyboard:false style="overflow:auto; ">
    <div class="modal-dialog" style="width: 780px;height: auto;">
        <div class="modal-content" style="overflow:hidden;">
            <span class="glyphicon glyphicon-remove closeModal" onclick="closeModals('addWindow', 'addForm')"></span>
            <form class="form-horizontal" role="form" id="addForm" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写投诉信息</h4>
                </div>
                <br/>
                <div class="form-group">
                    <label class="col-sm-3 control-label">投诉人：</label>
                    <div class="col-sm-7">
                        <select id="addUserName" name="userId" class="form-control js-data-example-ajax user" style="width:100%">
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">投诉时间：</label>
                    <div class="col-sm-7">
                        <input id="addComplaintCreatedTime" name="complaintCreatedTime" readonly onclick="getDate('addComplaintCreatedTime')" class="form-control datetimepicker"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">投诉内容：</label>
                    <div class="col-sm-7">
                        <textarea type="text" name="complaintContent" placeholder="请输入投诉内容" style="height: 100px;"
                                  class="form-control"></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-sm-offset-8">
                        <button type="button" class="btn btn-default"
                                onclick="closeModals('addWindow', 'addForm')">关闭
                        </button>
                        <button id="addButton" class="btn btn-sm btn-success" type="button" onclick="addSubmit()">保 存</button>
                        <input type="reset" name="reset" style="display: none;"/>
                    </div>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->




<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script src="/static/js/jquery.formFill.js"></script>
<script src="/static/js/select2/select2.js"></script>
<script src="/static/js/sweetalert/sweetalert.min.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/plugins/layui/layui.js" charset="utf-8"></script>
<script src="/static/js/backstage/main.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>

    $(function () {
        initTable('table', '/UserqueryByPager'); // 初始化表格
        initSelect2("user", "请选择用户", "/complaint/queryCombox");
        initSelect2("admin", "请选择回复人", "/complaint/queryCombox");
    });


</script>
</body>
</html>
