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
    <title>保养项目管理</title>
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
        <table id="table">
            <thead>
            <tr>
                <th data-radio="true" data-field="status"></th>
                <th data-field="maintainName">保养名称</th>
                <th data-field="maintainHour">所需时间</th>
                <th data-field="maintainMoney">所需费用</th>
                <th data-field="maintainManhourFee">工时费</th>
                <th data-field="maintainOrFix">维修保养选项</th>
                <th data-field="companyId">所属公司</th>
                <th data-field="maintainDes">相关描述</th>
                <th data-field="maintainStatus" data-formatter="formatterStatus">项目状态</th>
                <th data-formatter="openStatusFormatter">操作</th>
            </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <button id="btn_available" type="button" class="btn btn-default" onclick="showAvailable();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>可用维修保养记录
            </button>
            <button id="btn_disable" type="button" class="btn btn-default" onclick="showDisable();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>禁用维修保养记录
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
<div class="modal fade" id="addWindow" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog">
        <div class="modal-content">
            <form class="form-horizontal" id="addForm" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写该保养项目的信息</h4>
                </div>
                <br/>
                <div class="form-group">
                    <label class="col-sm-3 control-label">保养项目名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="maintainName" placeholder="请输入保养项目的名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">所需时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="maintainHour" placeholder="请预估所需的时间" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">基础费用：</label>
                    <div class="col-sm-7">
                        <input type="text" name="maintainMoney" placeholder="请预估所需的费用" class="form-control"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">工时费：</label>
                    <div class="col-sm-7">
                        <input type="text" name="maintainManhourFee" placeholder="请输入工时费" class="form-control"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">项目选项：</label>
                    <div class="col-sm-7">
                        <input type="text" name="maintainOrFix" placeholder="请选择项目选项" class="form-control"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">所属公司：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companyId" placeholder="请选择所属公司" class="form-control"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">相关描述：</label>
                    <div class="col-sm-7">
                        <textarea type="text" name="maintainDes" placeholder="请输入该项目相关的描述" style="height: 100px;"
                                  class="form-control"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-8">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button id="addButton" type="button" onclick="addSubmit()" class="btn btn-primary">保存</button>
                    </div>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<!-- 修改弹窗 -->
<div class="modal fade" id="editWindow" aria-hidden="true">
    <div class="modal-dialog" style="width: 700px;height: auto;">
        <div class="modal-content" style="overflow:hidden;">
            <form class="form-horizontal" id="editForm" method="post">
                <input type="hidden" name="maintainId" define="MaintainFix.maintainId"/>
                <div class="modal-header" style="overflow:auto;">
                    <h4>请修改该保养项目的信息</h4>
                </div>
                <br/>
                <div class="form-group">
                    <label class="col-sm-3 control-label">保养项目名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="maintainName" define="MaintainFix.maintainName"
                               placeholder="请输入保养项目的名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">所需时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="maintainHour" define="MaintainFix.maintainHour" placeholder="请预估所需的时间"
                               class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">基础费用：</label>
                    <div class="col-sm-7">
                        <input type="text" name="maintainMoney" define="MaintainFix.maintainMoney"
                               placeholder="请预估所需的费用" class="form-control"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">工时费：</label>
                    <div class="col-sm-7">
                        <input type="text" name="maintainManhourFee" define="MaintainFix.maintainManhourFee"
                               placeholder="请输入工时费" class="form-control"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">项目选项：</label>
                    <div class="col-sm-7">
                        <input type="text" name="maintainOrFix" define="MaintainFix.maintainOrFix" placeholder="请选择项目选项"
                               class="form-control"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">所属公司：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companyId" define="MaintainFix.companyId" placeholder="请选择所属公司"
                               class="form-control"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-8">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button id="editButton" type="button" onclick="editSubmit()" class="btn btn-primary">保存</button>
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
<script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/backstage/main.js"></script>
<script src="/static/js/backstage/basicInfoManage/maintainItem.js"></script>
</body>
</html>
