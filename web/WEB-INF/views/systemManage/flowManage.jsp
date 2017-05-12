<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <meta charset="utf-8">
    <title>流程管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
<style>
    .disabled, .disabled:hover, .disabled:active, .disabled:focus,
    #table .btn-danger.disabled:hover,
    #table .btn-danger.disabled:focus
    {
        background-color: #aaa;
        border: 1px solid #aaa;
    }
    #table .btn-danger.disabled:focus,
    .disabled:focus {
        outline: none;
    }
</style>
</head>
<body>
<%@include file="../backstage/contextmenu.jsp"%>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;"  >
        <table id="table">
            <thead>
            <tr>
                <th data-radio="true" data-field="status"></th>
                <th  data-field="flowName" >名称</th>
                <th data-field="lastModified" data-formatter = "formatterDate">最后修改时间
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </th>
                <th data-field="price" data-formatter = "flowStatusFormatter">状态</th>
                <th data-field="todoCell" data-formatter = "todoCell" data-events= "todoCellBtnEvent">操作</th>
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
        </div>
    </div>
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
<script>
    window.todoCellBtnEvent = {
        "click .cold" :     coldBtnClick ,
        "dblclick .cold" :  updBtnClick ,
        "click .upd"    :   function(e, val, row, idx) {updateProceDef(e.currentTarget, "/flow/deployFile", row.fileName);},
        "click .deploy" : function(e, val, row, idx) {updateProceDef(e.currentTarget,"/flow/deployFile", row.fileName);}
    };




    $(function () {
        initTable('table', '/flow/queryAllFile',"#toolbar"); // 初始化表格
    });

    function flowStatusFormatter(el, row, index) {
        var stat = checkDeployTime(row);
        if(stat === "NEW") {
            return "已有新版本,请重新部署";
        } else if(stat === "OK"){
            return "已经部署";
        } else if(stat === "NO") {
            return "未部署";
        }
    }

    function todoCell(el, row, index) {
        var stat = checkDeployTime(row);
        var btn = "";
        console.log(this);
        if(stat === "OK") {
            btn = '<button  type="button"   class="btn btn-danger cold disabled " >'
                    + '禁用'
                    + '</button>';
        } else if (stat === "NEW") {
            btn = '<button  type="button" class="btn btn-warning upd" style="margin-right:10px;" >'
                    + '更新'
                    + '</button>';
            btn +=  '<button  type="button"  class="btn btn-danger cold disabled "  >'
                    + '禁用'
                    + '</button>';
        } else if(stat === "NO") {
            btn = '<button  type="button" class="btn btn-primary deploy" >'
                    + '部署'
                    + '</button>';
        }
        return btn;
    }

    function coldBtnClick(e, val, row, idx) {
        var enterCtrlKey = e.ctrlKey;
        var curBtn = e.currentTarget;
        var $curBtn = $(curBtn);
        if(!enterCtrlKey) {
            if (!$curBtn.hasClass("disabled")) {
                console.log("禁用这个流程模版");
                swal(
                        {title:"",
                            text:"确定删除该流程模型吗",
                            type:"warning",
                            showCancelButton:true,
                            confirmButtonColor:"#DD6B55",
                            confirmButtonText:"我确定",
                            cancelButtonText:"再考虑一下",
                            closeOnConfirm:false,
                            closeOnCancel:false
                        },function(isConfirm){
                            if(isConfirm){
                                removeProceDef("/flow/removeProcessDeploy",row.flowKey);
                            }else{
                                swal({title:"", text:"已取消",  confirmButtonText:"确认", type:"success"})
                            }
                        })
            }
        }
    }

    function updBtnClick(e,val, row, idx) {
        var enterCtrlKey = e.ctrlKey;
        var curBtn = e.currentTarget;
        var $curBtn = $(curBtn);
        if(enterCtrlKey) {
            if($curBtn.hasClass("disabled")) {
                $curBtn.removeClass("disabled");
            } else {
                $curBtn.addClass("disabled");
            }
        }
    }
    function updateProceDef(btn, url, fileName) {
        console.log(btn);
        $(btn).attr("disabled");
        $.post(url, "fileName="+fileName,
                function(data) {
                    if(data.result === "success"){
                        swal({ title:"", text: data.message, type:"success"});// 提示窗口, 修改成功
                        $('#table').bootstrapTable("refresh");
                    } else {
                        swal({ title:"", text: data.message, type:"error"});// 提示窗口, 修改失败
                    }
                });

    }

    function removeProceDef(url, flowKey) {
        $.post(url, "flowKey="+flowKey,
                function (data) {
                    if(data.result === "success"){
                        swal({ title:"", text: data.message, type:"success"});// 提示窗口, 修改成功
                        $('#table').bootstrapTable("refresh");
                    } else {
                        swal({ title:"", text: data.message, type:"error"});// 提示窗口, 修改失败
                    }
                }
        )
    }




    function checkDeployTime(row) {
        var time = row.deployDatetime;
        if(time != undefined && time != null && time != "") {
            if(time < row.lastModified) {
                return "NEW";
            }
            return "OK";
        } else {
            return "NO";
        }
    }


    function deployDateFormatter(el, row, index) {
        if(row.flowDeployDate != null) {
            formatterDate(row.flowDeployDate,row,index);
        }
        return "";
    }
</script>
</body>
</html>
