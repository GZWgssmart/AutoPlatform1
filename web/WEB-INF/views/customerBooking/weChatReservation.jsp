<%--
  Created by IntelliJ IDEA.
  User: jyy
  Date: 2017/4/11
  Time: 19:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>微信预约</title>
    <script type="text/javascript" src="/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="/static/js/jquery.qrcode.min.js"></script>

    <script>
        $('#code').qrcode("http://www.helloweba.com"); //任意字符串
        $("#code").qrcode({
            render: "table", //table方式
            width: 200, //宽度
            height:200, //高度
            text: "微信" //任意内容
        });
        function toUtf8(str) {
            var out, i, len, c;
            out = "";
            len = str.length;
            for(i = 0; i < len; i++) {
                c = str.charCodeAt(i);
                if ((c >= 0x0001) && (c <= 0x007F)) {
                    out += str.charAt(i);
                } else if (c > 0x07FF) {
                    out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F));
                    out += String.fromCharCode(0x80 | ((c >>  6) & 0x3F));
                    out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));
                } else {
                    out += String.fromCharCode(0xC0 | ((c >>  6) & 0x1F));
                    out += String.fromCharCode(0x80 | ((c >>  0) & 0x3F));
                }
            }
            return out;
        }
        var str = toUtf8("钓鱼岛是中国的！");
        $('#code').qrcode(str);
    </script>
</head>
<body>
    <div id="code"></div>

</body>
</html>
