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
<body class="gray-bg">
<div class="row">
    <div class="col-sm-5" style="margin: 50px 30%;">
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>请登陆</h5>
                <div class="ibox-tools">
                    <a class="collapse-link">
                        <i class="fa fa-chevron-up"></i>
                    </a>
                    <a class="dropdown-toggle" data-toggle="dropdown" href="form_basic.html#">
                        <i class="fa fa-wrench"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="form_basic.html#">选项1</a>
                        </li>
                        <li><a href="form_basic.html#">选项2</a>
                        </li>
                    </ul>
                    <a class="close-link">
                        <i class="fa fa-times"></i>
                    </a>
                </div>
            </div>
            <div class="ibox-content">
                <form class="form-horizontal" id="loginForm">
                    <p>欢迎登录本站(⊙o⊙)</p>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">用户名：</label>

                        <div class="col-sm-8">
                            <input type="email" name="userEmail" placeholder="用户名" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">密码：</label>

                        <div class="col-sm-8">
                            <input type="password" name="userPwd" placeholder="密码" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">验证码：</label>

                        <div class="col-sm-8">
                            <input type="text" name="checkCode" placeholder="验证码" class="form-control">
                            <a href="javascript:;"><img style=" margin:10px 0 0 0; vertical-align:middle; height:35px;"
                                                        src="<%=path %>/captcha"
                                                        onclick="this.src='<%=path %>/captcha?time=Math.random();'"></a>
                        </div>

                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-8">
                            <button class="btn btn-sm btn-white" type="button" id="loginButton" onclick="loginSubmit()">
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
<script src="/static/js/backstage/user/user.js"></script>
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
