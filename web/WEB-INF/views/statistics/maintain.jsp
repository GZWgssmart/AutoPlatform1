<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017-04-11
  Time: 15:43
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

    <title>维修保养统计</title>
</head>
<body>
<%@include file="../backstage/contextmenu.jsp"%>
    <div class="head">
        <div class="title" style="height:55px">
            <h2 class="pull-left" style="bottom: 20px;">维修保养统计</h2>
            <div id="reportrange" class="pull-right" style="background: #fff; left:100px;margin-right: 138px;position: relative;top:33px;cursor: pointer; padding: 5px 10px; border: 1px solid #ccc;">
                <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp;
                <span></span> <b class="caret"></b>
            </div>
        </div>
    </div>

    <div class="container"  style="margin-top:10px">
        <div class="panel">
            <div class="subtitle"><h3 > 维修保养统计</h3></div>
            <div class="col-md-8">
                <div id="echart" style="height:60%;width:100%"></div>
            </div>
            <div class="col-md-4">
                <div id="top1"></div>
                <div id="top2"></div>
            </div>
        </div>
    </div>

    <div class="footer">
    </div>
</body>
<script>
    $(function(){
        var echart = echarts.init(document.getElementById("echart"));
        var echartOption = {
            legend: {data:['维修','保养','金额总计']},
            tooltip : { },
            xAxis: {
                type: 'category',
                boundaryGap: true,
                axisTick:{
                        alignWithLabel:true
                },
                splitLine: {show:true},

            },
            yAxis: [{
                name: '数量/个',
                type: 'value'
            },
            {
                name: '金额/元',
                type: 'value',
                splitLine: {
                    show: false
                }
            }],
            series: [{
                name: '维修',
                stack: '总量',
                type: "bar",
                label: {
                    normal: {
                        show: true,
                        position: 'inside'
                    }
                }
            },
            {
                name: '保养',
                stack: '总量',
                type: "bar",
                label: {
                    normal: {
                        show: true,
                        position: 'inside'
                    }
                }
            },{
                    name: '金额总计',
                    yAxisIndex: 1,
                    type: "line",
                    tooltip: {
                        formatter: "{a}<br />{b}: {c} 元"
                    }
             }],
            toolbox: {
                show: true,
                feature: {
                    dataZoom: {
                        yAxisIndex: 'none'
                    },
                    dataView: {readOnly: false},
                    restore: {},
                    saveAsImage: {}
                }
            },

        }
        var top1 = $("#top1").cyItem({
            title: {
                style: 'font-size:20px;',
                text: '排行最高维修/保养'
            },
            data: ['维修1','维修2','维修3']
        })
        var top2 = $("#top2").cyItem({
            title: { text: '排行最低维修/保养',
                style: "font-size:20px;"},
            data: ['维修5','维修6','维修7']
        })

        initData($("#reportrange>span"));
        setDaterangeReturnFun("#reportrange",daterangeReturnFun);

        echart.setOption(echartOption);
        setNewEchartData(echart);

        pageChangeEchartsResize(echart);
    })


    function daterangeReturnFun(){
        // 主图表更新 setNewEchartData
        // 右侧两个排行更新 setTopData
    }

    function setNewEchartData(echart){
        $.get("/table/queryType",function(data){
            var objs = arrayObjs2Objs(data,"name","price");
            var datas = arrayObjs2arrayAttr(data,"price");
            var newEchartData= {
                xAxis: {
                    data: (function(){
                        var dates = [];
                        var date = new Date();
                        for(var i =0;i<6;i++) {
                            var datestr = [date.getFullYear(), date.getMonth(), date.getDate()].join("-");
                            dates.push(datestr);
                            date = addOneDay(date);
                        }
                        return dates;
                    })()
                },
                series: [{
                    data:[1,2,3,4,4,5]
                },{
                    data:[1,1,2,3,4,5]
                },{
                    data: [1000,1200,500,600,900,700]
                }
                ]
            }
            echart.setOption(newEchartData);
        })
    }

    function setTopData(top, data){
        top.reLoadData(data); // data is array
    }

    function addOneDay(date){
        return new Date(+date+oneDay());
    }
    function oneDay(){
        return 24*3600*1000;
    }


</script>
</html>
