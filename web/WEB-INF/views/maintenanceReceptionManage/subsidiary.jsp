<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>维修保养记录管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/css/bootstrap-validate/bootstrapValidator.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet/less" href="/static/css/bootstrap-dateTimePicker/datetimepicker.less">
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
                <th data-radio="true" data-field="status" ></th>
                <th data-field="checkin.userName" data-width="50">维修保养登记人</th>
                <th data-field="startTime" data-formatter="formatterDate">维修保养开始时间</th>
                <th data-field="endTime" data-formatter="formatterDate">维修保养预估结束时间</th>
                <th data-field="actualEndTime" data-formatter="formatterDate">维修保养实际结束时间</th>
                <th data-field="recordCreatedTime" data-formatter="formatterDate">维修保养记录创建时间</th>
                <th data-field="pickupTime" data-formatter="formatterDate">维修保养车主提车时间</th>
                <th data-field="recordDes">维修保养记录描述</th>
                <th data-field="recordStatus" data-formatter="statusFormatter">记录状态</th>
            </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <button id="btn_available" type="button" class="btn btn-default" onclick="showAvailable();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>可用保养记录
            </button>
            <button id="btn_disable" type="button" class="btn btn-default" onclick="showDisable();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>禁用保养记录
            </button>
            <button id="btn_edit" type="button" class="btn btn-default" onclick="showDetail();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>查看明细
            </button>
            <button id="btn_add" type="button" class="btn btn-default" onclick="showAddDetail();">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>生成明细
            </button>
        </div>
    </div>
</div>

<div id="addWindow" class="modal fade" style="overflow-y:scroll" data-backdrop="static" >
    <div class="modal-dialog">
        <div class="modal-content">
            <form role="form" class="form-horizontal" id="addForm">
                <input type="hidden" define="maintainDetail.recordId" name="maintainRecordId"/>
                <div class="modal-header" style="overflow:auto;">
                    <h4>生成维修保养记录明细</h4>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修保养项目：</label>
                    <div class="col-sm-7">
                        <select id="addItem" class="js-example-tags maintainItem" name="maintainItemId" style="width:100%">
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">项目折扣：</label>
                    <div class="col-sm-7">
                        <input type="number" name="maintainDiscount" step="0.01" min="0.01" placeholder="请输入项目折扣" class="form-control" style="width:100%"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button id="addButton" type="button" onclick="addSubmit()" class="btn btn-success">添加
                    </button>
                    <input type="reset" name="reset" style="display: none;"/>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- 修改弹窗 -->
<div class="modal fade" id="editWindow" style="overflow-y:scroll" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <form role="form" class="form-horizontal" id="editForm">
                <input type="hidden" define="maintainDetail.maintainDetailId" name="maintainDetailId"/>
                <input type="hidden" define="maintainDetail.maintainRecordId" name="maintainRecordId"/>
                <div class="modal-header" style="overflow:auto;">
                    <h4>修改维修保养明细</h4>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修保养项目：</label>
                    <div class="col-sm-7">
                        <select id="editItem" class="js-example-tags maintainItem" name="maintainItemId" style="width:100%">
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">项目折扣：</label>
                    <div class="col-sm-7">
                        <input type="number" name="maintainDiscount" placeholder="请输入项目折扣" step="0.01" min="0.01" define="maintainDetail.maintainDiscount" class="form-control" style="width:100%"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            onclick="closeWindow()">关闭
                    </button>
                    <button id="editButton" type="button" onclick="editSubmit()" class="btn btn-success">保存
                    </button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div id="detailWindow" class="modal fade" aria-hidden="true" style="overflow-y:scroll" data-backdrop="static" keyboard:false>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 b-r">
                        <h3 class="m-t-none m-b">此维修保养记录下的所有明细</h3>
                        <table class="table table-hover" id="detailTable">
                            <thead>
                            <tr>
                                <th data-checkbox="true"></th>
                                <th data-field="maintainFix.maintainName">
                                    项目名称
                                </th>
                                <th data-field="maintainDiscount">
                                    项目折扣
                                </th>
                                <th data-field="mdcreatedTime" data-formatter="formatterDate">
                                    创建时间
                                </th>
                            </thead>
                        </table>
                        <div id="detailToolbar" class="btn-group">
                            <button id="btn_userDetail" type="button" class="btn btn-default" onclick="showUserDetail();">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>用户确认
                            </button>
                            <button id="btn_editDetail" type="button" class="btn btn-default" onclick="showEditDetail();">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改明细
                            </button>
                        </div>
                        <div style="height: 100px;"></div>
                        <div class="modal-footer" style="overflow:hidden;">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            <input type="button" class="btn btn-primary" onclick="checkApp()" value="确定">
                            </input>
                        </div>
                    </div>

                </div>
            </div>
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
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/backstage/maintenanceReception/subsidiary.js"></script>
<script src="/static/js/backstage/main.js"></script>
</body>
</html>
