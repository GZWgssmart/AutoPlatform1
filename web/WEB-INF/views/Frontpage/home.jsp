<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>主页</title>
</head>
<link rel="stylesheet" href="/static/css/bootstrap.min.css">
<link rel="stylesheet" href="/static/css/animate.css">
<style>
    html,body{
        font-family: 'microsoft Yahei','Open Sans', sans-serif;
        width: 100%;
        height: auto;
    }
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
        background:url(/static/img/Frontpage/menu-bg1.png);
        width: 220px;
        text-align: center;
        margin-right: -50px;
        font-size: 20px;
    }
    #menu-bg a{
        color:white;
    }
    #menu-bg2{
        background: url(/static/img/Frontpage/menu-bg2.png);
        text-align: center;
        width: 180px;
        font-size: 20px;
    }
    #menu-bg2 a{
        color: white;
    }
    .icon-li:after{
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
        height: 422px;
        margin-top: 50px;
    }
    .carousel-inner{
        height: 422px;
        width: 100%;
    }
    .carousel-inner img{
        width: 100%;
        height: 100%;
    }
    .carousel-caption{
        padding-bottom: 27%;
        font-size: 20px;
    }
    .Maincontent2{
        height: 700px;
        width: 100%;
        background: url(/static/img/Frontpage/bg2.png);
    }
    .Maincontent{
        height: 700px;
        width:100%;
        padding-top:5%;
        background: url(/static/img/Frontpage/bg1.png);
    }
    
    .title{
        text-align: center;
        margin-top: 0;
        padding-top: 5%;
        font-size: 4em;
    }
    .carousel-control{
        opacity: 0.1;
    }
    .features-info{
        width: 100%;
        padding-top: 5%;
        padding-left: 5%;
    }
    .secicon1{
        width: auto;
    }
    .icon{
        display: inline-block;
        vertical-align:middle;
        width: 90px;
        height: 90px;
    }
    .icon-quan{
        background: url("/static/img/Frontpage/quan.png") no-repeat;
    }
    .text-icon{

        padding-left: 15px;
        font-weight: 600;
    }
    span{
        font-size:19px; ;
    }
    #myCarousel.left{
        width: 10%;
        height: 95%;
    }
    #myCarousel.right{
        width: 10%;
        height: 95%;
    }
    .rows{
        padding-top: 80px;
        padding-left:15px;
        padding-right: 15px;
        padding-bottom: 35px;
        width: 100%;
        height: 80%;
    }
    .text p{
        height: auto;
        margin: 0px 15px;
        padding: 0px 0px;
        color: white;
        font-size: 24px;
        line-height: 40px;
    }
    .right-img{
        height: 100%;
    }
    .button-box{
        margin: 5%;
        height: auto;
        text-align: center;
    }
    .button-box .btn{
        background-color:#eb9316;
        box-shadow: 4px 4px 10px black;
        color: white;
        font-size: 20px;
    }
    .button-box2{
        height: auto;
        text-align: center;
    }
    .button-box2 .btn{
        background-color:#eb9316;
        box-shadow: 4px 4px 10px black;
        color: white;
        font-size: 20px;
    }

    @media screen and (max-width: 456px){
        .right-img img{
            display: none;
        }
    }
    .Maincontent3{
        width: 100%;
        height: 700px;
        background: url(/static/img/Frontpage/bg3.png);
    }

</style>
<body>

    <div class="content">
        <nav class="nav navbar-default navbar-fixed-top" role="navigation">
            <div class="container-fluid">
                <div class="navbar-header">

                </div>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#">主页</a></li>
                    <li class="icon-li"><a href="#">登录</a></li>
                    <li class="icon-li"><a href="#">试用申请</a></li>
                    <li class="icon-li"><a href="/backstageIndex">后台</a></li>
                    <li class="icon-li"><a href="#">关于我们</a></li>
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
                    <img src="/static/img/Frontpage/banner1.png">
                    <div class="carousel-caption">标题 1</div>
                </div>
                <div class="item ">
                    <img src="/static/img/Frontpage/banner5.png"/>
                    <div class="carousel-caption">标题 2</div>
                </div>
                <div class="item">
                    <img src="/static/img/Frontpage/lunbo3.jpg"/>
                    <div class="carousel-caption">标题 3</div>
                </div>
                <div class="item">
                    <img src="/static/img/Frontpage/lunbo4.jpg"/>
                    <div class="carousel-caption">标题 4</div>
                </div>
                <div class="item">
                    <img src="/static/img/Frontpage/lunbo5.jpg"/>
                    <div class="carousel-caption">标题 5</div>
                </div>
            </div>
            <!-- 轮播（Carousel）导航 -->
            <a class="carousel-control left" href="#myCarousel"
               data-slide="prev"><span class="glyphicon glyphicon-chevron-left" style="left:0;width:200px;height: 200px;"></span></a>
            <a class="carousel-control right" href="#myCarousel"
               data-slide="next"><span class="glyphicon glyphicon-chevron-right" style="left:0;width:200px;height: 200px;"></span></a>
        </div>

        <div class="Maincontent">
            <h2 class="title">汽车维修保养采购平台</h2>
            <div class="row features-info banner-info text-left wow fadeInLeft animated"  data-wow-delay="0.5s" style="visibility: visible; animation-delay: 0.5s; animation-name: fadeInLeft;">
                <div class="col-sm-4 col-md-4">
                    <div class="secicon1">
                        <i class="icon icon-quan"></i>
                        <span class="text-icon">全系车型，海量品类</span>
                    </div>
                </div>
                <div class="col-sm-4 col-md-4">
                    <div class="secicon1">
                        <i class="icon" style="background: url(/static/img/Frontpage/bi.png)"></i>
                        <span class="text-icon">多家比价，透明降本</span>
                    </div>
                </div>
                <div class="col-sm-4 col-md-4">
                    <div class="secicon1">
                        <i class="icon" style="background: url(/static/img/Frontpage/fu.png)"></i>
                        <span class="text-icon">账期服务，采购代付</span>
                    </div>
                </div>
            </div>
            <div class="row features-info banner-img wow fadeInRight animated" data-wow-delay="0.5s" style="visibility: visible; animation-delay: 0.5s; animation-name: fadeInRight;">
                <div class="col-sm-4 col-md-4">
                    <div class="secicon1">
                        <i class="icon" style="background:url(/static/img/Frontpage/zhun.png);"></i>
                        <span class="text-icon">数据支持，精准下单</span>
                    </div>
                </div>
                <div class="col-sm-4 col-md-4">
                    <div class="secicon1">
                        <i class="icon" style="background: url(/static/img/Frontpage/bao.png);"></i>
                        <span class="text-icon">三包三赔，权益保障</span>
                    </div>
                </div>
                <div class="col-sm-4 col-md-4">
                    <div class="secicon1">
                        <i class="icon" style="background: url(/static/img/Frontpage/xiao.png)"></i>
                        <span class="text-icon">高效物流，轨迹跟踪</span>
                    </div>
                </div>
            </div>
            <div class="button-box">
                <button class="btn wow fadeInRight animated" data-wow-delay="1.5s" style="width: 200px;height: 50px;visibility: visible; animation-delay: 1.5s;animation-name: fadeInRight;">了解更多</button>
            </div>
        </div>
        <div class="Maincontent2">
            <div class="rows">
                <div class="col-md-7 banner-info text-left wow fadeInLeft animated" data-wow-delay="0.4s" style="visibility: visible; animation-delay: 0.4s; animation-name: fadeInLeft;">
                    <div class="text">
                        <p>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"汽车维修管理系统"是一款面向汽修汽配行业的管理软件，本系统专注于车辆的信息化管理，
                            为加强企业对车辆维修的综合管理而提供全方位的解决方案，并且具有二次开发的独特特性，
                            独特的二次开发功能可以为新老用户在以后的使用过程中出现的新模块，新功能随时进行添加，
                            为用户的使用提供全面服务。</br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"汽车维修管理系统"以对车辆的维修和管理为主线，
                            通过对信息的收集、存储、传递、统计、分析、综合查询、报表输出和信息共享，
                            及时为企业领导及各部门管理人员的决策提供全面、准确的信息数据。<br/>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;此汽车维修保养管理系统旨在提升汽修店的信息化水平及工作
                            效率，提供便捷有效的方式管理从维修保养预约到维修完成产生收费单据并提车的整个过程。并附带汽修店基本信息的管理，汽车配件的库存管理等功能。
                        </p>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class="right-img col-md-5 banner-img wow fadeInRight animated" data-wow-delay="0.4s" style="visibility: visible; animation-delay: 0.4s; animation-name: fadeInRight;">
                    <a href="#"><img src="/static/img/Frontpage/slider.png" id="js" style="width: 100%;height: 100%"/></a>
                </div>
            </div>
            <div class="button-box2">
                <button class="btn wow fadeInRight animated " data-wow-delay="1s" style="width: 200px;height: 50px;visibility: visible; animation-delay: 1s; animation-name: fadeInRight;">了解更多</button>
            </div>
        </div>
        <div class="Maincontent3">
            <div class="container">
                
            </div>
        </div>

</div>
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/wow.js"></script>
<script>
    if (!(/msie [6|7|8|9]/i.test(navigator.userAgent))){
        new WOW().init();
    };
</script>
</body>
</html>
