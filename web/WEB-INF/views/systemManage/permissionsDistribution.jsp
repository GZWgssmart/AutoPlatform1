<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <meta charset="utf-8"/>
    <title>权限分配</title>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
</head>
<%--<body>--%>
<%--<c:forEach items="${roles}" var="role">--%>
    <%--<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">--%>
        <%--<div class="panel panel-default">--%>
            <%--<div class="panel-heading" role="tab" id="heading${role.roleId}">--%>
                <%--<h4 class="panel-title">--%>
                    <%--<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse${role.roleId}"--%>
                       <%--aria-expanded="false" aria-controls="collapseOne">--%>
                            <%--${role.roleName}--%>
                    <%--</a>--%>
                <%--</h4>--%>
            <%--</div>--%>
            <%--<div id="collapse${role.roleId}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading${role.roleId}">--%>
                <%--<div class="panel-body">--%>
                        <%--&lt;%&ndash;<div id="toolbar" class="btn-group">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<button id="btn_add" type="button" class="btn btn-default" onclick="showAdd();">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增&ndash;%&gt;--%>
                        <%--&lt;%&ndash;</button>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<button id="btn_edit" type="button" class="btn btn-default" onclick="showEdit();">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改&ndash;%&gt;--%>
                        <%--&lt;%&ndash;</button>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<button id="btn_delete" type="button" class="btn btn-default" onclick="showDel();">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除&ndash;%&gt;--%>
                        <%--&lt;%&ndash;</button>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                    <%--<div class="panel-body" style="padding-bottom:0px;">--%>
                        <%--<!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->--%>
                        <%--<!-- table里的所有属性在bootstrap-table.js的240行-->--%>
                        <%--<table id="table"--%>
                               <%--data-toggle="table"--%>
                               <%--data-url="/role/permission/${role.roleId}"--%>
                               <%--data-method="post"--%>
                               <%--data-query-params="queryParams"--%>
                               <%--data-pagination="true"--%>
                               <%--data-page-size="10"--%>
                               <%--data-height="543"--%>
                               <%--data-id-field="id"--%>
                               <%--data-page-list="[5, 10, 20]"--%>
                               <%--data-cach="false"--%>
                               <%--data-click-to-select="true"--%>
                        <%-->--%>
                            <%--<thead>--%>
                            <%--<tr>--%>
                                <%--<th data-checkbox="true" data-formatter="showText"></th>--%>
                                <%--<th data-field="permissionId">用户账号</th>--%>
                                <%--<th data-field="permissionDes">用户密码</th>--%>
                            <%--</tr>--%>
                            <%--</thead>--%>
                        <%--</table>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</c:forEach>--%>
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script src="/static/js/jquery.formFill.js"></script>
<script src="/static/js/select2/select2.js"></script>
<script src="/static/js/sweetalert/sweetalert.min.js"></script>
<script>
    $(function () {
        $('#table').bootstrapTable('hideColumn', 'id');

        $("#addSelect").select2({
                language: 'zh-CN'
            }
        );

        //绑定Ajax的内容
        $.getJSON("/table/queryType", function (data) {
            $("#addSelect").empty();//清空下拉框
            $.each(data, function (i, item) {
                $("#addSelect").append("<option value='" + data[i].id + "'>&nbsp;" + data[i].name + "</option>");
            });
        })
//            $("#addSelect").on("select2:select",
//                    function (e) {
//                        alert(e)
//                        alert("select2:select", e);
//            });
    });

    function showText(value, row, index) {
        alert(row.status)
        if (row.status == true)
            return {
                disabled : true,//设置是否可用
                checked : true//设置选中
            };
        return value;
    }

    function showEdit() {
        var row = $('table').bootstrapTable('getSelections');
        if (row.length > 0) {
//                $('#editId').val(row[0].id);
//                $('#editName').val(row[0].name);
//                $('#editPrice').val(row[0].price);
            $("#edit").modal('show'); // 显示弹窗
            var ceshi = row[0];
            $("#editForm").fill(ceshi);
        } else {
            //layer.msg("请先选择某一行", {time : 1500, icon : 2});
            layer.alert("请先选择某一行");
        }
    }

    function showAdd() {

        $("#add").modal('show');
    }

    function formatRepo(repo) {
        return repo.text
    }
    function formatRepoSelection(repo) {
        return repo.text
    }

    function showDel() {
        var row = $('table').bootstrapTable('getSelections');
        if (row.length > 0) {
            $("#del").modal('show');
        } else {
            $("#tanchuang").modal('show');
        }
    }

    function checkAdd() {
        var id = $('#addId').val();
        var name = $('#addName').val();
        var price = $('#addPrice').val();
        var reslist = $("#addSelect").select2("data"); //获取多选的值
        alert(reslist.length)
        if (id != "" && name != "" && price != "") {
            return true;
        } else {
            var error = document.getElementById("addError");
            error.innerHTML = "请输入正确的数据";
            return false;
        }
    }

    function checkEdit() {
        $.post("/table/edit",
            $("#editForm").serialize(),
            function (data) {
                if (data.result == "success") {
                    $("#edit").modal('hide'); // 关闭指定的窗口
                    $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                    swal({
                        title: "",
                        text: data.message,
                        type: "success"
                    })// 提示窗口, 修改成功
                } else if (data.result == "fail") {
                    //$.messager.alert("提示", data.result.message, "info");
                }
            }, "json"
        );
    }

</script>
</body>
</html>
