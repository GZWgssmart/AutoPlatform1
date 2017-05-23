<%--
  Created by IntelliJ IDEA.
  User: 不曾有黑夜
  Date: 2017/4/18
  Time: 19:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>关于我们</title>
</head>
<link rel="stylesheet" href="/static/css/bootstrap.css">
<link rel="stylesheet" href="/static/css/animate.css">
<link rel="stylesheet" href="/static/css/Frontpage.css">
<link rel="stylesheet" href="/static/css/platform.css">
<body name="top">
    <%--


        下载页面


    --%>
    <div id="main">
        <%--导航栏--%>
        <nav class="nav navbar-default navbar-fixed-top" role="navigation"  style="">
            <div class="container-fluid">
                <div class="navbar-header">

                </div>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="/index">主页</a></li>
                    <li class="icon-li"><a href="/reg">登录</a></li>
                    <li class="icon-li"><a href="/platformIntro">关于我们</a></li>
                    <li id="menu-bg"><a href="/factoryreg">汽修公司入驻</a></li>
                </ul>
            </div>
        </nav>
        <%--第二个导航栏--%>
        <div class="nav-two">
            <div class="container-nav">
                <ul class="nav-ul">
                    <a href="#windows-m"><li>我是谁</li></a>
                    <a href="#android-m"><li>我在哪</li></a>
                    <a href="#iphone-m"><li>我要干嘛</li></a>
                    <a href="#ipad-m"><li>都是浮云</li></a>
                    <div class="clearfix"></div>
                </ul>
            </div>
        </div>
        <%--第一个内容--%>
        <div id="first" style="margin-top:100px;" name="windows-m">
            <div class="container">
                <div class="col-md-6 col-sm-6 content-left wow fadeInLeft animated" data-wow-delay="0.7s" >
                    <div class="first-left-bg">
                        <img style="width: 90%;" src="/static/img/Frontpage/pc-bg.png"/>
                    </div>
                </div>
                <div class="col-md-6 col-sm-6 content-right wow fadeInRight animated" data-wow-delay="0.7s" >
                    <div class="first-rt-txt">
                        <h1 style="font-size: 4em;"><p>我们是谁？</p> Who are we</h1>
                        <ul class="des-txt" style="list-style: none;">

                        </ul>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <%--背景图--%>
        <div id="thirdBar">

        </div>
        <%--第二个内容--%>
        <div id="two" name="iphone-m">
            <div class="container">
                <div class="col-md-6 col-sm-6 content-left  wow fadeInLeft animated" data-wow-delay="0.7s" >
                    <div class="first-rt-txt">
                        <h1 style="font-size: 4em;">我们在做什么？<p>What are we doing</p></h1>

                    </div>

                </div>
                <div class="col-md-6 col-sm-6 content-right wow fadeInRight animated" data-wow-delay="0.7s" >
                    <div class="first-left-bg">
                        <img src="/static/img/Frontpage/iphone-green.png"/>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <%--背景图--%>
        <div id="fourthBar"></div>
        <%--第三个内容--%>
        <div id="three" name="android-m">
                <div class="container">
                    <div class="col-md-6 col-sm-6 content-left wow fadeInLeft animated" data-wow-delay="0.7s" >
                        <div class="first-left-bg">
                            <img src="/static/img/Frontpage/anzhuo-bg.png"/>
                        </div>
                    </div>
                    <div class="col-md-6 col-sm-6 content-right wow fadeInRight animated" data-wow-delay="0.7s" >
                        <div class="first-rt-txt">
                            <h1 style="font-size: 4em;">我们在哪？<p>Where are we</p></h1>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        <div id="fifthBar"></div>
        <%--第四个内容--%>
        <div id="four" name="ipad-m">
                <div class="container">
                    <div class="col-md-6 col-sm-6 content-left wow fadeInLeft animated">
                        <div class="first-rt-txt">
                            <h1 style="font-size: 4em;">不想说什么</h1>
                        </div>

                    </div>
                    <div class="col-md-6 col-sm-6 content-right wow fadeInRight animated">
                        <div class="first-left-bg">
                            <img src="/static/img/Frontpage/ipad-bg.jpg"/>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        <div id="sixthBar"></div>
        <%--底部版权--%>
            <div class="bottom-nav">
                <div class="row concart-warp">
                    <div class="col-md-5 col-sm-12 btm-left">
                        <h4>联系我们：</h4>
                        <p>
                            <i class="icon-phone"><img src="/static/img/Frontpage/phone.png"/></i>
                            <span class="phone">15570102341</span>
                        </p>
                        <p>E-mail:8318045@qq.com</p>
                        <p><a href="javaScript:;"><img src="/static/img/Frontpage/btm-left.png"></a></p>
                    </div>
                    <div class="col-sm-9 col-md-5 wechat">
                        <h3 style="margin: 0;">扫码关注</h3>
                        <div class="row sm ">
                            <div class="col-md-3 col-sm-3">
                            </div>
                            <div class="col-md-5 col-sm-5" style="text-align: center;">
                                <img src="/static/img/Frontpage/erweim.jpg" width="180px" height="140px"/>
                            </div>
                            <div class="col-md-3 col-sm-3">

                            </div>
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-3 rt-img row">
                        <div class="col-md-12 col-sm-10 gz">
                            <h4 style="margin-bottom: 10px;">关注预约有好礼</h4>
                            <a href="/resepage" id="mc5-rtimg"><img src="/static/img/Frontpage/weixin.jpg" width="100px" height="100px"/></a>

                        </div>
                    </div>
                </div>
                <div class="t-bottom">
                    <span style="font-size: 19px;">© 2017-3017 神的坐骑 版权所有 ｜ 赣ICP备11018683-3</span>
                </div>
            </div>
    </div>
    <a href="#top" class="go-top" id="backtop" style="display:none;"></a>
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/wow.js"></script>
<script src="/static/js/init.js"></script>
<script src="/static/js/general.js"></script>
<script>
    if (!(/msie [5|6|7|8|9]/i.test(navigator.userAgent))){
        new WOW().init();
    };

</script>
</body>

</html>
