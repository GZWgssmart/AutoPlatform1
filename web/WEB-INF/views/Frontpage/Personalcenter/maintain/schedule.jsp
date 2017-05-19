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
                <th data-field="maintainRecord.checkin.userName">车主姓名</th>
                <th data-field="maintainRecord.checkin.userPhone">车主电话</th>
                <th data-field="maintainRecord.checkin.brand.brandName">汽车品牌</th>
                <th data-field="maintainRecord.checkin.color.colorName">汽车颜色</th>
                <th data-field="maintainRecord.checkin.plate.plateName">车牌号码</th>
                <th data-field="maintainRecord.checkin.company.companyName">汽修公司</th>
                <th data-field="maintainRecord.checkin.model.modelName">汽车车型</th>
                <th data-field="maintainRecord.checkin.carPlate">车牌名称</th>
                <th data-field="maintainRecord.checkin.maintainOrFix">维修|保养</th>
                <th data-field="maintainRecord.checkin.intactDegrees">车身完好度</th>
                <th data-field="maintainRecord.checkin.carThings">车上物品</th>
                <th data-field="maintainRecord.checkin.userRequests">用户要求描述</th>
            </tr>
            </thead>
        </table>
    </div>
</div>


<%--查看进度--%>
<div id="ScheduleWindow" class="modal fade" aria-hidden="true" style="overflow-y:scroll" data-backdrop="static" keyboard:false>

    <div class="modal-dialog" style="width: 90%;">
        <div class="modal-content">
            <div class="modal-body">
                <span class="glyphicon glyphicon-remove closeModal" data-dismiss="modal"></span>
                <h3 class="m-t-none m-b">车辆维修保养进度</h3>
                <div id="toolbars" class="btn-group">
                    <button id="btn_add" type="button" class="btn btn-default" onclick="showAdd();">
                        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增进度描述
                    </button>
                    <button id="btn_edit" type="button" class="btn btn-default" onclick="showEdit();">
                        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>确认完成
                    </button>
                </div>
                <hr>
                <div id="maintenance"></div>
                <div class="modal-footer" style="border: none">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 引入jquery -->
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script src="/static/js/jquery.formFill.js"></script>
<script src="/static/js/select2/select2.js"></script>
<script src="/static/js/sweetalert/sweetalert.min.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/backstage/main.js"></script>
<%--<script src="/static/js/backstage/basicInfoManage/maintenance.js"></script>--%>
<script>
    /*初始化表格*/
    $(function(){
         initTable('table','/maintainSchedule/queryScheduleByRecord');//初始化表格
    });
</script>
</body>
</html>
