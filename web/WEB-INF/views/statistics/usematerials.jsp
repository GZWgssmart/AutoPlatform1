<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017-04-11
  Time: 15:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html style="height:100%">
<head>
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

    <title>物料使用统计</title>
</head>
<body style="height:100%">
<%@include file="../backstage/contextmenu.jsp"%>
    <div class="head">
        <div class="title" style="height:55px">
            <h2 class="pull-left" style="bottom: 20px;">物料使用统计</h2>
            <div id="reportrange" class="pull-right" style="background: #fff; left:100px;margin-right: 138px;position: relative;top:33px;cursor: pointer; padding: 5px 10px; border: 1px solid #ccc;">
                <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp;
                <span></span> <b class="caret"></b>
            </div>
        </div>
    </div>

    <div class="container"  style="margin-top:10px">
        <div class="panel">
            <div>
                <div class="subtitle"><h3 >物料使用统计</h3></div>
                <div class="col-md-8">
                    <div>
                        <div id="echart" style="height:60%;width:100%"></div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div id="top1"></div>
                    <div id="top2"></div>
                </div>
            </div>
            <div>
                <div class="col-md-12">
                    <div class="subtitle"><h3 > 物料使用统计源</h3></div>
                    <table id="table"
                           data-toggle="table"
                           data-toolbar="#sourceTitle"
                           data-url="/table/queryType"
                           data-method="get"
                           data-pagination="true"
                           data-page-size="10"
                           data-id-field="id"
                           data-page-list="[5, 10, 20]"
                           data-cach="false">
                        <thead>
                            <tr>
                                <th data-field="name"  data-align="center">
                                    物料名称
                                </th>
                                <th data-field="price" data-align="center">
                                    价格
                                </th>
                                <th data-field="todo" data-align="center" data-formatter=todoCell>
                                    操作
                                </th>

                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="footer"></div>

    <div id="sourceTitle">
        <h3 >数据源</h3>
    </div>

    <div class="modal fade" id="modal" tabindex="2" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="width:100%;">
                <div class="modal-header">
                    <h4 style="float:left" onclick="resTest()"> 物料使用统计 </h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                </div>
                <div class="modal-title" style="width:100%;background-color: #1eacae">

                </div>
                <div class="modal-body" style="width:100%;height:80%">
                    <div id="detailsEchart" style="height:100%;width:100%"></div>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    var detailEchart  = echarts.init(document.getElementById("detailsEchart"));
    $(function(){
        var echart = echarts.init(document.getElementById("echart"));
        var table = $("#table").bootstrapTable();
        var top1 = $("#top1").cyItem({
            title: {
                style: 'font-size:20px',
                text: '物料使用排行'
            },
            data: ["物料1","物料2","物料3"]
        })
        var top2 = $("#top2").cyItem({
            title: {
                style: 'font-size:20px',
                text: '物料使用率排行'
            },
            data: ["物料4","物料3","物料5"]
        })

        var option = {
            xAxis: {
                type: "category",
                name: '日期',
                axisLabel: {
                    showMaxLabel: true,
                    showMinLabel: true,
                    formatter: function (value, idx) {
                        var date = new Date(value);
                        return [date.getMonth() + 1, date.getDate()].join('-');
                    },
                },
                boundaryGap: true,
                axisTick: {
                    alignWithLabel: true
                }
            },
            yAxis: {
                name: '数量/个',
                type: 'value',
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
            series: {
                name: "数量",
                type: 'bar',
                xAxisIndex: 0,
                yAxisIndex: 0,
            },
            legend: {
                data: ['数量']
            },
            tooltip: {
                trigger: 'axis'
            },
            toolbox: {
                feature : {
                    magicType : {show: true, type: ['line', 'bar']},
                    restore : {show: true},
                    saveAsImage : {show: true}
                }
            },
            dataZoom: [
                {
                    type: 'slider',
                    show: true,
                    xAxisIndex: [0]
                },
                {
                    type: 'inside',
                    xAxisIndex: [0]
                }
            ]
        };
        var detailOption ={
            xAxis: {
                type: "time",
                name: '日期',
                data: (function(){
                    var dates = [];
                    var date = new Date();
                    for(var i =0;i<7;i++) {
                        //var datestr = [date.getFullYear(), date.getMonth(), date.getDate()].join("-");
                        dates.push(date.toString());
                        date = addOneDay(date);
                    }

                    return dates;
                })()
            },
            yAxis: { name: '数量/个', type: 'value'},
            series: {  name: '数量', type: 'line'},
            legend:{ data: ['数量'] },
            tooltip: {},
            dataZoom: [
                {
                    type: 'slider',
                    show: true,
                    xAxisIndex: [0]
                },
                {
                    type: 'inside',
                    xAxisIndex: [0]
                }
            ]
        };

        initData($("#reportrange>span"));
        setDaterangeReturnFun("#reportrange",daterangeReturnFun);

        echart.setOption(option);
        detailEchart.setOption(detailOption);
        setMainEchartNewData(echart);

        pageChangeEchartsResize(echart,detailEchart);

    });

    function daterangeReturnFun(start, end, label){
        // 更新主图表        setNewEchartData
        // 更新右侧两个排行  setTopData
        //更新表格           setTableData
    }

    function todoCell(index, row, element){
        var viewbtn = '<div style="color:lightseagreen" onclick="openModel()">查看使用情况</div> ';
        return viewbtn;
    }

    function openModel(echar){
        $("#modal").modal("show");
        updateDetailEchart();
        detailEchartResize(detailEchart);
    }

    function setMainEchartNewData(echart){
        $.get("/table/queryType",function(data){
            var arr = arrayObjs2arrayAttr(data,"price");

            var dataOption = {
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
                    })(),
                },
                series: {
                    data: arr.slice(0,7)
                }
            };
            echart.setOption(dataOption);
        })
    }


    function updateDetailEchart(){
        $.get("/table/queryType",setDetaNewData);
    }

    function setDetaNewData(data){
        var detailOptionData = getDetailNewData(data);
        detailEchart.setOption(detailOptionData);
    }
    function getDetailNewData(data){
        var arr = arrayObjs2array(data, "name", "price");
        var date = new Date();
        var addoneday = addOneDay(date);
        var addtwoday = addOneDay(addoneday);
        var detailOptionData = {
            series: {
                xAxisIndex: 0,
                yAxisIndex: 0,
                data: [[date,10],[addoneday,15],[addtwoday,18]]
            }
        }
        return detailOptionData;
    }

    function addOneDay(date){
        return new Date(+date+oneDay());
    }
    function oneDay(){
        return 24*3600*1000;
    }




</script>
</html>
