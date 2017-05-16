<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="utf-8">
    <title>收费单据管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet/less" href="/static/css/bootstrap-dateTimePicker/datetimepicker.less">
    <link rel="stylesheet" href="/static/css/bootstrap-validate/bootstrapValidator.min.css">
</head>
<body>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;"  >
        <!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table" style="table-layout: fixed">
            <thead>
            <tr>
                <th data-radio="true" data-field="status"></th>
                <th data-width="90" data-field="maintainRecord.checkin.brand.brandName">汽车品牌</th>
                <th data-width="90" data-field="maintainRecord.checkin.model.modelName">汽车车型</th>
                <th data-width="90" data-field="maintainRecord.checkin.color.colorName">汽车颜色</th>
                <th data-width="90" data-field="maintainRecord.checkin.plate.plateName">汽车车牌</th>
                <th data-width="90" data-field="maintainRecord.checkin.carPlate">车牌号码</th>
                <th data-width="180" data-field="maintainRecord.pickupTime" data-formatter="formatterDate">维修保养记录提车时间</th>
                <th data-width="150" data-field="maintainRecord.recordDes">维修保养记录描述</th>
                <th data-width="90" data-field="paymentMethod">付款方式</th>
                <th data-width="90" data-field="chargeBillMoney">总金额</th>
                <th data-width="90" data-field="actualPayment">实际付款</th>
                <th data-width="180" data-field="chargeTime" data-formatter="formatterDate">收费时间</th>
                <th data-width="180" data-field="chargeCreatedTime" data-formatter="formatterDate">收费单据创建时间</th>
                <th data-width="130" data-field="chargeBillDes">收费单据描述</th>
                <th data-width="130" data-field="chargeBillStatus" data-formatter="showStatusFormatter">收费单据状态</th>
            </tr>
            </thead>
        </table>
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
</body>
</html>
