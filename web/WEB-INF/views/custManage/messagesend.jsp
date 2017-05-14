<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/4/11
  Time: 15:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <title>短信发送提醒</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/js/plugins/layui/css/layui.css" media="all">
</head>
<body>
<%@include file="../backstage/contextmenu.jsp" %>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;">
        <!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table">
            <thead>
            <tr>
                <th data-checkbox="true"></th>
                <th data-field="user.userName">用户名</th>
                <th data-field="sendTime" data-formatter="formatterDate">发送时间</th>
                <th data-field="sendCreatedTime" data-formatter="formatterDate">发送记录创建时间</th>
                <th data-field="sendMsg">发送内容</th>
            </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <shiro:hasAnyRoles name="公司超级管理员,公司普通管理员,汽车公司接待员">
                <button type="button" class="btn btn-w-m btn-info" onclick="showAdd();">发送短信提醒</button>
            </shiro:hasAnyRoles>
        </div>
    </div>
</div>

<!-- 添加弹窗 -->
<div class="modal fade" id="addWindow" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog" style="width: 720px;height: auto;">
        <div class="modal-content" style="overflow:hidden;">
            <form class="form-horizontal" id="addForm" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写短信发送提醒信息</h4>
                </div>
                <br/>
                <div class="form-group">
                    <label class="col-sm-3 control-label">用户名：</label>
                    <div class="col-sm-7">
                        <%--<input type="text" name="userId" placeholder="请选择用户" class="form-control">--%>
                        <select id="addUserName" name="userId" class="form-control js-example-basic-multiple messageSend"
                                multiple="multiple" style="width:100%">
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">发送时间：</label>
                    <div class="col-sm-7">
                        <input id="addSendTime" name="sendTime" readonly class="layui-input">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">发送记录创建时间：</label>
                    <div class="col-sm-7">
                        <input id="addSendCreatedTime" name="sendCreatedTime" readonly class="layui-input">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">发送内容：</label>
                    <div class="col-sm-7">
                        <textarea type="text" name="sendMsg" placeholder="请输入发送内容" style="height: 100px;"
                                  class="form-control"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-8">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button id="addButton" class="btn btn-sm btn-success" type="button" onclick="addSubmit()">保 存</button>
                    </div>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<%--<!-- 修改弹窗 -->--%>
<%--<div class="modal fade" id="editWindow" aria-hidden="true">--%>
    <%--<div class="modal-dialog" style="width: 720px;height: auto;">--%>
        <%--<div class="modal-content">--%>
            <%--<form class="form-horizontal" id="editForm" method="post">--%>
                <%--<div class="modal-header" style="overflow:auto;">--%>
                    <%--<h4>请修改短信发送提醒信息</h4>--%>
                <%--</div>--%>
                <%--<br/>--%>
                <%--<div class="form-group">--%>
                    <%--<label class="col-sm-3 control-label">用户名：</label>--%>
                    <%--<div class="col-sm-7">--%>
                        <%--<input type="text" name="userId" define="MessageSend.userId" placeholder="请选择用户" class="form-control">--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-group">--%>
                    <%--<label class="col-sm-3 control-label">发送时间：</label>--%>
                    <%--<div class="col-sm-7">--%>
                        <%--<input type="text" name="sendTime" define="MessageSend.sendTime" value="2012-05-15 21:05"--%>
                               <%--id="editDateTimePicker" class="form-control">--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-group">--%>
                    <%--<label class="col-sm-3 control-label">发送记录创建时间：</label>--%>
                    <%--<div class="col-sm-7">--%>
                        <%--<input type="text"  name="sendCreateTime" define="MessageSend.sendCreateTime" value="2012-05-15 21:05"--%>
                               <%--id="editDateTimePicker1" class="form-control">--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-group">--%>
                    <%--<label class="col-sm-3 control-label">发送内容：</label>--%>
                    <%--<div class="col-sm-7">--%>
                        <%--<textarea type="text" name="sendMsg"  define="MessageSend.sendMsg" placeholder="请输入发送内容" style="height: 100px;"--%>
                                  <%--class="form-control"></textarea>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-group">--%>
                    <%--<div class="col-sm-offset-8">--%>
                        <%--<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>--%>
                        <%--<button class="btn btn-sm btn-success" type="submit">保 存</button>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</form>--%>
        <%--</div><!-- /.modal-content -->--%>
    <%--</div><!-- /.modal-dialog -->--%>
<%--</div><!-- /.modal -->--%>

<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script src="/static/js/jquery.formFill.js"></script>
<script src="/static/js/select2/select2.js"></script>
<script src="/static/js/sweetalert/sweetalert.min.js"></script>
<script src="/static/js/contextmenu.js"></script>
<script src="/static/js/backstage/custManage/messagesend.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/plugins/layui/layui.js" charset="utf-8"></script>
<script src="/static/js/backstage/main.js"></script>
<script>
    layui.use('laydate', function(){

        var laydate = layui.laydate;

        var addSendTime = {
            format: 'yyyy-MM-dd hh:mm:ss',
            min: laydate.now(), //设定最小日期为当前日期
            max: '2099-12-30 23:59:59', //最大日期
            istime: true,
            istoday: false,
            festival: true
        };

        document.getElementById('addSendTime').onclick = function () {
            addSendTime.elem = this;
            laydate(addSendTime);
        }

        var addSendCreatedTime = {
            format: 'yyyy-MM-dd hh:mm:ss',
            max: '2099-12-30 23:59:59', //最大日期
            istime: true,
            istoday: false,
            festival: true
        };

        document.getElementById('addSendCreatedTime').onclick = function () {
            addSendCreatedTime.elem = this;
            laydate(addSendCreatedTime);
        }

    });
</script>
</body>
</html>
