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
<style>
    body,html{
        margin: 0;
        padding: 0;
        min-width: 800px;
        font-family:Microsoft YaHei,Arial,simsun, Helvetica, sans-serif;
        overflow-x: hidden;
    }
    *{
        margin:0;
        padding: 0;
    }
    li{
        list-style-type:none;
    }
    .main{
        width:100%;
        height: auto;
    }

    /*第一个导航栏模块*/
    .nav-first{
        width:100%;
        height:auto;
        background-color: #e6e6e6;
    }
    .nav-first ul{
        margin: 5px 0 ;
    }
    .nav-first ul li {
        float: left;
        font-size:15px;
        margin: 0 15px;
        white-space:nowrap;
        color:grey;
    }
    .nav-first ul a:hover li{
        color: #0d8ddb;
    }
    .right-ul{
        float: right;
        margin-right: 10px;
    }
    /*底部模块*/
    .t-bottom{
        text-align: center;
        width: 100%;
        background-color: #0d8ddb;
    }
    .t-bottom span{
        color: white;

    }
    /*表单部分*/
    .login-content{
        background: url(/static/img/Frontpage/sg-login.jpg)repeat;
        width: 100%;
        height: 660px;
        overflow: hidden;
    }
    .content{
        width: 400px;
        height: auto;
        margin: 45px auto;
        padding:25px;
        box-shadow: 4px 4px 3px #000;
        background: rgba(0,0,0,0.2);
        border-radius:5px;
    }
    .form-logo{
        margin-bottom:20px;
        text-align: center;
    }
    .form-group{
        overflow: hidden;
    }
    .form-group .btn{
        margin-bottom: 20px;
        color: #000;
    }
    .form-group .btn:hover{
        background: rgba(0,0,0,0.2);
        border: solid white 1px;
        color:#fff;
    }
    #login{
        display: block;
    }
    #reg{
        display: none;
    }
    .caveat{
        font-size: 16px;
        color: red;
    }
    .caveat{
        display:none;
    }
</style>
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
                            <a href="" class="right-ul"><li>我的中心</li></a>
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
                        <form class="form" action="" method="post">
                            <div class="form-group">
                                <input name="email" type="text" id="email" class="form-control" placeholder="请输入邮箱" required>
                            </div>
                            <div class="form-group">
                                <input name="password" type="password" id="password" class="form-control" placeholder="请输入密码"  required>
                            </div>
                            <div class="form-group">
                                <label style="color: white;"><input type="checkbox"> 记住账号</label>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-success btn-block" value="登录">登录</button>
                                <button type="reset" class="btn btn-info btn-block" onclick="reg()" value="没有账号，立即注册">没有账号，立即注册</button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
                <div class="content wow fadeInRight animated" id="reg">
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
<script src="/static/js/wow.js"></script>
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




    /*验证电话*/
    function checkphone() {
        var phoneTip = $("#phone-caveat");
        var phoneInput = document.getElementById("phone");
        var phoneValue = document.getElementById("phone").value;
        if(!(/^[1][3|5|7|9|8]\d{9}$/.test(phoneValue)) && phoneValue != ""){
            phoneTip.css("display","block");
            phoneInput.style.borderColor = "red";
        }else if(/^[1][3|5|7|9|8]\d{9}$/.test(phoneValue)){
            phoneTip.css("display","none");
            phoneInput.style.borderColor = "#ccc";
        }
    }

    /*验证密码*/
    function checkpwd(){
        var pwdTip = $("#pws1-caveat");
        var pwd1Input = document.getElementById("password1");
        var pwd1Value = document.getElementById("password1").value;
        if(pwd1Value.length < 2 || pwd1Value.length > 17){
            pwdTip.css("display","block")
            pwd1Input.style.borderColor = "red";
        }else if(pwd1Value.length <= 17 && pwd1Value.length >= 2){
            pwdTip.css("display","none")
            pwd1Input.style.borderColor = "#ccc";
        }
    }
</script>
</body>
</html>
