<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017-04-11
  Time: 15:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/static/css/bootstrap.min.css">
        <link rel="stylesheet" href="/static/css/bootstrap-table.css">
        <link rel="stylesheet" href="/static/css/statistics_Private/daterangepicker.css">
        <link rel="stylesheet" href="/static/css/statistics_Private/cyItem.css">
        <link rel="stylesheet" href="/static/css/statistics_Private/piecemeal.css">


        <title>财务统计</title>
</head>
<body >
<%@include file="../backstage/contextmenu.jsp"%>
    <div class="head">
        <div class="title" style="height:55px">
            <h2 class="pull-left" style="bottom: 20px;">财务统计</h2>
            <div id="reportrange" class="pull-right" style="background: #fff; left:100px;margin-right: 138px;position: relative;top:33px;cursor: pointer; padding: 5px 10px; border: 1px solid #ccc;">
                <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp;
                <span></span> <b class="caret"></b>
            </div>
        </div>
    </div>
    <div class="container " style="margin-top:10px">
        <div class="panel" >
            <div class="subtitle"><h3 > 收支图表</h3></div>
            <div class="echarImg clearfix" style="height:60%;">
                <div class="col-md-7" >
                    <div id="echart" style="width:100%;height:100%;"></div>
                </div>
                <div class="col-md-5" style="height:100%; padding-bottom:20px">
                    <div class="col-md-12"  style="height:40%; top: 10%">
                        <div id="top1"></div>
                    </div>
                    <div class="col-md-12"  style="height:30%;">
                        <div id="top2"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel" >
            <div class="subtitle"><h3> 收支记录</h3></div>
            <div class="financeTable clearfix" style="margin-top: 10px">
                <div class="panel-body" style="padding-bottom:0px;"  >
                    <table id="table">
                        <thead>
                        <tr>
                            <th data-radio="true"></th>
                            <th  data-formatter="ioTypeFormatter">
                                收支类型
                            </th>
                            <th data-field="inOutMoney">
                                收支金额
                            </th>
                            <th data-field="user.userName">
                                创建人
                            </th>
                            <th data-field="inOutCreatedTime" data-formatter="formatterDate">
                                创建时间
                            </th>
                        </tr>
                        </thead>
                    </table>

                </div>
            </div>
        </div>
    </div>

    </div>
</body>

<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script src="/static/js/echarts/echarts.js"></script>
<script src="/static/js/statistics_Private/moment.js"></script>
<script src="/static/js/statistics_Private/daterangepicker.js"></script>
<script src="/static/js/statistics_Private/cyItem.js"></script>
<script src="/static/js/backstage/statistics/finance.js"></script>
<script src="/static/js/backstage/main.js"></script>
<script src="/static/js/contextmenu.js"></script>

</html>
