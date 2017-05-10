<%--
  Created by IntelliJ IDEA.
  User: 不曾有黑夜
  Date: 2017/4/28
  Time: 10:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>预约页面</title>
</head>
<link rel="stylesheet" href="/static/css/bootstrap.css">
<link rel="stylesheet" href="/static/css/animate.css">
<link rel="stylesheet" href="/static/css/TopBtm.css">
<link rel="stylesheet" href="/static/css/resepages.css">
<body>
    <%--预约页面--%>
    <div class="main">
        <%--导航栏--%>
        <div class="nav nav-first">
            <div class="nav-left">
                <ul class="nav-left-ul">
                    <li>欢迎您，请登录</li>
                    <a href="reg"><li>登录</li></a>
                    <a href="reg"><li>绑定手机号</li></a>
                    <a href="userpage" class="right-ul"><li>我的中心</li></a>
                    <div class="clearfix"></div>
                </ul>
            </div>
            <div class="clearfix"></div>
        </div>
        <div class="nav nav-two" id="navbar-two">
            <ul class="nav-two-ul">
                <a href="home"><li>首页</li></a>
                <a href="factorypage"><li>找商家</li></a>
                <a href="resepage"><li class="actives">我要预约</li></a>
                <a href="javaScript:;"><li>首页</li></a>
                <a href="javaScript:;"><li>首页</li></a>
                <a href="javaScript:;"><li>首页</li></a>
            </ul>
        </div>
        <%--主内容区--%>
        <div class="content">
            <div class="form-box">
                <div class="form-box2 wow fadeInLeft animated">
                    <div class="title-box" >
                        <ul class="title-ul" style="padding:0;">
                           <a href="javaScript:;"><li class="choose" id="baoy" onmouseenter="Conversion()">预约保养</li></a>
                           <a href="javaScript:;"><li id="weix" onmouseenter="Conversion()">预约维修</li></a>
                        </ul>
                    </div>
                    <div class="body-form1">
                        <div class="form-content">
                            <form name="form1" id="form1" method="post" action="" onsubmit="return verification()" >
                                <div class="form-group">
                                    <label>姓名：</label>
                                    <input id="name" type="text" value="" class="form-control" onblur="verification()"  maxlength="15" placeholder="您的名字">
                                    <span class="prompt" id="name-pro">请填写该字段</span>
                                    <span class="prompt" id="name-pro2">长度必须大于等于两个字符，小于十个字符</span>
                                    <span class="prompt" id="name-pro3">名字错误</span>
                                </div>
                                <div class="form-group">
                                    <label>电话：</label>
                                    <input id="phone" type="text"  value="" class="form-control" onblur="verification()" maxlength="11" placeholder="手机号码">
                                    <span class="prompt" id="phone-pro">请填写该字段</span>
                                    <span class="prompt" id="phone-pro2">号码格式错误</span>
                                </div>
                                <div class="form-group">
                                    <span style="float: left;"><label>预约时间：</label></span>
                                    <div class="clearfix"></div>
                                    <input id="date" type="date" class="form-control yy-date">
                                    <input id="time" type="time" onblur="verification()" class="form-control yy-time">
                                    <span class="prompt" id="time-pro">请填写该字段</span>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="form-group choosecar">
                                    <label style="">选择车型：</label>
                                    <div class="clearfix"></div>
                                    <select class="select" style="margin-left: 0px;">
                                        <option>--品牌--</option>
                                        <option value="奥迪">奥迪吗</option>
                                        <option>奔驰啊</option>
                                        <option>宝马</option>
                                    </select>
                                    <select class="select">
                                        <option>--车系--</option>
                                        <option>奥迪吗</option>
                                        <option>奔驰啊</option>
                                        <option>宝马</option>
                                    </select>
                                    <select class="select">
                                        <option>--车型--</option>
                                        <option>奥迪吗</option>
                                        <option>奔驰啊</option>
                                        <option>还是宝马</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <input type="submit" class="btn btn-success" value="预约"/>
                                    <input type="reset" class="btn btn-warning" value="重置">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="form-wechat">
                    <div class="wechat-right" id="wechat-right">
                        <div class="erm-img  wow fadeInLeft animated">
                            <img src="/static/img/Frontpage/2wei.jpg"/>
                        </div>
                        <span style="font-size: 16px;padding-left:8px;float:left;color: white;">扫描二维码，微信预约，方便快捷</span>
                        <div class="clearfix"></div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
        <%--底部--%>
        <div class="t-bottom">
            <span style="font-size:19px;">© 2011-2016 赣州宏图预科班 版权所有 ｜ 赣ICP备11018683-3</span>
        </div>
    </div>

</body>
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/jquery.cxselect.min.js"></script>
<script src="/static/js/wow.js"></script>
<script src="/static/js/rese.js"></script>
</html>
