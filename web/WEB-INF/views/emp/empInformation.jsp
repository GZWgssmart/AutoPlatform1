<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%-- 地址选择器的css --%>
    <link href="/static/css/addressOption/address.css" type="text/css" rel="stylesheet">
    <link href="/static/css/addressOption/cityLayout.css" type="text/css" rel="stylesheet">

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/css/bootstrap-validate/bootstrapValidator.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet/less" href="/static/css/bootstrap-dateTimePicker/datetimepicker.less">

    <title>员工基本信息</title>
</head>
<body>
<%@include file="../backstage/contextmenu.jsp"%>

    <div class="container">
        <div class="panel-body" style="padding-bottom:0px;"  >
            <!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
            <!-- table里的所有属性在bootstrap-table.js的240行-->
            <table id="table" data-single-select="true">
                <thead>
                    <tr>
                        <th data-checkbox="true"></th>
                        <th data-field="userName">姓名</th>
                        <th data-field="userGender">性别</th>
                        <th data-field="role.roleName">用户角色</th>
                        <th data-field="company.companyName">所属公司</th>
                        <th data-field="userEmail">用户Email</th>
                        <th data-field="userAddress">地址</th>
                        <th data-field="userPhone">用户手机号</th>
                        <th data-field="userIdentity">身份证号</th>
                        <th data-field="userWeChat">微信</th>
                        <th data-field="userBirthday">生日</th>
                        <th data-field="userCreatedTime" data-formatter=formatterDateTime>创建时间</th>
                        <th data-field="userLoginedTime" data-formatter="formatterDateTime">最近一次登录时间</th>
                        <th data-field="userStatus" data-formatter="formatterStatus">用户状态</th>
                    </tr>
                </thead>
            </table>
            <div id="toolbar" class="btn-group">
                <button id="btn_add" type="button" class="btn btn-default" onclick="showAdd();">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
                </button>
                <button id="btn_edit" type="button" class="btn btn-default" onclick="showEdit();">
                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
                </button>
                <button id="btn_return" type="button" class="btn btn-default" onclick="showReturn();">
                    <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>辞退
                </button>
            </div>
        </div>
    </div>

    <!-- 添加弹窗 aria-hidden="true" 默认隐藏 data-backdrop="static" 点击模态窗底层不会关闭模态窗 -->
    <div class="modal fade" id="addWindow" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <form class="form-horizontal" role="form" id="addForm" method="post">
                    <div class="modal-header" style="overflow:auto;">
                        <p>添加人员信息</p>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">姓名：</label>
                        <div class="col-sm-7">
                            <input type="text" id="addUsername" name="userName" placeholder="请输入姓名" class="form-control userName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Email：</label>
                        <div class="col-sm-7">
                            <input type="email" id="addUserEmail" name="userEmail" placeholder="请输入邮箱" class="form-control userEmail">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">手机号码：</label>
                        <div class="col-sm-7">
                            <input type="number" id="addUserPhone" placeholder="手机号码为11位" class="form-control userPhone"
                                   aria-describedby="sizing-addon2" name="userPhone"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">角色：</label>
                        <div class="col-sm-7">
                            <select id="addUserRole" name="roleId" class="js-example-tags userRole" style="width: 100%;"></select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">身份证：</label>
                        <div class="col-sm-7">
                            <input type="number" id="addUserIdentity" name="userIdentity" placeholder="请输入身份证号" class="form-control userIdentity">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">性别：</label>
                        <div class="col-sm-7">
                            <select id="addUserGender" name="userGender" class="js-example-tags userGender" style="width: 50%;">
                                <option value="N">选择性别</option>
                                <option value="M">男</option>
                                <option VALUE="F">女</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">所属公司：</label>
                        <div class="col-sm-7">
                            <select id="addUserCompany" name="companyId" class="js-example-tags userCompany" style="width: 100%;"></select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">生日：</label>
                        <div class="col-sm-7">
                            <input id="addDatetimepicker" placeholder="请选择生日" readonly="true" type="text" name="userBirthday"
                                   class="form-control datetimepicker"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">用户描述：</label>
                        <div class="col-sm-7">
                            <input id="addUserDes" type="text" name="userDes" placeholder="请输入用户描述" class="form-control">
                        </div>
                    </div>
                    <%--<div class="form-group">--%>
                        <%--<label class="col-sm-3 control-label">地址：</label>--%>
                        <%--<div class="col-sm-7">--%>
                            <%--<input name="userAddress" id="start1" autocomplete="off" type="text" ov="请选择/输入城市名称"--%>
                                   <%--class="city_input inputFocus proCityQueryAll proCitySelAll">--%>
                        <%--</div>--%>
                    <%--</div>--%>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">地址：</label>
                        <div class="col-sm-7">
                            <input name="userAddress" id="addUserAddress" type="text" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">底薪：</label>
                        <div class="col-sm-7">
                            <input id="addUserSalary" type="number" name="userSalary" placeholder="请输入底薪" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">密码：</label>
                        <div class="col-sm-7">
                            <input type="password" id="addPassword" name="userPwd" placeholder="请输入密码" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">确定密码：</label>
                        <div class="col-sm-7">
                            <input type="password" id="addConfirm_password" name="confirm_password" placeholder="请确定密码" class="form-control">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <span id="addError"></span>
                        <button type="button" class="btn btn-default" data-dismiss="modal"> 关闭 </button>
                        <button id="addButton" onClick="addSubmit();" type="button" class="btn btn-sm btn-success">保存</button>
                    </div>
                </form>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <!-- 修改弹窗 -->
    <div class="modal fade" id="editWindow" style="overflow-y:scroll" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <form role="form" class="form-horizontal" id="editForm" method="post">
                    <div class="modal-header" style="overflow:auto;">
                        <p>修改人员信息</p>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">姓名：</label>
                        <div class="col-sm-7">
                            <input id="editUserName" type="text" name="userName" define="emp.userName" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Email：</label>
                        <div class="col-sm-7">
                            <input id="editUserEmail" type="email" name="userEmail" define="emp.userEmail" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label" >手机号码：</label>
                        <div class="col-sm-7">
                            <input id="editUserPhone" type="number" name="userPhone" define="emp.userPhone" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label" >身份证：</label>
                        <div class="col-sm-7">
                            <input id="editUserIdentity" type="number" name="userIdentity" define="emp.userIdentity" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">角色：</label>
                        <div class="col-sm-7">
                            <select id="editUserRole" name="roleId" define="emp.roleId" class="js-example-tags userRole" style="width: 100%;"></select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">性别：</label>
                        <div class="col-sm-7">
                            <select id="editUserGender" name="userGender" define="emp.userGender" class="js-example-tags userGender" style="width: 50%;">
                                <option value="N">未选择</option>
                                <option value="M">男</option>
                                <option value="F">女</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">生日：</label>
                        <div class="col-sm-7">
                            <input id="editDatetimepicker" readonly="true" type="text" name="emp.userBirthday"
                                   class="form-control datetimepicker"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">地址：</label>
                        <div class="col-sm-7">
                            <input type="text" id="editUserAddress" name="emp.userAddress" class="form-control userAddress">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">底薪：</label>
                        <div class="col-sm-7">
                            <input id="editUserSalary" type="number" name="emp.userSalary" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">所属公司：</label>
                        <div class="col-sm-7">
                            <select id="editUserCompany" name="companyId" class="js-example-tags userCompany" style="width: 100%;"></select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <span id="editError"></span>
                        <button type="button" class="btn btn-default" data-dismiss="modal"> 关闭 </button>
                        <button id="editButton" onclick="editSubmit();" type="submit" class="btn btn-primary btn-sm"> 保存 </button>
                    </div>
                </form>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <!-- 地址选择框 弹出省省市 -->
    <div class="provinceCityAll">
        <div class="tabs clearfix">
            <ul>
                <li><a href="javascript:" class="current" tb="hotCityAll">热门城市</a></li>
                <li><a href="javascript:" tb="provinceAll">省份</a></li>
                <li><a href="javascript:" tb="cityAll" id="cityAll">城市</a></li>
                <li><a href="javascript:" tb="countyAll" id="countyAll">区县</a></li>
            </ul>
        </div>
        <div class="con">
            <div class="hotCityAll invis">
                <div class="pre"><a></a></div>
                <div class="list">
                    <ul></ul>
                </div>
                <div class="next"><a class="can"></a></div>
            </div>
            <div class="provinceAll invis">
                <div class="pre"><a></a></div>
                <div class="list">
                    <ul></ul>
                </div>
                <div class="next"><a class="can"></a></div>
            </div>
            <div class="cityAll invis">
                <div class="pre"><a></a></div>
                <div class="list">
                    <ul></ul>
                </div>
                <div class="next"><a class="can"></a></div>
            </div>
            <div class="countyAll invis">
                <div class="pre"><a></a></div>
                <div class="list">
                    <ul></ul>
                </div>
                <div class="next"><a class="can"></a></div>
            </div>
        </div>
    </div>

    <!-- 删除弹窗 -->
    <div class="modal fade" id="del" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <form action="/table/edit" method="post">
                <div class="modal-content">
                    <input type="hidden" id="delNoticeId"/>
                    <div class="modal-footer" style="text-align: center;">
                        <h2>确认删除吗?</h2>
                        <button type="button" class="btn btn-default"
                                data-dismiss="modal">关闭
                        </button>
                        <button type="sumbit" class="btn btn-primary" onclick="del()">
                            确认
                        </button>
                    </div>
                </div><!-- /.modal-content -->
            </form>
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <%-- 地址选择框用到的js --%>
    <script type="text/javascript" src="/static/js/backstage/emp/addressOption/jquery-1.6.2.min.js"></script>

    <script src="/static/js/jquery.min.js"></script>
    <script src="/static/js/bootstrap.min.js"></script>
    <script src="/static/js/bootstrap-table/bootstrap-table.js"></script>
    <script src="/static/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
    <script src="/static/js/jquery.formFill.js"></script>
    <script src="/static/js/select2/select2.js"></script>
    <script src="/static/js/sweetalert/sweetalert.min.js"></script>
    <script src="/static/js/contextmenu.js"></script>
    <script src="/static/js/backstage/main.js"></script>
    <script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
    <script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
    <script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
    <script src="/static/js/backstage/emp/empInFormation.js"></script>

    <%-- 地址选择框用到的js --%>
    <script type="text/javascript" src="/static/js/backstage/emp/addressOption/public.js"></script>

</body>
<script>
    function formatterDateTime(ele, row,index) {
        return new Date(ele).toLocaleString();
    }

    function formatterStatus(value) {
        if(value == 'Y') {
            return "<i class='glyphicon glyphicon-ok-circle' style='color: #4ceaea'></i>";
        } else if (value == 'N') {
            return "<i class='glyphicon glyphicon-ban-circle' style='color: red'></i>";
        }
    }
</script>
</html>
