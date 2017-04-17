<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017-04-11
  Time: 15:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/statistics_Private/daterangepicker.css">
    <link rel="stylesheet" href="/static/css/statistics_Private/piecemeal.css">

    <script src="/static/js/jquery.min.js"></script>
    <script src="/static/js/bootstrap.min.js"></script>
    <script src="/static/js/bootstrap-table/bootstrap-table.js"></script>
    <script src="/static/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
    <script src="/static/js/echarts/echarts.js"></script>
    <script src="/static/js/statistics_Private/moment.js"></script>
    <script src="/static/js/statistics_Private/daterangepicker.js"></script>
    <script src="/static/js/statistics_Private/piecemeal.js"></script>

    <title>客户消费统计</title>
</head>
<body>
<%@include file="../backstage/contextmenu.jsp"%>

<div class="head">
    <div class="title" style="height:55px">
        <h2 class="pull-left" style="bottom: 20px">客户消费统计</h2>
        <div id="reportrange" class="pull-right" style="background: #fff; left:100px;margin-right: 138px;position: relative;top:33px;cursor: pointer; padding: 5px 10px; border: 1px solid #ccc;">
            <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp;
            <span></span> <b class="caret"></b>
        </div>
    </div>
</div>

<div class="container" style="height:100%">
    <div class="panel" style="height:55%;margin-top:10px">
        <div class="subtitle"><h3> 消费总览</h3></div>
        <div id="echart" style="height:100%"> </div>
    </div>

    <div class="panel" style="height:80%">
        <div class="subtitle" ><h3>客户消费数据</h3></div>
        <div style="height:85%">
            <table id="souTable" data-height="100%"
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
                <th  data-field="name" data-sortable="true">姓名</th>
                <th  data-field="name" data-sortable="true">性别</th>
                <th data-field="price" data-sortable="true">下单时间</th>
            </tr>
            </thead>
        </table>
        </div>
    </div>

    <div class="panel" style="height:60%;margin-top:40px;"   >
        <div class="subtitle"><h3 > 客户特征总览 </h3></div>
        <div style="height:80%">
            <div class="col-md-6" style="height:100%">
                <div id="splicTimerEchart" style="height:100%"> </div>
            </div>
            <div class="col-md-6" style="height:100%">
                <div style="height:50%">
                    <div id="clientEchart" style="height:100%" ></div>
                </div>
                <div style="height:40%">
                    <h4 style="font-weight:bold">性别<button id="testBtn">点击更换数据</button></h4>
                    <div>
                        <table id = "genderTable" data-height="auto">
                            <thead>
                            <tr>
                                <th data-field="gender">性别</th>
                                <th data-field="count">人数</th>
                                <th data-field="abc">Test</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="footer"></div>

</body>
<script>

    $(function(){

        var echart = echarts.init(document.getElementById("echart"));
        var splicTimerEchart = echarts.init(document.getElementById("splicTimerEchart"));
        var clientEchart = echarts.init(document.getElementById("clientEchart"));


        var genderTable = $("#genderTable").bootstrapTable({
            data: [{gender:'男',count:20},{gender:'女',count:15}]
        });
        var souTable = $("#souTable").bootstrapTable();

        $("#testBtn").click(function () {
            genderTable.bootstrapTable('load', [{gender:'男',count:88},{gender:'女',count:99}]);
        });

        var option = {
            legend: {data: ['客户量']},
            xAxis: {
                name: '日期',
                type: 'category'
            },
            yAxis: {
                name: '人',
                type: 'value'
            },
            series: {
                name: '客户量',
                type: 'bar'
            },
            tooltip: {},
            toolbox: {
                feature: {
                    dataZoom: {
                        yAxisIndex: 'none'
                    },
                    dataView: {readOnly: false},
                    magicType: {type: ['line', 'bar']},
                    restore: {},
                    saveAsImage: {}
                }
            }
        }
        var splicTimerOption = {
            title: {
                text: "时段分析"
            },
            xAxis: {
                name: '时段',
                type: 'category',
                boundaryGap: false,
            },
            yAxis: {
                name: '人',
                type: 'value'
            },
            series: {
                name: '客户量',
                type: 'line',
                tooltip: {
                    formatter: function (data){
                        var name = data.name,
                                seriesName = data.seriesName,
                                value = data.value,
                                til = "",
                                be = name+ ":00",
                                en = name+ ":59";
                        til +=be + " - " + en;
                        var con =  seriesName + ": " +  value
                        return til+"<br/><br/>" + con;
                    }
                }
            },
            tooltip: {
                trigger: 'axis',
                formatter: function (datas){
                    var data = datas[0];
                    var seriesName = data.seriesName,
                            value = data.value,
                            name = data.name,
                            til = "",
                            be = name+ ":00",
                            en = name+ ":59";
                    til +=be + " - " + en;
                    var con =  seriesName + ": " +  value + " 人"
                    return til+"<br/>" + con;
                }
            },
            toolbox: {
                feature: {
                    dataZoom: {
                        yAxisIndex: 'none'
                    },
                    dataView: {readOnly: false},
                    magicType: {type: ['line', 'bar']},
                    restore: {},
                    saveAsImage: {}
                }
            }
        }
        var clientOption = {
            title: {
                text: "新老客户"
            },
            legend: {
                data:['新客户','老客户'],
                orient: 'vertical',
                left: 'right',
                top: 'center',
            },
            tooltip : {
            },
            toolbox: {
                feature: {
                    dataZoom: {
                        yAxisIndex: 'none'
                    },
                    dataView: {readOnly: false},
                    magicType: {type: ['line', 'bar']},
                    restore: {},
                    saveAsImage: {}
                }
            },
            series :{
                    name:'客户类型',
                    type:'pie',
                    radius : '55%',
                    center: ['50%', '50%'],
                    label: {
                        normal: {
                            textStyle: {
                                color: 'rgba(0, 0, 0, 0.6)'
                            }
                        }
                    }
            }
        }

        initData($("#reportrange>span"));
        setDaterangeReturnFun("#reportrange",daterangeReturnFun);

        echart.setOption(option);
        splicTimerEchart.setOption(splicTimerOption);
        clientEchart.setOption(clientOption);

        setMainEchartsData(echart);
        setSplicTimerEchartData(splicTimerEchart);
        setClientEchartData(clientEchart);

        pageChangeEchartsResize(echart, splicTimerEchart);
    })


    function setMainEchartsData (echart) {
        //$.get("json.json",function (data) {
        //});
        var dataOption = {
            xAxis: {
                data: ['星期一','星期二','星期三','星期四','星期五','星期六','星期天']
            },
            series: {
                data: [15,30,24,17,14,36,28]
            }
        }
        echart.setOption(dataOption);
    }

    function setSplicTimerEchartData(echart) {
        var dataOption = {
            xAxis: {
                data: (function (){
                    var data= [];
                    for(var i = 0; i<24; i++){
                        data.push(i);
                    }
                    return data;
                })()
            },
            series: {
                data: (function (){
                    var data = [];
                    for(var i =0; i<24; i++){
                        var num = Math.floor(Math.random()*100);
                        data.push(num);
                    }
                    return data;
                })()
            }
        }
        echart.setOption(dataOption);
    }

    function setClientEchartData (echart) {
        var clientOptionData = {
            series : {
                data:[{value:335, name:'新客户'},
                    {value:310, name:'老客户'}]
            }
        };
        echart.setOption(clientOptionData);
    }

    function setTableData(table, data){
        table.bootstrapTable("load",data);
    }


    function daterangeReturnFun(start, end, label) {
        // 设置主要图表的方法 ,在这里为 setMainEchartsData(echart);
        // 设置时段图表的方法 ,在这里为 setSplicTimerEchartData(echart);
        // 设置客户为新老用户的方法 ,在这里为 setClientEchartData(echart);
        // 设置table数据的方法. // 这里为 setTableData;
    }

</script>
</html>
