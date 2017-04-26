
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
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
                <th data-radio="true"></th>
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
                <th data-width="100" data-field="workStatus" data-formatter="formatterStatus">
                    工单状态
                </th>
                <th data-width="100" data-field="workStatus" data-formatter="openStatusFormatter">
                    操作
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
            <button id="searchDisable" type="button" class="btn btn-danger" onclick="">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询未完成工单
            </button>
            <button id="searchRapid" type="button" class="btn btn-success" onclick="">
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
                        <select id="addRecordId" class="js-example-tags record" name="recordId" style="width:100%;">
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 control-label">指派用户编号：</label>
                    <div class="col-sm-7">
                        <select id="addUserId" class="js-example-tags user" name="userId" style="width:100%;">
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">工单指派时间：</label>
                    <div class="col-sm-7">
                        <input type="date" name="workAssignTime" id="addworkAssignTime" placeholder="请输入工单指派时间" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">工单创建时间：</label>
                    <div class="col-sm-7">
                        <input type="date" name="workCreatedTime" id="addworkCreateTime"placeholder="请输入工单创建时间" class="form-control">
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
            <form class="form-horizontal" role="form"id="editForm">
                <input type="hidden" name="workId" define="Order.workId"/>
                <input type="hidden"name="workStatus" define="Order.workStatus">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写订单信息</h4>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">保养记录编号：</label>
                    <div class="col-sm-7">
                        <select id="editRecordId" class="js-example-tags record" name="recordId" style="width:100%;">
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 control-label">指派用户编号：</label>
                    <div class="col-sm-7">
                        <select id="editUserId" class="js-example-tags user" name="userId" style="width:100%;">
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">工单指派时间：</label>
                    <div class="col-sm-7">
                        <input type="date" name="workAssignTime" id="addworkAssignTime" placeholder="请输入工单指派时间" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">工单创建时间：</label>
                    <div class="col-sm-7">
                        <input type="date" name="workCreatedTime" id="addworkCreateTime"placeholder="请输入工单创建时间" class="form-control">
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


<div id="recordWindow" class="modal fade" aria-hidden="true" style="overflow:scroll" data-backdrop="static" keyboard:false>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 b-r">
                        <h3 class="m-t-none m-b">维修保养记录添加</h3>
                        <table class="table table-hover" id="recordTable">
                            <thead>
                            <tr>
                                <th data-radio="true"></th>
                                <th data-width="100" data-formatter="maintainRecord.recordId">
                                    保养记录编号
                                </th>
                                <th data-width="100" data-field="user.userId">
                                    指派工单编号
                                </th>
                                <th data-width="100" data-field="workAssignTime" data-formatter="formatterDate">
                                    工单指派时间
                                </th>
                                <th data-width="100" data-field="workCreatedTime"  data-formatter="formatterDateTime">
                                    工单创建时间
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                        <div style="height: 100px;"></div>
                        <div class="modal-footer" style="overflow:hidden;">
                            <button type="button" class="btn btn-default" onclick="closeAppWin()">关闭
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

<!-- 删除弹窗 -->
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
