<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/css/fileinput.css">
    <link rel="stylesheet" href="/static/css/bootstrap-validate/bootstrapValidator.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/datetimepicker.less">

    <title>支出管理</title>
</head>
<body>

<%@include file="../backstage/contextmenu.jsp" %>

<div class="container">
<div class="panel-body" style="padding-bottom:0px;" >
<!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
<!-- table里的所有属性在bootstrap-table.js的240行-->
<table id="table">
    <thead>
    <tr>
        <th data-radio="true"></th>
        <th data-field="user.userName">姓名</th>
        <th data-field="prizeSalary">奖金</th>
        <th data-field="minusSalay">罚款</th>
        <th data-field="totalSalary">总工资</th>
        <th data-field="salaryDes">工资发放描述</th>
        <th data-formatter="formatterDate" data-field="salaryTime">工资发放时间</th>
        <th data-formatter="formatterDate" data-field="salaryCreatedTime">创建时间</th>
    </tr>
    </thead>
</table>
<div id="toolbar" class="btn-group">
<shiro:hasAnyRoles name="公司超级管理员,公司普通管理员,汽车公司财务人员">
    <button id="btn_add" type="button" class="btn btn-default" onclick="showAdd();">
    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
    </button>
</shiro:hasAnyRoles>

    <shiro:hasAnyRoles name="公司超级管理员,公司普通管理员,汽车公司财务人员">
        <button id="btn_edit" type="button" class="btn btn-default" onclick="showEdit();">
            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
        </button>
    </shiro:hasAnyRoles>
    <shiro:hasAnyRoles name="系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司财务人员">
        <button type="button" class="btn btn-default">
            <a href="/salary/exportExcel">导出数据</a>
        </button>
    </shiro:hasAnyRoles>
    <shiro:hasAnyRoles name="系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司财务人员">
        <button type="button" class="btn btn-default">
            <a href="javascript:void(0)" onclick="importData();">导入数据</a>
        </button>
    </shiro:hasAnyRoles>
    </div>
    </div>
    </div>


    <!-- 添加弹窗 -->
    <div aria-hidden="true" data-backdrop="static" keyboard:false
         class="modal fade" id="import" aria-hidden="true" style="overflow:auto;">
        <div class="container kv-main">
            <div class="ibox-title">
                <div class="input-group">
                    <div class="input-group-btn">
                    </div>
                    <input id="txt_file" name="txt_file" type="file" class="form-control" multiple class="file-loading"
                           placeholder="请选择或输入一个你想上传的相册类型,默认当天日期为类型!"/>
                </div>

            </div>

        </div>
    </div><!-- /.modal -->


    <!-- 添加弹窗 -->
    <div aria-hidden="true" data-backdrop="static" keyboard:false
         class="modal fade" id="add" aria-hidden="true" style="overflow:auto;">
    <div class="modal-dialog">
    <div class="modal-content">
    <div class="container">
        <div class="modal-body">

            <span class="glyphicon glyphicon-remove closeModal" data-dismiss="modal" onclick="closeModals('add','addForm')"></span>
                <form class="form-horizontal" role="form" id="addForm">
                <div class="modal-header" style="overflow:auto;">
                <p>员工工资录入</p>
                </div>
                <div class="form-group">
                <label class="col-sm-3 control-label" for="userName">员工姓名：</label>
                <div class="col-sm-7">
                <input type="hidden" id="userId" readonly="true" name="userId">
                <input onclick="checkAppointment();" type="text" readonly="true" name="userName" id="userName" placeholder="请点击选择员工" class="form-control">
                </div>

                </div>
                <div class="form-group">
                <label class="col-sm-3 control-label">罚款：</label>
                <div class="col-sm-7">
                <input type="text" name="minusSalay" placeholder="请输入罚款" class="form-control">
                </div>
                </div>
                <div class="form-group">
                <label class="col-sm-3 control-label">奖金：</label>
                <div class="col-sm-7">
                <input type="text" name="prizeSalary" placeholder="请输入奖金" class="form-control">
                </div>
                </div>
                <div class="form-group">
                <label class="col-sm-3 control-label">总工资：</label>
                <div class="col-sm-7">
                <input type="text" name="totalSalary" placeholder="请输入总工资" class="form-control">
                </div>
                </div>

                <div class="form-group">
                <label class="col-sm-3 control-label" >工资描述：</label>
                <div class="col-sm-7">
                <input type="text" name="salaryDes" placeholder="请输入工资发放描述" class="form-control">
                </div>
                </div>

                <div class="form-group">
                <label class="col-sm-3 control-label">工资发放时间：</label>
                <div class="col-sm-7">
                <input type="date" name="salaryTime" placeholder="请选择工资发放时间" id="salaryTime" class="form-control">
                </div>
                </div>

                <div class="modal-footer">
                <span id="addError"></span>
                <button type="button" class="btn btn-default" onclick="closeModals('add','addForm')">关闭
                </button>
                <button type="button" id="addButton" onclick="addSubmit()" class="btn btn-success btn-sm">保存</button>
                </div>
                </form>
        </div>
    </div>
    </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->


    <%--人员管理窗弹窗显示--%>
    <div id="personnelWin" class="modal fade" aria-hidden="true" style="overflow:scroll" data-backdrop="static" keyboard:false>
    <div class="modal-dialog">
    <div class="modal-content">
    <div class="modal-body">
    <div class="row">
    <div class="col-sm-12 b-r">
    <h3 class="m-t-none m-b">选择人员</h3>
    <table class="table table-hover" id="appTable"
    data-height="550">
    <thead>
    <tr>
    <th data-radio="true" data-field="status"></th>
    <th data-field="userName">姓名</th>
    </tr>
    </thead>
    <tbody>
    </tbody>

    </table>
    <div class="modal-footer">
    <button type="button" class="btn btn-default" onclick="closePersonnelWin()">关闭
    </button>
    <input type="button" class="btn btn-primary" onclick="checkPersonnel()" value="确定">
    </input>
    </div>
    </div>

    </div>
    </div>
    </div>
    </div>
    </div>


    <!-- 修改弹窗 -->
    <div aria-hidden="true" data-backdrop="static" keyboard:false
         class="modal fade" id="edit" aria-hidden="true">
    <div class="modal-dialog">
    <div class="modal-content">
    <div class="container" >
        <div class="modal-body">

        <span class="glyphicon glyphicon-remove closeModal" data-dismiss="modal" onclick="closeModals('edit','editForm')"></span>
    <form class="form-horizontal" role="form" id="editForm" method="post">
    <input type="hidden" define="salary.salaryId" name="salaryId">
    <div class="modal-header" style="overflow:auto;">
    <p>修改员工工资录入</p>
    </div>
    <div class="form-group">
    <label class="col-sm-3 control-label" for="userName">员工姓名：</label>
    <div class="col-sm-7">
    <input type="hidden" define="salary.userId" name="userId">
    <input define="salary.user.userName" type="text" readonly="true" class="form-control">
    </div>
    </div>
    <div class="form-group">
    <label class="col-sm-3 control-label">罚款：</label>
    <div class="col-sm-7">
    <input type="text" define="salary.minusSalay" name="minusSalay" class="form-control">
    </div>
    </div>
    <div class="form-group">
    <label class="col-sm-3 control-label">奖金：</label>
    <div class="col-sm-7">
    <input type="text" define="salary.prizeSalary" name="prizeSalary" class="form-control">
    </div>
    </div>
    <div class="form-group">
    <label class="col-sm-3 control-label">总工资：</label>
    <div class="col-sm-7">
    <input type="text" define="salary.totalSalary" name="totalSalary" class="form-control">
    </div>
    </div>

    <div class="form-group">
    <label class="col-sm-3 control-label" >工资描述：</label>
    <div class="col-sm-7">
    <input type="text" define="salary.salaryDes" name="salaryDes" class="form-control">
    </div>
    </div>

    <div class="form-group">
    <label class="col-sm-3 control-label">工资发放时间：</label>
    <div class="col-sm-7">
        <input type="text" name="salaryTime"
               onclick="getDate('editDateTimePicker')" id="editDateTimePicker" class="form-control">
    </div>
    </div>
    <div class="modal-footer">
    <span id="editError"></span>
    <button type="button" class="btn btn-default"
    data-dismiss="modal"  onclick="closeModals('edit','editForm')">关闭
    </button>
    <button type="button" id="editButton" onclick="editSubmit()" class="btn btn-success btn-sm">保存</button>
    </div>
    </form>
        </div>
    </div>
    </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->


    <!-- 提示弹窗 -->
    <div class="modal fade" id="tanchuang" aria-hidden="true">
    <div class="modal-dialog">
    <div class="modal-content">
    <div class="modal-header">
    提示
    </div>
    <div class="modal-body">
    请先选择某一行
    </div>
    <div class="modal-footer">
    <button type="button" class="btn btn-default"
    data-dismiss="modal">关闭
    </button>
    </div>
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
<script src="/static/js/contextmenu.js"></script>
<script src="/static/js/bootstrap-select/bootstrap-select.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="/static/js/backstage/main.js"></script>
<script src="/static/js/bootstrap-switch/bootstrap-switch.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/backstage/financialControlJS/salary.js"></script>
<script src="/static/js/fileInput/fileinput.js"></script>
<script src="/static/js/fileInput/zh.js"></script>

    </body>
    </html>
