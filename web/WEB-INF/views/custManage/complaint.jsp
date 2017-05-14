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
    <title>投诉管理</title>
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
                <th data-field="user.userName">投诉人</th>
                <th data-field="company.companyName">投诉人所属公司</th>
                <th data-field="complaintCreatedTime" data-formatter="formatterDate">投诉时间</th>
                <th data-field="complaintContent">投诉内容</th>
                <th data-formatter="formatterUserName">投诉回复人</th>
                <th data-field="complaintReplyTime" data-formatter="formatterDate">投诉回复时间</th>
                <th data-field="complaintReply">投诉回复内容</th>
            </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <shiro:hasAnyRoles name="车主">
                <button id="btn_add" type="button" class="btn btn-default" onclick="showAdd();">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
                </button>
            </shiro:hasAnyRoles>
            <shiro:hasAnyRoles name="汽修公司管理员,汽修公司接待员">
                <button id="btn_application" type="button" class="btn btn-success" onclick="showReply();">回复车主</button>
            </shiro:hasAnyRoles>
            <%--<button id="btn_edit" type="button" class="btn btn-default" onclick="showEdit();">--%>
            <%--<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改--%>
            <%--</button>--%>
            <shiro:hasAnyRoles name="系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司接待员,车主">
                <div class="input-group" style="width:350px;float:left;padding:0;margin:0 0 0 -1px;">
                    <div class="input-group-btn">
                        <button type="button" id="ulButton" class="btn btn-default" style="border-radius:0px;"
                                data-toggle="dropdown">投诉人<span class="caret"></span></button>
                        <ul class="dropdown-menu pull-right">
                            <li><a onclick="onclikLi(this)">投诉人</a></li>
                            <li class="divider"></li>
                            <li><a onclick="onclikLi(this)">投诉内容</a></li>
                            <li class="divider"></li>
                            <li><a onclick="onclikLi(this)">投诉回复人</a></li>
                            <li class="divider"></li>
                            <li><a onclick="onclikLi(this)">投诉回复内容</a></li>
                        </ul>
                    </div><!-- /btn-group -->
                    <input id="ulInput" class="form-control" onkeypress="if(event.keyCode==13) {blurredQuery();}">
                    <a href="javascript:;" onclick="blurredQuery()"><span
                            class="glyphicon glyphicon-search search-style"></span></a>
                    </input>
                </div>
                <!-- /input-group -->
            </shiro:hasAnyRoles>
        </div>
    </div>
</div>

<!-- 添加弹窗 -->
<div class="modal fade" id="addWindow" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog" style="width: 780px;height: auto;">
        <div class="modal-content" style="overflow:hidden;">
            <form class="form-horizontal" role="form" id="addForm" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写投诉信息</h4>
                </div>
                <br/>
                <div class="form-group">
                    <label class="col-sm-3 control-label">投诉人：</label>
                    <div class="col-sm-7">
                        <select id="addUserName" name="userId" class="form-control js-data-example-ajax user" style="width:100%">
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">投诉时间：</label>
                    <div class="col-sm-7">
                        <input id="addComplaintCreatedTime" name="complaintCreatedTime" readonly class="layui-input" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">投诉内容：</label>
                    <div class="col-sm-7">
                        <textarea type="text" name="complaintContent" placeholder="请输入投诉内容" style="height: 100px;"
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

<!-- 回复弹窗 -->
<div class="modal fade" id="addReplyWindow" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog" style="width: 780px;height: auto;">
        <div class="modal-content" style="overflow:hidden;">
            <form class="form-horizontal" role="form" id="addReplyForm" method="post">
                <input type="hidden" name="complaintId" define="Complaint.complaintId" />
                <%--<input type="hidden" name="userId" define="Complaint.user.userId" />--%>
                <%--<input id="start2" type="text" name="complaintCreatedTime" define="Complaint.complaintCreatedTime" />--%>
                <%--<input type="hidden" name="complaintContent" define="Complaint.complaintContent" />--%>
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写回复信息</h4>
                </div>
                <br/>
                <div class="form-group">
                    <label class="col-sm-3 control-label">投诉回复人：</label>
                    <div class="col-sm-7">
                        <%--<select id="addAdminName" name="complaintReplyUser" class="form-control js-data-example-ajax admin" style="width:100%">--%>
                        <%--</select>--%>
                        <input id="addAdminId" name="complaintReplyUser" readonly define="Complaint.complaintReplyUser" value="${sessionScope.user.userName}" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">投诉回复时间：</label>
                    <div class="col-sm-7">
                        <input id="addReplyComplaintReplyTime" name="complaintReplyTime" readonly define="Complaint.complaintReplyTime" class="layui-input">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">投诉回复内容：</label>
                    <div class="col-sm-7">
                        <textarea type="text"  name="complaintReply" define="Complaint.complaintReply" placeholder="请输入投诉回复内容" style="height: 100px;"
                                  class="form-control"></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-sm-offset-8">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button id="replyButton" class="btn btn-sm btn-success" type="button" onclick="addReplySubmit()">保 存</button>
                    </div>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<!-- 修改弹窗 -->
<div class="modal fade" id="editWindow" aria-hidden="true">
    <div class="modal-dialog" style="width: 780px;height: auto;">
        <div class="modal-content">
            <form class="form-horizontal" id="editForm" method="post">
                <input type="text" name="complaintId" define="Complaint.complaintId" />
                <%--<input type="text" name="userId" define="Complaint.user.userId" />--%>
                <%--<input id="start3" type="text" name="complaintCreatedTime" define="Complaint.complaintCreatedTime" />--%>
                <%--<input type="text" name="complaintContent" define="Complaint.complaintContent" />--%>
                <div class="modal-header" style="overflow:auto;">
                    <h4>请修改投诉管理信息</h4>
                </div>
                <br/>
                <div class="form-group">
                    <label class="col-sm-3 control-label">投诉回复人：</label>
                    <div class="col-sm-7">
                        <select id="editAdminName" name="complaintReplyUser" class="form-control js-data-example-ajax admin" style="width:100%">
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">投诉回复时间：</label>
                    <div class="col-sm-7">
                        <input id="editComplaintReplyTime" name="complaintReplyTime" readonly  define="Complaint.complaintReplyTime" class="layui-input">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">投诉回复内容：</label>
                    <div class="col-sm-7">
                        <textarea type="text"  name="complaintReply" define="Complaint.complaintReply" placeholder="请输入投诉回复内容" style="height: 100px;"
                                  class="form-control"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-8">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button id="editButton" class="btn btn-sm btn-success" type="button" onclick="editSubmit()">保 存</button>
                    </div>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script src="/static/js/jquery.formFill.js"></script>
<script src="/static/js/select2/select2.js"></script>
<script src="/static/js/sweetalert/sweetalert.min.js"></script>
<script src="/static/js/contextmenu.js"></script>
<script src="/static/js/backstage/custManage/complaint.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/plugins/layui/layui.js" charset="utf-8"></script>
<script src="/static/js/backstage/main.js"></script>
<script>
    $(function() {
        layui.use('laydate', function () {

            var laydate = layui.laydate;

            //日期范围限制
            var addComplaintCreatedTime = {
                format: 'yyyy-MM-dd hh:mm:ss',
                min: laydate.now(), //设定最小日期为当前日期
                max: '2099-12-30 23:59:59', //最大日期
                istime: true,
                istoday: false,
                festival: true
            };

            var addReplyComplaintReplyTime = {
                format: 'yyyy-MM-dd hh:mm:ss',
                min: laydate.now(),
                max: '2099-12-30 23:59:59',
                istime: true,
                istoday: false,
                festival: true
            };

            document.getElementById('addComplaintCreatedTime').onclick = function () {
                addComplaintCreatedTime.elem = this;
                laydate(addComplaintCreatedTime);
            }

            document.getElementById('addReplyComplaintReplyTime').onclick = function () {
                addReplyComplaintReplyTime.elem = this;
                laydate(addReplyComplaintReplyTime);
            }


            var editComplaintReplyTime = {
                format: 'yyyy-MM-dd hh:mm:ss',
                max: '2099-12-30 23:59:59',
                istime: true,
                istoday: false,
            };

            document.getElementById('editComplaintReplyTime').onclick = function () {
                editComplaintReplyTime.elem = this;
                laydate(editComplaintReplyTime);
            }
        });
    });
</script>
</body>
</html>
