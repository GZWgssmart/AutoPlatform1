<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <meta charset="utf-8">
    <title>权限管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
</head>
<style>
    .coldStatus {
        color: #999
    }
    a {
        color: #337ab7;
    }

</style>
<body>
<%@include file="../backstage/contextmenu.jsp"%>

<div class="container">
    <div class="nav">
        <ul id="myTab" class="nav nav-tabs">
            <li class="pull-right" onclick = "recycle()">
                <a  data-toggle="tab" >
                    <h4>回收站</h4>
                </a>
            </li>
            <li class="active pull-right" onclick = "canUse()">
                <a  data-toggle="tab" >
                    <h4>可使用</h4>
                </a>
            </li>
        </ul>
    </div>

    <div class="panel-body" style="padding-bottom:0px;"  >
        <!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table">
            <thead>
            <tr>
                <th data-checkbox	="true" data-field="status"></th>
                <th  data-field="permissionName">权限名称</th>
                <th data-field="permissionZhname">权限中文名称</th>
                <th  data-field="permissionDes">权限描述</th>
                <th data-field="permissionStatus" data-formatter=formatterstatus>权限状态</th>
                <th data-field="module" data-formatter=formatterfun>权限所属模块</th>
                <th data-field="todoCell"  data-formatter=todoCell data-events=operateEvents>操作</th>
            </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <button id="btn_add" type="button" class="btn btn-default" onclick="showAdd();">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
            </button>
            <button id="btn_delete" type="button" class="btn btn-default" onclick="updStatuses();">
                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
            </button>
        </div>

        <div id="toolbar2" class="btn-group">
            <button  type="button" class="btn btn-default" onclick="updStatuses();">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>还原
            </button>
        </div>
    </div>
</div>

<!-- 添加弹窗 -->
<div class="modal fade" id="add" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <hr/>
            <form id="addForm" class="form-horizontal" method="post">
                <input type="reset" name="reset" style="display: none;"/>
                <div class="modal-header" style="overflow:auto;">
                    <p>添加权限</p>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">权限名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="permissionName" define="emp.name" class="form-control" maxlength="20">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">权限中文名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="permissionZhname" define="emp.name" class="form-control" maxlength="20">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">权限描述：</label>
                    <div class="col-sm-7">
                        <input type="text" name="permissionDes" define="emp.name" class="form-control" maxlength="500">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">权限所属模块：</label>
                    <div class="col-sm-7">
                        <%--<input type="text" name="modulePermission" define="emp.name" class="form-control" maxlength="500">--%>
                        <select id="addSelect" name="module.moduleId"  class="js-example-basic-multiple form-control"  style="width:300px;"></select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button id="addButton" type="submit" class="btn btn-primary btn-sm">保存</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<!-- 修改弹窗 -->
<div class="modal fade" id="edit" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3></h3>
                <input>
            </div>
            <hr/>
            <form id="editForm" class="form-horizontal">
                <input type="text" name="permissionId" define="permission.permissionId" style="display:none">
                <div class="form-group">
                    <label class="col-sm-3 control-label">权限名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="permissionName" define="permission.permissionName" class="form-control" maxlength="20">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">权限中文名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="permissionZhname" define="permission.permissionZhname" class="form-control" maxlength="20">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">权限所属模块：</label>
                    <div class="col-sm-7">
                        <%--<input type="text" name="modulePermission" define="emp.name" class="form-control" maxlength="500">--%>
                        <select id="moduleSelect" name="module.moduleId"  class="js-example-basic-multiple form-control" define="permission.module.moduleId"  style="width:300px;"></select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">权限描述：</label>
                    <div class="col-sm-7">
                        <textarea type="textarea"  name="permissionDes"  define="permission.permissionDes" class="form-control"  placeholder="请输入权限描述"
                                  rows="3" maxlength="100"></textarea>
                    </div>
                </div>
            </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal" onclick = "closeModal()">关闭
                    </button>
                    <button id="subButton"  class="btn btn-primary" onclick="saveEdit()">保存</button>
                </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script src="/static/js/backstage/systemManage/jquery.formFillTemp.js"></script>
<script src="/static/js/select2/select2.js"></script>
<script src="/static/js/sweetalert/sweetalert.min.js"></script>
<script src="/static/js/contextmenu.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<%--<script src="/static/js/backstage/systemManage/permissionsManage.js"></script>--%>
<script src="/static/js/backstage/main.js"></script>
</body>
<script>

    $(function(){
        todoCellEvent();
        canUse();
        initSelect("#moduleSelect", "/module/queryAll" ,"moduleId", "moduleName");
        validator("editForm");
    })
    function initSelect(selectId, url, name, value){
        $.get(url, function (data) {
            $(selectId).empty();//清空下拉框
            $.each(data, function (i, item) {
                $(selectId).append("<option value='" + data[i][name] + "'>&nbsp;" + data[i][value]+ "</option>");
            });
        })
    }
    function validator(formId) {
        $('#' + formId).bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                permissionName: {
                    message: '权限名称验证失败',
                    validators: {
                        notEmpty: {
                            message: '权限名称不能为空'
                        },
                        stringLength: {
                            min: 3,
                            max: 20,
                            message: "权限长度必须在3至20个字符之间"
                        },
                        regexp: {
                            regexp: /^[^$&,""''\s]+$/,
                            message: '权限名称不允许存在符号'
                        }
                    }
                },
                permissionZhname: {
                    message: '权限中文名称验证失败',
                    validators: {
                        notEmpty: {
                            message: '权限中文名称不能为空'
                        },
                        stringLength: {
                            min: 3,
                            max: 20,
                            message: '权限中文名称必须在3至20个字符之间'
                        },
                        regexp: {
                            regexp: /^[^$&,""''\s]+$/,
                            message: '权限中文名称不允许存在符号'
                        }
                    }
                },
                permissionDes: {
                    message: '权限简介验证失败',
                    validators: {
                        notEmpty: {
                            message: '权限中文名称不能为空'
                        },
                        stringLength: {
                            min: 3,
                            max: 100,
                            message: '权限中文名称必须在3至100个字符之间'
                        }
                    }
                },
            }
        }) .on('success.form.bv', function (e) {
            var title =$("#edit .modal-header> input").val();
            // $("#"+formId).data('bootstrapValidator').resetForm(true);
            if(title === "add") {
                formSubmit("/permission/insert", formId, addServlet);
            }else if (title === "edit"){
                formSubmit("/permission/update", formId, editServlet);
            }
        })
    }
    function formSubmit(url, formId,fun){
        $.post(url,
                $("#" + formId).serialize(),
                fun
        );
    }

    function todoCell(element, row ,index){
        var statusIconClass =  row.permissionStatus === 'Y'? '': '';
        if(row.permissionStatus === "Y"){
            return '<div style="color:#428bca">' +
                    '<a class="edit"  href="javascript:void(0)"><span class="glyphicon glyphicon-edit" ></span></a>' +
                    '&nbsp;&nbsp;&nbsp;'+
                    '<a class="updstatus" href="javascript:void(0)"><span class="glyphicon glyphicon-remove" ></span></a>' +
                    '</div> ';
        }else {
            return '<button id="btn_available"  type="button" class="btn btn-success updstatus">还原</button>';
        }
    }
    function todoCellEvent(){
        window.operateEvents = {
            'click .edit': function (e, value, row, index) {
                var permission = row;
                $("#edit .modal-header> input").val("edit");
                $("#edit .modal-header> h3").text("修改权限");
                $("#editForm").fill(permission);
                $("#edit").modal('show'); // 显示弹窗
            },
            'click .updstatus': function (e, value, row, index) {
                var msg;
                var coldMsg = "您确定要禁用此权限吗";
                var returnMsg = "您确定要启用此权限吗";
                var sucMsg;
                if(row.permissionStatus === 'Y' ){
                    msg = coldMsg;
                    sucMsg = "禁用成功";
                }else {
                    msg=returnMsg;
                    sucMsg="启用成功";
                }

                swal(
                        {title:"",
                            text:msg,
                            type:"warning",
                            showCancelButton:true,
                            confirmButtonColor:"#DD6B55",
                            confirmButtonText:"我确定",
                            cancelButtonText:"再考虑一下",
                            closeOnConfirm:false,
                            closeOnCancel:false
                        },
                        function(isConfirm){
                            if(isConfirm)
                            {
                                $.get("/permission/updateStatus?permissionId="+ row.permissionId+"&permissionStatus="+row.permissionStatus,
                                        function(data) {
                                    var typeTitle = "还原";
                                    var result = {msg: "失败", code: "error"};
                                    var msg = "失败";

                                    if(row.permissionStatus === "Y") {
                                        typeTitle = "删除";
                                    }
                                    if(data.result === "success") {
                                        result.msg = "成功";
                                        result.code="success";
                                        if(row.permissionStatus === "Y") {
                                            canUse();
                                        }else {
                                            recycle();
                                        }

                                     }
                                    swal({title:"",
                                        text:typeTitle + result.msg,
                                        type:result.code,
                                        confirmButtonText:"确认",
                                    })
                                })
                            }
                            else{
                                swal({title:"",
                                    text:"已取消",
                                    confirmButtonText:"确认",
                                    type:"error"})
                            }
                        })
            }
        };
    }

    function formatterfun(element, row ,index){
        return element!=null? element.moduleName: "<p style='color:#999'>暂无模块</p>";
    }

    function formatterstatus(element, row, index) {
        return element=== 'Y'? '<p>可用</p>':
                '<p>不可用</p>'
    }

    function saveEdit(){
        $("#editForm").data('bootstrapValidator').validate();
        if ($("#editForm").data('bootstrapValidator').isValid()) {
            $("#subButton").attr("disabled","disabled");
        } else {
            $("#subButton").removeAttr("disabled");
        }
    }
    function editServlet(data) {
        var result = {};
        result.code = "error"
        result.msg = "修改失败";
        if(data.result === "success") {
            result.code = "success";
            result.msg = "修改成功"
        }
        swal({
            title:"",
            text: result.msg, // 主要文本
            confirmButtonColor: "#DD6B55", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:result.code},function (){
            $("#edit").modal("hide");
            $("#editForm").data('bootstrapValidator').resetForm(true);
            $("#subButton").removeAttr("disabled");
           canUse();
        }) // 提示类型
    }
    function addServlet(data) {
        var result = {};
        result.code = "error"
        result.msg = "添加失败";
        if(data.result === "success") {
            result.code = "success";
            result.msg = "添加成功"
        }
        swal({
            title:"",
            text: result.msg, // 主要文本
            confirmButtonColor: "#DD6B55", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:result.code},function (){
            $("#edit").modal("hide");
            $("#subButton").removeAttr("disabled");
            $("#editForm").data('bootstrapValidator').resetForm(true);
            canUse();
        }) // 提示类型
    }

    function showAdd(){
        $("#edit .modal-header> input").val("add");
        $("#edit .modal-header> h3").text("添加权限");
        $("#edit").modal('show'); // 显示弹窗
    }
    function closeModal(){
        $("#edit").modal("hide");
        $("#editForm").data('bootstrapValidator').resetForm(true);
    }

    function canUse() {
        $("#toolbar2").css("display","none");
        $("#toolbar").css("display","block");
        initTable('table', '/permission/queryAll',"#toolbar"); // 初始化表格
    }
    function recycle() {
        $("#toolbar2").css("display","block");
        $("#toolbar").css("display","none");
        initTable('table', '/permission/queryRecycle', "#toolbar2"); // 初始化表格
    }

    function initTable(tableId, url, toolbar) {

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
            showColumns: true,  //显示下拉框勾选要显示的列
            showRefresh: true,  //显示刷新按钮
            showToggle: true, // 显示详情
            strictSearch: true,
            clickToSelect: true,  //是否启用点击选中行
            uniqueId: "checkinId",                     //每一行的唯一标识，一般为主键列
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            toolbar : toolbar,// 指定工具栏
            sidePagination: "server", //表示服务端请求

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

    // 批量删除与还原
    function updStatuses(){
        var rows =  $('#table').bootstrapTable('getSelections');
        var status = "删除";
        if(rows.length >0) {
            var row = rows[0];
            var permissionStatus = "Y";
            if(row.permissionStatus === 'N') {
                status = "还原";
                permissionStatus = "N";
            }
            swal(
                    {title:"",
                        text:"您确定要"+status+"此权限吗",
                        type:"warning",
                        showCancelButton:true,
                        confirmButtonColor:"#DD6B55",
                        confirmButtonText:"我确定",
                        cancelButtonText:"再考虑一下",
                        closeOnConfirm:false,
                        closeOnCancel:false
                    },function(isConfirm){
                        if(isConfirm)
                        {
                            var ids = [];
                            $.each(rows, function(index,ele){
                                ids.push(ele.permissionId);
                            });
                            $.post("/permission/updateStatuses",
                            "status="+permissionStatus+"&permissionIdsStr="+ids.join(","),
                                    function (data){
                                        if(data.result === "success"){
                                            swal({title:"",
                                                text:status + "成功",
                                                type:"success",
                                                confirmButtonText:"确认",
                                            },function(){
                                                if(row.permissionStatus === 'N') {
                                                    recycle();
                                                } else {
                                                    canUse();
                                                }
                                            })
                                        }  else {
                                            swal({title:"",
                                                text:status + "失败",
                                                type:"error",
                                                confirmButtonText:"确认",
                                            },function(){
                                            })
                                        }
                                    }
                            );
                        }
                        else{
                            swal({title:"",
                                text:"已取消",
                                confirmButtonText:"确认",
                                type:"error"})
                        }
                    })
        }else{
            swal({
                title:"",
                text: "请先选择要改变的权限", // 主要文本
                confirmButtonColor: "#DD6B55", // 提示按钮的颜色
                confirmButtonText:"确定", // 提示按钮上的文本
                type:"warning"}) // 提示类型
        }

    }


</script>
</html>
