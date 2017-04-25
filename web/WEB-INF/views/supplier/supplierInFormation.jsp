<%--
  Created by IntelliJ IDEA.
  User: AngeJob
  Date: 2017/4/12
  Time: 10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>供应商管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/css/bootstrap-validate/bootstrapValidator.min.css">
</head>
<body>
<%@include file="../backstage/contextmenu.jsp"%>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;"  >
        <!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table">
            <thead>
            <tr>
                <th data-checkbox="true"></th>
                <th data-field="supplyName">
                    供应商名称
                </th>
                <th data-field="supplyTel">
                    供应商联系电话
                </th>
                <th data-field="supplyPricipal">
                    供应商负责人
                </th>
                <th data-field="supplyAddress">
                    供应商地址
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </th>
                <th data-field="supplyWeChat">
                    供应商微信号
                </th>
                <th data-field="supplyCreatedTime"data-formatter="formatterDateTime">
                    创建时间
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </th>
                <th data-field="supplyType.supplyTypeName">
                    供应商类型
                </th>
                <th data-field="company.companyName">
                    供应商所属公司
                </th>
                <th data-formatter="formatterStatus">
                    供应商状态
                </th>
                <th data-formatter="openStatusFormatter">
                    操作
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
            <button id="searchDisable" type="button" class="btn btn-danger" onclick="searchDisableStatus();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询禁用类型
            </button>
            <button id="searchRapid" type="button" class="btn btn-success" onclick="searchRapidStatus();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询激活类型
            </button>
            <div class="input-group" style="width:300px;float:left;padding:0;margin:0 0 0 -1px;">
                <div class="input-group-btn">
                    <button type="button" id="ulButton" class="btn btn-default" style="border-radius:0px;" data-toggle="dropdown">
                        供应商/供应商类型/所属公司
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu pull-right">
                        <li><a onclick="onclikLi(this)">供应商</a></li>
                        <li class="divider"></li>
                        <li><a onclick="onclikLi(this)">供应商类型</a></li>
                        <li class="divider"></li>
                        <li><a onclick="onclikLi(this)">所属公司</a></li>
                        <li class="divider"></li>
                        <li><a onclick="onclikLi(this)"></a></li>
                    </ul>
                </div><!-- /btn-group -->
                <input id="ulInput" class="form-control" onkeypress="if(event.keyCode==13) {blurredQuery();}">
                    <a href="javaScript:;" onclick="blurredQuery()"><span class="glyphicon glyphicon-search search-style"></span></a>
                </input>
            </div><!-- /input-group -->
        </div>
    </div>
</div>

<!-- 添加弹窗 -->

<div id="addWindow" class="modal fade" style="overflow-y:scroll" data-backdrop="static" >
    <div class="modal-dialog"  style="width: 780px;height: auto;">
        <div class="modal-content" >
            <form role="form" class="form-horizontal" id="addForm">
                <div class="modal-header" style="overflow:auto;">
                    <p>添加供应商信息</p>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">供应商名称：</label>
                    <div class="col-sm-7">
                        <input id="addSupplyName" name="supplyName" type="text" placeholder="请输入供应商名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">联系电话：</label>
                    <div class="col-sm-7">
                        <input type="text" id="addSupplyTel" placeholder="请输入联系电话" name="supplyTel" class="form-control" style="width:100%"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">供应商负责人：</label>
                    <div class="col-sm-7">
                        <input type="text"  name="supplyPricipal" placeholder="请输入供应商负责人" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">供应商地址：</label>
                    <div class="col-sm-7">
                        <input type="text" name="supplyAddress" placeholder="请输入供应商地址" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">微信号：</label>
                    <div class="col-sm-7">
                        <input type="text"  name="supplyWeChat" placeholder="请输入微信号" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">供应商类型：</label>
                    <div class="col-sm-7">
                        <select id="addSupplyType" class="js-example-tags supplyType" name="supplyTypeId" style="width:100%"></select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">供应商所属公司：</label>
                    <div class="col-sm-7">
                        <select id="addCompany" class="js-example-tags company" name="companyId" style="width:100%">
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">支付宝账号：</label>
                    <div class="col-sm-7">
                        <input type="text"  name="supplyAlipay" placeholder="请输入支付宝账号" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">开户银行全称：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请输入开户银行全称" name="supplyBank" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">开户人姓名：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请输入开户人姓名"  name="supplyBankAccount"   class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">开户卡号：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请输入开户卡号" name="supplyBankNo"  class="form-control">
                    </div>
                </div>
                <div class="modal-footer" >
                    <span id="addError"></span>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭 </button>
                    <button id="addButton" type="button" onclick="addSubmit()" class="btn btn-primary">保存
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<!-- 修改弹窗 -->
<div id="editWindow" class="modal fade" style="overflow-y:scroll" data-backdrop="static" >
    <div class="modal-dialog"  style="width: 780px;height: auto;">
        <div class="modal-content">
            <form role="form" class="form-horizontal" id="editForm">
                <input type="hidden" name="supplyId" define="supply.supplyId"/>
                <input type="hidden"name="supplyStatus" define="supply.supplyStatus">
                <div class="modal-header" style="overflow:auto;">
                    <p>修改供应商信息</p>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">供应商名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="supplyName" define="supply.supplyName" placeholder="请输入供应商名称"  class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">联系电话：</label>
                    <div class="col-sm-7">
                        <input type="text" define="supply.supplyTel" placeholder="请输入联系电话" name="supplyTel" class="form-control" style="width:100%"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">供应商负责人：</label>
                    <div class="col-sm-7">
                        <input type="text" define="supply.supplyPricipal"   name="supplyPricipal" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">供应商地址：</label>
                    <div class="col-sm-7">
                        <input type="text" define="supply.supplyAddress" name="supplyAddress" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">微信号：</label>
                    <div class="col-sm-7">
                        <input type="text" define="supply.supplyWeChat" name="supplyWeChat"  class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">供应商类型：</label>
                    <div class="col-sm-7">
                        <select id="editSupplyType" class="js-example-tags supplyType" name="supplyTypeId" style="width:100%"></select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 control-label">供应商所属公司：</label>
                    <div class="col-sm-7">
                        <select id="editCompany" class="js-example-tags company" define="supply.companyId" name="companyId" style="width:100%">
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">支付宝账号：</label>
                    <div class="col-sm-7">
                        <input type="text" define="supply.supplyAlipay"  name="supplyAlipay"  class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">开户银行全称：</label>
                    <div class="col-sm-7">
                        <input type="text" define="supply.supplyBank" name="supplyBank" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">开户人姓名：</label>
                    <div class="col-sm-7">
                        <input type="text" define="supply.supplyBankAccount"  name="supplyBankAccount"   class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">开户卡号：</label>
                    <div class="col-sm-7">
                        <input type="text" define="supply.supplyBankNo" name="supplyBankNo"  class="form-control">
                    </div>
                </div>
                <div class="modal-footer" >
                    <span id="editError"></span>
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button id="editButton" type="button" onclick="editSubmit()" class="btn btn-primary">保存
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
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
<script src="/static/js/contextmenu.js"></script>
<script src="/static/js/backstage/supplier/supplierInFormation.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/backstage/main.js"></script>

</body>
</html>