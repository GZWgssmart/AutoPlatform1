<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>主页</title>
</head>
<link rel="stylesheet" href="/static/css/bootstrap.min.css">

<style>
    .nav{
        background-color:white ;
    }
    .container-fluid .navbar-header a{
        text-decoration:none;
    }
    .container-fluid ul{
        font-size: 18px;
    }
    .container-fluid ul li{
        padding: 0 10px;
        color: black;
    }

    #menu-bg{
        background:url(/static/img/menu-bg1.png);
        width: 220px;
        text-align: center;
        margin-right: -50px;
        font-size: 20px;
    }
    #menu-bg a{
        color:white;
    }
    #menu-bg2{
        background: url(/static/img/menu-bg2.png);
        text-align: center;
        width: 180px;
        font-size: 20px;
    }
    #menu-bg2 a{
        color: white;
    }
    .icon:after{
        position: absolute;
        content: "";
        width: 0px;
        height: 25px;
        top: 15px;
        left: 0px;
        border-right:1px solid grey;
        transform: rotate(20deg);
    }
    /*轮播图*/
    #myCarousel{
        width: 100%;
        height: 450px;
    }
    .carousel-inner{
        height: 450px;
        width: 100%;
    }
    .carousel-inner img{
        width: 100%;
        height: auto;
    }
</style>
<body>

<nav class="nav navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="#">主页</a></li>
            <li class="icon"><a href="#">登录</a></li>
            <li class="icon"><a href="#">注册</a></li>
            <li class="icon"><a href="#">帮助</a></li>
            <li class="icon"><a href="#">关于我们</a></li>
            <li id="menu-bg"><a href="#">汽配商入驻</a></li>
            <li id="menu-bg2"><a href="#">汽修厂入驻</a></li>
        </ul>
    </div>
</nav>

<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- 轮播（Carousel）指标 -->
    <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
        <li data-target="#myCarousel" data-slide-to="3"></li>
        <li data-target="#myCarousel" data-slide-to="4"></li>
    </ol>
    <!-- 轮播项目-->
    <div class="carousel-inner">
        <div class="item active">
            <img src="/static/img/lunbo1.jpg">
        </div>
        <div class="item ">
            <img src="/static/img/lunbo2.jpg"/>
        </div>
        <div class="item">
            <img src="/static/img/lunbo3.jpg"/>
            <div class="carousel-caption">女神么么哒！</div>
        </div>
        <div class="item">
            <img src="/static/img/lunbo4.jpg"/>
            <div class="carousel-caption">女神么么哒！</div>
        </div>
        <div class="item">
            <img src="/static/img/lunbo5.jpg"/>
        </div>
    </div>
    <!-- 轮播（Carousel）导航 -->
    <a class="carousel-control left" href="#myCarousel"
       data-slide="prev">&nbsp;</a>
    <a class="carousel-control right" href="#myCarousel"
       data-slide="next">&nbsp;</a>
</div>


<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
</body>
</html>
