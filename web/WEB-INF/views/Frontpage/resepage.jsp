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
<link rel="stylesheet" href="/static/css/resepage.css">
<link rel="stylesheet" href="/static/css/TopBtm.css">
<style>
    .content{
        width: 100%;
        height: 750px;
        background: url(/static/img/Frontpage/sg-bg2.jpg);
    }
    .form-box{
        height: 100%;
        margin: 0px 90px;
        padding-top: 100px;
        text-align: center;

    }
    .title-box ul li{
        display: inline-block;
        font-size: 2em;
        margin: 15px 15px;
    }
    .title-box ul li a{
        color: white;
    }
    .form-box2{
        width: 650px;
        float: left;
        padding: 15px 35px;
        background: rgba(0,0,0,0.6);
    }
    .form-control{
        height: 40px;
    }
    input[type=date]{
        width: 250px;
    }
    input[type=time]{
        width: 235px;
        margin-right: 0;
    }
    .form-group{
        height: 75px;
    }
    .form-group label{
        color: white;
        font-size: 21px;
        float: left;
    }
    .yy-date,.yy-time{
        display: inline;
        margin-right:15px;
        float: left;
    }
    .choose{
        color: #EEEEEE;
        border-bottom: solid 4px #5bc0de;
    }
    .btn{
        font-size: 18px;
        margin: 0 15px;
        width:170px;
    }
    .select{
        height: 30px;
        width: auto;
        padding: 0 5px;
        margin: 5px 5px;
    }

    .form-wechat{
        float:right;
        height: 100%;
        width: 350px;
    }
    .erm-img{
        width: 250px;
        height: 250px;
        margin-bottom:15px;
    }
    .erm-img img{
        width: 100%;
        height:100%;
    }
    .choosecar{
        height: auto;
        width: 100%;
        text-align:left;
    }
    .prompt{
        color: red;
        display: none;
        font-size: 16px;
        margin: 5px 5px;
    }
    .show{
        diplay:block;
    }
    .wechat-right{
        margin: 15px 20px;
        padding: 28px 28px;
        background: rgba(0,0,0,0.5);
    }
    .wechat-right:before,.wechat-right:after{
        width: 0;
        height:0;
        content:"";
        position: absolute;
        right: 419px;
        top:280px;
        border: solid 26px transparent;
    }
    .wechat-right:before{
        top:230px;
        border: solid 42px transparent;
        border-right-color:rgba(0,0,0,0.5) ;
    }

</style>
<body>
    <%--预约页面--%>
    <div class="main">
        <%--导航栏--%>
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
                <div class="form-box2">
                    <div class="title-box">
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
                                    <span class="prompt" id="name-pro3">名字格式错误</span>
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
                                        <option value="奥迪">奥迪吗</option>
                                        <option>奔驰啊</option>
                                        <option>宝马</option>
                                    </select>
                                    <select class="select">
                                        <option>奥迪吗</option>
                                        <option>奔驰啊</option>
                                        <option>宝马</option>
                                    </select>
                                    <select class="select">
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
                    <div class="wechat-right">
                        <div class="erm-img">
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
        <a href="#top" class="go-top" id="backtop" style="display:none;"></a>
    </div>

</body>
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/jquery.cxselect.min.js"></script>
<script src="/static/js/general.js"></script>
<script>
    function verification(){
        var nameValue = document.getElementById("name").value;
        var phoneValue = document.getElementById("phone").value;
        var dateValue = document.getElementById("date").value;
        var timeValue = document.getElementById("time").value;
        var name = document.getElementById("name");
        var phone = document.getElementById("phone");
        var date = document.getElementById("date");
        var time = document.getElementById("time");
        var namepro = $("#name-pro");
        var namepro2 = $("#name-pro2");
        var namepro3 = $("#name-pro3");
        var phonepro = $("#phone-pro");
        var phonepro2 = $("#phone-pro2");
        var datepro = $("#time-pro");
        /*验证姓名框*/
        if(nameValue == null || nameValue == ""){
            namepro.addClass("show")
            name.style.borderColor = "red";
            return false;
        }else if(nameValue.length < 2 || nameValue.length >= 10){
            namepro.removeClass("show");
            namepro2.addClass("show");
            name.style.borderColor = "red";
            return false;

        }else if(/\w+/.test(nameValue)){
            name.style.borderColor = "red";
            namepro3.addClass("show");
            return false;
            /*验证电话框*/
        }else if(phoneValue == null || phoneValue == ""){
            namepro.removeClass("show");
            namepro2.removeClass("show");
            namepro3.removeClass("show");
            name.style.borderColor = "#ccc";
            phonepro.addClass("show");
            phone.style.borderColor = "red";
            return false;
            /*判断格式*/

        }else if(!(/^1[3|5|8]\d{9}/.test(phoneValue))){
            phonepro.removeClass("show")
            phonepro2.addClass("show");
            phone.style.borderColor = "red";
            return false;
        }else if(dateValue == null || dateValue == "" || timeValue == null || timeValue == ""){
            namepro.removeClass("show");
            namepro2.removeClass("show");
            name.style.borderColor = "#ccc";
            phonepro.removeClass("show")
            phonepro2.removeClass("show");
            phone.style.borderColor = "#ccc";
            datepro.addClass("show")
            date.style.borderColor="red";
            time.style.borderColor="red";
            return false;
        }
        datepro.removeClass("show")
        date.style.borderColor="#ccc";
        time.style.borderColor="#ccc";
        return true;
    };

    function Conversion(){
        var by = $("#baoy");
        var wx = $("#weix");
        by.click(function () {
            wx.removeClass("choose");
            by.addClass("choose");
        });
        wx.click(function () {
            by.removeClass("choose");
            wx.addClass("choose");
        });

    };


</script>
</html>
