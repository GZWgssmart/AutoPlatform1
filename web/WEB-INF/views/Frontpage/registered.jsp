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

            <div class="content wow fadeInLeft animated" id="login" onkeydown="keydown()">
                <div class="form-box">
                    <div class="form-logo">
                        <h2 style="color: white;margin-top: 0;">登录</h2>
                    </div>
                    <div class="form-content">
                        <form class="form" id="loginForm" >
                            <div class="form-group">
                                <input type="text" name="userEmail" id="email" class="form-control" placeholder="请输入邮箱/手机号">
                            </div>
                            <div class="form-group">
                                <input type="password" name="userPwd" class="form-control" placeholder="请输入密码">
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-3 col-sm-3" style="width: 29.6%">
                                    <a href="javascript:;">
                                        <img style="vertical-align:middle; height:35px;" src="/captcha" onclick="this.src='/captcha?time=Math.random();'"></a>
                                    </div>
                                    <div class="col-md-8 col-sm-8" style="padding-right: 0px;"><input type="text" name="checkCode"  placeholder="验证码" class="form-control"></div>
                                </div>

                            </div>
                            <div class="form-group">
                                <label style="overflow: hidden;"><input type="checkbox" value="记住账号" style="position: relative;top:3px;width: 16px;height: 16px;"> <span style="font-size: 16px;">记住账号</span></label>
                            </div>
                            <div class="form-group">
                                <button type="button" class="btn btn-success btn-block" value="登录" id="loginButton" onclick="loginSubmit()">登录</button>
                                <button type="reset" class="btn btn-info btn-block" onclick="reg()" value="没有账号，立即注册">没有账号，立即注册</button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
                <div class="content wow fadeInRight animated" id="reg" name="regs" onkeydown="keydownres()">
                    <div class="form-box">
                        <div class="form-logo">
                            <h2 style="color: white">注册账号</h2>
                        </div>
                        <div class="form-content">
                            <form class="form" id="regform">
                                <div class="form-group">
                                    <input name="phone" type="text" id="phone" class="form-control" placeholder="请输入您的手机号" >
                                    <span class="caveat" id="phone-caveat">手机号错误</span>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-7 col-md-8">
                                            <input name="phonecode" style="width: 105%" type="text" id="phone-code" class="form-control" placeholder="请输入验证码" >
                                        </div>
                                        <div class="col-xs-5 col-md-4">
                                            <a class="btn btn-info" style="margin-bottom: 0;">发送验证码</a>
                                        </div>
                                    </div>
                                    <span class="caveat" id="phonecode-caveat">验证码错误</span>
                                </div>
                                <div class="form-group">
                                    <input name="password" type="password" id="password1" class="form-control" placeholder="请输入密码" >
                                    <span class="caveat" id="pwd1-caveat">密码至少六位并且小于十八位</span>
                                </div>
                                <div class="form-group">
                                    <input name="password2" type="password" id="password2" class="form-control" placeholder="请再次输入密码" >
                                    <span class="caveat" id="pwd2-caveat">输入密码不一致</span>
                                </div>
                                <div class="form-group">
                                    <input type="checkbox"  style="position: relative;top:2px;width: 14px;height: 14px;"><a class="surre" href="javaScript:;" style="padding: 3px 3px;font-size: 16px;">  我同意《用户服务协议》</a>
                                </div>
                                <div class="form-group">
                                    <button type="submit" id="resbtn" class="btn btn-success btn-block" value="确认注册" onclick="regSubmit()">确认注册</button>
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
<script src="/static/js/backstage/user/frontLogin.js"></script>
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
            validator2("regform");
            document.title = "注册";
        }else if(reg.css("display") == "block"){
            reg.css("display","none");
            login.css("display","block");
            $(".form-content form input").each(function () {
                $(this).val('');
            });
            validator("loginForm");
            document.title = "账号登录";
        };

    };
    /*回车登录*/
    function keydown(){
        if(event.keyCode == 13){
            document.getElementById("loginButton").click();
        }
    }
    function keydownres(){
        if(event.keyCode == 13){
            document.getElementById("resbtn").click();
        }
    }


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
