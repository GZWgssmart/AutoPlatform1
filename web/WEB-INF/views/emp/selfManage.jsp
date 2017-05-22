<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="com.gs.bean.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>个人资料</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/css/bootstrap-validate/bootstrapValidator.min.css">

    <style>
        /* 让显示详细信息的窗口中的所有Input都不显示边框 */
        #detailWindow input {
            border:0 solid white;
        }
        .form-right .form-group{
            padding-top:10px;
            padding-left: 25%;
        }
        #detailWindow .form-group input{
            width: 200px;
        }
        .form-group label{
            padding:0;
        }
        .form-left{
            padding-top:20px;
        }

        #detailForm .form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control {
            background: #fff;
        }
        #detailForm .form-control {
            box-shadow: none;
        }

        .select2-container .select2-selection--multiple {
            height: auto;
        }
    </style>
</head>
<body>
<%@include file="../backstage/contextmenu.jsp" %>

<div class="container" id="detailWindow">
    <div class="panel-body" style="padding-bottom:0px;">
        <div class="modal-body">
            <form role="form" class="form-horizontal" id="detailForm" method="post">
                <div class="row">
                    <div class="form-right col-md-7">
                        <div class="form-group">
                            <img id="detailUserIcon" class="img-circle" style="width:180px;height:180px;"
                                 src="/${sessionScope.user.userIcon}"><br/>
                        </div>
                        <div class="form-group pull-left">
                            <label class=" control-label">姓名：</label>
                            <input type="text" name="userName" value="${sessionScope.user.userName}" class="form-control"
                                   style="margin-left: 30px;" disabled="true"> <%-- 此果文字会变成灰色，不可编辑。--%>
                        </div>
                        <div class="form-group pull-left">
                            <label class="control-label">Email：</label>
                            <input style="margin-left: 20px;" type="text" value="${sessionScope.user.userEmail}"
                                   class="form-control" disabled="true">
                        </div>
                        <div class="form-group pull-left">
                            <label class="control-label">手机号码：</label>
                            <input type="number" value="${sessionScope.user.userPhone}" class="form-control" disabled="true">
                        </div>
                        <div class="form-group pull-left">
                            <label class="control-label">身份证：</label>
                            <input style="margin-left: 10px;" type="number" class="form-control"
                                   value="${sessionScope.user.userIdentity}" disabled="true">
                        </div>
                        <div class="form-group pull-left">
                            <label class="control-label">创建时间：</label>
                            <input id="detailCreatedTime" value="${sessionScope.user.userCreatedTime}" type="text" class="form-control" disabled="true">
                        </div>
                    </div>
                    <div class="form-left col-md-5">
                        <div class="form-group pull-left">
                            <label class="control-label">角色：</label>
                            <input value="${sessionScope.user.role.roleName}" class="form-control" type="text" disabled="true"
                                   style="margin-left: 30px;">
                        </div>
                        <div class="form-group pull-left">
                            <label class=control-label">用户描述：</label>
                            <input type="text" disabled="true" value="${sessionScope.user.userDes}" class="form-control">
                        </div>
                        <div class="form-group pull-left">
                            <label class="control-label">性别：</label>
                            <input id="detailGender" type="text" class="form-control" value="${sessionScope.user.userGender}"
                                   disabled="true" style="margin-left: 30px;">
                        </div>
                        <div class="form-group pull-left">
                            <label class="control-label">生日：</label>
                            <input id="detailBirthday" value="${sessionScope.user.userBirthday}"
                                   class="form-control" disabled="true" style="margin-left: 30px;">
                        </div>
                        <div class="form-group pull-left">
                            <label class="control-label">底薪：</label>
                            <input type="number" value="${sessionScope.user.userSalary}" name="userSalary" class="form-control"
                                   style="margin-left: 30px;" disabled="true">
                        </div>
                        <div class="form-group pull-left">
                            <label class="control-label">昵称：</label>
                            <input type="text" value="${sessionScope.user.userNickname}" class="form-control" disabled="true" style="margin-left: 30px;">
                        </div>
                        <div class="form-group pull-left">
                            <label class="control-label">所属公司：</label>
                            <input value="${sessionScope.user.company.companyName}" class="form-control" disabled="true">
                        </div>
                        <div class="form-group pull-left">
                            <label class="control-label" >地址：</label>
                            <input type="text" value="${sessionScope.user.userAddress}" class="form-control" disabled="true" style="margin-left: 20px;">
                        </div>
                        <div class="form-group pull-left">
                            <label class="control-label">上一次登录时间：</label>
                            <input id="detailLoginTime" value="${sessionScope.user.userLoginedTime}" type="text" class="form-control" disabled="true">
                        </div>
                        <p class="clearfix"></p>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>


<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/backstage/emp/jquery-ui.js"></script>
<script src="/static/js/backstage/emp/jquery.formFillTemp.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script src="/static/js/sweetalert/sweetalert.min.js"></script>
<script src="/static/js/contextmenu.js"></script>
<script src="/static/js/backstage/main.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
</body>

<script>
    var gender = $("#detailGender").val();
    $(function() {
        var resultGender = formatterSex(gender);
        $("#detailGender").val(resultGender);

        var birthday = $("#detailBirthday").val();
        $('#detailBirthday').val(formatterDate(new Date(birthday)));  /* 格式化不带时分秒的时间 */

        var createdTime = $("#detailCreatedTime").val();  /* 创建时间 */
        var formatterCreateTime = formatterDateTime(createdTime);
        $("#detailCreatedTime").val(formatterCreateTime);

        var loginTime = $("#detailLoginTime").val();  /* 登录时间 */
        var formatterLoginTime = formatterDateTime(loginTime);
        if(formatterLoginTime == null || formatterLoginTime == '') {
            $("#detailLoginTime").val("未登录过");
        } else {
            $("#detailLoginTime").val(formatterLoginTime);
        }
    }
    );

    function formatterSex(gender) {
        if (gender == 'N') {
            return "未选择";
        } else if (gender == 'M') {
            return "男"
        } else if (gender == 'F') {
            return "女"
        }
    }

    //格式化不带时分秒的时间值。
    function formatterDate(value) {
        if (value == undefined || value == null || value == '') {
            return "";
        } else {
            var date = new Date(value);
            var year = date.getFullYear().toString();
            var month = (date.getMonth() + 1);
            var day = date.getDate().toString();
            if (month < 10) {
                month = "0" + month;
            }
            if (day < 10) {
                day = "0" + day;
            }
            return year + "-" + month + "-" + day
        }
    }

    //格式化带时分秒的时间值。
    function formatterDateTime(value) {
        if (value == undefined || value == null || value == '') {
            return "";
        } else {
            var date = new Date(value);
            var year = date.getFullYear().toString();
            var month = (date.getMonth() + 1);
            var day = date.getDate().toString();
            var hour = date.getHours().toString();
            var minutes = date.getMinutes().toString();
            var seconds = date.getSeconds().toString();
            if (month < 10) {
                month = "0" + month;
            }
            if (day < 10) {
                day = "0" + day;
            }
            if (hour < 10) {
                hour = "0" + hour;
            }
            if (minutes < 10) {
                minutes = "0" + minutes;
            }
            if (seconds < 10) {
                seconds = "0" + seconds;
            }
            return year + "-" + month + "-" + day + " " + hour + ":" + minutes + ":" + seconds;
        }
    }

</script>

</html>
