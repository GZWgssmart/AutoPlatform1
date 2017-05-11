<%--
  Created by IntelliJ IDEA.
  User: 不曾有黑夜
  Date: 2017/5/11
  Time: 14:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>账号信息</title>
</head>
<link rel="stylesheet" href="/static/css/bootstrap.css">
<style>
    body,html{
        font-family:Microsoft YaHei,Arial,simsun, Helvetica, sans-serif;
    }
    *{
        padding:0;
        margin:0;
    }
    .form-box{
        width: 400px;
        height:auto;
        margin: 0px auto;
    }
    @media (max-width: 767px) {
        .form-box{
            width:100%;
        }
    }
    .info{
        margin-bottom: 15px;
    }
    .content{
        padding:0 50px;
    }

</style>
<body>
    <div class="main">
        <div class="form-box well" id="form-box2">
            <form class=" info-form" id="form2" action="" method="get">
                <div class="content">
                    <div class="info">
                        <label>名称：</label>
                        <input class="form-control" type="text" value="张三">
                    </div>

                    <div class="info">
                        <label>电话：</label>
                        <input class="form-control" type="text" value="15770944049">
                    </div>
                    <div class="info">
                        <label>邮箱：</label>
                        <input class="form-control" type="text" value="qweasdzxc102@qq.com">
                    </div>
                    <div class="info">
                        <label>地址：</label>
                        <fieldset id="city_china" >
                            <select class="province" disabled="disabled" name="province"></select>
                            <select class="city" disabled="disabled" name="city"></select>
                            <select class="area" disabled="disabled" name="area"></select>
                        </fieldset>
                    </div>
                    <div class="info">
                        <label>性别：</label>
                        <select style="width: 30%" >
                            <option value="男">
                                男
                            </option>
                            <option value="女">
                                女
                            </option>
                        </select>
                    </div>
                    <div class="info">
                        <a class="btn btn-danger btn-block" href="/accountinfo">确认</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <script src="/static/js/jquery.min.js"></script>
    <script src="/static/js/jquery.cxselect.js"></script>
</body>
<script>
    $.cxSelect.defaults.url = '/static/js/cityData.min.json';
    $('#city_china').cxSelect({
        selects: ['province', 'city', 'area']
    });


</script>
</html>
