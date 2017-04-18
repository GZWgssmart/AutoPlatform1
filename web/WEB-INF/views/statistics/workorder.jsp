<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017-04-11
  Time: 15:49
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

    <title>工单统计</title>
</head>
<body>
<%@include file="../backstage/contextmenu.jsp"%>
    <div class="head">
        <div class="title" style="height:55px">
            <h2 class="pull-left" style="bottom: 20px;">工单统计</h2>
            <div id="reportrange" class="pull-right" style="background: #fff; left:100px;margin-right: 138px;position: relative;top:33px;cursor: pointer; padding: 5px 10px; border: 1px solid #ccc;">
                <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp;
                <span></span> <b class="caret"></b>
            </div>
        </div>
    </div>

    <div class="container"  style="margin-top:10px">
        <div class="panel" style="height:55%">
            <div class="subtitle"><h3 > 工单统计</h3></div>
            <div class="col-md-8">
                <div id="mainEchart" style="width:100%;height:90%"></div>
            </div>
            <div class="col-md-4">
                <div id="top1"></div>
                <div id="top2"></div>
            </div>
        </div>
        <div class="panel" style="height:60%">
            <div class="subtitle"><h3 > 工单统计源</h3></div>
            <div >
                <table id="table"
                       data-toggle="table"
                       data-url="/table/queryType"
                       data-method="get"
                       data-pagination="true"
                       data-page-size="10"
                       data-id-field="id"
                       data-page-list="[5, 10, 20]"
                       data-cach="false">
                    <thead>
                    <tr>
                        <th data-field="name">工单名称</th>
                        <th data-field="price">数量</th>
                        <th data-field="todoCell" data-align ="center" data-formatter=todoCell>操作</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>

    <div class="footer"></div>

    <div class="modal fade" id="modal" tabindex="2" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="width:100%;">
                <div class="modal-header">
                    <h4 class="title">员工工单统计</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                </div>
                <div class="modal-title" style="width:100%;height:60%;">
                    <div id="echart" style="width:100%;height:100%"></div>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    var echart =  echarts.init(document.getElementById("echart"));
    $(function(){
        var mainEchart = echarts.init(document.getElementById("mainEchart"));
        var table = $("#table").bootstrapTable();
        var mainEchartOption = {
            tooltip : {
            },
            legend: {
                data: ['数量','提成']
            },
            xAxis: {
                type: 'category',
                boundaryGap: true,
                axisTick:{
                    alignWithLabel:true
                },
                splitLine: {show:true},
            },
            yAxis: [{
                name: '数量/单',
                type: 'value'
            },{
                name: "提成/元",
                type: 'value',
                splitLine: {
                    show: false
                }
            }],
            series: [{
                name: '数量',
                type: "bar",
                tooltip: {
                    formatter: "{a}<br />{b}: {c} 单"
                }
            },{
                name: "提成",
                type: "line",
                yAxisIndex: 1,
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
            }
        };
        var detailEchartOption = {
//            title: {
//                text: '员工工单统计',
//            },
            tooltip : { },
            legend: {
                data: ['数量','提成']
            },
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
            xAxis:{ name: '名称', type: 'category' },
            yAxis:[{
                name: '数量/单',
                type: 'value'
            }, {
                name: '提成/元',
                type: 'value',
                splitLine: {
                    show: false
                }
            }],
            series:[{
                name: "数量",
                type:'bar',
                tooltip: {
                    formatter: "{a}<br />{b}: {c} 单"
                }
            },{
                name: "提成",
                type:'line',
                yAxisIndex: 1,
                tooltip: {
                    formatter: "{a}<br />{b}: {c} 元"
                }
            }],
            dataZoom:  [ {
                id: 'dataZoomSliderX',
                type: 'slider',
                xAxisIndex: [0],
                filterMode: 'filter'
            },
            {
                    id: 'dataZoomInsideX',
                    type: 'inside',
                    yAxisIndex: [0],
                    filterMode: 'empty'
            }
        ]
        };
        var top1 = $("#top1").cyItem({
            title: { text: '效率最高排行',
                style: "font-size:20px;"},
            data: ['员工1','员工2','员工3']
        });
        var top2 = $("#top2").cyItem({
            title: { text: '效率最低排行',
                style: "font-size:20px;"},
            data: ['员工1','员工2','员工3']
        });

        initData($("#reportrange>span"));
        setDaterangeReturnFun("#reportrange",daterangeReturnFun);

        mainEchart.setOption(mainEchartOption);
        echart.setOption(detailEchartOption);

        mainSetNewEchartData(mainEchart);

        pageChangeEchartsResize(echart, mainEchart);

    })

    function daterangeReturnFun(start, end, label){
        // 更新主图表        mainSetNewEchartData
        // 更新右侧两个排行  setTopData
        //更新表格           setTableData
    }

    function mainSetNewEchartData(echart){
        $.get("/table/queryType",function (data) {
            var newData = arrayObjs2arrayAttr(data, "price");
            console.log(newData.slice(0,7))
            var newOption = {
                xAxis: {
                    data:  (function(){
                        var dates = [];
                        var date = new Date();
                        for(var i =0;i<7;i++) {
                            var datestr = [date.getFullYear(), date.getMonth()+i, date.getDate()].join("-");
                            dates.push(datestr);
                            date = addOneDay(date);
                        }
                        return dates;
                    })()
                },
                series: [{
                    data: newData.slice(0,7)
                },{
                    data: newData.slice(0,7)
                }]
            }
            echart.setOption(newOption);
        })
    }

    function todoCell(index, row, element){
        var viewbtn = '<div style="color:lightseagreen" onclick="openModel()">查看趋势</div> ';
        return viewbtn;
    }

    function openModel(){
        var echar = echart;
        $.get("/table/queryType",function(data){
            var workorderfordate = data;
            var xAxdata = arrayObjs2arrayAttr(data,"name");
            var serdata = arrayObjs2array(data,"name","price");
            var detailEchartOption = {
                xAxis:{ data:['a','b','c']},
                series:[{
                    data:   [11,12,13]
                },{
                    data:   [11,12,13]
                }]
            }
            echart.setOption(detailEchartOption);
        })

        $("#modal").modal("show");
        detailEchartResize(echar);
    }


    function addOneDay(date){
        return new Date(+date+oneDay());
    }
    function oneDay(){
        return 24*3600*1000;
    }


</script>
</html>
