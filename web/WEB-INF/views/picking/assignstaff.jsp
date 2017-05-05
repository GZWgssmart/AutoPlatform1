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
    <title>指派员工</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/datetimepicker.less">
</head>
<style>
    .sd{
        font-weight: bold;
    }
    a {
        color: #337ab7;
    }
    #accInfoTable tr {
        font-family:"微软雅黑";
        line-height:30px;
    }

</style>
<body>
<%@include file="../backstage/contextmenu.jsp"%>
<div class="container">
    <div class="nav">
        <ul id="myTab" class="nav nav-tabs">
            <li class="pull-right" onclick = "hasDispatcher()">
                <a  data-toggle="tab" >
                    <h4>进行中</h4>
                </a>
            </li>
            <li class="active pull-right" onclick = "noDispatcher()">
                <a  data-toggle="tab" >
                    <h4>未指定</h4>
                </a>
            </li>
        </ul>
    </div>

    <div class="panel-body" style="padding-bottom:0px;"  >
        <table id="recordTable" style="table-layout: fixed" data-search=true>
            <thead>
            <tr >
                <th data-radio="true"></th>
                <th data-width="110" data-field="workInfo" data-formatter = "formatterUser">
                    员工
                </th>
                <th data-width="110" data-field="carplate">
                    车牌
                </th>
                <th data-width="110" data-field="carmodel">
                    车型
                </th>
                <th data-width="100" data-hide="all" data-field="hours">
                    所需工时
                </th>
                <th data-width="180" data-hide="all" data-field="record.recordCreatedTime" data-formatter="formatterDate">
                    创建时间
                </th>
                <th data-width="180" data-hide="all" data-field="todoCell" data-formatter="todoCell">
                    操作
                </th>
            </tr>
            </thead>
        </table>
    </div>
</div>

<!-- 指派员工弹窗 -->
<div class="modal fade" id="appointModal" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog">
        <div class="modal-content">
            <form class="form-horizontal" id="appointForm" method="post">
                <input type="text" name="recordId" define="record.recordId" style="display:none"/>
                <div class="modal-header" style="overflow:auto;">
                    <h4 class="sd">请选择指定的员工</h4>
                </div>
                <hr>
                <div class="form-group">
                    <label class="col-sm-3 control-label">请选择员工：</label>
                    <select   class="js-example-basic-multiple addemp" name="userId"  style="width:300px;">
                    </select>
                </div>
                <div class="modal-footer" style="border: none;">
                    <span id="editError" style="color: red;"></span>
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button type="button" onclick="submitDispatcher()" class="btn btn-primary">
                        确认
                    </button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 维修保养明细弹窗 -->
<div class="modal fade" id="accsInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="margin-right:0;width:95%;">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3 class="modal-title" id="myModalLabel">维修保养明细</h3>
            </div>
            <div class="modal-body">
                <table id="accInfoTable" style="table-layout: fixed">
                    <thead>
                    <tr >
                        <th data-width="110" data-field="carmodel" data-formatter="infoFormatter"></th>
                    </tr>
                    </thead>

                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary">提交更改</button>
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
<script src="/static/js/backstage/picking/materials.js"></script>

</body>
<script>
    $(function() {
        initTable('recordTable', '/dispatching/noDispRecordByPager'); // 初始化表格
        $("#recordTable").bootstrapTable("hideColumn","workInfo")
        initSelect2("addemp", "请选择员工", "/dispatching/emps"); // 初始化select2, 第一个参数是class的名字, 第二个参数是select2的提示语, 第三个参数是select2的查询url
    });

    function todoCell(element, row, index){
        var accInfo = '<a style="margin-right:30px;float:left;margin-bottom: 8px;"><span onclick = "showInfo(\''+ row.record.recordId +'\')" class="glyphicon glyphicon-list-alt"><span style="position: inherit;bottom: 2px;margin-left:5px;">查看明细</span></span></a>'
        var dispatcher = "";
        if(row.workInfo){
            dispatcher = '<a style="float:left"><span onclick = "showAppoint(\''+ row.record.recordId +'\')" class="glyphicon glyphicon-user"><span style="position: inherit;bottom: 2px;margin-left:5px;">重新指定</span></span></a>'
        } else {
            dispatcher = '<a style="float:left"><span onclick = "showAppoint(\''+ row.record.recordId +'\')" class="glyphicon glyphicon-user"><span style="position: inherit;bottom: 2px;margin-left:5px;">指定员工</span></span></a>'
        }
        return accInfo + dispatcher;
    }

    function showInfo(recordId){
        infoTableSet('accInfoTable', '/dispatching/recordDetails?recordId='+ recordId); // 初始化表格
        $("#accInfoTable").bootstrapTable({

        })
        $("#accsInfo").modal("show");


    }

// 重写了
    function showAppoint(recordId){
            $("#appointModal").modal('show'); // 显示弹窗
            var record = {recordId:recordId};
            $("#appointForm").fill(record);
    }

    function formatterUser(ele, row, index) {
        console.log(ele.user);
       if(ele.user!= null){
            return ele.user.userName;
        }
        return "暂无指派";
    }
    //面板
    function hasDispatcher(){
        initTable('recordTable', '/dispatching/dispRecordByPager'); // 初始化表格
        $("#recordTable").bootstrapTable("showColumn","workInfo")

    }
    function noDispatcher(){
        initTable('recordTable', '/dispatching/noDispRecordByPager'); // 初始化表格

        $("#recordTable").bootstrapTable("hideColumn","workInfo")
    }

    function infoFormatter(ele, row, index){
        var htmlTest = [];
        /*类型  名称 数量 预计天数*/
        var maintainFix = row.maintainFix;
        if(maintainFix){
            htmlTest.push("<div ><span class='col-md-4'>类型:</span>")
            htmlTest.push("<span class='col-md-6'>"+ maintainFix.maintainOrFix +"</span></div>")

            htmlTest.push("<div><span class='col-md-4'>名称:</span>")
            htmlTest.push("<span class='col-md-6'>"+ maintainFix.maintainName +"</span></div>")

            htmlTest.push("<div><span class='col-md-4'>工时费:</span>")
            htmlTest.push("<span class='col-md-6'>"+ maintainFix.maintainManHourFee +"</span></div>")

            htmlTest.push("<div><span class='col-md-4'>预计完成工时:</span>")
            htmlTest.push("<span class='col-md-6'>"+maintainFix.maintainHour +"</span></div>")

        }

        return htmlTest.join("");
    }


    function infoTableSet(tableId, url) {

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
            strictSearch: true,
            clickToSelect: true,  //是否启用点击选中行
            uniqueId: "maintainDetailId",                     //每一行的唯一标识，一般为主键列
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            sidePagination: "server", //表示服务端请求
            showHeader: false,
            //设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder
            //设置为limit可以获取limit, offset, search, sort, order
            queryParamsType : "undefined",
            queryParams: function queryParams(params) {   //设置查询参数
                var param = {
                    pageNumber: params.pageNumber,
                    pageSize: params.pageSize,
                    orderNum : $("#orderNum").val()
                };
                return param;
            },
        });
    }

</script>
</html>
