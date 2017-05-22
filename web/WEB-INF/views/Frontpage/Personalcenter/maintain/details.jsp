<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/4/11
  Time: 15:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <title>维维修保养明细管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/datetimepicker.less">
</head>
<body>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;">
        <table id="table" style="table-layout: fixed">
            <thead>
            <tr>
                <th data-radio="true" data-field="status"></th>
                <th data-width="90" data-field="checkin.userName">
                    车主姓名
                </th>
                <th data-width="120" data-field="checkin.userPhone">
                    车主电话
                </th>
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
                <th data-width="100" data-field="checkin.maintainOrFix">
                    保养&nbsp;|&nbsp;维修
                </th>
                <th data-width="90" data-field="checkin.ifClearCar" data-formatter="showYesOrNoFormatter">
                    是否洗车
                </th>
                <th data-width="150" data-field="checkin.carThings">
                    车上物品描述
                </th>
                <th data-width="150" data-field="checkin.intactDegrees">
                    汽车完好度描述
                </th>
                <th data-width="150" data-field="recordDes">
                    维修保养记录描述
                </th>
                <th data-width="160" data-field="startTime" data-formatter="formatterDate">维修保养开始时间</th>
                <th data-width="190" data-field="endTime" data-formatter="formatterDate">维修保养预估结束时间</th>
                <th data-width="190" data-field="actualEndTime" data-formatter="formatterDate">维修保养实际结束时间</th>
                <th data-width="190" data-field="recordCreatedTime" data-formatter="formatterDate">维修保养记录创建时间</th>
                <th data-width="190" data-field="pickupTime" data-formatter="formatterDate">维修保养车主提车时间</th>
                <th data-width="100" data-hide="all" data-field="currentStatus">
                    当前状态
                </th>
                <th data-width="90" data-field="recordStatus" data-formatter="showStatusFormatter">
                    记录状态
                </th>
            </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
                <button id="btn_edit" type="button" class="btn btn-default" onclick="showDetail();">
                    <span class="glyphicon glyphicon-search" aria-hidden="true"></span>查看明细
                </button>
        </div>
    </div>
</div>

<!-- 明细表格 -->
<div id="detailWindow" class="modal fade" aria-hidden="true" style="overflow-y:scroll" data-backdrop="static"
     keyboard:false>
    <div class="modal-dialog" style="width: 90%">
        <div class="modal-content">
            <div class="modal-body">
                <div id="ifConfirm" style="background: url('/static/img/userCornfirm.png')-50px -50px no-repeat;position: absolute;z-index:999;width: 250px;height: 250px;background-size:250px;display: none"></div>
                <span class="glyphicon glyphicon-remove closeModal" data-dismiss="modal"></span>
                <h3 class="m-t-none m-b">此维修保养记录下的所有明细</h3>
                <table class="table table-hover" id="detailTable">
                    <thead>
                    <tr>
                        <th data-radio="true" data-field="status"></th>
                        <th data-width="100" data-field="maintainFix.maintainName">
                            项目名称
                        </th>
                        <th data-width="100" data-field="maintainFix.maintainHour">
                            项目公时
                        </th>
                        <th data-width="100" data-field="maintainFix.maintainOrFix">
                            维修|保养
                        </th>
                        <th data-width="100" data-field="maintainFix.maintainDes">
                            项目描述
                        </th>
                        <th data-width="100" data-field="maintainDiscount" data-formatter="formatterDiscount">
                            项目折扣
                        </th>
                        <th data-width="100" data-field="maintainFix.maintainMoney">
                            原价
                        </th>
                        <th data-width="110" data-field="maintainFix.maintainMoney"
                            data-formatter="formatterDiscountMoney">
                            折扣后价钱
                        </th>
                        <th data-width="100" data-field="mdcreatedTime" data-formatter="formatterDate">
                            明细创建时间
                        </th>
                    </thead>
                </table>
                <div class="modal-footer" style="overflow:hidden;">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
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
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="/static/js/backstage/main.js"></script>
<script>
    $(function () {
         initTable('table', '/maintainRecord/queryByOwner'); // 初始化表格
    });

    // 折扣
    function formatterDiscount(value) {
        if(value >= 1) {
            return "无折扣";
        } else {
            var str = value.toString();;
            var str1 = str.split('.')[1];
            str1 += "折";
            return str1;
        }
    }

    // 折扣后价钱
    function formatterDiscountMoney(value, row, index){
        var disCount = row.maintainDiscount;
        return value * disCount;
    }

    var recordId = "";

    // 显示所有明细
    function showDetail() {
        var row = $('#table').bootstrapTable('getSelections');
        if (row.length > 0) {
            recordId = row[0].recordId;
            $("#detailWindow").modal('show');
            if (row[0].ifConfirm == 'Y') {
                // 把用户已签字盖章显示
                $("#ifConfirm").css("display", "block");
                $("#detailToolbar").css("display", "none");
            } else {
                $("#ifConfirm").css("display", "none");
                $("#detailToolbar").css("display", "block");
            }
            initTableNotTollbar('detailTable', '/maintainDetail/queryByOwner/' + row[0].recordId + '');
        }
    }

</script>
</body>
</html>
