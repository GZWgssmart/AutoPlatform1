<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<h ead>
    <title>员工工单管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/css/bootstrap-validate/bootstrapValidator.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/datetimepicker.less">

<%--<link rel="stylesheet" href="/static/css/table/table.css">--%>
</head>
<body>
<%@include file="../backstage/contextmenu.jsp"%>

<div class="container">
    <div class="panel-body">
        <!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table" style="table-layout: fixed">
            <thead>
            <tr>
                <th data-radio="true" data-field="status"></th>
                <th data-width="100" data-field="maintainRecord.chickinId">
                    保养记录编号
                </th>
                <th data-width="100" data-field="user.userName">
                    指派工单编号
                </th>
                <th data-width="100" data-field="workAssignTime" data-formatter="formatterDate">
                    工单指派时间
                </th>
                <th data-width="100" data-field="workCreatedTime"  data-formatter="formatterDateTime">
                    工单创建时间
                </th>
                <th data-width="100" data-field="workStatus" data-formatter="statusFormatter">
                    工单状态
                </th>
            </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <button id="btn_add" type="button" class="btn btn-default" onclick="showAdd();">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
            </button>
            <button id="btn_edit" type="button" class="btn btn-default" onclick="showEdit();">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
            </button>
            <button id="searchDisable" type="button" class="btn btn-danger" onclick="showDisable();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询未完成工单
            </button>
            <button id="searchRapid" type="button" class="btn btn-success" onclick="showComplete();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询已完成工单
            </button>
        </div>
    </div>
</div>

<!-- 添加弹窗 -->

<div id="addWindow" class="modal fade" style="overflow:scroll" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <form class="form-horizontal" role="form" id="addForm">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写订单信息</h4>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">保养记录编号：</label>
                    <div class="col-sm-7">
                       <%-- <select id="addRecordId" class="js-example-tags record" name="recordId" style="width:100%;">
                        </select>--%>
                        <input type="hidden"  id="addRecordId" readonly="true" name="recordId">
                        <input type="text" onclick="openRecord();" readonly="true" id="checkinId" name="recordId" placeholder="请点击选择保养记录" class="form-control">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 control-label">指派用户编号：</label>
                    <div class="col-sm-7">
                        <%--<select id="addUserId" class="js-example-tags user" name="userId" style="width:100%;">
                        </select>--%>
                            <input type="hidden"  id="addUserId" readonly="true" name="userId">
                            <input type="text" onclick="openUser();" readonly="true" id="addUserId" name="userId" placeholder="请点击选择用户" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">工单指派时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="workAssignTime" id="addworkAssignTime" onclick="getDate('addworkAssignTime');" placeholder="请输入工单指派时间" class="form-control datetimepicker">
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="col-sm-offset-8">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button id="addButton" type="button" onclick="addSubmit()" class="btn btn-primary">添加</button>
                        <input type="reset" name="reset" style="display: none;"/>
                    </div>
                </div>
            </form>

        </div><!-- /.modal-content -->
    </div>
</div>

<!-- 修改弹窗 -->
<div class="modal fade" id="editWindow" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog" style="height: auto; overflow:auto;">
        <div class="modal-content" style="overflow:auto;">
            <form class="form-horizontal" role="form" id="editForm" method="post">
                <input type="hidden" name="workId" define="WorkInfo.workId"/>
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写订单信息</h4>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">保养记录编号：</label>
                    <div class="col-sm-7">
                        <input type="hidden"  id="editRecordId" readonly="true" name="recordId">
                        <input type="text" onclick="openEditRecord();" readonly="true" id="editcheckinId" name="recordId" placeholder="请点击选择保养记录" class="form-control">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 control-label">指派用户编号：</label>
                    <div class="col-sm-7">
                        <%--<select id="editUserId" class="js-example-tags user" name="userId" style="width:100%;">
                        </select>--%>
                        <input type="hidden"  id="addUserId" readonly="true" name="userId">
                        <input type="text" onclick="openEditUser();" readonly="true" id="addUserId" name="userId" placeholder="请点击选择用户" class="form-control">

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">工单指派时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="workAssignTime" id="editworkAssignTime" onclick="getDate('editworkAssignTime');" placeholder="请输入工单指派时间" class="form-control datetimepicker">
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="col-sm-offset-8">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button id="editButton" type="button" onclick="editSubmit()" class="btn btn-primary">添加</button>
                        <input type="reset" name="reset" style="display: none;"/>
                    </div>
                </div>
            </form>

        </div><!-- /.modal-content -->
    </div>
</div><!-- /.modal -->

<%--add维修保养记录弹窗--%>
<div id="recordWindow" class="modal fade" aria-hidden="true" style="overflow:scroll" data-backdrop="static" keyboard:false>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 b-r">
                        <h3 class="m-t-none m-b">维修保养记录信息</h3>
                        <table class="table table-hover" id="recordTable" data-height="550">
                            <thead>
                            <tr>
                                <th data-radio="true" data-field="status"></th>
                                <th data-feild="maintainRecord.recordId">
                                    保养记录编号
                                </th>
                                <th data-feild="maintainRecord.startTime">
                                    维修保养开始时间
                                </th>
                                <th data-feild="maintainRecord.endTime">
                                    预估结束时间
                                </th>
                                <th data-feild="maintainRecord.recordCreatedTime">
                                    实际结束时间
                                </th>
                                <th data-feild="maintainRecord.pickupTime">
                                    车主提车时间
                                </th>
                                <th data-field="maintainRecord.recordDes">
                                    维修保养记录描述
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                        <div class="modal-footer" style="overflow:hidden;">
                            <button type="button" class="btn btn-default" onclick="closeRecord()">关闭
                            </button>
                            <input type="button" class="btn btn-primary" onclick="openRecord()" value="确定">
                            </input>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<%--add工单指派用户弹窗--%>
<div id="userWindow" class="modal fade" aria-hidden="true" style="overflow:scroll" data-backdrop="static" keyboard:false>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 b-r">
                        <h3 class="m-t-none m-b">工单指派用户信息</h3>
                        <table class="table table-hover" id="userTable" data-height="550">
                            <thead>
                            <tr>
                                <th data-radio="true" data-field="status"></th>
                                <th data-feild="user.userEmail">
                                    用户邮箱
                                </th>
                                <th data-feild="user.userPhone">
                                    用户电话
                                </th>
                                <th data-feild="user.userName">
                                    用户名字
                                </th>
                                <th data-feild="user.userGender">
                                    用户性别
                                </th>
                                <th data-feild="user.userIdentity">
                                    用户身份证
                                </th>
                                <th data-field="user.userAddress">
                                    用户地址
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                        <div class="modal-footer" style="overflow:hidden;">
                            <button type="button" class="btn btn-default" onclick="closeUser()">关闭
                            </button>
                            <input type="button" class="btn btn-primary" onclick="openUser()" value="确定">
                            </input>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>


<%--edit维修保养记录弹窗--%>
<div id="editRecordWindow" class="modal fade" aria-hidden="true" style="overflow:scroll" data-backdrop="static" keyboard:false>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 b-r">
                        <h3 class="m-t-none m-b">维修保养记录信息</h3>
                        <table class="table table-hover" id="editRecordTable" data-height="550">
                            <thead>
                            <tr>
                                <th data-radio="true" data-field="status"></th>
                                <th data-feild="maintainRecord.recordId">
                                    保养记录编号
                                </th>
                                <th data-feild="maintainRecord.startTime">
                                    维修保养开始时间
                                </th>
                                <th data-feild="maintainRecord.endTime">
                                    预估结束时间
                                </th>
                                <th data-feild="maintainRecord.recordCreatedTime">
                                    实际结束时间
                                </th>
                                <th data-feild="maintainRecord.pickupTime">
                                    车主提车时间
                                </th>
                                <th data-field="maintainRecord.recordDes">
                                    维修保养记录描述
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                        <div class="modal-footer" style="overflow:hidden;">
                            <button type="button" class="btn btn-default" onclick="closeEditRecord()">关闭
                            </button>
                            <input type="button" class="btn btn-primary" onclick="openRecord()" value="确定">
                            </input>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<%--edit工单指派用户弹窗--%>
<div id="editUserWindow" class="modal fade" aria-hidden="true" style="overflow:scroll" data-backdrop="static" keyboard:false>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 b-r">
                        <h3 class="m-t-none m-b">工单指派用户信息</h3>
                        <table class="table table-hover" id="editUserTable" data-height="550">
                            <thead>
                            <tr>
                                <th data-radio="true" data-field="status"></th>
                                <th data-feild="user.userEmail">
                                    用户邮箱
                                </th>
                                <th data-feild="user.userPhone">
                                    用户电话
                                </th>
                                <th data-feild="user.userName">
                                    用户名字
                                </th>
                                <th data-feild="user.userGender">
                                    用户性别
                                </th>
                                <th data-feild="user.userIdentity">
                                    用户身份证
                                </th>
                                <th data-field="user.userAddress">
                                    用户地址
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                        <div class="modal-footer" style="overflow:hidden;">
                            <button type="button" class="btn btn-default" onclick="closeEditUser();">关闭
                            </button>
                            <input type="button" class="btn btn-primary" onclick="" value="确定">
                            </input>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<!-- 删除弹窗 -->
<%--
<div class="modal fade" id="del" aria-hidden="true">
    <div class="modal-dialog" >
        <form action="/Order/deleteById" method="post">
            <div class="modal-content">
                <input type="hidden" id="delNoticeId"/>
                <div class="modal-footer" style="text-align: center;">
                    <h2>确认删除吗?</h2>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="sumbit" class="btn btn-primary" onclick="showDel()">
                        确认
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </form>
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
--%>

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
<script src="/static/js/backstage/emp/workInFo.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="/static/js/backstage/main.js"></script>

</body>
<script>

</script>
</html>
