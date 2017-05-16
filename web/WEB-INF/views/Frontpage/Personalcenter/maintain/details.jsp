<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>维修保养记录</title>
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
</head>
<body>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;">
        <table id="table" style="table-layout: fixed">
            <thead>
            <tr>
                <th data-radio="true" data-field="status"></th>
                <th data-width="90" data-field="checkin.brand.brandName">
                    汽车品牌
                </th>
                <th data-width="90" data-field="checkin.color.colorName">
                    汽车颜色
                </th>
                <th data-width="90" data-field="checkin.model.modelName">
                    汽车车型
                </th>
                <th data-width="90" data-field="checkin.plate.plateName">
                    汽车车牌
                </th>
                <th data-width="90" data-field="checkin.carPlate">
                    车牌号码
                </th>
                <th data-width="90" data-field="checkin.ifClearCar" data-formatter="showStatusFormatter">
                    是否洗车
                </th>
                <th data-width="150" data-field="checkin.carThings">
                    车上物品描述
                </th>
                <th data-width="150" data-field="checkin.intactDegrees">
                    汽车完好度描述
                </th>
                <th data-width="150" data-field="checkin.userRequests">
                    用户要求描述
                </th>
                <th data-width="100" data-field="checkin.maintainOrFix">
                    保养&nbsp;|&nbsp;维修
                </th>
                <th data-width="160" data-field="startTime" data-formatter="formatterDate">维修保养开始时间</th>
                <th data-width="190" data-field="endTime" data-formatter="formatterDate">维修保养预估结束时间</th>
                <th data-width="190" data-field="actualEndTime" data-formatter="formatterDate">维修保养实际结束时间</th>
                <th data-width="190" data-field="recordCreatedTime" data-formatter="formatterDate">维修保养记录创建时间</th>
                <th data-width="190" data-field="pickupTime" data-formatter="formatterDate">维修保养车主提车时间</th>
                <th data-width="160" data-field="recordDes">维修保养记录描述</th>
                <th data-width="100" data-field="recordStatus" data-formatter="statusFormatter">记录状态</th>
            </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <button id="btn_available" type="button" class="btn btn-default" onclick="showInfo();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span> 查看明细
            </button>
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
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="/static/js/backstage/main.js"></script>
<script src="/static/js/backstage/basicInfoManage/maintenance.js"></script>
</body>
</html>
