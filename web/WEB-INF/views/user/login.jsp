<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/3
  Time: 11:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <title>用户登陆</title>
    <link rel="shortcut icon" href="favicon.ico">
    <link href="/static/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="/static/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="/static/css/animate.min.css" rel="stylesheet">
    <link href="/static/css/style.min.css?v=4.1.0" rel="stylesheet">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/bootstrap-validate/bootstrapValidator.min.css">
</head>
<style>
    body{
        background: url(/static/img/Frontpage/515037.jpg);
        font-family:Microsoft YaHei,Arial,simsun, Helvetica, sans-serif;
    }
    .float-e-margins{
        border-radius:5px;
        background: rgba(0,0,0,0.2);
    }
    .form-group label{
        color: white;
        font-size: 17px;
    }
</style>
<body class="gray-bg">
<div class="row">
    <div class="col-sm-5 col-md-5" style="margin: 50px 30%;">
        <div class="ibox float-e-margins">
            <div class="ibox-title" style="padding:15px 0;background:black;text-align: center;border-color: black;">
                <span style="font-size: 30px;color: #fff;">登 录</span>

            </div>
            <div class="ibox-content" style="background: rgba(0,0,0,0.7);">
                <form class="form-horizontal" id="loginForm">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">帐号：</label>
                        <div class="col-sm-8">
                            <input type="text" name="userEmail" placeholder="邮箱/手机号/用户名" class="form-control" onkeypress="if(event.keyCode==13) {loginSubmit();}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">密码：</label>

                        <div class="col-sm-8">
                            <input type="password" name="userPwd" placeholder="密码" class="form-control" onkeypress="if(event.keyCode==13) {loginSubmit();}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">验证码：</label>
                        <div class="col-sm-8">
                            <input style="width: 64%;float: right;" type="text" name="checkCode" placeholder="验证码" class="form-control" onkeypress="if(event.keyCode==13) {loginSubmit();}">
                            <a href="javascript:;"><img style=" margin:0px 0 0 0; vertical-align:middle; height:35px;"
                                                        src="<%=path %>/captcha"
                                                        onclick="this.src='<%=path %>/captcha?time=Math.random();'"></a>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-8">
                            <button class="btn btn-block btn-success " type="button" id="loginButton" onclick="loginSubmit()">
                                登 录
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="/static/js/jquery.min.js?v=2.1.4"></script>
<script src="/static/js/bootstrap.min.js?v=3.3.6"></script>
<script src="/static/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="/static/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="/static/js/plugins/layer/layer.min.js"></script>
<script src="/static/js/sweetalert/sweetalert.min.js"></script>
<script src="/static/js/hplus.min.js?v=4.1.0"></script>
<script src="/static/js/contabs.min.js"></script>
<script src="/static/js/plugins/pace/pace.min.js"></script>
<script src="/static/js/backstage/user/backstageLogin.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script>
    $(function () {
        function bodyScroll(event) {
            event.preventDefault();
        }

        document.body.addEventListener('touchmove', bodyScroll(event), false);
        document.body.removeEventListener('touchmove', bodyScroll(event), false);
    });
    function doNothing() {
        window.event.returnValue = false;
        return false;
    }
</script>
</body>
</html>
