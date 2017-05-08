<%--
  Created by IntelliJ IDEA.
  User: 不曾有黑夜
  Date: 2017/5/4
  Time: 14:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>账号登录</title>
</head>
<link rel="stylesheet" href="/static/css/bootstrap.css">
<link rel="stylesheet" href="/static/css/animate.css">
<link rel="stylesheet" href="/static/css/sweetalert.css">
<link rel="stylesheet" href="/static/css/bootstrap-validate/bootstrapValidator.min.css">
<link rel="stylesheet" href="/static/css/registeredStyle.css">
<body>
    <div class="main">
        <%--顶部导航栏--%>
        <div class="nav nav-first">
            <div class="nav-left">
                <ul class="nav-left-ul">
                    <div class="row">
                        <div class="col-xs-8 col-md-6">
                        <li>欢迎您，请登录</li>
                        <a href="reg"><li>登录</li></a>
                        <a href="home"><li>返回首页</li></a>
                        </div>
                        <div class="col-xs-4 col-md-6">
                            <a href="userpage" class="right-ul"><li>我的中心</li></a>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </ul>
            </div>
            <div class="clearfix"></div>
        </div>

        <div class="login-content">

            <div class="content wow fadeInLeft animated" id="login">
                <div class="form-box">
                    <div class="form-logo">
                        <h2 style="color: white">登录</h2>
                    </div>
                    <div class="form-content">
                        <form class="form" id="loginForm">
                            <div class="form-group">
                                <input type="text" name="userEmail" id="email" class="form-control" placeholder="请输入邮箱/手机号">
                            </div>
                            <div class="form-group">
                                <input type="password" name="userPwd" class="form-control" placeholder="请输入密码">
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-3 col-sm-3" style="width: 29.6%">
                                    <a href="javascript:;"><img style="vertical-align:middle; height:35px;"
                                                                src="/captcha"
                                                                onclick="this.src='/captcha?time=Math.random();'"></a>
                                    </div>
                                    <div class="col-md-8 col-sm-8" style="padding-right: 0px;"><input type="text" name="checkCode"  placeholder="验证码" class="form-control"></div>
                                </div>

                            </div>
                            <div class="form-group">
                                <button type="button" class="btn btn-success btn-block" value="登录" id="loginButton" onclick="loginSubmit()">登录</button>
                                <button type="reset" class="btn btn-info btn-block" onclick="reg()" value="没有账号，立即注册">没有账号，立即注册</button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
                <div class="content wow fadeInRight animated" id="reg" name="regs">
                    <div class="form-box">
                        <div class="form-logo">
                            <h2 style="color: white">注册账号</h2>
                        </div>
                        <div class="form-content">
                            <form class="form" action="" method="post">
                                <div class="form-group">
                                    <input name="email" type="text" id="phone" class="form-control" onblur="checkphone()" placeholder="请输入您的手机号" required>
                                    <span class="caveat" id="phone-caveat">手机号错误</span>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-7 col-md-8">
                                            <input name="phonecode" type="text" id="phone-code" class="form-control" placeholder="请输入验证码" required>
                                        </div>
                                        <div class="col-xs-5 col-md-4">
                                            <a class="btn btn-info" style="margin-bottom: 0;">发送验证码</a>
                                        </div>
                                    </div>
                                    <span class="caveat" id="phonecode-caveat">验证码错误</span>
                                </div>
                                <div class="form-group">
                                    <input name="password" onblur="checkpwd()" type="password" id="password1" class="form-control" placeholder="请输入密码" required>
                                    <span class="caveat" id="pws1-caveat">密码至少六位数</span>
                                </div>
                                <div class="form-group">
                                    <input name="password2" type="password" id="password2" class="form-control" placeholder="请再次输入密码" required>
                                    <span class="caveat" id="pws2-caveat">输入密码不一致</span>
                                </div>
                                <div class="form-group">
                                    <input type="checkbox" required><a href="javaScript:;" style="padding: 3px 3px;font-size: 18px;">  我同意《用户服务协议》</a>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-success btn-block" value="确认注册">确认注册</button>
                                    <button type="reset" class="btn btn-info btn-block" onclick="reg()" value="登录">登录</button>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
        </div>
        <%--底部模块--%>
        <div class="t-bottom">
            <span style="font-size: 19px;">© 2011-2016 赣州宏图预科班 版权所有 ｜ 赣ICP备11018683-3</span>
        </div>
    </div>
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/jquery.cxselect.min.js"></script>
<script src="/static/js/wow.js"></script><script src="/static/js/sweetalert/sweetalert.min.js"></script>
<script src="/static/js/backstage/user/user.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script>
    function reg() {
        var login =$("#login");
        var reg = $("#reg");
        if(login.css("display") == "block"){
            login.css("display","none");
            reg.css("display","block");
            $(".form-content form input").each(function () {
                $(this).val('');
            });

        }else if(reg.css("display") == "block"){
            reg.css("display","none");
            login.css("display","block");
            $(".form-content form input").each(function () {
                $(this).val('');
            });
        };
    };

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
