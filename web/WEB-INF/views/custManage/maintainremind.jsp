<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/4/11
  Time: 15:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <title>维修保养提醒</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/js/plugins/layui/css/layui.css" media="all">
</head>
<body>
<%@include file="../backstage/contextmenu.jsp" %>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;">
        <!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table">
            <thead>
            <tr>
                <th data-checkbox="true"></th>
                <th data-field="user.userName">用户名</th>
                <th data-field="lastMaintainTime" data-formatter="formatterDate">上次维修保养时间</th>
                <th data-field="lastMaintainMileage">上次汽车行驶里程</th>
                <th data-field="remindMsg">维修保养提醒消息</th>
                <th data-field="remindTime" data-formatter="formatterDate">维修保养提醒时间</th>
                <th data-field="remindType">维修保养提醒方式</th>
                <th data-field="remindCreatedTime" data-formatter="formatterDate">提醒记录创建时间</th>
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
        </div>
    </div>
</div>

<!-- 添加弹窗 -->
<div class="modal fade" id="addWindow" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog" style="width: 790px;height: auto;">
        <div class="modal-content" style="overflow:hidden;">
            <form class="form-horizontal" id="addForm" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写维修维修保养提醒信息</h4>
                </div>
                <br/>
                <div class="form-group">
                    <label class="col-sm-3 control-label">用户名：</label>
                    <div class="col-sm-7">
                        <select id="addUserName" name="userId" class="form-control js-data-example-ajax user"
                                style="width:100%">
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">上次维修保养时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="lastMaintainTime" value="2012-05-15 21:05" id="addDateTimePicker" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">上次汽车行驶里程：</label>
                    <div class="col-sm-7">
                        <input type="text" name="lastMaintainMileage" placeholder="请输入上次汽车行驶里程" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修保养提醒内容：</label>
                    <div class="col-sm-7">
                        <textarea type="text" name="remindMsg" placeholder="请输入维修保养提醒内容" style="height: 100px;"
                                  class="form-control"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修保养提醒时间：</label>
                    <div class="col-sm-7">
                        <input type="text"  name="remindTime" value="2012-05-15 21:05" id="addDateTimePicker1" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修保养提醒方式：</label>
                    <div class="col-sm-7">
                        <input type="text" name="remindType" placeholder="请选择维修保养提醒方式" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修保养记录创建时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="remindCreatedTime" value="2012-05-15 21:05" id="addDateTimePicker2" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-8">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button id="addButton" class="btn btn-sm btn-success" type="button" onclick="addSubmit()">保 存</button>
                    </div>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<!-- 修改弹窗 -->
<div class="modal fade" id="editWindow" aria-hidden="true">
    <div class="modal-dialog" style="width: 790px;height: auto;">
        <div class="modal-content">
            <form class="form-horizontal" id="editForm" method="post">
                <input type="hidden" name="remindId" define="MaintainRemind.remindId">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请修改维修维修保养提醒信息</h4>
                </div>
                <br/>
                <div class="form-group">
                    <label class="col-sm-3 control-label">用户名称：</label>
                    <div class="col-sm-7">
                        <select id="editUserName" name="userId" class="form-control js-data-example-ajax user"
                                style="width:100%">
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">上次维修保养时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="lastMaintainTime" define="MaintainRemind.lastMaintainTime" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">上次汽车行驶里程：</label>
                    <div class="col-sm-7">
                        <input type="text" name="lastMaintainMileage" define="MaintainRemind.lastMaintainMileage" placeholder="请输入上次汽车行驶里程" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修保养提醒内容：</label>
                    <div class="col-sm-7">
                        <textarea type="text"  name="remindMsg" define="MaintainRemind.remindMsg"  placeholder="请输入维修保养提醒内容" style="height: 100px;"
                                  class="form-control"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修保养提醒时间：</label>
                    <div class="col-sm-7">
                        <input type="text"  name="remindTime" define="MaintainRemind.remindTime" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修保养提醒方式：</label>
                    <div class="col-sm-7">
                        <input type="text" name="remindType" define="MaintainRemind.remindType" placeholder="请选择维修保养提醒方式" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">提醒记录创建时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="remindCreatedTime" define="MaintainRemind.remindCreatedTime" value="2012-05-15 21:05"
                               id="editDateTimePicker2" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-8">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button id="editButton" class="btn btn-sm btn-success" type="button" onclick="editSubmit">保 存</button>
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
<script src="/static/js/contextmenu.js"></script>
<script src="/static/js/backstage/custManage/maintainremind.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/plugins/layui/layui.js" charset="utf-8"></script>
<script src="/static/js/backstage/main.js"></script>
</body>
</html>
