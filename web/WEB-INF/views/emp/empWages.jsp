<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工工资查询</title>
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
                        <th data-width="10%" data-field="prizeSalary">奖金</th>
                        <th data-width="10%" data-field="minusSalay">罚款</th>
                        <th data-width="10%" data-field="totalSalary">总工资</th>
                        <th data-width="15%" data-field="salaryDes">工资发放描述</th>
                        <th data-width="15%" data-field="salaryTime">工资发放时间</th>
                        <th data-width="15%" data-field="salaryCreatedTime">创建时间</th>
                    </tr>
                </thead>
            </table>
            <%--
                只有超级管理员和汽修公司的管理员能对员工工资进行录入和修改,普通员工的话只能分页查询自己的工资
                添加员工工资 对工资的管理应该属于财务的管理员负责，即使是超级管理员应该也不能对工资进行录入或者修改，
                所以，这一块，就只用来查询员工自己的工资
            --%>
        </div>
    </div>

    <%--<div class="modal fade" id="add" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <form class="form-horizontal" role="form" onsubmit="return checkAdd()" id="register-form" method="post">
                    <div class="modal-header" style="overflow:auto;">
                        <p>员工工资录入</p>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label" >员工姓名：</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" placeholder="员工姓名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label" >手机号码：</label>
                        <div class="col-sm-7">
                            <input type="number" class="form-control" placeholder="手机号只能输入11位"
                                   oninput="if (value.length > 11) { value = value.slice(0, 11)}" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label" >奖&nbsp;金：</label>
                        <div class="col-sm-7">
                            <input type="number" class="form-control" placeholder="奖金">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label" >罚&nbsp;款：</label>
                        <div class="col-sm-7">
                            <input type="number" class="form-control" placeholder="罚款">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">总工资：</label>
                        <div class="col-sm-7">
                            <input type="number" class="form-control" placeholder="总工资">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label" >工资发放描述：</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" placeholder="工资发放描述">
                        </div>
                    </div><br />
                    <div class="modal-footer" >
                        <span id="addError" style="color: red;"></span>
                        <button type="button" class="btn btn-default" data-dismiss="modal"> 关闭 </button>
                        <button type="submit" class="btn btn-primary btn-sm"> 保存 </button>
                    </div>
                </form>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>--%><!-- /.modal -->

    <!-- 修改员工工资 -->
    <div class="modal fade" id="edit" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="editForm" class="data1" id="editForm" method="post">
                    <div class="modal-header" style=" overflow:hidden;">
                        <div class="form-group">
                            <span class="input-group-addon">手机号码</span>
                            <input type="number" class="form-control" aria-describedby="sizing-addon2"
                                   oninput="if (value.length > 11) { value = value.slice(0, 11)}" />
                        </div>
                        <div class="form-group">
                            <span class="input-group-addon">奖金</span>
                            <input type="number" class="form-control" placeholder="奖金" aria-describedby="sizing-addon2">
                        </div>
                        <div class="form-group">
                            <span class="input-group-addon">罚款</span>
                            <input type="number" class="form-control" placeholder="罚款" aria-describedby="sizing-addon2">
                        </div>
                        <div class="form-group">
                            <span class="input-group-addon">总工资</span>
                            <input type="number" class="form-control" placeholder="总工资" aria-describedby="sizing-addon2">
                        </div>
                        <div class="form-group">
                            <span class="input-group-addon">工资发放描述</span>
                            <input type="text" class="form-control" placeholder="工资发放描述" aria-describedby="sizing-addon2">
                        </div>
                        <br />
                    </div>
                    <div class="modal-footer" >
                        <span id="editError" style="color: red;"></span>
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">关闭
                        </button>
                        <button type="submit" class="btn btn-primary btn-sm">保存</button>
                    </div>
                </form>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>

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
<script src="/static/js/backstage/emp/empWages.js"></script>
<script src="/static/js/bootstrap-select/bootstrap-select.js"></script>

</body>
</html>
