<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017-04-11
  Time: 15:52
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

    <title>维修保养类型统计</title>
</head>
<body>
<%@include file="../backstage/contextmenu.jsp"%>
<div class="head">
    <div class="title" style="height:55px">
        <h2 class="pull-left" style="bottom: 20px;">维修保养类型统计</h2>
        <div id="reportrange" class="pull-right" style="background: #fff; left:100px;margin-right: 138px;position: relative;top:33px;cursor: pointer; padding: 5px 10px; border: 1px solid #ccc;">
            <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp;
            <span></span> <b class="caret"></b>
        </div>
    </div>
</div>

<div class="container"  style="margin-top:10px">
    <div  class="panel">
        <div class="subtitle"><h3 > 维修保养类型统计</h3></div>
        <div class="col-md-8">
            <div id="echart" style="height:60%;width:100%"></div>
        </div>
        <div class="col-md-4"></div>
    </div>
    <div class="panel">
        <div class="col-md-12">
            <div class="subtitle"><h3> 维修/保养统计数据源</h3></div>
            <table id="table"
                   data-toggle="table"
                   data-toolbar="#sourceTitle"
                   data-url="/table/queryType"
                   data-method="get"
                   data-pagination="true"
                   data-show-refresh="true"
                   data-show-toggle="true"
                   data-show-columns="true"
                   data-page-size="10"
                   data-id-field="id"
                   data-page-list="[5, 10, 20]"
                   data-cach="false">
                <thead>
                <tr>
                    <th data-field="name"  data-align="center">
                        类型名称
                    </th>
                    <th data-field="price" data-align="center">
                        类型使用数量
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


<div class="footer"></div>

<div class="modal fade" id="modal" tabindex="2" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="width:100%;">
            <div class="modal-header">
                <h4 style="float:left" onclick="resTest()"> 维修/保养趋势 </h4>
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
    var detailsEchart = echarts.init(document.getElementById("detailsEchart"));
    $(function(){

        var echart = echarts.init(document.getElementById("echart"));
        var echartOption = {
            legend: {
                orient: 'vertical',
                left: 'left',
            },
            tooltip : {},
            toolbox: {
                feature : {
                    restore : {show: true},
                    saveAsImage : {show: true}
                }
            },
            series: {
                name: '维修保养类型',
                type: "pie"
            },
            labelLine: {
                normal: {
                    lineStyle: {
                        color: 'rgba(0, 0, 0, 0.5)'
                    },
                    smooth: 0.2,
                    length: 10,
                    length2: 20
                }
            }
        }
        var detailEchartOption ={
            legend: { data: ["维修/保养"], show: true},
            xAxis: {
                type: "time",
                name: '日期',
            },
            yAxis: { name: '数量/个', type: 'value'},
            series: {  name: '维修/保养数量', type: 'line'  },
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
        echart.setOption(echartOption);
        detailsEchart.setOption(detailEchartOption);

        initData($("#reportrange>span"));
        setDaterangeReturnFun("#reportrange",daterangeReturnFun);
        setMainEchartData(echart);

        pageChangeEchartsResize(echart,detailsEchart);
    });

    function daterangeReturnFun(){
        // 主图表更新 setNewEchartData
        // table更新, setTableData
    }

    function setMainEchartData(echart){
        $.get("/table/queryType",function(data){
            var itemDatas= arrayObjs2Objs(data,"name","price");
            var  titleDatas= arrayObjs2arrayAttr(data,"name");
            var eachartOptionData ={
                legend: {data: titleDatas},
                series:{data:itemDatas}
            };
            echart.setOption(eachartOptionData);
        })
    }

    function setTableData(table, data){
        table.bootstrapTable("load",data);
    }

    function todoCell(index, row, element){
        var viewbtn = '<div style="color:lightseagreen" onclick="openModal()">查看使用情况</div> ';
        return viewbtn;
    }

    function openModal(){
        $("#modal").modal("show");
        var detailEchart =detailsEchart;
        setDetailEchartNewData(detailEchart);
        detailEchartResize(detailEchart );
    }

    function setDetailEchartNewData(detailEchart){
        $.get("/table/queryType",function(data){
            var itemDatas= arrayObjs2array(data,"name","price");
            var  titleDatas= arrayObjs2arrayAttr(data,"name");
            var date = new Date();
            var addoneday = addOneDay(date);
            var addtwoday = addOneDay(addoneday);
            var detailEchartNewData = {
                xAxis: {
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
                series: {
                    xAxisIndex: 0,
                    yAxisIndex: 0,
                    data: [[date,10],[addoneday,15],[addtwoday,18]]
                }
            }
            detailEchart.setOption(detailEchartNewData);
        })
    }



    function addOneDay(date){
        return new Date(+date+oneDay());
    }
    function oneDay(){
        return 24*3600*1000;
    }




</script>
</html>
