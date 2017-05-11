<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <meta charset="utf-8">
    <title>收费单据管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet/less" href="/static/css/bootstrap-dateTimePicker/datetimepicker.less">
    <link rel="stylesheet" href="/static/css/bootstrap-validate/bootstrapValidator.min.css">
</head>
<body>
<%@include file="../backstage/contextmenu.jsp"%>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;"  >
        <!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table" style="table-layout: fixed">
            <thead>
            <tr>
                <th data-radio="true" data-field="status"></th>
                <th data-width="90" data-field="maintainRecord.checkin.userName">车主姓名</th>
                <th data-width="130" data-field="maintainRecord.checkin.userPhone">车主手机</th>
                <th data-width="90" data-field="maintainRecord.checkin.brand.brandName">汽车品牌</th>
                <th data-width="90" data-field="maintainRecord.checkin.model.modelName">汽车车型</th>
                <th data-width="90" data-field="maintainRecord.checkin.color.colorName">汽车颜色</th>
                <th data-width="90" data-field="maintainRecord.checkin.plate.plateName">汽车车牌</th>
                <th data-width="90" data-field="maintainRecord.checkin.carPlate">车牌号码</th>
                <th data-width="180" data-field="maintainRecord.pickupTime" data-formatter="formatterDate">维修保养记录提车时间</th>
                <th data-width="150" data-field="maintainRecord.recordDes">维修保养记录描述</th>
                <th data-width="90" data-field="paymentMethod">付款方式</th>
                <th data-width="90" data-field="chargeBillMoney">总金额</th>
                <th data-width="90" data-field="actualPayment">实际付款</th>
                <th data-width="180" data-field="chargeTime" data-formatter="formatterDate">收费时间</th>
                <th data-width="180" data-field="chargeCreatedTime" data-formatter="formatterDate">收费单据创建时间</th>
                <th data-width="130" data-field="chargeBillDes">收费单据描述</th>
                <th data-width="130" data-field="chargeBillStatus" data-formatter="showStatusFormatter">收费单据状态</th>
                <th data-width="90" data-field="chargeBillStatus" data-formatter="statusFormatter">操作</th>
            </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <button id="btn_available" type="button" class="btn btn-default" onclick="showAvailable();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>可用收费单据
            </button>
            <button id="btn_disable" type="button" class="btn btn-default" onclick="showDisable();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>禁用收费单据
            </button>
            <button id="btn_edit" type="button" class="btn btn-default" onclick="showEdit();">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
            </button>

            <button id="btn_Export" type="button" class="btn btn-default"><a href="/charge/exportExcel">
                <span class="glyphicon glyphicon-export" aria-hidden="true"></span>导出</a>
            </button>
            <button id="btn_print" type="button" class="btn btn-default" onclick="showPrint();">
                <span class="glyphicon glyphicon-print" aria-hidden="true"></span>打印
            </button>
            <div class="input-group" style="width:350px;float:left;padding:0;margin:0 0 0 -1px;">
                <div class="input-group-btn">
                    <button type="button" id="ulButton" class="btn btn-default" style="border-radius:0px;"
                            data-toggle="dropdown">车主/电话/汽车公司/车牌号<span class="caret"></span></button>
                    <ul class="dropdown-menu pull-right">
                        <li><a onclick="onclikLi(this)">车主/电话/汽车公司/车牌号</a></li>
                        <li class="divider"></li>
                        <li><a onclick="onclikLi(this)">车主</a></li>
                        <li class="divider"></li>
                        <li><a onclick="onclikLi(this)">电话</a></li>
                        <li class="divider"></li>
                        <li><a onclick="onclikLi(this)">汽车公司</a></li>
                        <li class="divider"></li>
                        <li><a onclick="onclikLi(this)">车牌号</a></li>
                    </ul>
                </div><!-- /btn-group -->
                <input id="ulInput" class="form-control" onkeypress="if(event.keyCode==13) {blurredQuery();}">
                <a href="javaScript:;" onclick="blurredQuery()"><span
                        class="glyphicon glyphicon-search search-style"></span></a>
                </input>
            </div><!-- /input-group -->
        </div>
    </div>
</div>

<!-- 修改弹窗 -->
<div class="modal fade" id="editWindow" style="overflow-y:scroll" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
            <span class="glyphicon glyphicon-remove closeModal" data-dismiss="modal"></span>
                <form id="editForm" role="form" class="form-horizontal">
                    <div class="modal-header" style="overflow:auto;">
                        <h4>修改收费单据</h4>
                    </div>
                    <input type="hidden" define="chargeBill.chargeBillId" name="chargeBillId"/>
                    <input type="hidden" define="chargeBill.maintainRecordId" name="maintainRecordId"/>
                    <input type="hidden" define="chargeBill.chargeBillStatus" name="chargeBillStatus"/>
                    <input type="hidden" define="chargeBill.chargeCreatedTime" name="chargeCreatedTime"/>
                    <div class="form-group">
                        <label class="col-sm-3 control-label" >付款方式：</label>
                        <div class="col-sm-7">
                            <input type="text" name="paymentMethod" define="chargeBill.paymentMethod" placeholder="请输入付款方式" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">总金额：</label>
                        <div class="col-sm-7">
                            <input type="number" name="chargeBillMoney" min="1" define="chargeBill.chargeBillMoney" placeholder="请输入总金额" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">实际付款：</label>
                        <div class="col-sm-7">
                            <input type="number" name="actualPayment" min="1" define="chargeBill.actualPayment" placeholder="请输入实际付款" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">收费时间：</label>
                        <div class="col-sm-7">
                            <input id="addDatetimepicker" placeholder="请选择收费时间"
                                   type="text" name="chargeTime" readonly="true"
                                   class="form-control datetimepicker"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">收费单据描述：</label>
                        <div class="col-sm-7">
                            <textarea type="textarea" name="chargeBillDes" class="form-control" define="chargeBill.chargeBillDes" placeholder="请输入收费单据描述" maxlength="100"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">关闭
                        </button>
                        <button type="submit" class="btn btn-success btn-sm">保存</button>
                    </div>
                </form>
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
<script src="/static/js/backstage/clearingOut/chargeDocuments.js"></script>
<script src="/static/js/backstage/main.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
</body>
</html>
