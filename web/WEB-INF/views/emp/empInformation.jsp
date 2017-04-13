<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工基本信息</title>
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
                    <th data-width="15%" data-field="phone">用户手机号</th>
                    <th data-width="10%" data-field="name">姓名</th>
                    <th data-width="15%" data-field="identity">身份证号</th>
                    <th data-width="10%" data-field="weChat">微信</th>
                    <th data-width="10%" data-field="company">所属公司</th>
                    <th data-width="15%" data-field="createTime">创建时间</th>
                    <th data-width="15%" data-field="userLoginedTime">最近一次登录时间</th>
                    <th data-width="5%" data-field="userStatus">用户状态</th>
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
                <a class='btn btn-danger' href='javascript:;'>离职</a>
            </div>
        </div>
    </div>

    <!-- 添加弹窗 -->

        <div class="modal fade" id="add" aria-hidden="true" style="overflow:hidden;">
            <div class="modal-dialog" style="overflow:hidden;">
                <div class="modal-content" style="overflow:hidden;">
                    <form class="form-horizontal" role="form" onsubmit="return checkAdd()" id="register-form" method="post">
                        <div class="modal-header" style="overflow:auto;">
                            <p>添加人员信息</p>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label" for="name">姓名：</label>
                            <div class="col-sm-7">
                                <input type="text" id="name" name="name" placeholder="请输入姓名" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label" for="phone">手机号码：</label>
                            <div class="col-sm-7">
                                <input type="text" id="phone" name="phone" placeholder="请输入手机号码" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">QQ：</label>
                            <div class="col-sm-7">
                                <input type="number" placeholder="请输入QQ" class="form-control" max="10">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">底薪：</label>
                            <div class="col-sm-7">
                                <input type="number" placeholder="请输入联系方式" class="form-control" max="10">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">微信：</label>
                            <div class="col-sm-7">
                                <input type="number" placeholder="请输入微信" class="form-control" max="11">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">角色：</label>
                            <div class="col-sm-7">
                                <select  placeholder="请选择角色" class="form-control">
                                    <option>a</option>
                                    <option>a</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label" for="password">密码：</label>
                            <div class="col-sm-7">
                                <input type="password" id="password" name="password" placeholder="请输入密码" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label" for="confirm_password">确定密码：</label>
                            <div class="col-sm-7">
                                <input type="password" id="confirm_password" name="confirm_password" placeholder="请确定密码" class="form-control">
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
                <hr/>
                <form class="form-horizontal" id="editForm" method="post">
                    <div class="modal-header" style="overflow:auto;">
                        <p>修改人员信息</p>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">姓名：</label>
                        <div class="col-sm-7">
                            <input type="text" define="emp.name"  class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label" >手机号码：</label>
                        <div class="col-sm-7">
                            <input type="text" define="emp.price" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">QQ：</label>
                        <div class="col-sm-7">
                            <input type="number"  class="form-control" max="10">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">底薪：</label>
                        <div class="col-sm-7">
                            <input type="number" class="form-control" max="10">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">微信：</label>
                        <div class="col-sm-7">
                            <input type="number" class="form-control" max="11">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">角色：</label>
                        <div class="col-sm-7">
                            <select class="form-control">
                                <option>a</option>
                                <option>a</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">密码：</label>
                        <div class="col-sm-7">
                            <input type="password" class="form-control">
                        </div>
                    </div>
                    <div class="modal-footer" style="overflow:hidden;">
                        <span id="editError"></span>
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">关闭
                        </button>
                        <button type="submit" class="btn btn-primary btn-sm">保存</button>
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
<script src="/static/js/backstage/emp/empInFormation.js"></script>
<script src="/static/js/bootstrap-select/bootstrap-select.js"></script>
<script src="/static/js/form/jquery.validate.js"></script>
<script src="/static/js/form/form.js"></script>

</body>
</html>
