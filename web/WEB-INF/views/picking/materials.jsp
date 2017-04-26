<%--
  Created by IntelliJ IDEA.
  User: yaoyong
  Date: 2017/4/11
  Time: 15:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>物料领取</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/datetimepicker.less">
    <%--<link rel="stylesheet" href="/static/css/picking/bootstrap-spinner.css">--%>

    <style>
        .materialsSuc{
            background: url("/static/img/materialsFlag1.png") 105% -25px;
            background-size: 22%;
            background-repeat: no-repeat;
        }
    </style>
</head>
<style>
    .sd{
        font-weight: bold;
    }
</style>
<body>
<%@include file="../backstage/contextmenu.jsp"%>
<div class="container">
    <div class="nav">
        <ul id="myTab" class="nav nav-tabs">
            <li class="pull-right" onclick="initHistory()">
                <a href="#historyPanel" data-toggle="tab">
                    <h4>历史记录</h4>
                </a>
            </li>
            <li class="active pull-right">
                <a href="#workInfoPanel" data-toggle="tab">
                    <h4>我的工单</h4>
                </a>
            </li>
        </ul>
    </div>
    <div  class="tab-content">
        <div id="workInfoPanel" class="tab-pane fade in active panel-body " data-toggle="tab" style="padding-bottom:0px;"  >
            <table id="materialsTable" style="table-layout: fixed" data-search=true>
                <thead>
                <tr >
                    <th data-radio="true"></th>
                    <th data-width="110" data-field="carplate">
                        车牌
                    </th>
                    <th data-width="180" data-hide="all" data-field="carbrand">
                        品牌
                    </th>
                    <th data-width="110" data-field="carmodel">
                        车型
                    </th>
                    <th data-width="110" data-field="colorName">
                        颜色
                    </th>
                    <th data-field="workAssignTime" data-formatter=formatterDate>
                        工单指派时间
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </th>
                    <th data-width="180" data-hide="all" data-field="useRequests" >
                        用户留言
                    </th>
                    <th data-width="180" data-hide="all" data-field="todoCell"  data-formatter="todoCell" >
                        操作
                    </th>
                </tr>
                </thead>
            </table>
            <div id="toolbar" class="btn-group">
                <button id="btn_add" type="button" class="btn btn-default" onclick="showAdd();">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
                </button>
                <button id="btn_edit" type="button" class="btn btn-default" onclick="showEdit();">
                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
                </button>
                <button id="btn_delete" type="button" class="btn btn-default" onclick="showDel();">
                    <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
                </button>
                <button id="btn_appoint" type="button" class="btn btn-warning" onclick="showAppoint();">追加物料</button>
                <button id="btn_confirm" type="button" class="btn btn-info" onclick="showConfirm();">领料确认</button>
                <button id="btn_application" type="button" class="btn btn-success" onclick="showApplication();">退料申请</button>
                <button id="btn_regress" type="button" class="btn btn-danger" onclick="showRegress();">确认退料</button>
            </div>
        </div>


        <div id="historyPanel" class="tab-pane fade" data-toggle="tab">
            <table id="historyTable" style="table-layout: fixed" data-search=true>
                <thead>
                <tr >
                    <th data-width="110" data-field="accessories.accName">零件名称</th>
                    <th data-width="110" data-field="record.checkin.carPlate">车牌</th>
                    <th data-width="110" data-field="flag" data-formatter="todoType">操作类型</th>
                    <th data-width="110" data-field="accCount">数量</th>
                    <th data-width="110" data-field="muUseDate" data-formatter=formatterDate>
                        操作时间
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
                </tr>
            </table>
        </div>
    </div>

</div>


<!-- 退料申请添加弹窗 -->
<div class="modal fade" id="application" aria-hidden="true">
    <div class="modal-dialog" style="overflow:hidden;">
        <form action="/table/edit" method="post">
            <div class="modal-content">
                <input type="hidden" id="delNoticeId3"/>
                <div class="modal-footer" style="text-align: center;">
                    <h2>确认退料申请吗?</h2>
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">取消
                    </button>
                    <button type="sumbit" class="btn btn-primary" onclick="">
                        确认
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </form>
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 确认退料弹窗 -->
<div class="modal fade" id="regress" aria-hidden="true">
    <div class="modal-dialog" style="overflow:hidden;">
        <form action="/table/edit" method="post">
            <div class="modal-content">
                <input type="hidden" id="delNoticeId1"/>
                <div class="modal-footer" style="text-align: center;">
                    <h2>确认退料吗?</h2>
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">取消
                    </button>
                    <button type="sumbit" class="btn btn-primary" onclick="">
                        确认
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </form>
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 零件明细弹窗 -->
<div class="modal fade" id="accsInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="margin-right:0;width:95%;">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel" onclick="testHH()">零件明细</h4>
            </div>
            <div class="modal-body">
                <input style="display: none;" id="seachRecordId" />
                <table id="workInfoAccDetailTable" style="table-layout: fixed" data-single-select="true"
                       data-show-header=false>
                    <thead>
                        <tr >
                            <th data-width="50"  data-field="accessories.accName"></th>
                            <th data-width="110"  data-formatter="accInfoFormat"></th>
                        </tr>
                    </thead>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script src="/static/js/jquery.formFill.js"></script>
<script src="/static/js/select2/select2.js"></script>
<script src="/static/js/sweetalert/sweetalert.min.js"></script>
<script src="/static/js/contextmenu.js"></script>
<script src="/static/js/backstage/main.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="/static/js/form/jquery.validate.js"></script>
<%--<script src="/static/js/backstage/picking/jquery.spinner.js"></script>
<script src="/static/js/backstage/picking/assignstaff.js"></script>--%>

</body>
<script>
    $(function(){
       // $("#materialsTable").bootstrapTable();
        initTable('materialsTable', '/dispatching/userWorksByPager'); // 初始化表格
        //initTable('workInfoAccDetailTable',"/materials/queryUserMaterialsByPager?recordId=1"); // 初始化表格
    });
    function testHH(){
        var rows = $("#workInfoAccDetailTable").bootstrapTable('getSelections');
        console.log(rows);
    }
    function todoCell(ele, row, index) {
        return "<span onclick='showWorkInfoDetail(\"" + row.recordId +"\")'>查看清单</span>";
    }

    function showWorkInfoDetail(recordId){
        abcd('workInfoAccDetailTable',"/materials/recordAccsByPager?recordId="+recordId);
        $("#accsInfo").modal("show");
        $("#seachRecordId").val(recordId);

    }


        function queryParams(params) {   //设置查询参数
            var param = {
                pageNumber: params.pageNumber,
                pageSize: params.pageSize,
                orderNum : $("#orderNum").val()
            };
            return param;
        }

    function accInfoFormat(element, row, index){
        console.log(row.materialReturn)
        console.log(row.materialUse)
        console.log(row.accessories)
        var max = row.accessories.accTotal;
        var min ;
        var htmltest = [];
        htmltest.push("<div style='display: inline-block;' class='col-md-7'>");
        htmltest.push("<span>库存: </span>");
        htmltest.push("<span>");
        htmltest.push(max);
        htmltest.push("</span><br />");
        htmltest.push("<span >所需数量: </span>");
        htmltest.push(row.materialCount);
        htmltest.push("</span></br>");
        htmltest.push("<span '>已领取: </span>");
        htmltest.push("<span style='margin-right:10px;'>");
        if(!isnull(row.materialUse)&&!isnull(row.materialReturn)){
            min = row.materialUse.accCount- row.materialReturn.accCount;
        } else if(!isnull(row.materialUse)){
            min = row.materialUse.accCount;
        } else {
            min = 0;
        }
        htmltest.push(min+"个");
        htmltest.push("<input type='number'  max="+ max +" min="+-min+" class='form-control text-center'  value='0'  style='width:100px;margin-left:20px;display: inline-block; width:80px'>");
        htmltest.push("</span>");
        htmltest.push("</div>");
        htmltest.push("<div style='float:right;height:100%;text-align: center;' class='col-md-4'>");
        htmltest.push("<button type='button' class='btn btn-success' onclick='showDel();' style='height:60px;top:10px;position:inherit; width:100%;'>领料</button>");
        htmltest.push("</div>");
        if(min === row.materialCount ){
            htmltest.push("<div style='position: relative;top:-10px;right:-10px;height:60px' class='materialsSuc' ></div>");
        }

        console.log(htmltest);
        return htmltest.join("");
    }
    function isnull(obj){
        if(obj===null) {
            return true;
        }
        return false;
    }
    function abcd(tableId, url) {
        console.log(url);

        //先销毁表格
        $('#' + tableId).bootstrapTable('destroy');
        //初始化表格,动态从服务器加载数据
        $("#" + tableId).bootstrapTable({
            method: "get",  //使用get请求到服务器获取数据
            url: url, //获取数据的Servlet地址
            striped: false,  //表格显示条纹
            pagination: true, //启动分页
            pageSize: 10,  //每页显示的记录数
            pageNumber:1, //当前第几页
            pageList: [10, 15, 20, 25, 30],  //记录数可选列表
            uniqueId: "accessories.accId",                     //每一行的唯一标识，一般为主键列
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            sidePagination: "server", //表示服务端请求
            //设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder
            //设置为limit可以获取limit, offset, search, sort, order
            queryParamsType : "undefined",
            queryParams: function queryParams(params) {   //设置查询参数
                var param = {
                    pageNumber: params.pageNumber,
                    pageSize: params.pageSize
                };
                return param;
            },
        });
    }

    /**
     * 第二个Table
     */
    function todoType(ele, row, index) {
        if(ele === 'U'){
            return '领料';
        }else {
            return '退料';
        }
    }
    function initHistory(){
        abcd('historyTable', '/materials/history'); // 初始化表格
    }

</script>
</html>

