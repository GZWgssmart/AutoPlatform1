<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/4/11
  Time: 15:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>维修保养项目管理</title>
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
<%@include file="../backstage/contextmenu.jsp" %>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;">
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
               data-height="543"
               data-id-field="id"
               data-page-list="[5, 10, 20]"
               data-cach="false"
               data-click-to-select="true"
               data-single-select="true">
            <thead>
            <tr>
                <th data-radio="true" data-field="status"></th>
                <th data-field="recordId">进度编号</th>
                <th data-field="checkinId">登记编号</th>
                <th data-field="startTime">开始时间</th>
                <th data-field="endTime">预估结束时间</th>
                <th data-field="actualEndTime">实际结束时间</th>
                <th data-field="recordCreatedTime">创建时间</th>
                <th data-field="pickupTime">车主提车时间</th>
                <th data-field="recordDes">进度描述</th>
                <th data-field="recordStatus">状态</th>
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
<div class="modal fade" id="addWindow" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog" style="width: 700px;height: auto;">
        <div class="modal-content" style="overflow:auto;">
            <form class="form-horizontal" role="form" onsubmit="return checkAdd()" id="showAddFormWar" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写车辆维修保养</h4>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">登记编号：</label>
                    <div class="col-sm-7">
                        <input type="text" name="checkinId" placeholder="请输入登记编号" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">开始时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="startTime" value="2012-05-15 21:05" id="addDateTimePicker"
                               class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">预估结束时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="endTime" value="2012-05-15 21:05" id="addDateTimePicker2"
                               class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">实际结束时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="actualEndTime" value="2012-05-15 21:05" id="addDateTimePicker3"
                               class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">创建时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="recordCreatedTime" value="2012-05-15 21:05" id="addDateTimePicker4"
                               class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">车主提车时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="pickupTime" value="2012-05-15 21:05" id="addDateTimePicker5"
                               class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">进度描述：</label>
                    <div class="col-sm-7">
                        <input type="text" name="recordDes" placeholder="请输入保养进度描述" class="form-control">
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
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<!-- 修改弹窗 -->
<div class="modal fade" id="editWindow" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog" style="width: 700px;height: auto;">
        <div class="modal-content" style="overflow:hidden;">
            <form class="form-horizontal" role="form" onsubmit="return checkEdit()" id="showEditFormWar" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写车辆维修保养</h4>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">进度编号：</label>
                    <div class="col-sm-7">
                        <input type="text" name="recordId" placeholder="请输入进度编号" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">登记编号：</label>
                    <div class="col-sm-7">
                        <input type="text" name="checkinId" placeholder="请输入登记编号" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">开始时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="startTime" value="2012-05-15 21:05" id="editDateTimePicker"
                               class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">预估结束时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="endTime" value="2012-05-15 21:05" id="editDateTimePicker2"
                               class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">实际结束时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="actualEndTime" value="2012-05-15 21:05" id="editDateTimePicker3"
                               class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">创建时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="recordCreatedTime" value="2012-05-15 21:05" id="editDateTimePicker4"
                               class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">车主提车时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="pickupTime" value="2012-05-15 21:05" id="aditDateTimePicker5"
                               class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">进度描述：</label>
                    <div class="col-sm-7">
                        <input type="text" name="recordDes" placeholder="请输入保养进度描述" class="form-control">
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
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 删除弹窗 -->
<div class="modal fade" id="del" aria-hidden="true">
    <div class="modal-dialog" style="overflow:hidden;">
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

<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script src="/static/js/jquery.formFill.js"></script>
<script src="/static/js/select2/select2.js"></script>
<script src="/static/js/sweetalert/sweetalert.min.js"></script>
<script src="/static/js/contextmenu.js"></script>
<script src="/static/js/fileInput/fileinput.js"></script>
<script src="/static/js/fileInput/zh.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<%--
    被注释的两行是移动端版本的datetimepicker
--%>
<%--<script src="/static/js/dateTimePicker/moment.js"></script>--%>
<%--<script src="/static/js/dateTimePicker/bootstrap-datetimepicker.js"></script>--%>
<script src="/static/js/form/jquery.validate.js"></script>
<script src="/static/js/backstage/basicInfoManage/maintenance.js"></script>
</body>
</html>
