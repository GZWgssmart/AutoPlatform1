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
    <link rel="stylesheet" href="/static/css/bootstrap-switch/bootstrap-switch.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-validate/bootstrapValidator.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet/less" href="/static/css/bootstrap-dateTimePicker/datetimepicker.less">

    <title>查看预约</title>
</head>
<body>


<div class="container">
    <div class="panel-body" style="padding-bottom:0px;"  >
        <!--show-refredata-single-sesh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table">
            <thead>
            <tr>
                <th data-checkbox="true"></th>
                <th data-width="100" data-field="userName" >
                    车主姓名
                </th>
                <th data-width="100" data-field="userPhone">
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
                <th data-width="180" data-field="arriveTime" data-formatter="formatterDate">
                    到店时间
                </th>
                <th data-width="100" data-field="plate.plateName">
                    汽车车牌
                </th>
                <th data-width="100" data-field="carPlate">
                    车牌号码
                </th>
                <th data-width="100" data-hide="all" data-field="maintainOrFix">
                    保养&nbsp;|&nbsp;维修
                </th>
                <th data-width="180" data-hide="all" data-field="appCreatedTime" data-formatter="formatterDate">
                    登记时间
                </th>
                <th data-width="100" data-hide="all" data-field="company.companyName">
                    汽修公司
                </th>
                <th data-width="100" data-hide="all" data-field="currentStatus">
                    已预约&nbsp;|&nbsp;未预约
                </th>
                <th data-width="100" data-hide="all" data-field="appoitmentStatus" data-formatter="statusFormatter">
                    记录状态
                </th>
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
<script src="/static/js/contextmenu.js"></script>
<script src="/static/js/bootstrap-select/bootstrap-select.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="/static/js/backstage/main.js"></script>
<script src="/static/js/bootstrap-switch/bootstrap-switch.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/backstage/customerBooking/phoneResrvation.js"></script>
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
