<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工工单管理</title>
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
               data-url="/table/query"
               data-method="post"
               data-query-params="queryParams"
               data-pagination="true"
               data-search="true"
               data-show-refresh="true"
               data-show-toggle="true"
               data-show-columns="true"
               data-page-size="10"
               data-height="700"
               data-id-field="id"
               data-page-list="[5, 10, 20]"
               data-cach="false"
               data-click-to-select="true"
               data-single-select="true">
            <thead>
            <tr>
                <th data-radio="true" data-field="status"></th>
                <th data-width="15%" data-field="phone">联系电话</th>
                <th data-width="10%" data-field="name">车主姓名</th>
                <th data-width="20%" data-field="des">说明</th>
                <th data-width="20%" data-field="des">说明</th>
                <th data-width="15%" data-field="createTime">单据日期</th>
                <th data-width="15%" data-field="workCompletionTime">预计完成时间</th>
                <th data-width="10%" data-field="workStatus">当前状态</th>
            </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">

            <a class='btn btn-success' href='javascript:;'>结算</a>
            <a class='btn btn-warning' href='javascript:;'>还款</a>
            <a class='btn btn-primary' href='javascript:;'>结算后预览</a>
            <a class='btn btn-danger' href='javascript:;'>作废</a>
        </div>
    </div>
</div>

<!-- 添加弹窗 -->

<div class="modal fade" id="add" aria-hidden="true" >
    <div class="modal-dialog" >
        <div class="modal-content" >
            <form action="/table/edit" onsubmit="return checkAdd()" id="addForm" method="post">
                <div class="modal-header" style=" overflow:hidden;">
                    <div class="input-group">
                        <select  id="addSelect" style="width: 70%"  class="js-example-basic-multiple" multiple="multiple"></select>
                    </div>

                    <div class="input-group">
                        <span class="input-group-addon" id="sizing-addon1">手机号码</span>
                        <input type="text" class="form-control" placeholder="手机号码" aria-describedby="sizing-addon2">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon" id="sizing-addon2">姓名</span>
                        <input type="text" class="form-control" placeholder="姓名" aria-describedby="sizing-addon2">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon" id="sizing-addon3">身份证号码</span>
                        <input type="text" class="form-control" placeholder="身份证号码" aria-describedby="sizing-addon2">
                    </div>
                    <br />
                </div>

                <div class="modal-footer" >
                    <span id="addError" style="color: red;"></span>
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
                <div class="modal-header" style="width:auto; overflow:hidden;">
                    <input type="text"  define="ceshi.id" name="id" placeholder="请输入标题"  maxlength="15"/>
                    <input type="text"  define="ceshi.price" name="price"  placeholder="请输入标题"  maxlength="15"/>
                </div>
                <div class="modal-body">
                    <textarea type="text" style="width: 80%"  define="ceshi.name" name="name" placeholder="请输入描述"  maxlength="142"></textarea>
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
<script src="/static/js/backstage/emp/workInFo.js"></script>
<script src="/static/js/bootstrap-select/bootstrap-select.js"></script>

</body>
</html>
