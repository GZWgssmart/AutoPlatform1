<%--
  Created by IntelliJ IDEA.
  User: 不曾有黑夜
  Date: 2017/5/4
  Time: 14:44
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                    <c:choose>
                        <c:when test="${sessionScope.frontUser != null}">
                            <c:if test="${sessionScope.frontUser.userName != null}">
                                <li id="placelogin">欢迎您，${sessionScope.frontUser.userName}</li>
                                <a href="userpage" class="right-ul"><li>我的中心</li></a>
                                <a href="home" id="loginreg"><li>返回首页</li></a>
                                <div class="clearfix"></div>
                            </c:if>
                            <c:if test="${sessionScope.frontUser.userName == null}">
                                <li id="placelogin">欢迎您，${sessionScope.frontUser.userPhone}</li>
                                <a href="userpage" class="right-ul"><li>我的中心</li></a>
                                <a href="home" id="loginreg"><li>返回首页</li></a>
                                <div class="clearfix"></div>
                            </c:if>
                        </c:when>

                        <c:otherwise>
                            <li id="placelogin">欢迎您，请登录</li>
                            <a href="home" id="loginreg"><li>返回首页</li></a>
                            <div class="clearfix"></div>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
            <div class="clearfix"></div>
        </div>

        <div class="login-content" id="background-img">

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
                                <div>
                                <label style="overflow: hidden;display: inline;"><input type="checkbox" value="记住账号" style="position: relative;top:3px;width: 16px;height: 16px;"> <span style="font-size: 16px;">记住账号</span></label>

                                    <label><a href="">忘记密码</a></label>
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
                <div class="content wow fadeInRight animated" id="reg" name="regs" onkeydown="keydownres()">
                    <div class="form-box">
                        <div class="form-logo">
                            <h2 style="color: white">注册账号</h2>
                        </div>
                        <div class="form-content">
                            <form class="form" id="regform">
                                <div class="form-group">
                                    <input name="userPhone" type="text" id="phone" class="form-control" placeholder="请输入您的手机号" >
                                    <span class="caveat" id="phonecode-caveat"></span>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-7 col-md-6">
                                            <input name="phonecode"  type="text" id="phone-code" class="form-control" style="width: 110%;" placeholder="请输入验证码" >
                                        </div>
                                        <div class="col-xs-5 col-md-5">
                                            <a id="codeId" class="btn btn-info" style="margin-bottom: 0;width:123%;" onclick="sendCode(this);">获取短信验证码</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input name="userPwd" type="password" id="password1" class="form-control" placeholder="请输入密码" >
                                </div>
                                <div class="form-group">
                                    <input name="password2" type="password" id="password2" class="form-control" placeholder="请再次输入密码" >
                                </div>
                                <div class="form-group">
                                    <button type="button" id="resbtn" class="btn btn-success btn-block" onclick="regSubmit()">确认注册</button>
                                    <button type="reset" class="btn btn-info btn-block" onclick="reg()">登录</button>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
        </div>
        <%--底部模块--%>
        <%--<div class="t-bottom">--%>
            <%--<span style="font-size: 19px;">© 2011-2016 赣州宏图预科班 版权所有 ｜ 赣ICP备11018683-3</span>--%>
        <%--</div>--%>
    </div>
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/jquery.cxselect.min.js"></script>
<script src="/static/js/wow.js"></script><script src="/static/js/sweetalert/sweetalert.min.js"></script>
<script src="/static/js/backstage/user/frontLogin.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/registeredgen.js"></script>
</body>
</html>
