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
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/datetimepicker.less">
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
               data-height="700"
               data-id-field="id"
               data-page-list="[5, 10, 20]"
               data-cach="false"
               data-click-to-select="true"
               data-single-select="true">
            <thead>
            <tr>
                <th data-radio="true" data-field="status"></th>
                <th data-field="workId">工单编号</th>
                <th data-field="recordId">保养记录编号</th>
                <th data-field="userId">工单指派用户编号</th>
                <th data-field="workAssignTime">工单指派时间</th>
                <th data-field="workcreateTime">工单创建时间</th>
                <th data-field="workStatus">当前状态</th>
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
            <button id="btn_delete" type="button" class="btn btn-default" onclick="showDel();">
                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
            </button>
        </div>
    </div>
</div>

<!-- 添加弹窗 -->

<div class="modal fade" id="add" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog" style="height: auto; overflow:auto;">
        <div class="modal-content" style="overflow:auto;">
            <form class="form-horizontal" role="form" onsubmit="return checkAdd()" id="addForm" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写订单信息</h4>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">保养记录编号：</label>
                    <div class="col-sm-7">
                        <input type="text" name="recordId" placeholder="请输入保养记录编号" class="form-control">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 control-label">指派用户编号：</label>
                    <div class="col-sm-7">
                        <input type="text" name="userId" placeholder="请输入工单指派用户编号" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">工单指派时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="workAssignTime" id="addwrokAssignTime" value="2012-05-15 21:05" placeholder="请输入工单指派时间" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">工单创建时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="workcreateTime" id="addworkcreateTime" value="2012-05-15 21:05" placeholder="请输入工单创建时间" class="form-control" max="11">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-8">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button class="btn btn-sm btn-success" type="submit">保 存</button>
                    </div>
                </div>
            </form>

        </div><!-- /.modal-content -->
    </div>
</div>


<!-- 修改弹窗 -->
<div class="modal fade" id="edit" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog" style="height: auto; overflow:auto;">
        <div class="modal-content" style="overflow:auto;">
            <form class="form-horizontal" role="form" onsubmit="return checkEdit()" id="editForm" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请修改订单信息</h4>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">保养记录编号：</label>
                    <div class="col-sm-7">
                        <input type="text" name="recordId" placeholder="请输入保养记录编号" class="form-control">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 control-label">指派用户编号：</label>
                    <div class="col-sm-7">
                        <input type="text" name="userId" placeholder="请输入工单指派用户编号" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">工单指派时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="workAssignTime" id="editwrokAssignTime" value="2012-05-15 21:05" placeholder="请输入工单指派时间" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">工单创建时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="workcreateTime" id="editworkcreateTime" value="2012-05-15 21:05" placeholder="请输入工单创建时间" class="form-control" max="11">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-8">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button class="btn btn-sm btn-success" type="submit">保 存</button>
                    </div>
                </div>
            </form>

        </div><!-- /.modal-content -->
    </div>
</div><!-- /.modal -->

<!-- 删除弹窗 -->
<div class="modal fade" id="del" aria-hidden="true">
    <div class="modal-dialog" >
        <form action="/table/edit" method="post">
            <div class="modal-content">
                <input type="hidden" id="delNoticeId"/>
                <div class="modal-footer" style="text-align: center;">
                    <h2>确认删除吗?</h2>
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button type="sumbit" class="btn btn-primary" onclick="del()">
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
<script src="/static/js/form/jquery.validate.js"></script>
<script src="/static/js/contextmenu.js"></script>
<script src="/static/js/backstage/emp/workInFo.js"></script>
<script src="/static/js/bootstrap-select/bootstrap-select.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>

</body>
</html>
