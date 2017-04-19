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
                <th data-width="15%" data-field="phone">用户手机号</th>
                <th data-width="10%" data-field="name">姓名</th>
                <th data-width="10%" data-field="prizeSalary">奖金</th>
                <th data-width="10%" data-field="minusSalay">罚款</th>
                <th data-width="10%" data-field="totalSalary">总工资</th>
                <th data-width="15%" data-field="salaryDes">工资发放描述</th>
                <th data-width="15%" data-field="salaryTime">工资发放时间</th>
                <th data-width="15%" data-field="salaryCreatedTime">创建时间</th>
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

<!-- 添加弹窗 -->
<div class="modal fade" id="add" aria-hidden="true" style="overflow:auto;">
    <div class="modal-dialog" style="overflow:hidden;">
        <div class="modal-content" style="overflow:hidden;">
            <div class="container" style="width: 80%;">
                <form class="form-horizontal" role="form" onsubmit="return checkAdd()" id="register-form" method="post">
                    <div class="modal-header" style="overflow:auto;">
                        <p>员工工资录入</p>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label" for="name">员工姓名：</label>
                        <div class="col-sm-7">
                            <input onclick="checkAppointment();"  type="text" readonly="true" id="name" name="name" placeholder="请点击选择员工" class="form-control">
                         </div>

                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label" for="phone">手机号码：</label>
                        <div class="col-sm-7">
                            <input type="text" id="phone" name="phone" placeholder="请输入手机号码" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">罚款：</label>
                        <div class="col-sm-7">
                            <input type="number" placeholder="请输入罚款" class="form-control" max="10">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">底薪：</label>
                        <div class="col-sm-7">
                            <input type="number" placeholder="请输入联系方式" class="form-control" max="10">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">总工资：</label>
                        <div class="col-sm-7">
                            <input type="number" placeholder="请输入总工资" class="form-control" max="11">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label" for="password">工资描述：</label>
                        <div class="col-sm-7">
                            <input type="password" id="password" name="password" placeholder="请输入工资发放描述" class="form-control">
                        </div>
                    </div>

                    <div class="modal-footer">
                        <span id="addError"></span>
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">关闭
                        </button>
                        <button type="submit" class="btn btn-primary btn-sm">保存</button>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<div id="appWin" class="modal fade" aria-hidden="true" style="overflow:scroll" data-backdrop="static" keyboard:false>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 b-r">
                        <h3 class="m-t-none m-b">选择人员</h3>
                        <table class="table table-hover" id="appTable"
                               data-height="550">
                            <thead>
                            <tr>
                                <th data-radio="true" data-field="status"></th>
                                <th data-field="inTypeName">收入类型</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>

                        </table>
                        <div class="modal-footer" style="overflow:hidden;">
                            <button type="button" class="btn btn-default" onclick="closeAppWin()">关闭
                            </button>
                            <input type="button" class="btn btn-primary" onclick="checkApp()" value="确定">
                            </input>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>


<!-- 修改弹窗 -->
<div class="modal fade" id="edit" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="container" style="width: 80%;">
                <form class="form-horizontal" role="form" onsubmit="return checkAdd()" id="edit-form" method="post">
                    <div class="modal-header" style="overflow:auto;">
                        <p>员工工资录入</p>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label" for="name">员工姓名：</label>
                        <div class="col-sm-7">
                            <input type="text" id="n" name="name" placeholder="请输入员工姓名" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label" for="phone">手机号码：</label>
                        <div class="col-sm-7">
                            <input type="text" id="p" name="phone" placeholder="请输入手机号码" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">罚款：</label>
                        <div class="col-sm-7">
                            <input type="number" placeholder="请输入罚款" class="form-control" max="10">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">底薪：</label>
                        <div class="col-sm-7">
                            <input type="number" placeholder="请输入联系方式" class="form-control" max="10">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">总工资：</label>
                        <div class="col-sm-7">
                            <input type="number" placeholder="请输入总工资" class="form-control" max="11">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label" for="password">工资描述：</label>
                        <div class="col-sm-7">
                            <input type="password" id="pwd" name="password" placeholder="请输入工资发放描述" class="form-control">
                        </div>
                    </div>

                    <div class="modal-footer">
                        <span id="editError"></span>
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">关闭
                        </button>
                        <button type="submit" class="btn btn-primary btn-sm">保存</button>
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
<script src="/static/js/backstage/financialControlJS/salary.js"></script>
<script src="/static/js/bootstrap-select/bootstrap-select.js"></script>
<script src="/static/js/backstage/main.js"></script>


</body>
</html>
