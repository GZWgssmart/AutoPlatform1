<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <title>维修项目管理</title>
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
</head>
<body>
<%@include file="../backstage/contextmenu.jsp" %>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;">
        <table id="table" style="table-layout: fixed">
            <thead>
            <tr>
                <th data-radio="true" data-field="status"></th>
                <th data-field="maintainName">维修项目名称</th>
                <th data-field="maintainHour">维修项目工时</th>
                <th data-field="maintainMoney">维修项目基础费用</th>
                <th data-field="maintainManHourFee">维修项目工时费</th>
                <th data-field="maintainDes">维修项目描述</th>
                <th data-field="company.companyName">维修项目所属公司</th>
                <th data-field="maintainStatus" data-formatter="statusFormatter">维修项目状态</th>
            </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <button id="btn_available" type="button" class="btn btn-default" onclick="showAvailable();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>可用维修记录
            </button>
            <button id="btn_disable" type="button" class="btn btn-default" onclick="showDisable();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>禁用维修记录
            </button>
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
<div id="addWindow" class="modal fade" style="overflow-y:scroll" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <form role="form" class="form-horizontal" id="addForm">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写该维修项目的相关信息</h4>
                </div>
                <br/>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修项目名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="maintainName" placeholder="请输入维修项目名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修项目工时：</label>
                    <div class="col-sm-7">
                        <input type="text" name="maintainHour" placeholder="请输入维修项目工时" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修项目基础费用：</label>
                    <div class="col-sm-7">
                        <input type="text" name="maintainMoney" placeholder="请预估维修项目基础费用" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修项目工时费：</label>
                    <div class="col-sm-7">
                        <input type="text" name="maintainManHourFee" placeholder="请输入维修项目工时费" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修项目描述：</label>
                    <div class="col-sm-7">
                                <textarea class="form-control" placeholder="请输入维修项目描述" name="maintainDes"
                                          rows="3" maxlength="500"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修项目所属公司：</label>
                    <div class="col-sm-7">
                        <select id="addCompany" class="js-example-tags Company" name="companyId" style="width:100%">
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button id="addButton" type="button" onclick="addSubmit()" class="btn btn-primary">添加
                    </button>
                    <input type="reset" name="reset" style="display: none;"/>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<!-- 修改弹窗 -->
<div class="modal fade" id="editWindow" style="overflow-y:scroll" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <form form role="form" class="form-horizontal" id="editForm">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写该维修项目的相关信息</h4>
                </div>
                <input type="hidden" name="maintainId" define="MaintainFixMap.maintainId">
                <input type="hidden" name="maintainStatus" define="MaintainFixMap.maintainStatus">
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修项目名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="maintainName" define="MaintainFixMap.maintainName" placeholder="请输入维修项目名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修项目工时：</label>
                    <div class="col-sm-7">
                        <input type="text" name="maintainHour" define="MaintainFixMap.maintainHour" placeholder="请输入维修项目工时" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修项目基础费用：</label>
                    <div class="col-sm-7">
                        <input type="text" name="maintainMoney" define="MaintainFixMap.maintainMoney" placeholder="请输入维修项目基础费用" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修项目工时费：</label>
                    <div class="col-sm-7">
                        <input type="text" name="maintainManHourFee" define="MaintainFixMap.maintainManHourFee" placeholder="请输入维修项目工时费" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修项目描述：</label>
                    <div class="col-sm-7">
                                <textarea type="textarea" class="form-control" placeholder="请输入维修项目描述" define="MaintainFixMap.maintainDes" name="maintainDes"
                                          rows="3" maxlength="500"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修项目所属公司：</label>
                    <div class="col-sm-7">
                        <select id="editcompany" class="js-example-tags company" define="MaintainFixMap.companyId" name="companyId" style="width:100%">
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-8">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button id="editButton" type="button" onclick="editSubmit()" class="btn btn-sm btn-success">保存</button>
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
<script src="/static/js/backstage/main.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="/static/js/form/jquery.validate.js"></script>
<script src="/static/js/backstage/basicInfoManage/fixItem.js"></script>
</body>
</html>
