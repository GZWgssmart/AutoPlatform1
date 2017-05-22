<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>支付统计</title>
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link href="/static/css/select2/select2.css" rel="stylesheet">

</head>
<script type="text/javascript" src="/static/js/jquery.min.js"></script>
<script type="text/javascript" src="/static/js/echarts/echarts.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/bootstrap-select/select2.js"></script>
<script type="text/javascript" src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>


<body>
<%@include file="../backstage/contextmenu.jsp" %>


<div class='container-fluid'>
    <h2 class='page-header'>支付统计</h2>
    <!--
        选项卡：通过BS的类来控制选项卡的样式
    -->
    <ul class='nav nav-tabs'>
        <li class='active'><a href='#tab1' data-toggle='tab'>按年查找</a></li>
        <li><a href='#tab2' data-toggle='tab'>按月查找</a></li>
        <li><a href='#tab3' data-toggle='tab'>按日查找</a></li>
        <li><a href='#tab4' data-toggle='tab'>按季度查找</a></li>
        <li><a href='#tab5' data-toggle='tab'>按周查找</a></li>
    </ul>

    <!--
        选项卡的内容定义
    -->
    <div class='tab-content'>
        <div class='tab-pane active' id='tab1'>
            <div class="left col-xs-2 text-right">
                <label>开始时间:</label>
            </div>
            <div class="right col-xs-2 text-left">
                <div class="input-group" id="startYearInputId">
                    <input type="text" class="form-control form_Year" id="startYearInput" name="addtime"
                           placeholder="请选择开始时间">
                    <span class="input-group-addon" id="startYear"><span class="glyphicon glyphicon-time"
                                                                         aria-hidden="true"></span></span>
                </div>
            </div>
            <div class="left col-xs-2 text-right">
                <label>结束时间:</label>
            </div>
            <div class="right col-xs-2 text-left" id="endYearInputId">
                <div class="input-group">
                    <input type="text" class="form-control form_Year" id="endYearInput" name="addtime"
                           placeholder="请选择结束时间">
                    <span class="input-group-addon" id="endYear"><span class="glyphicon glyphicon-time"
                                                                       aria-hidden="true"></span></span>
                </div>
            </div>
            <button id="yearBtnId" type="button" class="btn btn-default" onclick="selectYears();">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>查询
            </button>
        </div>
        <div class='tab-pane' id='tab2'>
            <div class="left col-xs-2 text-right">
                <label>开始时间:</label>
            </div>
            <div class="right col-xs-2 text-left" id="startMonthInputId">
                <div class="input-group">
                    <input type="text" class="form-control form_Month" id="startMonthInput" name="addtime"
                           placeholder="请选择开始时间">
                    <span class="input-group-addon" id="startMonth"><span class="glyphicon glyphicon-time"
                                                                          aria-hidden="true"></span></span>
                </div>
            </div>
            <div class="left col-xs-2 text-right">
                <label>结束时间:</label>
            </div>
            <div class="right col-xs-2 text-left" id="endMonthInputId">
                <div class="input-group">
                    <input type="text" class="form-control form_Month" id="endMonthInput" name="addtime"
                           placeholder="请选择结束时间">
                    <span class="input-group-addon" id="endMonth"><span class="glyphicon glyphicon-time"
                                                                        aria-hidden="true"></span></span>
                </div>
            </div>
            <button id="monthBtnId" type="button" class="btn btn-default" onclick="selectMonth();">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>查询
            </button>
        </div>
        <div class='tab-pane' id='tab3'>
            <div class="left col-xs-2 text-right">
                <label>开始时间:</label>
            </div>
            <div class="right col-xs-2 text-left" id="startDayInputId" >
                <div class="input-group">
                    <input type="text" class="form-control form_Day" id="startDayInput" name="addtime"
                           placeholder="请选择开始时间">
                    <span class="input-group-addon" id="startDay"><span class="glyphicon glyphicon-time"
                                                                        aria-hidden="true"></span></span>
                </div>
            </div>
            <div class="left col-xs-2 text-right">
                <label>结束时间:</label>
            </div>
            <div class="right col-xs-2 text-left" id="endDayInputId">
                <div class="input-group">
                    <input type="text" class="form-control form_Day" id="endDayInput" name="addtime"
                           placeholder="请选择结束时间">
                    <span class="input-group-addon" id="endDay"><span class="glyphicon glyphicon-time"
                                                                      aria-hidden="true"></span></span>
                </div>
            </div>

            <button id="dayBtnId" type="button" class="btn btn-default"  onclick="selectDay();">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>查询
            </button>
        </div>
        <div class='tab-pane' id='tab4'>
            <div class="left col-xs-2 text-right">
                <label>开始时间:</label>
            </div>
            <div class="right col-xs-2 text-left" id="startQuarterInputId" >
                <div class="input-group">
                    <input type="text" class="form-control form_Day" id="startQuarterInput" name="addtime"
                           placeholder="请选择开始时间">
                    <span class="input-group-addon" id="startQuarter"><span class="glyphicon glyphicon-time"
                                                                            aria-hidden="true"></span></span>
                </div>
            </div>
            <div class="left col-xs-2 text-right">
                <label>结束时间:</label>
            </div>
            <div class="right col-xs-2 text-left" id="endQuarterInputId">
                <div class="input-group">
                    <input type="text" class="form-control form_Day" id="endQuarterInput" name="addtime"
                           placeholder="请选择结束时间">
                    <span class="input-group-addon" id="endQuarter"><span class="glyphicon glyphicon-time"
                                                                          aria-hidden="true"></span></span>
                </div>
            </div>

            <button id="quarterBtnId" type="button" class="btn btn-default"  onclick="selectQuarter();">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>查询
            </button>
        </div>
        <div class='tab-pane' id='tab5'>
            <div class="left col-xs-2 text-right">
                <label>开始时间:</label>
            </div>
            <div class="right col-xs-2 text-left" id="startWeekInputId" >
                <div class="input-group">
                    <input type="text" class="form-control form_Day" id="startWeekInput" name="addtime"
                           placeholder="请选择开始时间">
                    <span class="input-group-addon" id="startWeek"><span class="glyphicon glyphicon-time"
                                                                         aria-hidden="true"></span></span>
                </div>
            </div>
            <div class="left col-xs-2 text-right">
                <label>结束时间:</label>
            </div>
            <div class="right col-xs-2 text-left" id="endWeekInputId">
                <div class="input-group">
                    <input type="text" class="form-control form_Day" id="endWeekInput" name="addtime"
                           placeholder="请选择结束时间">
                    <span class="input-group-addon" id="endWeek"><span class="glyphicon glyphicon-time"
                                                                       aria-hidden="true"></span></span>
                </div>
            </div>

            <button id="weekBtnId" type="button" class="btn btn-default"  onclick="selectWeek();">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>查询
            </button>
        </div>
    </div>

</div>

<!-- 显示Echarts图表 -->
<div style="height:600px;min-height:100%;margin:0 auto;" id="main"></div>


<script>



</script>
<!-- 显示Echarts图表 -->
<script src="/static/js/backstage/statistics/myEcharts.js"></script>
<script type="text/javascript" src="/static/js/backstage/statistics/pay.js"></script>

<script src="/static/js/contextmenu.js"></script>

</div>

</body>
</html>