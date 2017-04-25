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
    <title>真正的主页</title>
</head>
<link rel="stylesheet" href="/static/css/bootstrap.css">
<link rel="stylesheet" href="/static/css/animate.css">
<style>
    body,html{
        margin: 0;
        padding: 0;
        min-width: 1350px;
        height: 100%;
        font-family:Microsoft YaHei,Arial,simsun, Helvetica, sans-serif;
        overflow-x: hidden;
    }
    li{
        list-style-type:none;
    }
    .main{
        width:100%;
        height: auto;
    }
    .nav-first{
        width:100%;
        height:auto;
        background-color: #D3D4D3;
    }
    .nav-first ul{
        margin: 0 0 ;
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
    .wrap-hd{
        height: 100px;
        width: 100%;
    }
    .nav-two{
        background-color: #0e9aef;
    }
    .nav-two ul li{
        float: left;
        font-size: 19px;
    }
    .nav-two-ul{
        margin:0px 50px;
    }
    .nav-two-ul li{
        width: 150px;
        height: 45px;
        text-align: center;
        line-height: 45px;
    }
    .nav-two-ul li:hover{
        background:#00a2d4;
    }
    .nav-two-ul a{
        text-decoration: none;
        color: white;
    }
    .content{
        margin: 15px 92px;
        height: 350px;
    }
    .carousel{
        height: 100%;
    }
    .item img{
        height:100%;
        width: 100%;
    }
    .showfactory{
        border: solid 1px #d7d7d7;
        margin: 15px 0;
        height: auto;
    }
    .title{

    }
    .factory{
        width: 350px;
        height: 300px;
        margin: 15px;
        display: inline-block;
    }
    .factory:hover{
        border:solid #0090ff 1px;
    }
    .factory .f-img{
        height: 50%;
        padding: 15px 20px;
    }
    .factory .f-img img{
        width: 100%;
        height: 100%;
    }
    .f-des{
        padding:15px 10px;
    }
    .company{
        margin-top: 15px;
    }

    .com-des,.com-address,.cns-a{
        text-decoration: none;
        color: black;
        display: inline-block;
        overflow: hidden;
        text-overflow: ellipsis;
        padding:0 15px;
        width:250px;
        height:30px;
        white-space: nowrap;
    }

    .icon-t{
        padding:0 14px;
    }
    .com-icon .icon-t i{
        display: inline-block;
        height: 25px;
        width: 25px;
        cursor: pointer;
    }
    .tuij{
        float: right;
        background: red;
        color: white;
        border-radius:5px ;
        padding: 4px 5px;
    }
    .ms,.hp{
        font-size: 20px;
        color: #a7aaab;
    }
    .hot-icon{
        background: url(/static/img/Frontpage/syicon-bg.png);
        background-position: -6px -329px;
        width: 30px;
        height: 30px;
        float: left;
        margin-right:5px;
    }
    .title-bg{
        background: url(/static/img/Frontpage/syicon-bg.png);
        background-position: -6px -363px;
        width: 30px;
        height: 30px;
        float: left;
        margin-right:5px;
    }
    .con{
        border:1px solid #d7d7d7;
    }
    .content-first{
        width: 100%;
        margin: 15px 0;
    }
    .acc-head ul{
        margin: 0;
        padding: 0;
    }
    .acc-head ul li{
        background: #f8f8f8;
        height: 30px;
        line-height: 30px;
        font-size: 20px;
    }
    .acc-head ul li span{
        display: inline-block;
    }
    .acc-content ul li{
        line-height: 30px;
        cursor: default;
    }
    .acc-content ul li span{
        display: inline-block;
        overflow: hidden;
        -ms-text-overflow: ellipsis;
        text-overflow: ellipsis;
        white-space:nowrap;
    }

    .go-top{
        position:fixed;
        background: url(/static/img/Frontpage/go-top2.png) no-repeat;
        width: 48px;
        height: 48px;
        right: 2em;
        bottom: 10em;
    }
    .product{
        border: solid 1px navajowhite;
        height: 500px;
        width: 100%;
    }
</style>
<body>
    <div class="main" name="top">
        <div class="nav nav-first">
            <div class="nav-left">
                <ul class="nav-left-ul">
                    <li>请登录</li>
                    <a href=""><li>登录</li></a>
                    <a href=""><li>绑定手机号</li></a>
                    <a href="" class="right-ul"><li>我的中心</li></a>
                    <a href="" class="right-ul"><li>消息中心</li></a>
                    <div class="clearfix"></div>
                </ul>
            </div>
            <div class="clearfix"></div>
        </div>
        <div class="wrap-hd">

        </div>
        <div class="nav nav-two">
            <ul class="nav-two-ul">
                <a href="javaScript:;"><li>首页</li></a>
                <a href="javaScript:;"><li>首页</li></a>
                <a href="javaScript:;"><li>首页</li></a>
                <a href="javaScript:;"><li>首页</li></a>
                <a href="javaScript:;"><li>首页</li></a>
                <a href="javaScript:;"><li>首页</li></a>
            </ul>
        </div>
        <div class="content">
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
                                    <div class="carousel-caption">标题 1</div>
                                </div>
                                <div class="item ">
                                    <img src="/static/img/Frontpage/582.jpg"/>
                                    <div class="carousel-caption">标题 2</div>
                                </div>
                                <div class="item">
                                    <img src="/static/img/Frontpage/lunbo3.jpg"/>
                                    <div class="carousel-caption">标题 3</div>
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
            <div class="clearfix"></div>
            <%--入驻商家--%>
            <div class="showfactory">
                <div class="hot-factory">
                    <div class="title">
                        <span class="hot-icon"></span>
                        <h3><a href="javaScript:;" style="text-decoration: none;">热门商家</a></h3>
                        <div class="clearfix"></div>
                    </div>
                    <div class="factory">
                        <div class="f-img">
                            <a href="javaScript:;">
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
                            <a href="javaScript:;">
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
                            <a href="javaScript:;">
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
            </div>
            <div class="product">
                
            </div>
        </div>

    </div>
    <a href="#top" class="go-top" id="backtop" style="display:block;"></a>



<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/jquery.cxselect.min.js"></script>
<script>
        /*$.cxSelect.defaults.url = 'static/js/cityData.json';
         $('#city_china').cxSelect({
         selects: ['province', 'city', 'area']
         });
         $('#city_china_val').cxSelect({
         selects: ['province', 'city', 'area'],
         nodata: 'none'
         });*/

</script>


</body>
</html>

