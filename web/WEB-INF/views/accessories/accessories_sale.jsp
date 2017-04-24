<%--
  Created by IntelliJ IDEA.
  User: XiaoQiao
  Date: 2017/4/11
  Time: 15:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>配件销售管理</title>
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
<div class="container ">
    <div class="panel-body" style="padding-bottom:0px;">
        <table id="table">
            <thead>
            <tr>
                <th data-radio="true" data-field="status"></th>
                <th data-field="companyId">所属公司</th>
                <th data-field="accId">配件编号</th>
                <th data-field="accSaledTime" data-formatter="formatterDate">配件销售时间</th>
                <th data-field="accSaleCount">配件销售数量</th>
                <th data-field="accSalePrice">配件销售单价</th>
                <th data-field="accSaleTotal">配件销售总价</th>
                <th data-field="accSaleDiscount">配件销售折扣</th>
                <th data-field="accSaleMoney">配件销售最终价</th>
                <th data-field="accSaleCreatedTime" data-formatter="formatterDateTime">销售记录创建时间</th>
                <th data-field="accSaleStatus" data-formatter="formatterStatus">销售记录状态</th>
                <th data-formatter="openStatusFormatter">操作</th>
            </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <button id="btn_available" type="button" class="btn btn-default" onclick="showAvailable();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>可用登记记录
            </button>
            <button id="btn_disable" type="button" class="btn btn-default" onclick="showDisable();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>禁用登记记录
            </button>
            <button id="btn_add" type="button" class="btn btn-default" onclick="showAdd();">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
            </button>
            <button id="btn_edit" type="button" class="btn btn-default" onclick="showEdit();">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
            </button>
            <div class="input-group" style="width:350px;float:left;padding:0;margin:0 0 0 -1px;">
                <div class="input-group-btn">
                    <button type="button" id="ulButton" class="btn btn-default" style="border-radius:0px;" data-toggle="dropdown">所属公司/配件编号/配件销售时间<span class="caret"></span></button>
                    <ul class="dropdown-menu pull-right">
                        <li><a onclick="onclikLi(this)">所属公司/配件编号/配件销售时间</a></li>
                        <li class="divider"></li>
                        <li><a onclick="onclikLi(this)">所属公司</a></li>
                        <li class="divider"></li>
                        <li><a onclick="onclikLi(this)">配件编号</a></li>
                        <li class="divider"></li>
                        <li><a onclick="onclikLi(this)">配件销售时间</a></li>
                        <li class="divider"></li>
                    </ul>
                </div><!-- /btn-group -->
                <input id="ulInput" class="form-control" onkeypress="if(event.keyCode==13) {blurredQuery();}">
                <a href="javaScript:;" onclick="blurredQuery()"><span class="glyphicon glyphicon-search search-style"></span></a>
                </input>
            </div><!-- /input-group -->
        </div>
    </div>
</div>
<!-- 增加弹窗 -->
<div class="modal fade" id="addWindow" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog" style="width: 700px;height: auto;">
        <div class="modal-content" style="overflow:hidden;">
            <form class="form-horizontal" role="form" id="addForm" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写配件销售信息</h4>
                </div>
                <br/>
                <div class="form-group">
                    <label class="col-sm-3 control-label">所属公司：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companyId" placeholder="请输入所属公司" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件编号：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accId" placeholder="请输入配件编号" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件销售时间：</label>
                    <div class="col-sm-7">
                        <input id="addDateTimePicker" placeholder="请选择配件销售时间" onclick="getDate('addDateTimePicker')"
                               readonly="true" type="text" name="accSaledTime"
                               class="form-control datetimepicker"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件销售数量：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accSaleCount" placeholder="请输入配件销售数量" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件销售单价：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accSalePrice" placeholder="请输入配件销售单价" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件销售总价：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accSaleTotal" placeholder="请输入配件销售总价" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件销售折扣：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accSaleDiscount" placeholder="请输入配件销售折扣" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件销售最终价：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accSaleMoney" placeholder="请输入配件销售最终价" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-8">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button class="btn btn-sm btn-success" onclick="addSubmit();" type="button">保 存</button>
                    </div>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<!-- 修改弹窗 -->
<div class="modal fade" id="editWindow" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form class="form-horizontal" role="form" id="editForm" method="post">
                <input type="hidden" name="accSaleId" define="AccessoriesSale.accSaleId"/>
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写配件销售信息</h4>
                </div>
                <br/>
                <div class="form-group">
                    <label class="col-sm-3 control-label">所属公司：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companyId" define="AccessoriesSale.companyId" placeholder="请输入所属公司"
                               class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件编号：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accId" define="AccessoriesSale.accId" placeholder="请输入配件编号"
                               class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件销售时间：</label>
                    <div class="col-sm-7">
                        <input id="editDateTimePicker" placeholder="请选择配件销售时间"
                               readonly="true" type="text" name="accSaledTime"
                               class="form-control datetimepicker"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件销售数量：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accSaleCount" define="AccessoriesSale.accSaleCount"
                               placeholder="请输入配件销售数量" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件销售单价：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accSalePrice" define="AccessoriesSale.accSalePrice"
                               placeholder="请输入配件销售单价" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件销售总价：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accSaleTotal" define="AccessoriesSale.accSaleTotal"
                               placeholder="请输入配件销售总价" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件销售折扣：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accSaleDiscount" define="AccessoriesSale.accSaleDiscount"
                               placeholder="请输入配件销售折扣" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件销售最终价：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accSaleMoney" define="AccessoriesSale.accSaleMoney"
                               placeholder="请输入配件销售最终价" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-8">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button class="btn btn-sm btn-success" onclick="editSubmit();" type="button">保 存</button>
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
<script src="/static/js/bootstrap-select/bootstrap-select.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/backstage/main.js"></script>
<script src="/static/js/backstage/accessories/accessories_sale.js"></script>
</body>
</html>
