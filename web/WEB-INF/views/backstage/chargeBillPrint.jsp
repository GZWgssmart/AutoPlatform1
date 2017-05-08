<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="utf-8">
    <title>收费单据打印</title>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
</head>
<style>
    .printStyle{font-weight: 100;font-size: 20px;}

</style>
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/backstage/main.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script>
    $(function () {
        var newWin = window.open('about:blank', '', '');
        var titleHtml = document.getElementById('printDiv').innerHTML;
        newWin.document.write("<html><head><title></title><link rel='stylesheet' href='/static/css/bootstrap.min.css'><script src='/static/js/jquery.min.js'/><script src='/static/js/backstage/main.js'/><script src='/static/js/bootstrap.min.js'/></head></html>");
        newWin.print();
    });
</script>
<body>
<div id="printDiv" class="row">
    <div class="col-sm-12" style="text-align: center">
       <h3><strong>收&nbsp;费&nbsp;单&nbsp;据</strong></h3>
    </div>

    <div class="col-sm-12" style="text-align: center">
        <span class="printStyle">日期: 2016/12月/1日</span>
    </div>

    <div class="row" style="border:0.5px solid black; font-size: 20px;">
        <div class="row" style="border:1px solid black;padding:10px 20px 10px 20px">
            <div class="col-sm-1" style="width:130px;">汽车公司 : </div>
            <div class="col-sm-4" style="border-bottom: 1px solid black">XXXX有限公司</div>
            <div class="col-sm-1" style="width:130px;">公司联系方式 : </div>
            <div class="col-sm-4" style="border-bottom: 1px solid black">15570102341</div>
        </div>
        <div class="col-sm-12" style="border:0.5px solid black;">
            <span class="printStyle">公司地址:${chargeBill.maintainRecord.checkin.company.companyAddress}</span><br>
        </div>
        <div>
            <div class="col-sm-8 text-right" ></div>
                用户签字:
                签字日期:
            </div>
    </div>
</div>

</body>
</html>
