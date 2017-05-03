<%--
  Created by IntelliJ IDEA.
  User: 不曾有黑夜
  Date: 2017/4/20
  Time: 20:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>主页</title>
</head>
<link rel="stylesheet" href="/static/css/bootstrap.css">
<link rel="stylesheet" href="/static/css/animate.css">
<link rel="stylesheet" href="/static/css/FrontHome.css">
<body>
    <%--

    主页面

    --%>
    <div class="main" name="top">
        <div class="nav nav-first">
        <div class="nav-left">
            <ul class="nav-left-ul">
                <li>欢迎您，请登录</li>
                <a href=""><li>登录</li></a>
                <a href=""><li>绑定手机号</li></a>
                <a href="" class="right-ul"><li>我的中心</li></a>
                <a href="" class="right-ul"><li>消息通知</li></a>
                <div class="clearfix"></div>
            </ul>
        </div>
        <div class="clearfix"></div>
    </div>
        <div class="nav nav-two" id="navbar-two">
            <ul class="nav-two-ul">
                <a href="home"><li class="actives">首页</li></a>
                <a href="factorypage"><li>找商家</li></a>
                <a href="resepage"><li>我要预约</li></a>
                <a href="javaScript:;"><li>首页</li></a>
                <a href="javaScript:;"><li>首页</li></a>
                <a href="javaScript:;"><li>首页</li></a>
            </ul>
        </div>
        <%--轮播图--%>
        <div class="car-carousel">
            <div class="carousel">
                <div class="car-choose">
                    <div id="myCarousel" class="carousel slide" data-ride="carousel">
                        <!-- 轮播（Carousel）指标 -->
                        <ol class="carousel-indicators">
                            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                            <li data-target="#myCarousel" data-slide-to="1"></li>
                            <li data-target="#myCarousel" data-slide-to="2"></li>
                        </ol>
                        <!-- 轮播项目-->
                        <div class="carousel-inner">
                            <div class="item active">
                                <img src="/static/img/Frontpage/banner1.png">
                                <%--<div class="carousel-caption">标题 1</div>--%>
                            </div>
                            <div class="item ">
                                <img src="/static/img/Frontpage/582.jpg"/>
                            </div>
                            <div class="item">
                                <img src="/static/img/Frontpage/lunbo3.jpg"/>
                            </div>
                        </div>
                        <!-- 轮播（Carousel）导航 -->
                        <button class="carousel-control left" href="#myCarousel" style="border: none;"
                                data-slide="prev"><span class="glyphicon glyphicon-chevron-left" style="left:0;width:200px;height: 200px;"></span></button>
                        <button class="carousel-control right" href="#myCarousel" style="border: none;"
                                data-slide="next"><span class="glyphicon glyphicon-chevron-right" style="left:0;width:200px;height: 200px;"></span></button>
                    </div>
                </div>
            </div>

        </div>
        <%--主内容开始--%>
        <div class="content">
            <%--保养项目开始--%>
            <div class="product">
                <%--保养项目头部--%>
                <div class="preferences">
                    <div class="pro-title">
                        <i class="title-bg"></i>
                        <h3>
                            <a href="javaScript:;" style="text-decoration: none;">保养项目</a>
                        </h3>
                    </div>
                    <div class="pro-content">
                        <div class="index_baoyang_wrap">
                            <div>
                                <a class="index-green" href="javaScript:;">
                                    <span class="baoy-title">小保养</span>
                                    <i class="jiage">￥ <span class="price-span">158</span> 起</i>
                                </a>
                            </div>
                            <div>
                                <a class="index-red" href="javaScript:;">
                                    <span class="baoy-title">大保养</span>
                                    <i class="jiage">￥ <span class="price-span">346</span> 起</i>
                                </a>
                            </div>
                            <div>
                                <a class="index-blue" href="javaScript:;">
                                    <span class="baoy-title">更换空调滤清器</span>
                                    <i class="jiage">￥ <span class="price-span">580</span> 起</i>
                                </a>
                            </div>
                            <div>
                                <a class="index-pink" href="javaScript:;">
                                    <span class="baoy-title">更换刹车片</span>
                                    <i class="jiage">￥ <span class="price-span">98</span> 起</i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <%--全部保养项目模块--%>
                <div class="index-main-wrap">
                    <ul class="index-ul">
                        <li class="one-li">
                            <a href="javaScript:;">
                                <span>更换轮胎</span>
                            </a>
                        </li>
                        <li class="two-li">
                            <a href="javaScript:;">
                                <span>更换轮毂</span>
                            </a>
                        </li>
                        <li class="three-li">
                            <a href="javaScript:;">
                                <span>更换刹车油</span>
                            </a>
                        </li>
                        <li class="four-li">
                            <a href="javaScript:;">
                                <span>更换火花塞</span>
                            </a>
                        </li>
                        <li class="five-li">
                            <a href="javaScript:;">
                                <span>更换电瓶</span>
                            </a>
                        </li>
                        <li class="six-li">
                            <a href="javaScript:;">
                                <span>更换大灯/灯泡</span>
                            </a>
                        </li>
                        <li class="seven-li">
                            <a href="javaScript:;">
                                <span>更换变速箱油</span>
                            </a>
                        </li>
                        <li class="eight-li">
                            <a href="javaScript:;">
                                <span>更换空调制冷剂</span>
                            </a>
                        </li>
                        <li class="nine-li">
                            <a href="javaScript:;">
                                <span>更换刹车盘</span>
                            </a>
                        </li>
                        <li class="ten-li">
                            <a href="javaScript:;">
                                <span>更换防冻冷却液</span>
                            </a>
                        </li>
                        <li class="eleven-li">
                            <a href="javaScript:;">
                                <span>进排气系统养护</span>
                            </a>
                        </li>
                        <li class="twelve-li">
                            <a href="javaScript:;">
                                <span>更换助力转向油</span>
                            </a>
                        </li>
                        <li class="thirteen-li">
                            <a href="javaScript:;">
                                <span>更换正时皮带</span>
                            </a>
                        </li>
                        <li class="fourteen-li">
                            <a href="javaScript:;">
                                <span>更换外部皮带</span>
                            </a>
                        </li>
                        <li class="fifteen-li">
                            <a href="javaScript:;">
                                <span>更换减震器</span>
                            </a>
                        </li>
                        <li class="sixteen-li">
                            <a href="javaScript:;">
                                <span>燃油系统养护</span>
                            </a>
                        </li>
                        <li class="seventeen-li">
                            <a href="javaScript:;">
                                <span>发动机内部养护</span>
                            </a>
                        </li>
                        <li class="eighteen-li">
                            <a href="javaScript:;">
                                <span>空调系统养护</span>
                            </a>
                        </li>
                        <div class="clearfix"></div>
                    </ul>
                </div>
            </div>
            <%--入驻商家--%>
            <div class="showfactory">
                <div class="hot-factory">
                    <div class="title">
                        <span class="hot-icon"></span>
                        <h3><a href="factorypage" style="text-decoration: none;">热门商家</a></h3>
                        <div class="clearfix"></div>
                    </div>
                    <div class="factory">
                        <div class="f-img">
                            <a href="factorypage">
                                <img src="/static/img/Frontpage/slider.png"/>
                            </a>
                        </div>
                        <div class="f-des">
                            <div class="company-name">
                                <span class="cns">
                                    <a class="cns-a" href="javaScript:;" title="公司名称公司名称公司名称公司sssss公司名称公司名称公司名称公司sssss">
                                        <i class="glyphicon glyphicon-bookmark"></i> 公司名称公司名称公司名称公司sssss公司名称公司名称公司名称公司sssss
                                    </a>
                                    <div style="float: right;margin-right: 15px">
                                        <img src="/static/img/Frontpage/xun-lv.png"/>
                                        <img src="/static/img/Frontpage/xun-lv.png"/>
                                    </div>
                                    <div class="clearfix"></div>
                                </span>
                            </div>
                            <div class="company-des">
                                <span class="com-des" title="公司描述公司描述公司描述公司描述公司描述公司描述公司描述公司描述">
                                    <i class="glyphicon glyphicon-edit"></i> 公司描述公司描述公司描述公司描述公司描述公司描述公司描述公司描述
                                </span>
                            </div>
                            <div class="company-address">
                                <span class="com-address" title="赣州市章贡区沙石镇">
                                    <i class="glyphicon glyphicon-map-marker"></i> 赣州市章贡区沙石镇
                                </span>
                            </div>
                            <div class="com-icon">
                                <div class="icon-t">
                                    <i class="ms glyphicon glyphicon-thumbs-up" title="五星好评"></i>
                                    <i class="hp glyphicon glyphicon-hourglass" title="闪电发货"></i>
                                    <span class="tuij" title="五星店铺">
                                        <i class="glyphicon glyphicon-star" style="width: 14px;height: 16px;"></i> 推荐
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="factory">
                        <div class="f-img">
                            <a href="factorypage">
                                <img src="/static/img/Frontpage/slider.png"/>
                            </a>
                        </div>
                        <div class="f-des">
                            <div class="company-name">
                                <span class="cns">
                                    <a class="cns-a" href="javaScript:;" title="公司名称公司名称公司名称公司sssss公司名称公司名称公司名称公司sssss">
                                        <i class="glyphicon glyphicon-bookmark"></i> 公司名称公司名称公司名称公司sssss公司名称公司名称公司名称公司sssss
                                    </a>
                                    <div style="float: right;margin-right: 15px">
                                        <img src="/static/img/Frontpage/xun-lv.png"/>
                                        <img src="/static/img/Frontpage/xun-lv.png"/>
                                    </div>
                                    <div class="clearfix"></div>
                                </span>
                            </div>
                            <div class="company-des">
                                <span class="com-des" title="公司描述公司描述公司描述公司描述公司描述公司描述公司描述公司描述">
                                    <i class="glyphicon glyphicon-edit"></i> 公司描述公司描述公司描述公司描述公司描述公司描述公司描述公司描述
                                </span>
                            </div>
                            <div class="company-address">
                                <span class="com-address" title="赣州市章贡区沙石镇">
                                    <i class="glyphicon glyphicon-map-marker"></i> 赣州市章贡区沙石镇
                                </span>
                            </div>
                            <div class="com-icon">
                                <div class="icon-t">
                                    <i class="ms glyphicon glyphicon-thumbs-up" title="五星好评"></i>
                                    <i class="hp glyphicon glyphicon-hourglass" title="闪电发货"></i>
                                    <span class="tuij" title="五星店铺">
                                        <i class="glyphicon glyphicon-star" style="width: 14px;height: 16px;"></i> 推荐
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="factory">
                        <div class="f-img">
                            <a href="factorypage">
                                <img src="/static/img/Frontpage/slider.png"/>
                            </a>
                        </div>
                        <div class="f-des">
                            <div class="company-name">
                                <span class="cns">
                                    <a class="cns-a" href="javaScript:;" title="公司名称公司名称公司名称公司sssss公司名称公司名称公司名称公司sssss">
                                        <i class="glyphicon glyphicon-bookmark"></i> . 公司名称公司名称公司名称公司sssss公司名称公司名称公司名称公司sssss
                                    </a>
                                    <div style="float: right;margin-right: 15px">
                                        <img src="/static/img/Frontpage/xun-lv.png"/>
                                        <img src="/static/img/Frontpage/xun-lv.png"/>
                                    </div>
                                    <div class="clearfix"></div>
                                </span>
                            </div>
                            <div class="company-des">
                                <span class="com-des" title="公司描述公司描述公司描述公司描述公司描述公司描述公司描述公司描述">
                                    <i class="glyphicon glyphicon-edit"></i> 公司描述公司描述公司描述公司描述公司描述公司描述公司描述公司描述
                                </span>
                            </div>
                            <div class="company-address">
                                <span class="com-address" title="赣州市章贡区沙石镇">
                                    <i class="glyphicon glyphicon-map-marker"></i> 赣州市章贡区沙石镇
                                </span>
                            </div>
                            <div class="com-icon">
                                <div class="icon-t">
                                    <i class="ms glyphicon glyphicon-thumbs-up" title="五星好评"></i>
                                    <i class="hp glyphicon glyphicon-hourglass" title="闪电发货"></i>
                                    <span class="tuij" title="五星店铺">
                                        <i class="glyphicon glyphicon-star" style="width: 14px;height: 16px;"></i> 推荐
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%--最近成交--%>
            <div class="content-first">
                <div class="recent-title">
                    <i class="title-bg"></i>
                    <h3><a href="javaScript:;" style="text-decoration: none;">最近预约保养</a></h3>
                </div>
                <div class="con">
                    <div class="acc-head">
                        <ul>
                            <li>
                                <span style="width:20%;margin-left:15px;">保养项目</span>
                                <span style="width:33%;">车型</span>
                                <span style="width: 20%;">费用</span>
                                <span style="width: 16%;">保养时间</span>
                            </li>
                        </ul>
                    </div>
                    <div class="acc-content">
                        <ul style="margin: 0;padding: 0;">
                            <li>
                                <span style="width:20%;margin-left:19px;padding-right: 15px;">前档玻璃外压条</span>
                                <span style="width:33%;padding-right: 15px;">丰田 Alphard(进口) 3.5 手自一体 豪华版 2011款</span>
                                <span style="width: 20%;">579.00</span>
                                <span style="width: 16%;">2017-04-24</span>
                            </li>
                            <li>
                                <span style="width:20%;margin-left:19px;padding-right: 15px;">前档玻璃外压条</span>
                                <span style="width:33%;padding-right: 15px;">丰田 Alphard(进口) 3.5 手自一体 豪华版 2011款</span>
                                <span style="width: 20%;">579.00</span>
                                <span style="width: 16%;">2017-04-24</span>
                            </li>
                            <li>
                                <span style="width:20%;margin-left:19px;padding-right: 15px;">前档玻璃外压条</span>
                                <span style="width:33%;padding-right: 15px;">坎坎坷坷扩扩所所所安慰道丰田 Alphard(进口) 3.5 手自一体 豪华版 2011款</span>
                                <span style="width: 20%;">579.00</span>
                                <span style="width: 16%;">2017-04-24</span>
                            </li>
                            <li>
                                <span style="width:20%;margin-left:19px;padding-right: 15px;">前档玻璃外压条</span>
                                <span style="width:33%;padding-right: 15px;">丰田 Alphard(进口) 3.5 手自一体 豪华版 2011款</span>
                                <span style="width: 20%;">579.00</span>
                                <span style="width: 16%;">2017-04-24</span>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="recent-title">
                    <i class="title-bg"></i>
                    <h3><a href="javaScript:;" style="text-decoration: none;">最近预约维修</a></h3>
                </div>
                <div class="con">
                    <div class="acc-head">
                        <ul>
                            <li>
                                <span style="width:20%;margin-left:15px;">维修项目</span>
                                <span style="width:33%;">车型</span>
                                <span style="width: 20%;">维修费用</span>
                                <span style="width: 16%;">维修时间</span>
                            </li>
                        </ul>
                    </div>
                    <div class="acc-content">
                        <ul style="margin: 0;padding: 0;">
                            <li>
                                <span style="width:20%;margin-left:19px;padding-right: 15px;">前档玻璃外压条</span>
                                <span style="width:33%;padding-right: 15px;">丰田 Alphard(进口) 3.5 手自一体 豪华版 2011款</span>
                                <span style="width: 20%;">579.00</span>
                                <span style="width: 16%;">2017-04-24</span>
                            </li>
                            <li>
                                <span style="width:20%;margin-left:19px;padding-right: 15px;">前档玻璃外压条</span>
                                <span style="width:33%;padding-right: 15px;">丰田 Alphard(进口) 3.5 手自一体 豪华版 2011款</span>
                                <span style="width: 20%;">579.00</span>
                                <span style="width: 16%;">2017-04-24</span>
                            </li>
                            <li>
                                <span style="width:20%;margin-left:19px;padding-right: 15px;">前档玻璃外压条</span>
                                <span style="width:33%;padding-right: 15px;">坎坎坷坷扩扩所所所安慰道丰田 Alphard(进口) 3.5 手自一体 豪华版 2011款</span>
                                <span style="width: 20%;">579.00</span>
                                <span style="width: 16%;">2017-04-24</span>
                            </li>
                            <li>
                                <span style="width:20%;margin-left:19px;padding-right: 15px;">前档玻璃外压条</span>
                                <span style="width:33%;padding-right: 15px;">丰田 Alphard(进口) 3.5 手自一体 豪华版 2011款</span>
                                <span style="width: 20%;">579.00</span>
                                <span style="width: 16%;">2017-04-24</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <%--底部模块--%>
        <div class="index-bottom">
            <div class="bottom-main">
                <div class="bottom-bs">
                    <div class="bg"></div>
                    <a href="javaScript:;" style="text-decoration: none;">
                        <div class="btm-title">原厂品质正品配件</div>
                        <div class="btm-des">
                            <span>深厚的产业背景和厂商资源，严格控制进货渠道，杜绝一切假冒伪劣配件</span>
                        </div>
                    </a>
                </div>
                <div class="bottom-bs">
                    <div class="bg-two"></div>
                    <a href="javaScript:;" style="text-decoration: none;">
                        <div class="btm-title">保养省钱，安心便捷</div>
                        <div class="btm-des">
                            <span>优惠的配件价格，合理的安装人工费，汽车保养省钱之道</span>
                        </div>
                    </a>
                </div>
                <div class="bottom-bs">
                    <div class="bg-three"></div>
                    <a href="javaScript:;" style="text-decoration: none;">
                        <div class="btm-title">汽车保养专家系统</div>
                        <div class="btm-des">
                            <span>要保养什么，用什么配件，用多少？智能汽车保养专家系统，让您轻松养车</span>
                        </div>
                    </a>
                </div>
                <div class="bottom-bs">
                    <div class="bg-four"></div>
                    <a href="javaScript:;" style="text-decoration: none;">
                        <div class="btm-title">全里程保养保障</div>
                        <div class="btm-des">
                            <span> 针对汽车从上路到报废整个期间所有需要保养的项目都可以提供全面服务</span>
                        </div>
                    </a>
                </div>
                <div class="bottom-bs">
                    <div class="bg-five"></div>
                    <a href="javaScript:;" style="text-decoration: none;">
                        <div class="btm-title">线下安装服务承诺</div>
                        <div class="btm-des">
                            <span>到店安装、特约安装店全部经过严格筛选，定期对技术资质和服务能力评估</span>
                        </div>
                    </a>
                </div>
                <div class="bottom-bs">
                    <div class="bg-six"></div>
                    <a href="javaScript:;" style="text-decoration: none;">
                        <div class="btm-title">汽车保养服务保障</div>
                        <div class="btm-des">
                            <span>从养车无忧网购买配件到特约安装店更换，出现任何问题，统一协调解决</span>
                        </div>
                    </a>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="btm-two">
                <ul class="btm-ul">
                    <li>
                        <div style="margin: 15px 20px;">
                            <div style="font-size: 20px;">联系我们：</div>
                            <span style="display: block;line-height: 3;color: #0e9aef;font-size: 22px;"><img src="/static/img/Frontpage/phone.png"/> 4000-5875200</span>
                            <span style="font-size: 18px">Email: qweasdxzc102@qq.com</span>
                        </div>
                    </li>
                    <li>
                        <div style="margin: 15px 20px;text-align: center;">
                            <span style="font-size: 20px;">扫码关注</span>
                            <ul class="saoma">
                                <li>
                                    <img src="/static/img/Frontpage/pcode-4.png"/>
                                </li>
                                <li>
                                    <img src="/static/img/Frontpage/pcode-4.png"/>
                                </li>
                                <li>
                                    <img src="/static/img/Frontpage/pcode-4.png"/>
                                </li>
                                <div class="clearfix"></div>
                            </ul>
                        </div>
                    </li>
                    <li>
                        <div class="btm-an">
                            <a class="ruzhu" href="javaScript:;" >汽修厂入驻</a>
                            <a class="jiam" href="platformIntro">商家加盟</a>
                        </div>
                    </li>
                    <div class="clearfix"></div>
                </ul>
            </div>
            <div class="t-bottom">
                <span style="font-size: 19px;">© 2011-2016 赣州宏图预科班 版权所有 ｜ 赣ICP备11018683-3</span>
            </div>
        </div>
        <a href="#top" class="go-top" id="backtop" style="display:none;"></a>
    </div>



<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/jquery.cxselect.min.js"></script>
<script>

    $(document).ready(function(){
        $(".nav-two-ul a li").each(function(){
            $this = $(this);
            if($this[0].href==String(window.location)){
                $this.addClass("actives");
            }
        });

        $(function () {
            var navbar = $("#navbar-two");
            $(window).scroll(function () {
                if($(window).scrollTop() > 21){
                    if(navbar.css("position") !="fixed"){
                        navbar.css({ 'position': 'fixed',top:0,width:1349,zIndex:9999})
                    };
                }else if(navbar.css("position") != "static"){
                    navbar.css("position","static");
                }
            }) ;
        });

        $(function(){
            var backtop = document.getElementById("backtop");
            $(window).scroll(function () {
                if($(window).scrollTop() >= 500){
                    backtop.style.display = "block";
                }else if($(window).scrollTop() <500){
                    backtop.style.display = "none";
                }
            });
        });
        $(function(){
            $('a[href*=#],area[href*=#]').click(function() {
                if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
                    var $target = $(this.hash);
                    $target = $target.length && $target || $('[name=' + this.hash.slice(1) + ']');
                    if ($target.length) {
                        var targetOffset = $target.offset().top;
                        $('html,body').animate({
                                    scrollTop: targetOffset
                                },
                                1000);
                        return false;
                    }
                }
            });
        });
    });
</script>


</body>
</html>

