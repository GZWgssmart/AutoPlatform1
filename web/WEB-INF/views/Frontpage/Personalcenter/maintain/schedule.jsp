<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>维修保养进度管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/css/bootstrap-validate/bootstrapValidator.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
</head>
<body>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;">
        <!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table">
            <thead>
            <tr>
                <th data-radio="true" data-field="status"></th>
                <th data-field="maintainRecord.checkin.brand.brandName">汽车品牌</th>
                <th data-field="maintainRecord.checkin.color.colorName">汽车颜色</th>
                <th data-field="maintainRecord.checkin.plate.plateName">车牌号码</th>
                <th data-field="maintainRecord.startTime" data-formatter="formatterDateTime">保养开始时间</th>
                <th data-field="maintainRecord.actualEndTime" data-formatter="formatterDateTime">保养结束时间</th>
                <th data-field="maintainRecord.pickupTime" data-formatter="formatterDateTime">车主提车时间</th>
                <th data-field="maintainRecord.recordDes">维修保养进度描述</th>
                <th data-field="workStatus">维修保养状态</th>
            </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <button id="btn_available" type="button" class="btn btn-default" onclick="showInfo();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span> 查看详情
            </button>
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
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="/static/js/backstage/main.js"></script>
<script src="/static/js/backstage/basicInfoManage/maintenance.js"></script>
<script>
    function showInfo() {
        var row = $('table').bootstrapTable('getSelections');
        if (row.length > 0) {
            /*显示窗口*/
            alert("好棒棒哦！");
        } else {
            swal({
                "title": "",
                "text": "请先选择一条数据",
                "type": "warning"
            })
        }
    }
</script>
</body>
</html>
