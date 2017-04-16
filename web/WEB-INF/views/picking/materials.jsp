<%--
  Created by IntelliJ IDEA.
  User: yaoyong
  Date: 2017/4/11
  Time: 15:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>物料清单管理</title>
    <meta charset="utf-8">
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
               data-click-to-select="true"
               data-single-select="true">
            <thead>
            <tr>
                <th data-radio="true" data-field="status"></th>
                <th data-field="materialName">物料名称</th>
                <th data-field="materielState">物料说明</th>
                <th ddata-field="materielCount">物料数量</th>
                <th data-field="maintain">维修保养记录</th>
                <th data-field="materiel_Receive_Time">领料时间</th>
                <th data-field="accCount">退料数量</th>
                <th data-field="mrReturnDate">退料时间</th>
                <th data-field="materielStatus">状态</th>
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
            <button id="btn_delete" type="button" class="btn btn-default" onclick="showDel();">
                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
            </button>
            <button id="btn_appoint" type="button" class="btn btn-warning" onclick="showAppoint();">指派员工</button>
            <button id="btn_confirm" type="button" class="btn btn-info" onclick="showConfirm();">领料确认</button>
            <button id="btn_application" type="button" class="btn btn-success" onclick="showApplication();">退料申请</button>
            <button id="btn_regress" type="button" class="btn btn-danger" onclick="showRegress();">确认退料</button>
        </div>
    </div>
</div>

<!-- 指派员工弹窗 -->
<div class="modal fade" id="appoint" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog" style="width: 700px;height: auto;">
        <div class="modal-content" style="overflow:hidden; ">
            <form class="form-horizontal" id="AppointForm" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <p>请选择指定的员工</p>
                </div>
                <hr>
                <div class="form-group">
                    <label class="col-sm-3 control-label">请选择员工：</label>
                    <select id="addSelect"  class="js-example-basic-multiple" multiple="multiple" style="width:300px;">
                    </select>
                </div>
                <div class="modal-footer" style="border: none;">
                    <span id="editError" style="color: red;"></span>
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button type="button" onclick="checkEdit()" class="btn btn-primary">
                        确认
                    </button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 确认退料弹窗 -->
<div class="modal fade" id="regress" aria-hidden="true">
    <div class="modal-dialog" style="overflow:hidden;">
        <form action="/table/edit" method="post">
            <div class="modal-content">
                <input type="hidden" id="delNoticeId1"/>
                <div class="modal-footer" style="text-align: center;">
                    <h2>确认退料吗?</h2>
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">取消
                    </button>
                    <button type="sumbit" class="btn btn-primary" onclick="del()">
                        确认
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </form>
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 添加弹窗 -->
<div class="modal fade" id="add" aria-hidden="true" style="overflow:hidden;">
    <div class="modal-dialog" style="overflow:hidden;">
        <div class="modal-content" style="overflow:hidden;">
            <form class="form-horizontal" role="form" onsubmit="return checkAdd()" id="register-form" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <p>添加物料清单</p>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label" for="materialName">物料名称：</label>
                    <div class="col-sm-7">
                        <input type="text" id="materialName" name="materialName" placeholder="请输入物料名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label" for="materielState">物料说明：</label>
                    <div class="col-sm-7">
                        <input type="text" id="materielState" name="materielState" placeholder="请输入物料说明" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label" for="materielCount">物料数量：</label>
                    <div class="col-sm-7">
                        <input type="text" id="materielCount" name="materielCount" placeholder="请输入物料数量" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label" for="maintain">维修保养记录：</label>
                    <div class="col-sm-7">
                        <input type="text" id="maintain" name="maintain" placeholder="请输入维修保养记录" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label" for="materiel_Receive_Time">领料时间：</label>
                    <div class="col-sm-7">
                        <input type="text" id="materiel_Receive_Time" name="materiel_Receive_Time" placeholder="请输入领料时间" class="form-control">
                    </div>
                </div>
                <div class="modal-footer" style="overflow:hidden;">
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
<div class="modal fade" id="edit" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="editForm" class="data1" id="editForm" method="post">
                <div class="modal-header" style="overflow:hidden;">
                    <input type="text"  define="ceshi.id" name="id" placeholder="请输入标题" style="width:300px;margin-left:70px;" maxlength="15"/>
                    <input type="text"  define="ceshi.price" name="price"  placeholder="请输入标题" style="width:300px;margin-left:70px;" maxlength="15"/>
                </div>
                <div class="modal-body">
                    <textarea type="text"  define="ceshi.name" name="name" placeholder="请输入描述"  style="width:530px;height:100px;" maxlength="142"></textarea>
                </div>
                <div class="modal-footer">
                    <span id="editError1" style="color: red;"></span>
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
<script src="/static/js/backstage/picking/materials.js"></script>
</body>
</html>
