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

    <title>维修保养明细管理</title>
</head>
<body>

<%@include file="../backstage/contextmenu.jsp"%>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;"  >
        <!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table" data-toggle="table" data-toolbar="#toolbar" data-url="/table/query"
               data-method="post" data-query-params="queryParams" data-pagination="true"
               data-search="true" data-show-refresh="true" data-show-toggle="true"
               data-show-columns="true" data-page-size="10" data-height="600"
               data-id-field="id" data-page-list="[5, 10, 20]" data-cach="false"
               data-click-to-select="true" data-single-select="true">
            <thead>
                <tr>
                    <%-- 时间控件都没加 --%>
                    <th data-radio="true" data-field="status"></th>
                    <th data-field="startTime">开始时间</th>
                    <th data-field="endTime">预估结束时间</th>
                    <th data-field="actualEndTime">实际结束时间</th>
                    <th data-field="maintainName">维修保养项目名称</th>
                    <th data-field="pickupTime">维修保养记录创建时间</th>
                    <th data-field="maintainHour">工时</th>
                    <th data-field="maintainMoney">基础费用</th>
                    <th data-field="maintainManHourFee">工时费</th>
                    <th data-field="maintainDiscount">维修保养项目折扣</th> <%-- 默认0,可选择折扣，也可选择减价 --%>
                    <th data-field="maintainOrFix">保养还是维修</th><%-- 下拉 --%>
                    <th data-field="maintainDes">描述</th>
                    <th data-field="companyName">维修保养项目所属公司</th>
                    <th data-field="mdCreateTime">维修保养明细创建时间</th>
                    <th data-field="recordStatus">状态</th>
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

<%-- 添加窗口 --%>
<div class="modal fade" id="add" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="container">
                <form class="form-horizontal" role="form" onsubmit="return checkAdd()" id="register-form" method="post">
                    <div class="modal-header" style="overflow:auto;">
                        <p>维修保养明细录入</p>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label" for="name">维修保养开始时间：</label>
                        <div class="col-sm-7">
                            <input type="date" id="statt" name="start" placeholder="2017/02/02 08:30" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label" for="name">预估结束时间：</label>
                        <div class="col-sm-7">
                            <input type="date" id="end" name="end" placeholder="2017/02/07 08:30" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label" for="name">实际结束时间：</label>
                        <div class="col-sm-7">
                            <input type="date" id="actualEnd" name="actualEnd" placeholder="2017/02/02 08:30" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label" for="name">维修保养项目名称：</label>
                        <div class="col-sm-7">
                            <input type="text" id="name" name="name" placeholder="维修保养项目名称" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label" for="name">维修保养项目工时：</label>
                        <div class="col-sm-7">
                            <input type="number" id="hour" name="hour" placeholder="维修保养项目工时" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label" for="name">基础费用：</label>
                        <div class="col-sm-7">
                            <input type="number" id="money" name="money" placeholder="基础费用" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label" for="name">工时费用：</label>
                        <div class="col-sm-7">
                            <input type="number" id="manHourFee" name="manHourFee" placeholder="工时费用" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">维修保养项目描述：</label>
                        <div class="col-sm-7">
                            <textarea type="text" placeholder="请输入维修保养项目描述" style="height: 50px;"
                                  class="form-control"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label" for="name">项目所属公司：</label>
                        <div class="col-sm-7">
                            <input type="text" placeholder="维修保养项目所属公司" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">维修保养项目折扣：</label>
                        <div class="col-sm-7">
                            <select>
                                <option>无</option>
                                <option>折扣</option>
                                <option>减价</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">保养还是维修：</label>
                        <div class="col-sm-7">
                            <select>
                                <option>保养</option>
                                <option>维修</option>
                            </select>
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
                <form class="form-horizontal" id="editForm" method="post">
                    <div class="modal-header" style="overflow:auto;">
                        <p>维修保养明细修改</p>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label" for="name">维修保养开始时间：</label>
                        <div class="col-sm-7">
                            <input type="date" name="start" placeholder="2017/02/02 08:30" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label" for="name">预估结束时间：</label>
                        <div class="col-sm-7">
                            <input type="date" name="end" placeholder="2017/02/07 08:30" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label" for="name">实际结束时间：</label>
                        <div class="col-sm-7">
                            <input type="date" name="actualEnd" placeholder="2017/02/02 08:30" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label" for="name">维修保养项目名称：</label>
                        <div class="col-sm-7">
                            <input type="text" name="name" placeholder="维修保养项目名称" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label" for="name">维修保养项目工时：</label>
                        <div class="col-sm-7">
                            <input type="number" name="hour" placeholder="维修保养项目工时" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label" for="name">基础费用：</label>
                        <div class="col-sm-7">
                            <input type="number" name="money" placeholder="基础费用" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label" for="name">工时费用：</label>
                        <div class="col-sm-7">
                            <input type="number" name="manHourFee" placeholder="工时费用" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">维修保养项目描述：</label>
                        <div class="col-sm-7">
                            <textarea type="text" placeholder="请输入维修保养项目描述" style="height: 50px;"
                                      class="form-control"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label" for="name">项目所属公司：</label>
                        <div class="col-sm-7">
                            <input type="text" placeholder="维修保养项目所属公司" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">维修保养项目折扣：</label>
                        <div class="col-sm-7">
                            <select>
                                <option>无</option>
                                <option>折扣</option>
                                <option>减价</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">保养还是维修：</label>
                        <div class="col-sm-7">
                            <select>
                                <option>保养</option>
                                <option>维修</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">状态：</label>
                        <div class="col-sm-7">
                            <label><input type="radio" name="recordStatus" value="Y" /> 激 活</label>
                            <label><input type="radio" name="recordStatus" value="N" /> 禁 用</label>
                        </div>
                    </div>
                    <div class="modal-footer" style="overflow:hidden;">
                        <button type="button" class="btn btn-default" data-dismiss="modal"> 关闭 </button>
                        <button type="button" class="btn btn-primary"> 保存 </button>
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
    <script src="/static/js/bootstrap-select/bootstrap-select.js"></script>
    <script src="/static/js/form/jquery.validate.js"></script>
    <script src="/static/js/form/form.js"></script>
    <script src="/static/js/maintenanceJieDaiGuanLi/subsidiary.js"></script>
</body>
</html>
