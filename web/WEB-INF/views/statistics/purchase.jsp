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
    <script src="/static/js/sweetalert/sweetalert.min.js"></script>
    <script src="/static/js/echarts/echarts.js"></script>
    <script src="/static/js/statistics_Private/moment.js"></script>
    <script src="/static/js/statistics_Private/daterangepicker.js"></script>
    <script src="/static/js/statistics_Private/cyItem.js"></script>
    <script src="/static/js/statistics_Private/piecemeal.js"></script>
    <title>采购统计</title>

</head>
<body>
<%@include file="../backstage/contextmenu.jsp"%>
<div class="head">
    <div class="title" style="height:55px">
        <h2 class="pull-left" style="bottom: 20px;">支付厂商统计</h2>
        <div id="reportrange" class="pull-right" style="background: #fff; left:100px;margin-right: 138px;position: relative;top:33px;cursor: pointer; padding: 5px 10px; border: 1px solid #ccc;">
            <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp;
            <span></span> <b class="caret"></b>
        </div>
    </div>
</div>
<div class="container " style="height:100%;margin-top: 10px" >
    <div class="panel" style="height: 70%">
        <div class="subtitle"><h3 > 进货支付金额</h3></div>
        <div  class="col-md-8"  style="height: 100%" >
            <div id="echart"  style="height: 80%"></div>
        </div>
        <div class="col-md-4" style="height: 100%">
            <div id="top1"></div>
            <div id="top2"></div>
        </div>
    </div>
    <div class="panel">
        <div class="col-md-12">
            <div class="subtitle"><h3 > 进货数据源</h3></div>
            <table id="table"
                   data-toggle="table"
                   data-toolbar="#toolbar"
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
                    <th  data-field="name" >进货名称</th>
                    <th data-field="price" >进货厂商</th>
                    <th data-field="price" >进货数量</th>
                    <th data-field="price" >进货单价</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
<div class="footer">
</div>

</body>
<script>

    $(function(){
        var echart = echarts.init(document.getElementById("echart"));
        var table = $("#table").bootstrapTable();
        var top1 = $("#top1").cyItem({
            title: { text: '支付最多厂商排行',
                style: "font-size:20px;"},
            data: ['厂商1','厂商2','厂商3']
        });
        var top2 = $("#top2").cyItem({
            title: { text: '支付最少厂商排行',style: "font-size:20px;" },
            data: ['厂商1','厂商2','厂商3']
        });

        var echartOption = {
            legend:{ data: ['采购数量,采购金额'] },
            tooltip: {},
            xAxis: {
                //type: "time",
                type: 'category',
                name: '日期/时间',
            },
            yAxis: [{
                name: '数量/个',
                type: 'value'
            },{
                name: '金额/元',
                type: 'value'
            }],
            series: [{
                name: '采购数量',
                type: 'bar',
                label: {
                    normal: {
                        show: true,
                        position: 'inside'
                    }
                }
            },{
                name: '采购金额',
                type: 'line',
                yAxisIndex: 1
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
            dataZoom: [
                {
                    type: 'slider',
                    xAxisIndex: [0]
                },
                {
                    type: 'inside',
                    xAxisIndex: [0]
                }
            ]
        }
        var detailEcharOption = {
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
            yAxis: { name: '数量/个'},
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
            ]};

        initData($("#reportrange>span"));
        setDaterangeReturnFun("#reportrange",daterangeReturnFun);

        echart.setOption(echartOption);
        setMainEchartNewData(echart);


        pageChangeEchartsResize(echart);
    })



    function daterangeReturnFun(start, end, label) {
        // 更新主要图表的方法 ,在这里为 setMainEchartsData(echart);
        // 更新右侧两个排行 ,在这里为 setTopData(echart);
        // 设置table数据的方法. // 这里为 setTableData;
    }

    function setMainEchartNewData(echart){
        $.get("/table/queryType",function(data){
            var newData = arrayObjs2arrayAttr(data,"price");
            var newOption = {
                xAxis: {
                    data: ['2017-03','2017-04','2017-05','2017-06','2017-07','2017-08']
                },
                series: [{
                    data:  newData.slice(0,7)
                },{
                    data: [2000,3000,1500,2100,1300,4300]
                }]
            };
            echart.setOption(newOption);
        })
    }



    function todoCell(){
        var viewbtn = '<div style="color:lightseagreen" onclick="openModal()">查看库存情况</div> ';
        return viewbtn;
    }

    function openModal(){
        console.log("openModal");
    }


    function getleftNums(arr){
        var len = arr.length;
        var newArr = [];
        for(var i=0; i<len; i++) {
            var newNum = -arr[i];
            newArr.push(newNum);
        }
        return newArr;
    }


    function addOneDay(date){
        return new Date(+date+oneDay());
    }
    function oneDay(){
        return 24*3600*1000;
    }
</script>
</html>
