<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
<head>
    <meta charset="utf-8"/>
    <title>权限分配</title>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
</head>

<style>
    a:focus {
        outline: none;text-decoration:none;
    }
    a{
        color:black; text-decoration:none;
    }

    a:hover{
        color:black; text-decoration:none;
    }
    a:visited {
        text-decoration: none;
    }
    a:active{
        color:black;text-decoration:none;
    }
    .biaoqian {
        padding: 4px 12px;
        margin-bottom: 0;
        font-size: 14px;
        font-weight: 400;
        line-height: 1.42857143;
        text-align: center;
        white-space: nowrap;
        vertical-align: middle;
        -ms-touch-action: manipulation;
        touch-action: manipulation;
        cursor: pointer;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
        background-image: none;
        border: 1px solid transparent;
        border-radius: 4px;
        color: #333;
        background-color: #fff;
        border-color: #ccc;
        float:left;cursor:default;margin-top:10px;margin-right:10px;
    }
</style>
<body>
<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
    <c:forEach items="${roles}" var="role">
        <div class="panel panel-default">
            <div class="panel-heading" role="tab" id="heading${role.roleId}">
                <h4 class="panel-title">
                    <a role="button" id="${role.roleId}" data-toggle="collapse" data-parent="#accordion" href="#collapse${role.roleId}"
                       aria-expanded="false" onclick="showCollapse(${role.roleId})">
                            ${role.roleName}
                    </a>
                </h4>
            </div>
            <div id="collapse${role.roleId}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading${role.roleId}">
            </div>
        </div>
    </c:forEach>
</div>
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/jquery.formFill.js"></script>
<script src="/static/js/select2/select2.js"></script>
<script src="/static/js/sweetalert/sweetalert.min.js"></script>
<script>
    $(function () {

    });

    function showCollapse(id){
        var coll = "collapse"+id; // 获取到被打开的collapse Id;
        $("#"+coll).on('hide.bs.collapse', function () { // 当一个折叠窗被折叠时, 清空其所内所有事件
            var collapseDiv = $("#collapse"+id);
            collapseDiv.html("");
        })
        $.post("/role/permission/"+id,
            function (data) {
                var div = $("#collapse"+id);
                div.html("");
                var psYes = "<div id='yesPermission" + id + "' class='panel-body'><h4>已有权限</h4>";
                var psNo = "<div id='notPermission" + id + "' class='panel-body'><h4>未有权限</h4>";
                $.each(data, function (index, item) {
                    if(data[index].status == 'true') {
                        psYes += "<div id='permission_"+ data[index].permissionId +"' class='biaoqian'>"+data[index].permissionDes+"<a href='javascript:;' onclick='remove("+id+", "+data[index].permissionId+",\""+data[index].permissionDes + "\")';>&nbsp;✖</a></div>";
                    }else{
                        psNo += "<div id='permission_"+ data[index].permissionId +"' class='biaoqian'>"+ data[index].permissionDes+"<a href='javascript:;' onclick='add("+id+", "+data[index].permissionId+", \""+data[index].permissionDes + "\")';>&nbsp;➕</a></div>";
                    }
                });
                psYes += "</div>";
                psNo += "</div>";
                var permission = psYes + psNo;
                div.html(permission);
            }, "json"
        );
    }

    function remove(roleId, permissionId, permissionDes){
        $.get("/role/removePermission/"+roleId+"/"+permissionId,
            function (data) {
                if(data.result == 'success'){
                    document.getElementById("permission_"+ permissionId).remove();
                    var notPermission = document.getElementById("notPermission"+roleId);
                    var div2 = document.createElement("newDiv"+permissionId);
                    div2.innerHTML="<div id='permission_"+ permissionId +"' class='biaoqian'>"+ permissionDes+ "<a href='javascript:;' onclick='add("+roleId+", "+permissionId+", \""+permissionDes + "\")';>&nbsp;➕</a></div>";
                    notPermission.appendChild(div2);
                }
            }, "json");
    }

    function add(roleId, permissionId, permissionDes){
        $.get("/role/addPermission/"+roleId+"/"+permissionId,
            function (data) {
                if(data.result == 'success') {
                    document.getElementById("permission_" + permissionId).remove();
                    var yesPermission = document.getElementById("yesPermission" + roleId);
                    var div2 = document.createElement("newDiv" + roleId + permissionId);
                    div2.innerHTML = "<div id='permission_" + permissionId + "' class='biaoqian'>" + permissionDes + "<a href='javascript:;' onclick='remove(" + roleId + ", " + permissionId + ", \" " + permissionDes + "\")';>&nbsp;✖</a></div>";
                    yesPermission.appendChild(div2);
                }
            }, "json"
        );
    }

    function showText(value, row, index) {
        if (row.status == true)
            return {
                disabled : true,//设置是否可用
                checked : true//设置选中
            };
        return value;
    }


</script>
</body>
</html>
