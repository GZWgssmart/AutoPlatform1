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

        <script src="/static/js/jquery.min.js"></script>
        <script src="/static/js/bootstrap.min.js"></script>
        <script src="/static/js/bootstrap-table/bootstrap-table.js"></script>
        <script src="/static/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
        <script src="/static/js/echarts/echarts.js"></script>
        <script src="/static/js/statistics_Private/moment.js"></script>
        <script src="/static/js/statistics_Private/daterangepicker.js"></script>
        <script src="/static/js/statistics_Private/cyItem.js"></script>
        <script src="/static/js/statistics_Private/piecemeal.js"></script>

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
            <div class="subtitle"><h3> 标题2</h3></div>
            <div class="financeTable clearfix" style="margin-top: 10px">
                <div class="panel-body" style="padding-bottom:0px;"  >
                    <!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
                    <!-- table里的所有属性在bootstrap-table.js的240行-->
                    <table id="table"
                           data-toggle="table"
                           data-url="/table/queryType"
                           data-method="get"
                           data-pagination="true"
                           data-page-size="10"
                           data-id-field="id"
                           data-page-list="[5, 10, 20]"
                           data-cach="false"
                           data-click-to-select="true"
                           data-single-select="true"

                    >
                        <thead>
                            <tr>
                                <th data-radio="true" data-field="status"></th>
                                <th  data-field="name" data-sortable="true">用户账号</th>
                                <th data-field="price" data-sortable="true">用户密码</th>
                            </tr>
                        </thead>
                    </table>

                </div>
            </div>
        </div>
    </div>

    </div>
</body>
<script>
    $(function(){

        var echart = echarts.init(document.getElementById("echart"));
        var echartOption = {
            legend: {
                data:['收入','支出','盈利']
            },
            xAxis: {
                name: '日期',
                type: 'category',
            },
            yAxis: {
                name: '金额',
                axisLine: {
                    show: false
                },
                axisTick: {
                    show: false
                },
                axisLabel: {
                    textStyle: {
                        color: '#999'
                    }
                }
            },
            series: [{
                name: "收入",
                type: 'bar',
                itemStyle: {
                    normal: {
                        color: "#33aaaa"
                    }
                }
            },{
                name: "支出",
                type: 'bar',
                itemStyle: {
                    normal: {
                        color: "#dd3333",
                    }
                }
            },{
                name: "盈利",
                type: 'line'
            }],
            tooltip: {
                trigger: 'axis',
                formatter: "{a}<br />{b}: {c}<br />{b1}:{c1} 单"
            },

            toolbox: {
                feature : {
                    restore : {show: true},
                    saveAsImage : {show: true}
                }
            }
        }
        var tab =  $('#table').bootstrapTable();

        var top1 = $("#top1").cyItem({
            title: { text: '支出类型排行' },
            data: ['支出1','支出2','支出3']
        });
        var top2 = $("#top2").cyItem({
            title: { text: '收入类型排行' },
            data: ['收入1','收入2','收入3']
        });

        echart.setOption(echartOption);

        initData($("#reportrange>span"));
        setDaterangeReturnFun("#reportrange",daterangeReturnFun);

        setNewEchartData(echart);
        pageChangeEchartsResize(echart);
    })


    <!-- table begin -->
    function queryParam(dat){
        $.extend(dat, {name:"Rin",age:14})
    }
    <!-- table end -->

    function daterangeReturnFun(start, end, label){
        // 更新主图表        setNewEchartData
        // 更新右侧两个排行  setTopData
        //更新表格           setTableData
    }

    function setNewEchartData(echart){
        $.get("/table/queryType",function(data){
            var data= arrayObjs2arrayAttr(data,"price");
            var newEchartOption = {
                xAxis: {
                    data: (function(){
                        var dates = [];
                        var date = new Date();
                        for(var i =0;i<7;i++) {
                            var datestr = [date.getFullYear(), date.getMonth(), date.getDate()].join("-");
                            dates.push(datestr);
                            date = addOneDay(date);
                        }
                        return dates;
                    })()
                },
                series: [{
                    data: data.slice(0,7),
                },{
                    data: data.slice(0,7),
                },{
                    data: data.slice(0,7),
                }]
            }
            echart.setOption(newEchartOption);
        })
    }

    function setTopData(top, data){
        top.reLoadData(data); // data is array
    }

    function setTableData(table, data){
        table.bootstrapTable("load",data);
    }

    function addOneDay(date){
        return new Date(+date+oneDay());
    }
    function oneDay(){
        return 24*3600*1000;
    }





</script>
</html>
