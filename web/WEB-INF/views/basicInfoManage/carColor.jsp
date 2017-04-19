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
    <title>汽车颜色管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/css/minicolors/jquery.minicolors.css">
</head>
<body>
<%@include file="../backstage/contextmenu.jsp" %>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;">
        <!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table"
               data-toggle="table"
               data-toolbar="#toolbar"
               data-url="/carColor/queryAll"
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
                <th data-radio="true" data-field="colorId"></th>
                <th data-field="colorName">颜色名称</th>
                <th data-field="colorRGB">颜色的RBG值</th>
                <th data-field="colorHex">颜色的16进制值</th>
                <th data-field="colorDes">颜色描述</th>
                <th data-field="colorStatus">颜色状态</th>
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
        </div>
    </div>
</div>

<%--添加窗口--%>
<div class="modal fade" id="addWindow" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog" style="width: 700px;height: auto;">
        <div class="modal-content" style="overflow:hidden;">
            <form class="form-horizontal" role="form" onsubmit="return checkAdd()" id="showAddFormWar" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写汽车颜色的相关信息</h4>
                </div>
                <br/>
                <div class="form-group">
                    <label class="col-sm-3 control-label">颜色命名：</label>
                    <div class="col-sm-7">
                        <input type="text" name="colorName" placeholder="请输入颜色命名" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">颜色的16进制值：</label>
                    <div class="col-sm-5" style="padding-right: 0px">
                        <input name="colorHex" type="text" class="form-control addColor" data-control="hue" value="">
                    </div>
                    <div class="col-sm-2" style="padding-left: 0px;">
                        <input type="button" class="btn btn-default" value="确认" onclick="showAddHex();">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">颜色的RGB值：</label>
                    <div class="col-sm-7">
                        <input id="addrgbColor" type="text" placeholder="请选择颜色的RGB值" value="" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">颜色的描述：</label>
                    <div class="col-sm-7">
                        <textarea type="text" name="colorDes" placeholder="请输入该颜色的相关描述" style="height: 100px;"
                                  class="form-control"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-8">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button class="btn btn-sm btn-success" type="submit">保 存</button>
                    </div>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<%--修改窗口--%>
<div class="modal fade" id="editWindow" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog" style="width: 700px;height: auto;">
        <div class="modal-content" style="overflow:hidden;">
            <form class="form-horizontal" role="form" onsubmit="return checkAdd()" id="showEditFormWar" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写汽车颜色的相关信息</h4>
                </div>
                <br/>
                <div class="form-group">
                    <label class="col-sm-3 control-label">颜色命名：</label>
                    <div class="col-sm-7">
                        <input type="text" name="colorName" define="carColor.colorName" placeholder="请输入颜色命名" class="form-control">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 control-label">颜色的16进制值：</label>
                    <div class="col-sm-5" style="padding-right: 0px">
                        <input name="colorHex" define="carColor.colorHex" type="text" class="form-control editColor" data-control="hue" value="">
                    </div>
                    <div class="col-sm-2" style="padding-left: 0px;">
                        <input type="button" class="btn btn-default" value="确认" onclick="showEditHex();">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">颜色的RGB值：</label>
                    <div class="col-sm-7">
                        <input id="editrgbColor" define="carColor.colorRGB" type="text" placeholder="请选择颜色的RGB值" value="" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">颜色的描述：</label>
                    <div class="col-sm-7">
                        <textarea type="text" name="colorDes" define="carColor.colorDes" placeholder="请输入该颜色的相关描述" style="height: 100px;"
                                  class="form-control"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-8">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button class="btn btn-sm btn-success" type="submit">保 存</button>
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
<script src="/static/js/minicolors/jquery.minicolors.min.js"></script>
<script src="/static/js/form/jquery.validate.js"></script>
<script src="/static/js/backstage/basicInfoManage/carColor.js"></script>
</body>
</html>
