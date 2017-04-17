<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <meta charset="utf-8">
    <title>模块管理</title>
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
               data-height="543"
               data-id-field="id"
               data-page-list="[5, 10, 20]"
               data-cach="false"
               data-click-to-select="true">
            <thead>
            <tr>
                <th data-checkBox="true" data-field="status"></th>
                <th  data-field="name">收费单据编号</th>
                <th data-field="price">车主手机</th>
                <th data-field="price">车主姓名</th>
                <th data-field="price">维修保养记录编号</th>
                <th data-field="price">维修保养记录提车时间</th>
                <th data-field="price">维修保养记录描述</th>
                <th data-field="price">总金额</th>
                <th data-field="price">付款方式</th>
                <th data-field="price">实际付款</th>
                <th data-field="price">收费时间</th>
                <th data-field="price">收费单据创建时间</th>
                <th data-field="price">收费单据描述</th>
                <th data-field="price">收费单据状态</th>
            </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <button id="btn_edit" type="button" class="btn btn-default" onclick="showEdit();">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
            </button>
            <button id="btn_Export" type="button" class="btn btn-default" onclick="showExport();">
                <span class="glyphicon glyphicon-export" aria-hidden="true"></span>导出
            </button>
            <button id="btn_print" type="button" class="btn btn-default" onclick="showPrint();">
                <span class="glyphicon glyphicon-print" aria-hidden="true"></span>打印
            </button>
        </div>
    </div>
</div>
<!-- 修改弹窗 -->
<div class="modal fade" id="edit" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <hr/>
            <form id="editForm" class="form-horizontal" id="editForm" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <p>修改收费单据</p>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">总金额：</label>
                    <div class="col-sm-7">
                        <input type="number" define="emp.name"  class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">实际付款：</label>
                    <div class="col-sm-7">
                        <input type="number"  class="form-control" max="10">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">收费时间：</label>
                    <div class="col-sm-7">
                        <input type="text" class="form-control"  id="addDateTimePicker" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label" >付款方式：</label>
                    <div class="col-sm-7">
                        <input type="text" define="emp.price" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">收费单据描述：</label>
                    <div class="col-sm-7">
                        <input type="text" class="form-control" maxlength="100">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">收费单据状态：</label>
                    <div class="col-sm-7">
                        <select class="form-control">
                            <option>可用</option>
                            <option>不可用</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <span id="editError" style="color: red;"></span>
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button type="button" onclick="checkEdit()" class="btn btn-primary">
                        保存
                    </button>
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
<script src="/static/js/form/jquery.validate.js"></script>
<script src="/static/js/form/form.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="/static/js/backstage/clearingOut/chargeDocuments.js"></script>
</body>
</html>
