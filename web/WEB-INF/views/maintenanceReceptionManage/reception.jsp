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
    <link rel="stylesheet" href="/static/css/bootstrap-validate/bootstrapValidator.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet/less" href="/static/css/bootstrap-dateTimePicker/datetimepicker.less">
    <title>接待登记管理</title>
</head>
<body>

<%@include file="../backstage/contextmenu.jsp"%>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;"  >
        <!--show-refredata-single-sesh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table" style="table-layout: fixed">
            <thead>
            <tr >
                <th data-radio="true"></th>
                <th data-width="100" data-field="userName">
                    车主姓名
                </th>
                <th data-width="110" data-field="userPhone">
                    车主电话
                </th>
                <th data-width="100" data-field="brand.brandName">
                    汽车品牌
                </th>
                <th data-width="100" data-field="color.colorName">
                    汽车颜色
                </th>
                <th data-width="100" data-field="model.modelName">
                    汽车车型
                </th>
                <th data-width="100" data-field="plate.plateName">
                    汽车车牌
                </th>
                <th data-width="100" data-field="carPlate">
                    车牌号码
                </th>
                <th data-width="180" data-field="arriveTime" data-formatter="formatterDate">
                    到店时间
                </th>
                <th data-width="120" data-hide="all" data-field="carMileage">
                    汽车行驶里程
                </th>
                <th data-width="120" data-hide="all" data-field="nowOil">
                    汽车当前油量
                </th>
                <th data-width="100" data-hide="all" data-field="ifClearCar" data-formatter="showStatusFormatter">
                    是否洗车
                </th>
                <th data-width="150" data-hide="all" data-field="carThings">
                    车上物品描述
                </th>
                <th data-width="150"  data-hide="all" data-field="intactDegrees">
                    汽车完好度描述
                </th>
                <th data-width="150" data-hide="all" data-field="userRequests">
                    用户要求描述
                </th>
                <th data-width="100" data-hide="all" data-field="maintainOrFix">
                    保养&nbsp;|&nbsp;维修
                </th>
                <th data-width="180" data-hide="all" data-field="checkinCreatedTime" data-formatter="formatterDate">
                    登记时间
                </th>
                <th data-width="120" data-hide="all" data-field="company.companyName">
                    汽修公司
                </th>
                <th data-width="100" data-hide="all" data-field="checkinStatus" data-formatter="statusFormatter">
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
            <div class="input-group" style="width:350px;float:left;padding:0;margin:0 0 0 -1px;">
                <div class="input-group-btn">
                    <button type="button" id="ulButton" class="btn btn-default" style="border-radius:0px;" data-toggle="dropdown">车主/汽车公司/汽车车牌<span class="caret"></span></button>
                    <ul class="dropdown-menu pull-right">
                        <li><a onclick="onclikLi(this)">车主/汽车公司/汽车车牌</a></li>
                        <li class="divider"></li>
                        <li><a onclick="onclikLi(this)">车主</a></li>
                        <li class="divider"></li>
                        <li><a onclick="onclikLi(this)">汽车公司</a></li>
                        <li class="divider"></li>
                        <li><a onclick="onclikLi(this)">汽车车牌</a></li>
                    </ul>
                </div><!-- /btn-group -->
                <input id="ulInput" class="form-control" onkeypress="if(event.keyCode==13) {blurredQuery();}">
                    <a href="javaScript:;" onclick="blurredQuery()"><span class="glyphicon glyphicon-search search-style"></span></a>
                </input>
            </div><!-- /input-group -->
        </div>
    </div>
</div>



<div id="addWindow" class="modal fade" style="overflow-y:scroll" data-backdrop="static" >
    <div class="modal-dialog">
        <div class="modal-content">
                        <form role="form" class="form-horizontal" id="addForm">
                            <div class="modal-header" style="overflow:auto;">
                                <h4>添加登记记录信息</h4>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">是否预约：</label>
                                <div class="col-sm-7">
                                    <select class="js-example-tags form-control" id="app"
                                            onchange="checkAppointment(this)">
                                        <option value="N">否</option>
                                        <option value="Y">是</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">保养&nbsp;|&nbsp;维修：</label>
                                <div class="col-sm-7">
                                    <select id="addMaintainOrFix" class="js-example-tags form-control" name="maintainOrFix">
                                        <option value="保养">保养</option>
                                        <option value="维修">维修</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">是否洗车：</label>
                                <div class="col-sm-7">
                                    <select class="js-example-tags form-control" name="ifClearCar">
                                        <option value="N">否</option>
                                        <option value="Y">是</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">车主姓名：</label>
                                <div class="col-sm-7">
                                    <input type="text" id="addUserName" placeholder="请输入车主姓名" name="userName" class="form-control"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">车主电话：</label>
                                <div class="col-sm-7">
                                    <input type="number" id="addUserPhone" placeholder="请输入车主电话" name="userPhone" class="form-control" style="width:100%"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">汽车品牌：</label>
                                <div class="col-sm-7">
                                <select id="addCarBrand" class="js-example-tags carBrand" name="brandId" style="width:100%">
                                </select>
                                </div>
                            </div>
                            <div id="addModelDiv" style="display: none" class="form-group">
                                <label class="col-sm-3 control-label">汽车车型：</label>
                                <div class="col-sm-7">
                                    <select id="addCarModel" class="js-example-tags carModel" name="modelId" style="width:100%">
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">汽车颜色：</label>
                                <div class="col-sm-7">
                                <select id="addCarColor" class="js-example-tags carColor" name="colorId" style="width:100%">
                                </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">汽车车牌：</label>
                                <div class="col-sm-7">
                                <select id="addCarPlate" class="js-example-tags carPlate" name="plateId" style="width:100%">
                                </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">车牌号码：</label>
                                <div class="col-sm-7">
                                <input type="text" name="carPlate" placeholder="请输入车牌号码" class="form-control"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">到店时间：</label>
                                <div class="col-sm-7">     <!-- 当设置不可编辑后, 会修改颜色, 在min.css里搜索.form-control{background-color:#eee;opacity:1} -->
                                <input id="addDatetimepicker" placeholder="请选择到店时间" onclick="getDate('addDatetimepicker')" readonly="true" type="text" name="arriveTime"
                                       class="form-control datetimepicker"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">汽车行驶里程：</label>
                                <div class="col-sm-7">
                                <input type="number" name="carMileage" placeholder="请输入汽车行驶里程" class="form-control" style="width:100%"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">汽车当前油量：</label>
                                <div class="col-sm-7">
                                <input type="number" name="nowOil" placeholder="请输入汽车当前油量" class="form-control" style="width:100%"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">车上物品描述：</label>
                                <div class="col-sm-7">
                                <textarea class="form-control" placeholder="请输入车上物品描述" name="carThings"
                                          rows="3" maxlength="500"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">汽车完好度描述：</label>
                                <div class="col-sm-7">
                                <textarea class="form-control" placeholder="请输入汽车完好度描述" name="intactDegrees"
                                          rows="3" maxlength="500"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">用户要求描述：</label>
                                <div class="col-sm-7">
                                <textarea class="form-control" placeholder="请输入用户要求描述" name="userRequests"
                                          rows="3" maxlength="500"></textarea>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-default"
                                        data-dismiss="modal">关闭
                                </button>
                                <button id="addButton" type="button" onclick="addSubmit()" class="btn btn-primary">添加
                                </button>
                                <input type="reset" name="reset" style="display: none;"/>
                            </div>
                        </form>
                    </div>
                </div>
</div>


<!-- 修改弹窗 -->
<div class="modal fade" id="editWindow" style="overflow-y:scroll" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <form role="form" class="form-horizontal" id="editForm">
                <div class="modal-header" style="overflow:auto;">
                    <h4>修改登记记录信息</h4>
                </div>
                <input type="hidden" define="checkin.checkinId" name="checkinId" class="form-control"/>
                <input type="hidden" define="checkin.userId" name="userId" class="form-control"/>
                <input type="hidden" define="checkin.appointmentId" name="appointmentId" class="form-control"/>
                <div class="form-group">
                    <label class="col-sm-3 control-label">保养&nbsp;|&nbsp;维修：</label>
                    <div class="col-sm-7">
                        <select id="editMaintainOrFix" define="checkin.maintainOrFix" class="js-example-tags form-control" name="maintainOrFix">
                            <option value="保养">保养</option>
                            <option value="维修">维修</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">是否洗车：</label>
                    <div class="col-sm-7">
                        <select class="js-example-tags form-control" define="checkin.ifClearCar" name="ifClearCar">
                            <option value="N">否</option>
                            <option value="Y">是</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">车主姓名：</label>
                    <div class="col-sm-7">
                        <input type="text" name="userName" placeholder="车主姓名" define="checkin.userName" class="form-control"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">车主电话：</label>
                    <div class="col-sm-7">
                        <input type="number" name="userPhone" placeholder="车主电话" define="checkin.userPhone" class="form-control" style="width:100%"/>
                    </div>
                </div>

                <div id="editModelDiv" class="form-group">
                    <label class="col-sm-3 control-label">汽车品牌：</label>
                    <div class="col-sm-7">
                        <select id="editCarBrand" class="js-example-tags carBrand" define="checkin.brandId" name="brandId" style="width:100%">
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">汽车车型：</label>
                    <div class="col-sm-7">
                        <select id="editCarModel" class="js-example-tags carModel" define="checkin.modelId" name="modelId" style="width:100%">
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">汽车颜色：</label>
                    <div class="col-sm-7">
                        <select id="editCarColor" class="js-example-tags carColor" define="checkin.colorId" name="colorId" style="width:100%">
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">汽车车牌：</label>
                    <div class="col-sm-7">
                        <select id="editCarPlate" class="js-example-tags carPlate" define="checkin.plateId" name="plateId" style="width:100%">
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">车牌号码：</label>
                    <div class="col-sm-7">
                        <input type="text" name="carPlate" placeholder="车牌号码" define="checkin.carPlate" class="form-control"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">到店时间：</label>
                    <div class="col-sm-7">     <!-- 当设置不可编辑后, 会修改颜色, 在min.css里搜索.form-control{background-color:#eee;opacity:1} -->
                        <input id="editDatetimepicker" placeholder="请选择到店时间" readonly="true" type="text" name="arriveTime"
                               class="form-control datetimepicker"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">汽车行驶里程：</label>
                    <div class="col-sm-7">
                        <input type="number" name="carMileage" placeholder="请输入汽车行驶里程" define="checkin.carMileage" class="form-control" style="width:100%"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">汽车当前油量：</label>
                    <div class="col-sm-7">
                        <input type="number" name="nowOil" placeholder="请输入汽车当前油量" define="checkin.nowOil" class="form-control" style="width:100%"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">车上物品描述：</label>
                    <div class="col-sm-7">
                                <textarea type="textarea" class="form-control" placeholder="请输入车上物品描述" define="checkin.carThings" name="carThings"
                                          rows="3" maxlength="500"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">汽车完好度描述：</label>
                    <div class="col-sm-7">
                                <textarea type="textarea" class="form-control" placeholder="请输入汽车完好度描述" define="checkin.intactDegrees" name="intactDegrees"
                                          rows="3" maxlength="500"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">用户要求描述：</label>
                    <div class="col-sm-7">
                                <textarea type="textarea" class="form-control" placeholder="请输入用户要求描述" define="checkin.userRequests" name="userRequests"
                                          rows="3" maxlength="500"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button id="editButton" type="button" onclick="editSubmit()" class="btn btn-primary">保存
                    </button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div id="appWindow" class="modal fade" aria-hidden="true" style="overflow:scroll" data-backdrop="static" keyboard:false>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 b-r">
                        <h3 class="m-t-none m-b">选择预约记录</h3>
                        <table class="table table-hover" id="appTable">
                            <thead>
                            <tr>
                                <th data-checkbox="true"></th>
                                <th data-field="userName">
                                    车主姓名
                                </th>
                                <th data-field="userPhone">
                                    车主电话
                                </th>
                                <th data-field="brand.brandName">
                                    汽车品牌
                                </th>
                                <th data-field="color.colorName">
                                    汽车颜色
                                </th>
                                <th data-field="model.modelName">
                                    汽车车型
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </th>
                                <th data-field="plate.plateName">
                                    汽车车牌
                                </th>
                                <th data-field="carPlate">
                                    车牌号码
                                </th>
                                <th data-field="arriveTime" data-formatter="formatterDate">
                                    预计到店时间
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </th>
                                <th data-field="maintainOrFix">
                                    维修&nbsp;|&nbsp;保养
                                </th>
                                <th data-field="appCreatedTime" data-formatter="formatterDate">
                                    预约创建时间
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </th>
                                <th data-field="company.companyName">
                                    汽修公司
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </th>
                                <th data-field="appoitmentStatus" data-formatter="status">
                                    预约状态
                                </th>
                            </thead>
                            <tbody>
                            </tbody>

                        </table>
                        <div style="height: 100px;"></div>
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
    <script src="/static/js/jquery.min.js"></script>
    <script src="/static/js/bootstrap.min.js"></script>
    <script src="/static/js/bootstrap-table/bootstrap-table.js"></script>
    <script src="/static/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
    <script src="/static/js/jquery.formFill.js"></script>
    <script src="/static/js/select2/select2.js"></script>
    <script src="/static/js/sweetalert/sweetalert.min.js"></script>
    <script src="/static/js/contextmenu.js"></script>
    <script src="/static/js/backstage/main.js"></script>
    <script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
    <script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
    <script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
    <script src="/static/js/backstage/maintenanceReception/reception.js"></script>

</body>
</html>
