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

    <title>账单管理,查看收费单据</title>
</head>
<body>

<%@include file="../backstage/contextmenu.jsp"%>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;"  >
        <!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table">
            <thead>
                <tr>
                    <%-- 时间控件都没加 --%>
                    <%-- 汽修店维修保养的收费单据统一在此处管理，只支持查看，不支持修改 --%>
                    <%-- 当汽车维修保养结束后，由汽修店员工确认结束，一旦确认则系统自动根据维修保养明细和维修保养单据生成收费单据 --%>
                        <th data-radio="true">
                    <th data-field="maintainRecordId">维修保养记录编号</th>
                    <th data-field="chargeBillMoney">收费总金额</th>
                    <th data-field="paymentMethod">付款方式</th>
                    <th data-field="actualPayment">实付款</th>
                    <th data-field="chargeTime" data-formatter="formatterDate">收费时间</th>
                    <th data-field="chargeCreatedTime" data-formatter="formatterDate">收费单据创建时间</th>
                    <th data-field="chargeBillDes">收费单据描述</th>
                    <th data-field="chargeBillStatus"data-formatter="statusFormatter">收费状态</th>
                        <th data-field="chargeBillStatus" data-formatter="openStatusFormatter">操作</th>
                </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <button id="searchDisable" type="button" class="btn btn-default" onclick="searchDisableStatus();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询禁用类型
            </button>
            <button id="searchRapid" type="button" class="btn btn-default" onclick="searchRapidStatus();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询激活类型
            </button>
        </div>

    </div>
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
<script src="/static/js/backstage/financialControlJS/bill.js"></script>
<script src="/static/js/bootstrap-select/bootstrap-select.js"></script>
<script src="/static/js/form/jquery.validate.js"></script>
<script src="/static/js/form/form.js"></script>
<script src="/static/js/backstage/main.js"></script>

</body>
</html>
