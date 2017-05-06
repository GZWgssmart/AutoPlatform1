<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="utf-8">
    <title>维修保养明细打印</title>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
</head>
<body>
<div class="row" style="padding:30px 30px 0 30px">
    <div id="printDiv1" class="col-sm-6">
        <span class="fontStyle"><strong>汽车公司: ${maintainRecord.checkin.company.companyName}</strong></span><br/>
        <span class="fontStyle">公司联系方式:${maintainRecord.checkin.company.companyTel}</span><br/>
        <span class="fontStyle">公司地址:${maintainRecord.checkin.company.companyAddress}</span><br></div>
    <div id="printDiv2" class="col-sm-6 text-right">
        <span class="fontStyle"><strong>车主名称: ${maintainRecord.checkin.userName}</strong></span><br/>
        <span class="fontStyle">车主联系方式:${maintainRecord.checkin.userPhone}</span><br>
        <span class="fontStyle">汽车品牌:${maintainRecord.checkin.brand.brandName}</span><br>
        <span class="fontStyle">汽车车型:${maintainRecord.checkin.model.modelName}</span><br>
        <span class="fontStyle">总计: ${maintainRecord.total}</span><br>
        <span class="fontStyle" style="color:red"><strong>折扣后总计: ${maintainRecord.discountMoney}</strong></span>
        <br><span class="fontStyle">明细日期:<fmt:formatDate value="${maintainRecord.todayTime}" pattern="yyyy/MM/dd  HH:mm:ss"></fmt:formatDate></span><br></div>
</div>
<table id="printTable" border="1px" bordercolor="#676a6c" cellspacing="0px" style="border-collapse:collapse;width:94%;margin-top:3%;margin-left:3%;">
    <tbody><tr><th style="text-align: center" colspan="5">维修保养记录明细清单</th></tr>
    <tr><th style="text-align: center">项目名称</th>
        <th style="text-align: center">项目折扣</th>
        <th style="text-align: center">原价</th>
        <th style="text-align: center">折扣后价钱</th>
        <th style="text-align: center">创建时间</th>
    </tr>
    <c:forEach items="${maintainDetails}" var="m">
    <tr><td style="text-align: center"><span class="fontStyle">${m.maintainFix.maintainName}</span></td>
        <td style="text-align: center"><span class="fontStyle">${m.disCount}</span></td>
        <td style="text-align: center"><span class="fontStyle">${m.maintainFix.maintainMoney}</span></td>
        <td style="text-align: center"><span class="fontStyle">${m.maintainFix.maintainMoney * m.maintainDiscount}</span></td>
        <td style="text-align: center"><span class="fontStyle"><fmt:formatDate value="${m.mdcreatedTime}" pattern="yyyy/MM/dd  HH:mm:ss"></fmt:formatDate></span></td>
    </tr>
    </c:forEach>
    <tr></tr>
    </tbody>
</table>
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
