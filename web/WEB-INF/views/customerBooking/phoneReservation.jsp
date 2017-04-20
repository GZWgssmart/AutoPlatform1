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
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/datetimepicker.less">

    <title>维修保养预约电话管理</title>
</head>
<body>

<%@include file="../backstage/contextmenu.jsp"%>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;"  >
        <!--show-refredata-single-sesh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table">
            <thead>
            <tr>
                <th data-checkbox="true"></th>
                <th data-field="userName">
                    车主姓名
                </th>
                <th data-field="userPhone">
                    车主电话
                </th>
                <th data-field="brandName">
                    汽车品牌
                </th>
                <th data-field="colorName">
                    汽车颜色
                </th>
                <th data-field="model.modelName">
                    汽车车型
                </th>
                <th data-field="plateName">
                    汽车车牌
                </th>
                <th data-field="carPlate">
                    车牌号码
                </th>
                <th data-field="arriveTime" data-formatter="formatterDate">
                    到店时间
                </th>
                <th data-hide="all" data-field="maintainOrFix">
                    保养&nbsp;|&nbsp;维修
                </th>
                <th data-hide="all" data-field="appCreatedTime" data-formatter="formatterDate">
                    登记时间
                </th>
                <th data-hide="all" data-field="companyName">
                    汽修公司
                </th>
                <th data-hide="all" data-field="appoitmentStatus" data-formatter="statusFormatter">
                    记录状态
                </th>
            </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <button id="btn_available" type="button" class="btn btn-default" onclick="showAvailable();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>可用登记记录
            </button>
            <button id="btn_disable" type="button" class="btn btn-default" onclick="showDisable();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>禁用登记记录
            </button>
            <button id="btn_add" type="button" class="btn btn-default" onclick="showAdd();">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
            </button>
            <button id="btn_edit" type="button" class="btn btn-default" onclick="showEdit();">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
            </button>
        </div>
    </div>
</div>

<!-- 添加弹窗 -->
<div class="modal fade" id="addWindow" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <hr/>
            <form class="form-horizontal" onsubmit="return checkAdd()" id="showAddFormWar" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <h4>添加登记记录信息</h4>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">车主名字：</label>
                    <div class="col-sm-7">
                        <input type="text" name="userName" define="emp.name" placeholder="请输入车主姓名" class="form-control" maxlength="20">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">车主电话：</label>
                    <div class="col-sm-7">
                        <input type="number" name="userPhone" placeholder="请输入车主手机号" class="form-control" maxlength="11">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">汽车品牌：</label>
                    <div class="col-sm-7">
                        <select>
                            <option>请选择品牌</option>
                            <option>品牌一</option>
                            <option>品牌二</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">汽车颜色：</label>
                    <div class="col-sm-7">
                        <select>
                            <option>请选择颜色</option>
                            <option>白色</option>
                            <option>黑色</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">汽车车型：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请选择车型" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">汽车车牌：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请选择汽车车牌" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">汽车车牌号：</label>
                    <div class="col-sm-7">
                        <input type="number" placeholder="请输入汽车车牌号" class="form-control">
                    </div>
                </div>


                <div class="form-group">
                    <label class="col-sm-3 control-label">到店时间：</label>
                    <div class="col-sm-7">
                        <input type="text" id="addArriveTime" onclick="getDate('addArriveTime')" placeholder="请选择到店时间" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">保养|维修：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请选择是保养或者维修" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">登记时间：</label>
                    <div class="col-sm-7">
                        <input type="text" id="addAppointmentCreatedTime" onclick="getDate('addAppointmentCreatedTime')" placeholder="请选择登记时间" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">汽修公司名称：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请输入汽修公司名称" class="form-control">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button id="addButton" type="submit" class="btn btn-primary btn-sm">保存</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 修改弹窗 -->
<div class="modal fade" id="editWindow" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <form class="form-horizontal" id="showEditFormWar" method="post" onclick="return checkEdit('table/edit');">
                <div class="modal-header" style="overflow:auto;">
                    <h4>被接待的车主信息修改</h4>
                </div>
                <br/>
                <div class="form-group">
                    <label class="col-sm-5 control-label">车主名字：</label>
                    <div class="col-sm-7">
                        <input type="text" name="userName" placeholder="请输入车主姓名" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 control-label">车主车牌号</label>
                    <div class="col-sm-7">
                        <input type="number" placeholder="请输入车主车牌号" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 control-label">车主手机号</label>
                    <div class="col-sm-7">
                        <input type="number" placeholder="请输入车主手机号" class="form-control" maxlength="11">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 control-label">车的品牌：</label>
                    <div class="col-sm-7">
                        <select>
                            <option>请选择品牌</option>
                            <option>品牌一</option>
                            <option>品牌二</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 control-label">车的颜色：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请输入车的颜色" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 control-label">车型：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请输入车型" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 control-label">车主到店时间：</label>
                    <div class="col-sm-7">
                        <input type="date" id="editArriveTime" onclick="getDate('editArriveTime')" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 control-label">汽修公司名称：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请输入汽修公司名称" class="form-control">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-5 control-label">登记时间：</label>
                    <div class="col-sm-7">
                        <input type="date" id="editCheckinCreatedTime" onclick="getDate('editCheckinCreatedTime')" class="form-control">
                    </div>
                </div>
                <%-- 注: 暂时先这么写，颜色是选择不是输入,看到这句说明你要更改这部分 --%>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">车的颜色：</label>
                        <div class="col-sm-7">
                            <select>
                                <option>请选择品牌</option>
                                <option>白色</option>
                                <option>黑色</option>
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
<script src="/static/js/backstage/main.js"></script>
<script src="/static/js/form/jquery.validate.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="/static/js/backstage/customerBooking/phoneResrvation.js"></script>
<script src="/static/js/bootstrap-select/bootstrap-select.js"></script>

</body>
</html>
