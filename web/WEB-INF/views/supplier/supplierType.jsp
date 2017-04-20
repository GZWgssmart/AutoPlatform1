<%--
  Created by IntelliJ IDEA.
  User: AngeJob
  Date: 2017/4/12
  Time: 10:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>供应商类型管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
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
               data-method="get"
               data-query-params="queryParams"
               data-pagination="true"
               data-search="true"
               data-show-refresh="true"
               data-show-toggle="true"
               data-show-columns="true"
               data-page-size="10"
               data-height="600"
               data-id-field="id"
               data-page-list="[5, 10, 20]"
               data-cach="false"
               data-click-to-select="true"
               data-single-select="true">
            <thead>
            <tr>
                <th data-radio="true" data-field="status"></th>
                <th data-field="supplyTypeName">供应商类型名称</th>
                <th data-field="companyId">供应商类型所属公司</th>
                <th data-field="supplyTypeDes">供应商类型描述内容</th>
                <th data-formatter="formatterStatus">类型状态</th>
                <th data-width="12%" data-formatter="openStatusFormatter">操作</th>
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
            <button id="searchRapid" type="button" class="btn btn-info" onclick="searchRapidStatus();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询激活类型
            </button>
        </div>
    </div>
</div>

<!-- 添加弹窗 -->

<div class="modal fade" id="addWindow" aria-hidden="true" >
    <div class="modal-dialog"  style="width: 750px;height: auto;" >
        <div class="modal-content" >
                <form class="form-horizontal"  role="form" id="addForm" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <p>添加供应商类型信息</p>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">供应商类型名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="supplyTypeName" id="name" placeholder="请输入供应商类型名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">供应商所属公司：</label>
                    <div class="col-sm-7">
                        <input type="text"  name="companyId" placeholder="请选择供应商所属公司" class="form-control">
                    </div>
                </div>
                 <div class="form-group">
                        <label class="col-sm-3 control-label">供应商类型描述：</label>
                        <div class="col-sm-7">
                        <textarea type="text" name="supplyTypeDes" placeholder="请输入供应商类型描述内容" style="height:100px;"
                                  class="form-control"></textarea>
                        </div>
                  </div>
                <div class="modal-footer" >
                    <span id="addError"></span>
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button type="submit" class="btn btn-primary btn-sm">保存</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<!-- 修改弹窗 -->
<div class="modal fade" id="editWindow" aria-hidden="true">
    <div class="modal-dialog"  style="width: 750px;height: auto;">
        <div class="modal-content">
            <form  class="form-horizontal"  id="editForm" method="post">
                <input type="hidden" name="supplyTypeId" define="supplyType.supplyTypeId"/>
                <input type="hidden"name="supplyTypeStatus" define="supplyType.supplyTypeStatus">
                <div class="modal-header" style="overflow:auto;">
                    <p>修改供应商类型信息</p>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">供应商类型名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="supplyTypeName" define="supplyType.supplyTypeName"  placeholder="请输入供应商类型名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">供应商所属公司：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companyId" define="supplyType.companyId" placeholder="请选择供应商类型所属公司" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">供应商类型描述：</label>
                    <div class="col-sm-7">
                        <input type="text" name="supplyTypeDes" define="supplyType.supplyTypeDes" placeholder="请输入供应商类型描述内容"
                               style="height:100px;" class="form-control">
                    </div>
                </div>
                <div class="modal-footer" >
                    <span id="editError"></span>
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <input type="submit" class="btn btn-primary"/>
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
<script src="/static/js/backstage/supplier/supplierType.js"></script>
<script src="/static/js/bootstrap-select/bootstrap-select.js"></script>
<script src="/static/js/form/jquery.validate.js"></script>
<script src="/static/js/backstage/main.js"></script>

</body>
</html>