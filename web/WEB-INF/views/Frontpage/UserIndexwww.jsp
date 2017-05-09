<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>个人中心</title>
    <link rel="stylesheet" href="/static/css/pintuer.css">
    <link rel="stylesheet" href="/static/css/bootstrap.css">
    <link rel="stylesheet" href="/static/css/admin.css">
    <script src="/static/js/jquery.min.js"></script>
</head>
<style>
    /*第一个导航栏模块*/
    *{
        margin: 0;
        padding: 0;
    }
    .nav-first{
        width:100%;
        height:auto;
        background-color: #e6e6e6;
        overflow: hidden;
    }
    .nav-first ul{
        margin: 5px 0;
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
    .leftnav h2{
        margin-top:0;
        margin-bottom:0;
    }
</style>
<body style="background-color:#f2f9fd;">
<div class="nav-first">
    <div class="nav-left">
        <ul class="nav-left-ul">
            <li>欢迎您，请登录</li>
            <a href="reg"><li>登录</li></a>
            <a href="home"><li>返回首页</li></a>
            <a href="userpage" class="right-ul"><li>我的中心</li></a>
            <div class="clearfix"></div>
        </ul>
    </div>
    <div class="clearfix"></div>
</div>
<div class="header bg-main">
  <div class="logo margin-big-left fadein-top">
    <h3><img src="/static/img/Frontpage/sg-login.jpg" class="radius-circle rotate-hover" height="50" />个人中心</h3>
  </div>
</div>
<div class="leftnav">
  <div class="leftnav-title"><strong><span class="icon-list"></span>菜单列表</strong></div>
  <h2><span class="icon-user"></span>账号设置</h2>
  <ul style="display:block">
    <li><a href="home" target="right">账号信息</a></li>
    <li><a href="factorydeta" target="right">修改密码</a></li>
  </ul>
  <h2><span class="icon-phone-square"></span>我的预约</h2>
  <ul>
    <li><a href="list.html" target="right">电话预约</a></li>
    <li><a href="add.html" target="right">微信预约</a></li>
    <li><a href="cate.html" target="right">网上预约</a></li>
  </ul>
    <h2><span class="icon-pencil-square-o"></span>维修保养</h2>
    <ul>
        <li><a href="list.html" target="right">查看维修保养进度</a></li>
        <li><a href="list.html" target="right">支付记录</a></li>
    </ul>
    <h2><span class="icon-money"></span>结算提车</h2>
    <ul>
        <li><a href="list.html" target="right">提车提醒</a></li>
        <li><a href="list.html" target="right">收费单据</a></li>
    </ul>
</div>
<script type="text/javascript">
$(document).ready(function () {
    $(function () {
        $(".leftnav h2").click(function () {
            $(this).next().slideToggle(200);
            $(this).toggleClass("on");
        })
        $(".leftnav ul li a").click(function () {
            $("#a_leader_txt").text($(this).text());
            $(".leftnav ul li a").removeClass("on");
            $(this).addClass("on");
        });
    });
});
</script>
<ul class="bread">
  <li><a href="home" target="right" class="icon-home"> 首页</a></li>
  <li><a href="##" id="a_leader_txt">网站信息</a></li>
</ul>
<div class="admin">
  <iframe scrolling="auto" rameborder="0" src="home" name="right" width="100%" height="100%"></iframe>
</div>
<div style="text-align:center;">
</div>
</body>
</html>