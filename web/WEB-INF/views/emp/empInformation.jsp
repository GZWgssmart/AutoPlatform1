<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
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

    <link rel="stylesheet" href="/static/css/fileinput.css">

    <title>员工基本信息</title>

    <style>
        fieldset {
            margin: 1em 0;
        }

        fieldset legend {
            font: bold 14px/2 "\5fae\8f6f\96c5\9ed1";
        }

        /* 给添加窗口的select2设置宽度*/
        .addWindow .editUserRole .form-group {
            width: 690px;
        }

        /* 让显示详细信息的窗口中的所有Input都不显示边框 */
        #detailWindow input {
            border:0px;
        }
        .form-right .form-group{
            padding-top:10px;
            padding-left: 25%;
        }
        #detailWindow .form-group input{
            width: 200px;
        }
        .form-group label{
            padding:0;
        }
        .form-left{
            padding-top:20px;
        }

        #detailForm .form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control {
            background: #fff;
        }
        #detailForm .form-control {
            box-shadow: none;
        }
    </style>

</head>
<body>
<%@include file="../backstage/contextmenu.jsp" %>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;">
        <!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table" data-single-select="true">
            <thead>
            <tr>
                <th data-checkbox="true"></th>
                <th data-field="userName">姓名</th>
                <th data-field="userGender" data-formatter="formatterGender">性别</th>
                <th data-formatter="formatterRole">用户角色</th>
                <th data-field="company" data-formatter="companyFormatter">所属公司</th>
                <th data-field="userEmail">用户Email</th>
                <th data-field="userPhone">用户手机号</th>
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
            <button id="searchDisable" type="button" class="btn btn-danger" onclick="searchDisableStatus();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询已禁用/辞退的记录
            </button>
            <button id="searchRapid" type="button" class="btn btn-success" onclick="searchRapidStatus();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询可用记录
            </button>
        </div>
    </div>
</div>

<!-- 添加弹窗 aria-hidden="true" 默认隐藏 data-backdrop="static" 点击模态窗底层不会关闭模态窗 -->
<div class="modal fade" id="addWindow" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog" style="width:900px;">
        <div class="modal-content">
            <div class="modal-body">
                <div class="modal-header" style="overflow:auto;">
                    <h3>添加人员信息</h3>
                </div>
                <form class="form-horizontal" role="form" id="addForm" method="post" enctype="multipart/form-data">
                    <div class="col-md-7">
                        <div class="form-group">
                            <label class="col-md-3 control-label">用户头像：</label>
                            <div class="col-md-9" style="margin-left: 30px;">
                                <div class="input-group">   <%-- FileInput边框和组件组在一起 --%>
                                    <div class="input-group-btn"></div> <%-- 用来显示选中的图片 --%>
                                    <input id="file" name="userIconTemp" type="file" class="form-control file-loading"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="form-group">
                            <label class="col-md-3 control-label">姓名：</label>
                            <div class="col-md-9">
                                <input type="text" id="addUsername" name="userName" placeholder="请输入姓名"
                                   class="form-control userName">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">性别：</label>
                            <div class="col-md-9">
                                <select id="addUserGender" name="userGender"
                                        class="js-example-tags form-control userGender">
                                    <option value="N">请选择性别</option>
                                    <option value="M">男</option>
                                    <option VALUE="F">女</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Email：</label>
                            <div class="col-md-9">
                                <input type="email" name="userEmail" placeholder="请输入邮箱"
                                       class="form-control userEmail">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">电话：</label>
                            <div class="col-md-9">
                                <input type="number" id="addUserPhone" placeholder="手机号码为11位"
                                       class="form-control userPhone" maxlength="11"
                                       aria-describedby="sizing-addon2" name="userPhone"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">生日：</label>
                            <div class="col-md-9">
                                <input id="addDatetimepicker" placeholder="请选择生日" readonly="true" type="text"
                                       name="userBirthday" class="form-control datetimepicker"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">底薪：</label>
                            <div class="col-md-9">
                                <input id="addUserSalary" type="number" min="0" name="userSalary"
                                       placeholder="请输入底薪" class="form-control">
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="form-group col-md-6">
                            <label class="col-md-4 control-label">身份证：</label>
                            <div class="col-md-8">
                                <input type="number" id="addUserIdentity" name="userIdentity" maxlength="18"
                                       placeholder="请输入身份证号" class="form-control userIdentity">
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label class="col-md-4 control-label">用户描述：</label>
                            <div class="col-md-8">
                                <textarea id="addUserDes" class="form-control" name="userDes" placeholder="请输入用户描述"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-md-12">
                        <label class="col-md-2 control-label">角色：</label>
                        <div class="col-md-10" style="border:solid 1px red;">
                            <select class="js-example-basic-multiple js-states form-control userRole"
                                id="addUserRole" name="roleId" multiple="multiple"></select>    <%-- js-example-basic-multiple --%>
                        </div>
                    </div>
                    <div class="form-group col-md-12">
                        <label class="col-md-2 control-label" style="top: 9px;right:5px">家庭住址：</label>
                        <div class="col-md-10">
                            <fieldset id="city_china">
                                <div class="form-group col-md-4">
                                    <select class="province js-example-tags form-control" disabled="disabled" name="province"></select>
                                </div>
                                <div class="form-group col-md-4">
                                    <select class="city js-example-tags form-control" disabled="disabled" name="city"></select>
                                </div>
                                <div class="form-group col-md-4">
                                    <select class="area js-example-tags form-control" disabled="disabled" name="area"></select>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                    <p class="clearfix"></p>
                    <div class="modal-footer">
                        <span id="addError"></span>
                        <button type="button" class="btn btn-default" data-dismiss="modal"> 关闭</button>
                        <button id="addButton" onClick="addSubmit();" type="button" class="btn btn-sm btn-success">保存
                        </button>
                    </div>
                </form>
            </div><!-- /.modal-body -->
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
                        <label class="col-md-4 control-label">手机号码：</label>
                        <div class="col-md-8">
                            <input type="number" name="userPhone" define="emp.userPhone" class="form-control">
                        </div>
                    </div>
                    <div class="form-group col-md-6 pull-left">
                        <label class="col-md-4 control-label">身份证：</label>
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
                            <select id="editUserRole" name="roleId" define="emp.role.roleId"
                                class="js-example-basic-multiple userRole" multiple="multiple"
                                style="width: 100%;"></select>
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
                            <input id="editDatetimepicker" readonly="true" type="date" define="emp.userBirthday"
                               name="userBirthdayTemp" class="form-control datetimepicker">
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
                        <label class="col-md-4 control-label">昵称：</label>
                        <div class="col-md-8">
                            <input type="text" name="userNickName" define="emp.userNickName" class="form-control">
                        </div>
                    </div>
                    <p class="clearfix"></p>
                </div>
                <div>
                    <div class="form-group col-md-12 pull-right">
                        <label class="col-md-2 control-label" style="top: 9px;right:5px">地址：</label>
                        <div class="col-md-9" id="address" style="margin-top: 10px;display: block;">
                            <input type="text" define="emp.userAddress" class="form-control">
                        </div>
                        <div class="col-md-9" id="userAddress" style="display: none;">
                            <fieldset id="editCity_china">
                                <div class="pull-left">
                                    省份：<select class="province" disabled="disabled" id="editProvince" name="editProvince"></select>
                                </div>
                                <div class="pull-left">
                                    &nbsp;&nbsp;&nbsp;城市：<select class="city" disabled="disabled"
                                        id="editCity" name="editCity"></select>
                                </div>
                                <div class="pull-left">
                                    &nbsp;&nbsp;&nbsp;地区：<select class="area" disabled="disabled"
                                        id="editArea" name="editArea"></select>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <span id="editError"></span>
                    <button type="button" class="btn btn-default" data-dismiss="modal"> 关闭</button>
                    <button id="editButton" onclick="editSubmit();" type="submit" class="btn btn-primary btn-sm">
                        保存
                    </button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 详细信息弹窗 -->
<div class="modal fade" id="detailWindow" style="overflow-y:scroll" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content" style="width:850px; margin-left:-121px;">
            <div class="modal-header">
                <h3>详细信息</h3>
            </div>
            <form role="form" class="form-horizontal" id="detailForm" method="post">
                <div class="row">
                    <div class="form-right col-md-7">
                        <div class="form-group">
                            <img id="detailUserIcon" src="" class="img-circle" style="width:180px;height:180px;">
                        </div>
                        <div class="form-group pull-left">
                            <label class=" control-label">姓名：</label>
                            <input type="text" name="userName" define="emp.userName" class="form-control"
                               style="margin-left: 30px;" disabled="true"> <%-- &lt;%&ndash;&lt;%&ndash;此果文字会变成灰色，不可编辑。&ndash;%&gt;&ndash;%&gt;--%>
                        </div>
                        <div class="form-group pull-left">
                            <label class="control-label">Email：</label>
                            <input style="margin-left: 20px;" type="text" define="emp.userEmail" class="form-control" disabled="true">
                        </div>
                        <div class="form-group pull-left">
                            <label class="control-label">手机号码：</label>
                            <input type="number" define="emp.userPhone" class="form-control" disabled="true">
                        </div>
                        <div class="form-group pull-left">
                            <label class="control-label">身份证：</label>
                            <input style="margin-left: 10px;" type="number" class="form-control"
                               define="emp.userIdentity" disabled="true">
                        </div>
                        <div class="form-group pull-left">
                            <label class="control-label">创建时间：</label>
                            <input id="detailCreatedTime" type="text" class="form-control" disabled="true">
                        </div>
                    </div>
                    <div class="form-left col-md-5">
                        <div class="form-group pull-left">
                            <label class="control-label">角色：</label>
                            <input define="emp.role.roleName" class="form-control" type="text" disabled="true"
                               style="margin-left: 30px;">
                        </div>
                        <div class="form-group pull-left">
                            <label class=control-label">用户描述：</label>
                            <input type="text" disabled="true" define="emp.userDes" class="form-control">
                        </div>
                        <div class="form-group pull-left">
                            <label class="control-label">性别：</label>
                            <input id="detailGender" type="text" class="form-control"
                                 disabled="true" style="margin-left: 30px;">
                        </div>
                        <div class="form-group pull-left">
                            <label class="control-label">生日：</label>
                            <input id="detailBirthday" type="date" define="emp.userBirthday"
                               class="form-control" disabled="true" style="margin-left: 30px;">
                        </div>
                        <div class="form-group pull-left">
                            <label class="control-label">底薪：</label>
                            <input type="number" define="emp.userSalary" name="userSalary" class="form-control"
                               style="margin-left: 30px;" disabled="true">
                        </div>
                        <div class="form-group pull-left">
                            <label class=" control-label">昵称：</label>
                            <input type="text" define="emp.userNickName" class="form-control" disabled="true" style="margin-left: 30px;">
                        </div>
                        <p class="clearfix"></p>
                        <div class="form-group pull-left">
                            <label class="control-label">所属公司：</label>
                            <input define="emp.companyId" class="form-control" disabled="true">
                        </div>
                        <div class="form-group pull-left">
                            <label class="control-label" >地址：</label>
                            <input type="text" define="emp.userAddress" class="form-control" disabled="true" style="margin-left: 20px;">
                        </div>
                        <div class="form-group pull-left">
                            <label class="control-label">  上一次登录时间：</label>
                            <input id="detailLoginTime" type="text" class="form-control" disabled="true">
                        </div>
                        <p class="clearfix"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal"> 关闭</button>
                    </div>
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
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        关闭
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
<%-- 文件上传 --%>
<script src="/static/js/fileInput/fileinput.js"></script>
<script src="/static/js/fileInput/zh.js"></script>

</body>
<script>

    $(".js-example-basic-multiple").select2({
        allowClear: true
    });

    $(function () {
        //0.初始化fileinput
        var oFileInput = new FileInput();
        oFileInput.Init("file", "/userBasicManage/addFile");
    });

    //初始化fileinput
    var FileInput = function () {
        var oFile = new Object();
        //初始化fileinput控件（第一次初始化）
        oFile.Init = function (ctrlName, uploadUrl) {
            var control = $('#' + ctrlName);
            //初始化上传控件的样式
            control.fileinput({
                language: 'zh', //设置语言
                uploadUrl: uploadUrl, //上传的地址
                allowedFileExtensions: ['jpg', 'gif', 'png'],//接收的文件后缀
                showUpload: true, //是否显示上传按钮
                showCaption: false,//是否显示标题
                browseClass: "btn btn-primary", //按钮样式
                dropZoneEnabled: true,//是否显示拖拽区域
                minImageWidth: 50, //图片的最小宽度
                minImageHeight: 50,//图片的最小高度
//                maxImageWidth: 350,//图片的最大宽度
//                maxImageHeight: 350,//图片的最大高度
                maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
                maxFileCount: 1, //表示允许同时上传的最大文件个数
                enctype: 'multipart/form-data',
                validateInitialCount: true,
                previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
                msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
            }).on("fileuploaded", function (event, data) {
                // data 为controller返回的json
                var resp= data.response;
                if (resp.controllerResult.result == 'success') {
                    $("#file").val(resp.imgPath)
                    alert('处理成功');
                } else {
                    alert("上传失败")
                }
            });
        }
        return oFile;
    };

//    格式化角色
    function formatterRole(value, row, index) {
        if(row.role != null && row.role!=""){
            var roles = null;
            $.each(row.role, function(index, value, item) {
                if(roles == "" ||roles == null){
                    roles = row.role.roleName;
                } else if(roles != row.role.roleName) {
                    roles += "," + row.role.roleName;
                }
            });
            return roles;
        }else{
            return "-"
        }
    }

//    function formatterDateTime(ele, row, index) {
//        return new Date(ele).toLocaleString();
//    }

//   格式化性别
    function formatterGender(val) {
        if (val == 'N') {
            return "未选择";
        } else if (val == 'M') {
            return "男"
        } else if (val == 'F') {
            return "女"
        }
    }

    // 激活或禁用
    function formatterStatus(value, row, index) {
        if (value == 'Y') {
            if(row.role.roleName == '车主') {
                return "&nbsp;<button type='button' class='btn btn-danger' " +
                    "onclick='inactive(\"" + '/userBasicManage/updateStatus?id=' + row.userId + '&status=Y' + "\")'>禁用</button>&nbsp;&nbsp;"
                + "<a onclick='showDetail()' class='btn btn-info btn-sm'><span class='glyphicon glyphicon-fullscreen'></span>详细信息</a>";
            }
            return "&nbsp;<button type='button' class='btn btn-danger' " +
                "onclick='inactive(\"" + '/userBasicManage/updateStatus?id=' + row.userId + '&status=Y' + "\")'>辞退</button>&nbsp;&nbsp;"
            + "<a onclick='showDetail()' class='btn btn-info btn-sm'><span class='glyphicon glyphicon-fullscreen'></span>详细信息</a>";
        } else {
            if(row.role.roleName == '车主') {
                return "&nbsp;<button type='button' class='btn btn-success' " +
                    "onclick='active(\"" + '/userBasicManage/updateStatus?id=' + row.userId + '&status=N' + "\")'>激活</button>&nbsp;&nbsp;"
                + "<a onclick='showDetail()' class='btn btn-info btn-sm'><span class='glyphicon glyphicon-fullscreen'></span>详细信息</a>";
            }
        }
    }

    var contentPath = ''
    var roles = "系统超级管理员,系统普通管理员,汽修公司管理员,汽修公司接待员";

//  查询不可用的
    function searchDisableStatus() {
        $.post(contentPath + "/user/isLogin/" + roles, function (data) {
            if (data.result == "success") {
                initTable('table', '/userBasicManage/queryByPagerDisable');
            } else if (data.result == "notLogin") {
                swal({
                    text: data.message,
                    confirmButtonText: "确认", // 提示按钮上的文本
                    type: "error"
                }, function (isConfirm) {
                    if (isConfirm) {
                        top.location = "/user/loginPage";
                    } else {
                        top.location = "/user/loginPage";
                    }
                })
            } else if (data.result = "notRole") {
                swal({
                    text: data.message,
                    confirmButtonText: "确认", // 提示按钮上的文本
                    type: "error"
                })
            }
        })
    }

//  查询可用的
    function searchRapidStatus() {
        $.post(contentPath + "/user/isLogin/" + roles, function (data) {
            if (data.result == "success") {
                initTable('table', '/userBasicManage/queryByPager');
            } else if (data.result == "notLogin") {
                swal({
                    text: data.message,
                    confirmButtonText: "确认", // 提示按钮上的文本
                    type: "error"
                }, function (isConfirm) {
                    if (isConfirm) {
                        top.location = "/user/loginPage";
                    } else {
                        top.location = "/user/loginPage";
                    }
                })
            } else if (data.result = "notRole") {
                swal({
                    text: data.message,
                    confirmButtonText: "确认", // 提示按钮上的文本
                    type: "error"
                })
            }
        })
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

    function companyFormatter(el,row,index){
        if(el!=null) {
            return el.companyName;
        }
        return "汽修公司"
    }

//  修改时，点击地址的文本框后，文本框隐藏，地址下拉选择显示
    var address = $("#address");
    address.click(function () {
        address.css('display', 'none');
        $('#userAddress').css('display', 'block');
    })

</script>
</html>
