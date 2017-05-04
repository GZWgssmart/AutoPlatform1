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
            background: url("/static/img/materialsFlag1.png") 105% -34px;
            background-size: 100%;
            background-repeat: no-repeat;
        }
        #materialsForm input[disable] {
            background: #fff;
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
                    <h4><span class="glyphicon glyphicon-time" ></span>&nbsp;历史记录</h4>
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
                    <th data-width="180"  data-field="workAssignTime" data-formatter=formatterDate >
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

<!-- 零件明细弹窗 -->
<div class="modal fade" id="accsInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="margin-right:0;width:95%;">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">零件明细
                    <button type="button" class="btn btn-warning"  aria-hidden="true" onclick="showAppend()">追加物料</button>
                </h4>
            </div>
            <div class="modal-body">
                <input style="display: none;" id="seachRecordId" />

                <table id="workInfoAccDetailTable" style="table-layout: fixed" data-single-select="true"
                       data-show-header="false" >
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


<!-- 确认弹窗 -->
<div class="modal fade" id="application" aria-hidden="true">
    <div class="modal-dialog" style="overflow:hidden;">
            <div class="modal-content">
                <div class="modal-footer" style="text-align: center;">
                    <div class="modal-header" style="overflow:auto;">
                        <h2>领取/退回 物料</h2>
                    </div>
                    <hr>
                    <form id="materialsForm" class="form-horizontal">
                        <input type="text" name="matainRecordId" define="materials.recordId" style="display:none"/>
                        <input type="text" name="accId" define="materials.accId" style="display:none"/>
                        <input type="text" name="accCount" define="materials.accCount"  style="display: none" />

                        <div class="form-group">
                            <label class="col-sm-3 control-label">操作类型：</label>
                            <div class="col-sm-7">
                                <input type="text" define="materials.type" disabled class="form-control" style="background-color:#fff;border:none">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">物料名称：</label>
                            <div class="col-sm-7">
                                <input type="text" define="materials.accName" disabled class="form-control" style="background-color:#fff;border:none">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">物料数量：</label>
                            <div class="col-sm-7">
                                <input type="text"  define="materials.accCountView" disabled class="form-control" style="background-color:#fff;border:none">
                            </div>
                        </div>
                    </form>
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">取消
                    </button>
                    <button  class="btn btn-primary" onclick="submitMaterials()">
                        确认
                    </button>
                </div>
            </div><!-- /.modal-content -->

    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 追加弹窗 -->
<div class="modal fade" id="appendModal" aria-hidden="true">
    <div class="modal-dialog" style="overflow:hidden;">
        <div class="modal-content">
            <div class="modal-footer" style="text-align: center;">
                <div class="modal-header" style="overflow:auto;">
                    <h2>确认操作吗?</h2>
                </div>
                <hr>
                <form id="appendMaterialsForm" class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">请选择零件：</label>
                        <div class="col-sm-7">
                            <select class="js-example-tags materialsCombobox"  name="accId"  style="width:300px;"></select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label" >请填写数量：</label>
                        <div class="col-sm-7">
                            <input type="number" name="materialCount" min = 1 define="emp.userIdentity" class="form-control">
                        </div>
                    </div>
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">取消
                    </button>
                    <button  class="btn btn-primary" onclick="appendMaterial()">
                        确认
                    </button>
                </form>

            </div>
        </div><!-- /.modal-content -->

    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


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
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<%--<script src="/static/js/backstage/picking/jquery.spinner.js"></script>
<script src="/static/js/backstage/picking/assignstaff.js"></script>--%>

</body>
<script>
    $(function(){
       // $("#materialsTable").bootstrapTable();
        initTable('materialsTable', '/dispatching/userWorksByPager'); // 初始化表格

        initSelect2("materialsCombobox", "请选择零件", "/accInv/queryAllAccInv"); // 初始化select2, 第一个参数是class的名字, 第二个参数是select2的提示语, 第三个参数是select2的查询url

        //initTable('workInfoAccDetailTable',"/materials/queryUserMaterialsByPager?recordId=1"); // 初始化表格
    });

    function todoCell(ele, row, index) {
        return "<span onclick='showWorkInfoDetail(\"" + row.recordId +"\")'>查看清单</span>";
    }

    function appendMaterial(){
        validator("appendMaterialsForm");
        var recordTest = "maintainRecordId="+$("#seachRecordId").val();
        var formSeri = $("#appendMaterialsForm").serialize();
        var newParams = formSeri+"&" + recordTest;
        $.post("/materials/insert",newParams,function(data){
            console.log(data);
            if (data.result == "success") {
                $("#appendModal").modal('hide'); // 关闭指定的窗口
                swal({
                    title:"",
                    text: "操作成功",
                    type:"success"})// 提示窗口, 修改成功
            } else if (data.result == "fail") {
                $.messager.alert("提示", "操作失败", "info");
            }
        })
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

        var min ;
        if(!isnull(row.materialUse)&&!isnull(row.materialReturn)){
            min = row.materialUse.accCount- row.materialReturn.accCount;
        } else if(!isnull(row.materialUse)){
            min = row.materialUse.accCount;
        } else {
            min = 0;
        }
        var max = row.materialCount - min;
        var htmltest = [];
        htmltest.push("<input style='display:none' value=" + row.accessories.accId+ " /> ");
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
        htmltest.push(min);
        htmltest.push("<input type='number'  max="+ max +" min="+-min+" class='form-control text-center'  value='0'  style='width:100px;margin-left:20px;display: inline-block; width:80px'>");
        htmltest.push("</span>");
        htmltest.push("</div>");
        htmltest.push("<div style='float:right;height:100%;text-align: center;' class='col-md-4'>");

        if(min >= row.materialCount ){
            htmltest.push("<div style='position: relative;top:-10px;right:-10px;height:60px' class='materialsSuc' ></div>");
        }else {
            htmltest.push("<button type='button' class='btn btn-success' onclick='showDel(this);' style='height:60px;top:10px;position:inherit; width:100%;'>领料/退料</button>");
        }
        htmltest.push("</div>");
        return htmltest.join("");
    }
    function showDel(t){
        var $t = $(t)[0];
        var td = $($t).parents()[1];
        var td1 = $(td).prev();
        var input = $(td).find("input")[1];
        var $input = $(input);
        var max = parseInt($input.attr("max"));
        var min = parseInt($input.attr("min"));
        var val = parseInt($input.val());
        if( val > max){
            $input.val(max);
        } else if(val <min){
            $input.val(min);
        }
        var materials = {};
        var accName = td1.text();
        var recordId = $("#seachRecordId").val();
        var accIdel = $(td).find("input")[0];
        var accCount =  $input.val();
        materials.recordId = recordId;
        materials.accId = $(accIdel).val();
        materials.accName = accName;
        materials.type = "领料";
        materials.accCount = accCount;
        materials.accCountView = accCount;
        if(materials.accCount < 0 ) {
            materials.type= "退料";
            materials.accCountView = -parseInt(accCount);
        }



        $("#materialsForm").fill(materials);
        $("#application").modal("show");
    }
    function isnull(obj){
        if(obj===null) {
            return true;
        }
        return false;
    }
    function abcd(tableId, url) {
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

    function submitMaterials() {
        $.post("/materials/insertUse",
                $("#materialsForm").serialize(),
                function (data) {
                    if (data.result == "success") {
                        $("#application").modal('hide'); // 关闭指定的窗口
                        $('#workInfoAccDetailTable').bootstrapTable("refresh");
                        swal({
                            title:"",
                            text: "操作成功",
                            type:"success"})// 提示窗口, 修改成功
                    } else if (data.result == "fail") {
                        $.messager.alert("提示", "操作失败", "info");
                    }
                });
    }
    function showAppend(){
        $("#appendModal").modal("show")
        $("#accsInfo").modal('hide'); // 关闭指定的窗口
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


    function validator(formId) {
        $('#' + formId).bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                materialCount: {
                    message: '用户名验证失败',
                    validators: {
                        notEmpty: {
                            message: '数量不能为空'
                        },
                        numeric: {
                            message: '数量至少为1'
                        }
                    }
                },
                accId: {
                    message: '零件验证失败',
                    validators: {
                        notEmpty: {
                            message: '请选择零件'
                        }
                    }
                }

            }
        })

                .on('success.form.bv', function (e) {
                    if (formId == "addForm") {
                        formSubmit("/checkin/add", formId, "addWindow");

                    } else if (formId == "editForm") {
                        formSubmit("/checkin/edit", formId, "editWindow");

                    }
                })

    }



</script>
</html>

