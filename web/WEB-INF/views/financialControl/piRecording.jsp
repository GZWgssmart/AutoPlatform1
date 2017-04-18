<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">

    <title>支出管理</title>
</head>
<body>

<%@include file="../backstage/contextmenu.jsp" %>

<div class="container">
    <div class="panel-body">
        <!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table" data-toggle="table" data-toolbar="#toolbar" data-url=""
               data-method="post" data-query-params="queryParams" data-pagination="true"
               data-search="true" data-show-refresh="true" data-show-toggle="true"
               data-show-columns="true" data-page-size="10" data-height="543"
               data-id-field="id" data-page-list="[5, 10, 20]" data-cach="false"
               data-click-to-select="true" data-single-select="true">
            <thead>
            <tr>
                <th data-radio="true" data-field="status"></th>
                <th data-width="15%" data-field="outTypeId">支出类型</th>
                <th data-width="15%" data-field="inTypeId">收入类型</th>
                <th data-width="15%" data-field="inOutMoney">收支金额</th>
                <th data-width="15%" data-field="inOutCreatedUser">创建人</th>
                <th data-width="20%" data-field="inOutCreatedTime">创建时间</th>
                <th data-width="15%" data-field="inOutStatus">记录状态</th>
            </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <button id="btn_add" type="button" class="btn btn-default" onclick="showAdd();">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>其它支出
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

<!-- 添加弹窗 -->
<div class="modal fade" id="add" aria-hidden="true" style="overflow:auto;">
    <div class="modal-dialog" style="overflow:hidden;">
        <div class="modal-content" style="overflow:hidden;">
            <div class="container" style="width: 80%;">
                <form class="form-horizontal" onsubmit="return checkAdd()" id="addForm" method="post">
                    <div class="modal-header" style="overflow:auto;">
                        <h4>其它支出添加</h4>
                    </div>
                    <br/>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">收支金额：</label>
                        <div class="col-sm-7">
                            <input type="number" placeholder="请输入收支金额" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">创建人：</label>
                        <div class="col-sm-7">
                            <input type="text" placeholder="请输入收支记录创建人" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-8">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            <button class="btn btn-sm btn-success" type="submit">保 存</button>
                        </div>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 修改弹窗 -->
<div class="modal fade" id="edit" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="container" style="width: 80%;">
                <form id="editForm" class="data1" method="post">
                    <div class="modal-header" style="overflow:auto;">
                        <h4>收支记录修改</h4>
                    </div>
                    <br/>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">收支金额：</label>
                        <div class="col-sm-7">
                            <input type="number" placeholder="请输入收支金额" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">创建人：</label>
                        <div class="col-sm-7">
                            <input type="text" placeholder="请输入收支记录创建人" class="form-control">
                        </div>
                    </div>
                    <div class="modal-footer" style="overflow:hidden;">
                        <button type="button" class="btn btn-default" data-dismiss="modal"> 关闭</button>
                        <button type="button" class="btn btn-primary"> 保存</button>
                    </div>
                </form>
            </div>
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
<script src="/static/js/financialControlJS/payOut.js"></script>
<script src="/static/js/bootstrap-select/bootstrap-select.js"></script>

</body>
</html>
