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
                <th data-width="100" data-field="checkin.userName">
                    车主姓名
                </th>
                <th data-width="110" data-field="checkin.userPhone">
                    车主电话
                </th>
                <th data-width="100" data-field="checkin.brand.brandName">
                    汽车品牌
                </th>
                <th data-width="100" data-field="checkin.color.colorName">
                    汽车颜色
                </th>
                <th data-width="100" data-field="checkin.model.modelName">
                    汽车车型
                </th>
                <th data-width="100" data-field="checkin.plate.plateName">
                    汽车车牌
                </th>
                <th data-width="100" data-field="checkin.carPlate">
                    车牌号码
                </th>
                <th data-width="100" data-field="checkin.ifClearCar" data-formatter="showStatusFormatter">
                    是否洗车
                </th>
                <th data-width="150" data-field="checkin.carThings">
                    车上物品描述
                </th>
                <th data-width="150" data-field="checkin.intactDegrees">
                    汽车完好度描述
                </th>
                <th data-width="150" data-field="checkin.userRequests">
                    用户要求描述
                </th>
                <th data-width="100" data-field="checkin.maintainOrFix">
                    保养&nbsp;|&nbsp;维修
                </th>
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
                <input type="hidden" id="addItemId" name="maintainItemId">
                <div class="modal-header" style="overflow:auto;">
                    <h4>生成维修保养记录明细</h4>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修保养项目：</label>
                    <div class="col-sm-9">
                        <input id="addItem" class="form-control" placeholder="请选择维修保养项目" readonly="true" style="width:52%;">
                        </input>
                        <button type="button" class="btn btn-default" onclick="showItem('addWindow');">
                            <span class="glyphicon glyphicon-search" aria-hidden="true"></span>查看项目
                        </button>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">项目折扣：</label>
                    <div class="col-sm-7">
                        <input type="number" name="maintainDiscount" step="0.1" min="0.1" max="1" placeholder="请输入项目折扣, 0.1代表1折" class="form-control" style="width:100%"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button id="addButton" type="button" onclick="addSubmit()" class="btn btn-success">生成
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
                <input type="hidden" id="editItemId" name="maintainItemId">
                <div class="modal-header" style="overflow:auto;">
                    <h4>修改维修保养明细</h4>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修保养项目：</label>
                    <div class="col-sm-9">
                        <input id="editItem" type="text" define="maintainDetail.maintainFix.maintainName" class="form-control" placeholder="请选择维修保养项目" readonly="true" style="width:52%;">
                        </input>
                        <button type="button" class="btn btn-default" onclick="showItem('editWindow');">
                            <span class="glyphicon glyphicon-search" aria-hidden="true"></span>查看项目
                        </button>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">项目折扣：</label>
                    <div class="col-sm-7">
                        <input type="number" name="maintainDiscount" placeholder="请输入项目折扣, 0.1代表1折" step="0.1" min="0.1" max="1" define="maintainDetail.maintainDiscount" class="form-control" style="width:100%"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button id="editButton" type="button" onclick="editSubmit()" class="btn btn-success">保存
                    </button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 维修保养项目表格 -->
<div class="modal fade" id="itemWindow" style="overflow-y:scroll" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog" style="width:90%;">
        <div class="modal-content">
        <table id="itemTable" style="table-layout: fixed">
            <thead>
            <tr>
                <th data-radio="true" data-field="status"></th>
                <th data-field="maintainName">维修项目名称</th>
                <th data-field="maintainHour">维修项目工时</th>
                <th data-field="maintainMoney">维修项目基础费用</th>
                <th data-field="maintainManHourFee">维修项目工时费</th>
                <th data-field="maintainDes">维修项目描述</th>
            </tr>
            </thead>
        </table>
            <div class="modal-footer">
                <button id="closeButton" type="button" class="btn btn-default"
                        onclick="closeWindow()">关闭
                </button>
                <button id="itemButton" type="button" onclick="itemSubmit()" class="btn btn-success">确定
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 明细表格 -->
<div id="detailWindow" class="modal fade" aria-hidden="true" style="overflow-y:scroll" data-backdrop="static" keyboard:false>
    <div class="modal-dialog" style="width: 90%">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 b-r">
                        <h3 class="m-t-none m-b">此维修保养记录下的所有明细</h3>
                        <table class="table table-hover" id="detailTable">
                            <thead>
                            <tr>
                                <th data-rideo="true"></th>
                                <th data-field="maintainFix.maintainName">
                                    项目名称
                                </th>
                                <th data-field="maintainFix.maintainHour">
                                    项目公时
                                </th>
                                <th data-field="maintainFix.maintainOrFix">
                                    维修|保养
                                </th>
                                <th data-field="maintainFix.maintainDes">
                                    项目描述
                                </th>
                                <th data-field="maintainDiscount" data-formatter="formatterDiscount">
                                    项目折扣
                                </th>
                                <th data-field="maintainFix.maintainMoney">
                                    原价
                                </th>
                                <th data-field="maintainFix.maintainMoney" data-formatter="formatterDiscountMoney">
                                    折扣后
                                </th>
                                <th data-field="mdcreatedTime" data-formatter="formatterDate">
                                    创建时间
                                </th>
                            </thead>
                        </table>
                        <div id="detailToolbar" class="btn-group">
                            <button id="btn_userDetail" type="button" class="btn btn-default" onclick="showUserDetail();">
                                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>用户已签字
                            </button>
                            <button id="btn_editDetail" type="button" class="btn btn-default" onclick="showEditDetail();">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改明细
                            </button>
                            <button id="btn_printDetail" type="button" class="btn btn-default" onclick="showPrint();">
                                <span class="glyphicon glyphicon-print" aria-hidden="true"></span>打印明细
                            </button>
                        </div>
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
