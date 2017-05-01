<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getContextPath(); %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="/static/jsp/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="/static/jsp/animate.css" rel="stylesheet">

    <link href="/static/jsp/style.css?v=4.1.0" rel="stylesheet">

    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/css/bootstrap-validate/bootstrapValidator.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet/less" href="/static/css/bootstrap-dateTimePicker/datetimepicker.less">

    <title>员工基本信息</title>

    <style>
        fieldset {
            margin: 1em 0;
        }

        fieldset legend {
            font: bold 14px/2 "\5fae\8f6f\96c5\9ed1";
        }
    </style>

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
                        <th data-field="userGender" data-formatter="formatterGender">性别</th>
                        <th data-field="role.roleName">用户角色</th>
                        <th data-field="company.companyName">所属公司</th>
                        <th data-field="userEmail">用户Email</th>
                        <th data-field="userAddress">地址</th>
                        <th data-field="userPhone">用户手机号</th>
                        <th data-field="userIdentity">身份证号</th>
                        <th data-field="userWeChat">微信</th>
                        <th data-field="userBirthday" data-formatter="formatterDate">生日</th>
                        <th data-field="userCreatedTime" data-formatter=formatterDateTime>创建时间</th>
                        <th data-field="userLoginedTime" data-formatter="formatterDateTime">最近一次登录时间</th>
                        <th data-field="userStatus" data-formatter="formatterStatus">操作</th>
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
            <div class="modal-content" style="width:900px; margin-left:-200px;">
                <form class="form-horizontal" role="form" id="addForm" method="post">
                    <div class="modal-header" style="overflow:auto;">
                        <h3>添加人员信息</h3>
                    </div>
                    <div style="margin-left: auto;width:90%;margin-left:auto;margin-right:auto">
                        <div class="wrapper wrapper-content">
                            <div class="row">
                                <div class="col-sm-6" style="height:500px;">
                                    <div class="ibox float-e-margins">
                                        <div class="ibox-content">
                                            <ul class="nav nav-tabs" id="avatar-tab">
                                                <li class="active" id="upload"><a href="javascript:;">本地上传</a></li>
                                                <li id="webcam"><a href="javascript:;">视频拍照</a></li>
                                            </ul>
                                            <div class="m-t m-b">
                                                <div id="flash1">
                                                    <p id="swf1">本组件需要安装Flash Player后才可使用，请从
                                                        <a href="http://www.adobe.com/go/getflashplayer">这里</a>下载安装。
                                                    </p>
                                                </div>
                                                <div id="editorPanelButtons" style="display:none">
                                                    <p class="m-t">
                                                        <label class="checkbox-inline">
                                                            <input type="checkbox" id="src_upload">是否上传原图片？</label>
                                                    </p>
                                                    <p>
                                                        <a href="javascript:;"  class="btn btn-w-m btn-primary button_upload">
                                                            <i class="fa fa-upload"></i> 上传</a>
                                                        <a href="javascript:;"
                                                           class="btn btn-w-m btn-info button_cancel">取消</a>
                                                    </p>
                                                </div>
                                                <p id="webcamPanelButton" style="display:none">
                                                    <a href="javascript:;" class="btn btn-w-m btn-info button_shutter">
                                                        <i class="fa fa-camera"></i> 拍照</a>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div>
                                    <div class="form-group col-md-6 pull-left">
                                        <label class="col-md-4 control-label">姓名：</label>
                                        <div class="col-md-8" >
                                            <input type="text" id="addUsername" name="userName" placeholder="请输入姓名" class="form-control userName">
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6 pull-left">
                                        <label class="col-md-4 control-label">Email：</label>
                                        <div class="col-md-8">
                                            <input type="email" name="userEmail" placeholder="请输入邮箱" class="form-control userEmail">
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6 pull-left">
                                        <label class="col-md-4 control-label">手机号码：</label>
                                        <div class="col-md-8">
                                            <input type="number" id="addUserPhone" placeholder="手机号码为11位" class="form-control userPhone"
                                                   aria-describedby="sizing-addon2" name="userPhone"/>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6 pull-left">
                                        <label class="col-md-4 control-label">角色：</label>
                                        <div class="col-md-8">
                                            <select id="addUserRole" name="roleId" class="js-example-tags userRole" style="width: 100%;"></select>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6 pull-left">
                                        <label class="col-md-4 control-label">身份证：</label>
                                        <div class="col-md-8">
                                            <input type="number" id="addUserIdentity" name="userIdentity" placeholder="请输入身份证号" class="form-control userIdentity">
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6 pull-left">
                                        <label class="col-md-4 control-label">性别：</label>
                                        <div class="col-md-8">
                                            <select id="addUserGender" name="userGender" class="js-example-tags userGender" style="width: 50%;">
                                                <option value="N">选择性别</option>
                                                <option value="M">男</option>
                                                <option VALUE="F">女</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6 pull-left">
                                        <label class="col-md-4 control-label">所属公司：</label>
                                        <div class="col-md-8">
                                            <select id="addUserCompany" name="companyId" class="js-example-tags userCompany" style="width: 100%;"></select>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6 pull-left">
                                        <label class="col-md-4 control-label">用户描述：</label>
                                        <div class="col-md-8">
                                            <input id="addUserDes" type="text" name="userDes" placeholder="请输入用户描述" class="form-control">
                                        </div>
                                    </div>
                                    <p class="clearfix"></p>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div class="form-group col-md-12 pull-right">
                                <label class="col-md-2 control-label" style="top: 9px;right:5px">地址：</label>
                                <div class="col-md-9">
                                    <fieldset id="city_china">
                                        <div class="pull-left">省份：<select class="province" disabled="disabled" name="province" style="width:75px;"></select></div>
                                        <div class="pull-left">&nbsp;&nbsp;&nbsp;城市：<select class="city" disabled="disabled" name="city"></select></div>
                                        <div class="pull-left">&nbsp;&nbsp;&nbsp;地区：<select class="area" disabled="disabled" name="area"></select></div>
                                    </fieldset>
                                </div>
                            </div>
                            <p class="clearfix"></p>
                        </div>
                        <div>
                            <div class="form-group col-md-6 pull-left">
                                <label class="col-md-4 control-label">生日：</label>
                                <div class="col-md-8">
                                    <input id="addDatetimepicker" placeholder="请选择生日" readonly="true" type="text" name="userBirthday"
                                           class="form-control datetimepicker"/>
                                </div>
                            </div>
                            <div class="form-group col-md-6 pull-left">
                                <label class="col-md-4 control-label">底薪：</label>
                                <div class="col-md-8">
                                    <input id="addUserSalary" type="number" min="0" name="userSalary" placeholder="请输入底薪" class="form-control">
                                </div>
                            </div>
                            <p class="clearfix"></p>
                        </div>
                        <div>
                            <div>
                                <div class="form-group col-md-6 pull-left">
                                    <label class="col-md-4 control-label">密码：</label>
                                    <div class="col-md-8">
                                        <input type="password" id="addPassword" name="userPwd" placeholder="请输入密码" class="form-control">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-md-6 pull-left">
                                <label class="col-md-4 control-label">确定密码：</label>
                                <div class="col-md-8">
                                    <input type="password" id="addConfirm_password" name="confirm_password" placeholder="请确定密码" class="form-control">
                                </div>
                            </div>
                            <p class="clearfix"></p>
                        </div>
                        <div class="modal-footer">
                            <span id="addError"></span>
                            <button type="button" class="btn btn-default" data-dismiss="modal"> 关闭 </button>
                            <button id="addButton" onClick="addSubmit();" type="button" class="btn btn-sm btn-success">保存</button>
                        </div>
                    </div>
                </form>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <!-- 修改弹窗 -->
    <div class="modal fade" id="editWindow" style="overflow-y:scroll" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content" style="width:900px; margin-left:-200px;">
                <form role="form" class="form-horizontal" id="editForm" method="post">
                    <div class="modal-header" style="overflow:auto;">
                        <h3>修改人员信息</h3>
                    </div>
                    <input type="hidden" define="emp.userId" name="userId" class="form-control"/>
                    <div>
                        <div class="form-group col-md-6 pull-left">
                            <label class="col-md-4 control-label">姓名：</label>
                            <div class="col-md-8">
                                <input type="text" name="userName" define="emp.userName" class="form-control">
                            </div>
                        </div>
                        <div class="form-group col-md-6 pull-left">
                            <label class="col-md-4 control-label">Email：</label>
                            <div class="col-md-8">
                                <input type="text" name="userEmail" define="emp.userEmail" class="form-control">
                            </div>
                        </div>
                        <p class="clearfix"></p>
                    </div>
                    <div>
                        <div class="form-group col-md-6 pull-left">
                            <label class="col-md-4 control-label" >手机号码：</label>
                            <div class="col-md-8">
                                <input type="number" name="userPhone" define="emp.userPhone" class="form-control">
                            </div>
                        </div>
                        <div class="form-group col-md-6 pull-left">
                            <label class="col-md-4 control-label" >身份证：</label>
                            <div class="col-md-8">
                                <input type="number" name="userIdentity" define="emp.userIdentity" class="form-control">
                            </div>
                        </div>
                        <p class="clearfix"></p>
                    </div>
                    <div>
                        <div class="form-group col-md-6 pull-left">
                            <label class="col-md-4 control-label">角色：</label>
                            <div class="col-md-8">
                                <select id="editUserRole" name="roleId" define="emp.roleId" class="form-control userRole" style="width: 100%;"></select>
                            </div>
                        </div>
                        <div class="form-group col-md-6 pull-left">
                            <label class="col-md-4 control-label">用户描述：</label>
                            <div class="col-md-8">
                                <input type="text" name="userDes" define="emp.userDes" class="form-control">
                            </div>
                        </div>
                        <p class="clearfix"></p>
                    </div>
                    <div>
                        <div class="form-group col-md-6 pull-left">
                            <label class="col-md-4 control-label">性别：</label>
                            <div class="col-md-8">
                                <select name="userGender" define="emp.userGender" class="form-control" style="width: 50%;">
                                    <option value='N'>未选择</option>
                                    <option value='M'>男</option>
                                    <option value='F'>女</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-6 pull-left">
                            <label class="col-md-4 control-label">生日：</label>
                            <div class="col-md-8">
                                <input id="editDatetimepicker" readonly="true" type="text" define="emp.userBirthday" name="userBirthday"
                                       class="form-control datetimepicker"/>
                            </div>
                        </div>
                        <p class="clearfix"></p>
                    </div>
                    <div>
                        <div class="form-group col-md-6 pull-left">
                            <label class="col-md-4 control-label">底薪：</label>
                            <div class="col-md-8">
                                <input type="number" define="emp.userSalary" name="userSalary" class="form-control">
                            </div>
                        </div>
                        <div class="form-group col-md-6 pull-left">
                            <label class="col-md-4 control-label">所属公司：</label>
                            <div class="col-md-8">
                                <select id="editUserCompany" name="companyId" define="emp.companyId" class="form-control userCompany" style="width: 100%;"></select>
                            </div>
                        </div>
                        <p class="clearfix"></p>
                    </div>
                    <div>
                        <div class="form-group col-md-12 pull-right">
                            <label class="col-md-2 control-label" style="top: 9px;right:5px">地址：</label>
                            <div class="col-md-9">
                                <fieldset id="editCity_china">
                                    <div class="pull-left">
                                        省份：<select class="province" disabled="disabled" name="editProvince"></select>
                                    </div>
                                    <div class="pull-left">
                                        &nbsp;&nbsp;&nbsp;城市：<select class="city" disabled="disabled" name="editCity"></select>
                                    </div>
                                    <div class="pull-left">
                                        &nbsp;&nbsp;&nbsp;地区：<select class="area" disabled="disabled" name="editArea"></select>
                                    </div>
                                </fieldset>
                            </div>
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


    <script src="/static/js/jquery.min.js"></script>
    <script src="/static/js/bootstrap.min.js"></script>
    <script src="/static/js/backstage/emp/jquery-ui.js"></script>
    <script src="/static/js/backstage/emp/jquery.formFillTemp.js"></script>
    <script src="/static/js/bootstrap-table/bootstrap-table.js"></script>
    <script src="/static/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
    <script src="/static/js/select2/select2.js"></script>
    <script src="/static/js/sweetalert/sweetalert.min.js"></script>
    <script src="/static/js/contextmenu.js"></script>
    <script src="/static/js/backstage/main.js"></script>
    <script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
    <script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
    <script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
    <script src="/static/js/backstage/emp/empInFormation.js"></script>

    <%-- 地址选择 --%>
    <script src="/static/js/jquery.cxselect.min.js"></script>

    <!-- 自定义js -->
    <script src="/static/jsp/content.js?v=1.0.0"></script>

    <script type="text/javascript" src="/static/scripts/swfobject.js"></script>
    <script type="text/javascript" src="/static/scripts/fullAvatarEditor.js"></script>
    <script type="text/javascript" src="/static/scripts/jQuery.Cookie.js"></script>
    <script type="text/javascript" src="/static/scripts/test.js"></script>

</body>
<script>
    function formatterGender(val) {
        if(val == 'N') {
            return "未选择";
        } else if(val == 'M') {
            return "男"
        } else if(val == 'F') {
            return "女"
        }
    }

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

    $.cxSelect.defaults.url = '/static/js/cityData.json';
    $('#city_china').cxSelect({
        selects: ['province', 'city', 'area']
    });
    $('#editCity_china').cxSelect({
        selects: ['province', 'city', 'area']
    });
    $('#city_china_val').cxSelect({
        selects: ['province', 'city', 'area'],
        nodata: 'none'
    });

    swfobject.addDomLoadEvent(function () {
        var swf = new fullAvatarEditor("swfContainer", {
            id: 'swf',
            upload_url: '/static/jsp/upload.jsp',
            src_upload: 2
        }, function (msg) {
            switch (msg.code) {
                case 1 :
                    alert("页面成功加载了组件！");
                    break;
                case 2 :
                    alert("已成功加载默认指定的图片到编辑面板。");
                    break;
                case 3 :
                    if (msg.type == 0) {
                        alert("摄像头已准备就绪且用户已允许使用。");
                    }
                    else if (msg.type == 1) {
                        alert("摄像头已准备就绪但用户未允许使用！");
                    }
                    else {
                        alert("摄像头被占用！");
                    }
                    break;
                case 5 :
                    if (msg.type == 0) {
                        if (msg.contentsourceUrl) {
                            alert("原图已成功保存至服务器，url为：\n" + msg.content.sourceUrl);
                        }
                        alert("头像已成功保存至服务器，url为：\n" + msg.content.avatarUrls.join("\n"));
                    }
                    break;
            }
        });
        document.getElementById("upload").onclick = function () {
            swf.call("upload");
        };
    });

</script>
</html>
