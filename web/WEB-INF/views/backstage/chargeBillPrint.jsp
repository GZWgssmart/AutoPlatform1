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
<body>
<%--<div class="row" style="padding:30px 30px 0 30px">--%>
    <%--<div id="printDiv1" class="col-sm-6">--%>
        <%--<span class="fontStyle"><strong>汽车公司: ${chargeBill.maintainRecord.checkin.company.companyName}</strong></span><br/>--%>
        <%--<span class="fontStyle">公司联系方式:${chargeBill.maintainRecord.checkin.company.companyTel}</span><br/>--%>
        <%--<span class="fontStyle">公司地址:${chargeBill.maintainRecord.checkin.company.companyAddress}</span><br></div>--%>
    <%--<div id="printDiv2" class="col-sm-6 text-right">--%>
        <%--<span class="fontStyle"><strong>车主名称: ${chargeBill.maintainRecord.checkin.userName}</strong></span><br/>--%>
        <%--<span class="fontStyle">车主联系方式:${chargeBill.maintainRecord.checkin.userPhone}</span><br>--%>
        <%--<span class="fontStyle">汽车品牌:${chargeBill.maintainRecord.checkin.brand.brandName}</span><br>--%>
        <%--<span class="fontStyle">汽车车型:${chargeBill.maintainRecord.checkin.model.modelName}</span><br>--%>
        <%--<span class="fontStyle">付款方式:${chargeBill.paymentMethod}</span><br>--%>
        <%--<span class="fontStyle">总金额: ${chargeBill.chargeBillMoney}</span><br>--%>
        <%--<span class="fontStyle" style="color:red"><strong>实际付款: ${chargeBill.actualPayment}</strong></span><br>--%>
        <%--<span class="fontStyle">收费时间:<fmt:formatDate value="${chargeBill.chargeTime}" pattern="yyyy/MM/dd  HH:mm:ss"></fmt:formatDate></span><br>--%>
        <%--<span class="fontStyle">收费单据创建时间:<fmt:formatDate value="${chargeBill.chargeCreatedTime}" pattern="yyyy/MM/dd  HH:mm:ss"></fmt:formatDate></span><br></div>--%>
<%--</div>--%>
<%--<table id="printTable" border="1px" bordercolor="#676a6c" cellspacing="0px" style="border-collapse:collapse;width:94%;margin-top:3%;margin-left:3%;">--%>
    <%--<tbody><tr><th style="text-align: center" colspan="5">维修保养记录明细清单</th></tr>--%>
    <%--<tr><th style="text-align: center">项目名称</th>--%>
        <%--<th style="text-align: center">项目折扣</th>--%>
        <%--<th style="text-align: center">原价</th>--%>
        <%--<th style="text-align: center">折扣后价钱</th>--%>
        <%--<th style="text-align: center">创建时间</th>--%>
    <%--</tr>--%>
    <%--<c:forEach items="${maintainDetails}" var="m">--%>
    <%--<tr><td style="text-align: center"><span class="fontStyle">${m.maintainFix.maintainName}</span></td>--%>
        <%--<td style="text-align: center"><span class="fontStyle">${m.disCount}</span></td>--%>
        <%--<td style="text-align: center"><span class="fontStyle">${m.maintainFix.maintainMoney}</span></td>--%>
        <%--<td style="text-align: center"><span class="fontStyle">${m.maintainFix.maintainMoney * m.maintainDiscount}</span></td>--%>
        <%--<td style="text-align: center"><span class="fontStyle"><fmt:formatDate value="${m.mdcreatedTime}" pattern="yyyy/MM/dd  HH:mm:ss"></fmt:formatDate></span></td>--%>
    <%--</tr>--%>
    <%--</c:forEach>--%>
    <%--<tr></tr>--%>
    <%--</tbody>--%>
<%--</table>--%>
<div class="row">
    <div class="col-sm-12" style="text-align: center">
       <h3><strong>收&nbsp;费&nbsp;单&nbsp;据</strong></h3>
    </div>

    <div class="col-sm-12" style="text-align: center">
        <span class="printStyle">日期: 2016/12月/1日</span>
    </div>

    <div class="row" style="border:0.5px solid black; font-size: 20px;">
        <div class="col-sm-12" style="border:1px solid black;padding:10px 20px 10px 20px">
            <div class="col-sm-2" style="width:130px;">汽车公司 : </div>
            <div class="col-sm-4" style="border-bottom: 1px solid black">XXXX有限公司</div>
            <div class="col-sm-2" style="width:130px;">公司联系方式 : </div>
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

<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/backstage/main.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script>
    $(function () {
        window.print();
    });
</script>
</body>
</html>
