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
    <script src="/static/js/statistics_Private/moment.js"></script>
    <script src="/static/js/statistics_Private/daterangepicker.js"></script>
    <script src="/static/js/echarts/echarts.js"></script>
    <script src="/static/js/statistics_Private/cyItem.js"></script>
    <script src="/static/js/statistics_Private/piecemeal.js"></script>

    <title>库存统计</title>

</head>
<body>
<%@include file="../backstage/contextmenu.jsp"%>
<div class="head">
    <div class="title" style="height:55px">
        <h2 class="pull-left" style="bottom: 20px;">库存统计</h2>
        <div id="reportrange" class="pull-right" style="background: #fff; left:100px;margin-right: 138px;position: relative;top:33px;cursor: pointer; padding: 5px 10px; border: 1px solid #ccc;">
            <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>&nbsp;
            <span></span> <b class="caret"></b>
        </div>
    </div>
</div>

<div class="container "  style="margin-top:10px">
    <div class="panel" style="height:60%">
        <div class="subtitle"><h3 > 库存统计</h3></div>
        <div style="height:85%">
            <div  class="col-md-8"  >
                <div id="echart" style="height:100%"></div>
            </div>
            <div class="col-md-4">
                <div id="top1"></div>
                <div id="top2"></div>
                <div id="top3"></div>
            </div>
        </div>
    </div>
    <div class="panel"  style="height:70%">
        <div class="subtitle"><h3 > 库存数据源</h3></div>
        <div class="col-md-12">
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
                    <th  data-field="name" >库存类型</th>
                    <th data-field="price" >库存数量</th>
                    <th data-field="todoCell" data-formatter=todoCell >操作</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>

<div class="footer">
</div>

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
                <div id="detailEchart" style="height:100%;width:100%"></div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    var detailEchart = echarts.init(document.getElementById("detailEchart"));
    $(function(){
        var echart = echarts.init(document.getElementById("echart"));
        var table = $("#table").bootstrapTable();

        var top1 = $("#top1").cyItem({
            title: { text: '库存排行' },
            data: ['库存1','库存2','库存3']
        });
        var top2 = $("#top2").cyItem({
            title: { text: '异常库存排行' },
            data: ['异常1','异常2','异常3']
        });
        var top3 = $("#top3").cyItem({
            title: { text: '库存销量比例排行' },
            data: ['销量1','销量2','销量3']
        });

        var echartOption = {
            legend:{ data: ['库存','已使用'] },
            tooltip: {},
            xAxis: {
                //type: "time",
                type: 'category',
                name: '日期/时间',

            },
            yAxis: { name: '数量/个',type: 'value'},
            series: [{
                name: '库存',
                type: 'bar',
                stack: "stock",
                label: {
                    normal: {
                        show: true,
                        position: 'inside'
                    }
                }
            }, {
                name: '已使用',
                type: 'bar',
                stack: "stock",
                label: {
                    normal: {
                        show: true,
                        position: 'inside'
                    }
                }
            }],
           /* toolbox: {
                feature : {
                    restore : {show: true},
                    saveAsImage : {show: true}
                }
            },*/
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
        };
        var detailEcharOption = {};

        initData($("#reportrange>span"));
        setDaterangeReturnFun("#reportrange",daterangeReturnFun);

        echart.setOption(echartOption);
        setMainEchartNewData(echart);

        pageChangeEchartsResize(echart, detailEchart);
    });

    function daterangeReturnFun(start, end, label){
        // 更新主图表        setMainEchartNewData
        // 更新右侧两个排行  setTopData
        //更新表格           setTableData
    }

    function setMainEchartNewData(echart){
        $.get("/table/queryType",function(data){
            var newData = arrayObjs2arrayAttr(data,"price");
            console.log(newData);
            console.log(getleftNums(newData));
            var newOption = {
                xAxis: {
                 data: ['2017-03','2017-04','2017-05','2017-06','2017-07','2017-08']
                },
                series: [{
                    data:  newData.slice(0,7)
                },{
                  data: getleftNums(newData).slice(0,7)
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


    // 测试数据用 setMainEchartNewData 方法中出现
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
