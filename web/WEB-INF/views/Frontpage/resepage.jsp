<%--
  Created by IntelliJ IDEA.
  User: 不曾有黑夜
  Date: 2017/4/28
  Time: 10:41
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>预约页面</title>
</head>
<link rel="stylesheet" href="/static/css/bootstrap.css">
<link rel="stylesheet" href="/static/css/animate.css">
<link rel="stylesheet" href="/static/css/TopBtm.css">
<link rel="stylesheet" href="/static/css/resepages.css">
<link rel="stylesheet" href="/static/css/select2.min.css">
<body>
    <%--预约页面--%>
    <div class="main">
        <%--导航栏--%>
        <div class="nav nav-first">
            <ul class="nav-left-ul">
                <c:choose>
                    <c:when test="${sessionScope.frontUser != null}">
                        <c:if test="${sessionScope.frontUser.userName != null}">
                            <li id="placelogin">欢迎您，${sessionScope.frontUser.userName}</li>
                            <a href="userpage" class="right-ul"><li>我的中心</li></a>
                            <a href="outusers"><li>退出</li></a>
                            <div class="clearfix"></div>
                        </c:if>
                        <c:if test="${sessionScope.frontUser.userName == null}">
                            <li id="placelogin">欢迎您，${sessionScope.frontUser.userPhone}</li>
                            <a href="userpage" class="right-ul"><li>我的中心</li></a>
                            <a href="outusers"><li>退出</li></a>
                            <div class="clearfix"></div>
                        </c:if>
                    </c:when>

                    <c:otherwise>
                        <li id="placelogin">欢迎您，请登录</li>
                        <a href="reg" id="loginreg"><li>登录/注册</li></a>
                        <a href="javaScript:;" class="right-ul"><li>我的中心</li></a>
                        <div class="clearfix"></div>
                    </c:otherwise>
                </c:choose>
            </ul>
            <div class="clearfix"></div>
        </div>
        <div class="nav nav-two" id="navbar-two">
            <ul class="nav-two-ul">
                <a href="home"><li>首页</li></a>
                <a href="factorypage"><li>商家</li></a>
                <a href="resepage"><li class="actives">预约</li></a>
                <a href="javaScript:;"><li>配件商城</li></a>
                <a href="javaScript:;"><li>保养项目</li></a>
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
                            <form name="form1" id="form1" method="post" onsubmit="return verification()" >
                                <%--<input type="hidden" name="userId" value="${sessionScope.frontUser.userId}">--%>
                                <div class="form-group">
                                    <c:if test="${sessionScope.frontUser != null}">
                                        <label>姓名：</label>
                                        <input id="name" name="userName" type="text" value="${sessionScope.frontUser.userName}" class="form-control" onblur="verification()"  maxlength="15" placeholder="您的名字">
                                        <span class="prompt" id="name-pro">请填写该字段</span>
                                        <span class="prompt" id="name-pro2">长度必须大于等于两个字符，小于十个字符</span>
                                        <span class="prompt" id="name-pro3">名字错误</span>
                                    </c:if>

                                    <c:if test="${sessionScope.frontUser == null}">
                                        <label>姓名：</label>
                                        <input id="name" name="userName" type="text" value="" class="form-control" onblur="verification()"  maxlength="15" placeholder="您的名字">
                                        <span class="prompt" id="name-pro">请填写该字段</span>
                                        <span class="prompt" id="name-pro2">长度必须大于等于两个字符，小于十个字符</span>
                                        <span class="prompt" id="name-pro3">名字错误</span>
                                    </c:if>
                                </div>
                                <div class="form-group">
                                    <c:if test="${sessionScope.frontUser != null}">
                                        <label>电话：</label>
                                        <input id="phone" type="text" name="userPhone" value="${sessionScope.frontUser.userPhone}" class="form-control" onblur="verification()" maxlength="11" placeholder="手机号码">
                                        <span class="prompt" id="phone-pro">请填写该字段</span>
                                        <span class="prompt" id="phone-pro2">号码格式错误</span>
                                    </c:if>
                                    <c:if test="${sessionScope.frontUser == null}">
                                        <label>电话：</label>
                                        <input id="phone" type="text" name="userPhone" value="" class="form-control" onblur="verification()" maxlength="11" placeholder="手机号码">
                                        <span class="prompt" id="phone-pro">请填写该字段</span>
                                        <span class="prompt" id="phone-pro2">号码格式错误</span>
                                    </c:if>
                                </div>
                               <%-- <div class="form-group">
                                        <label>车牌编号：</label>
                                        <input id="plateId" type="text" name="plateId" value="" class="form-control"  placeholder="">
                                </div>
                                <div class="form-group">
                                    <label>车牌：</label>
                                    <input id="carPlate" type="text" name="carPlate" value="" class="form-control"   placeholder="">
                                </div>--%>
                                <div class="form-group">
                                    <span style="float: left;"><label>到店时间：</label></span>
                                    <div class="clearfix"></div>
                                    <input id="date" name="arriveTime" type="date" class="form-control yy-date">
                                    <input id="time" type="time" onblur="verification()" class="form-control yy-time">
                                    <span class="prompt" id="time-pro">请填写该字段</span>
                                    <div class="clearfix"></div>
                                </div>
                                <%--<div class="form-group choosecar">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">汽车品牌：</label>
                                        <div class="col-sm-7">
                                            <select  id="addCarBrand" class="js-example-tags carBrand" name="brandId" style="width:100%">
                                            </select>
                                        </div>
                                    </div>
                                    <div id="addModelDiv" style="" class="form-group">
                                        <label class="col-sm-3 control-label">汽车车型：</label>
                                        <div class="col-sm-7">
                                            <select  id="addCarModel" class="js-example-tags carModel" name="modelId" style="width:100%">
                                            </select>
                                        </div>
                                    </div>

                                </div>--%>
                                <div class="form-group">
                                    <input type="button" onclick="addApp();" class="btn btn-success" value="预约"/>
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
<script src="/static/js/select2/select2.js"></script>
<script>

    function addApp() {
        $.post("/addApp",$("#form1").serialize(),function (data) {
            if(data.result=="success"){
                alert(data.message);
            }else{
                alert(data.message)
            }
        })
    }
//    $(function () {
//        initSelect2("carBrand", "请选择车型", "/carBrand/queryAllCarBrand");
//        initSelect2("carModel", "请选择品牌", "/carBrand/queryAllCarModel");
//   })
</script>
</html>
