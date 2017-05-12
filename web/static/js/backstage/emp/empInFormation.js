var contentPath = ''
var roles = "系统超级管理员,系统普通管理员,汽修公司管理员,汽修公司接待员";

$(function () {
    $.post(contentPath + "/user/isLogin/" + roles, function (data) {
        if (data.result == "success") {
            initTable('table', '/userBasicManage/queryByPagerAll'); // 初始化表格

            // 初始化select2, 第一个参数是class的名字, 第二个参数是select2的提示语, 第三个参数是select2的查询url
            initSelect2("userRole", "请选择角色", "/role/role2CheckBox");
            initSelect2("userCompany", "请选择所属公司", "/company/queryAllCompany");
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
        } else if (data.result == "notRole") {
            swal({
                text: data.message,
                confirmButtonText: "确认", // 提示按钮上的文本
                type: "error"
            })
        }
    })
});

function showAdd(){
    $.post(contentPath + "/user/isLogin/" + roles, function (data) {
        if (data.result == "success") {
            initDatePicker('addForm', 'userBirthday'); // 初始化时间框, 第一参数是form表单id, 第二参数是input的name
            $("#addWindow").modal('show');
            $("#addButton").removeAttr("disabled");
            $("#addUserRole").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
            validator('addForm'); // 初始化验证
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
        } else if (data.result == "notRole") {
            swal({
                text: data.message,
                confirmButtonText: "确认", // 提示按钮上的文本
                type: "error"
            })
        }
    })
}

function validator(formId) {
    $('#' + formId).bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            userName: {
                message: '用户名验证失败',
                validators: {
                    notEmpty: {
                        message: '用户名不能为空'
                    },
                    stringLength: {
                        min: 1,
                        max: 10,
                        message: '用户名长度必须在1到10位之间'
                    }
                }
            },
            userEmail: {
                message: '邮箱验证失败',
                validators: {
                    notEmpty: {
                        message: '邮箱不能为空'
                    }
                }
            },
            userIdentity: {
                message: '身份证验证失败',
                validators: {
                    notEmpty: {
                        message: '身份证不能为空'
                    },
                    stringLength: {
                        min:18,
                        max: 18,
                        message: '身份证长度为18位'
                    }
                }
            },
            userPhone: {
                message: '手机号验证失败',
                validators: {
                    notEmpty: {
                        message: '用户手机号码不能为空'
                    },
                    stringLength: {
                        min: 11,
                        max: 11,
                        message: '手机号码必须为11位'
                    },
                    regexp: {
                        regexp: /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/,
                        message: '请输入正确的手机号'
                    }
                }
            },
            userSalary: {
                message: '底薪验证失败',
                validators: {
                    notEmpty: {
                        message: '底薪不能为空'
                    }
                }
            },
            userBirthday:{
                message: '生日验证失败',
                validators: {
                    notEmpty: {
                        message: '生日不能为空'
                    }
                }
            },
            roleId: {
                message: '角色验证失败',
                validators: {
                    notEmpty: {
                        message: '员工角色不能为空'
                    }
                }
            },
            userPwd: {
                message: '密码验证失败',
                validators: {
                    notEmpty: {
                        message: '密码不能为空'
                    }
                }
            },
            confirm_password: {
                message: '确认密码失败',
                validators: {
                    notEmpty: {
                        message: '确认密码不能为空'
                    },
                    identical: {
                        field: 'userPwd',
                        message: '*两次输入密码不一致'
                    }
                }
            }
        }
    })
    .on('success.form.bv', function (e) {
        if (formId == "addForm") {
            formSubmit("/userBasicManage/addUser", formId, "addWindow");
        } else if (formId == "editForm") {
            formSubmit("/userBasicManage/updateUser", formId, "editWindow");
        }
    })
}

function formSubmit(url, formId, winId) {
    $.post(contentPath + "/user/isLogin/" + roles, function (data) {
        if (data.result == "success") {
            var birthdayDate = new Date(parseInt($("#editDatetimepicker").val()));
            var userBirthday = formatterDate(birthdayDate);
            $.post(url, $("#"+formId).serialize() + "&userBirthday="+userBirthday,
                function (data) {
                    if (data.controllerResult.result == "success") {
                        console.log(data);
                        if(data.user) {
                            var fileData = document.getElementById("file").files[0];
                            var formData = new FormData();
                            formData.append("userIcon", fileData);
                            formData.append("userId", data.user.userId);
                            $.ajax({
                                url: "/userBasicManage/afterUpdIcon",
                                type: "POST",
                                data: formData,
                                processData: false,
                                contentType: false,
                                success: function (data1) {
                                    iconUpldSuc(data1, winId, formId);
                                }
                            })
                        } else{
                            iconUpldSuc(data, winId, formId);
                        }
                    } else if (data.result == "fail") {
                        swal({title:"",
                            text:"操作失败",
                            confirmButtonText:"确认",
                            type:"error"})
                        $("#"+formId).removeAttr("disabled");
                    }
                }, "json"
            );
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

function iconUpldSuc(data, winId, formId) {
    var controllerResult= data.controllerResult;
    if (controllerResult.result == "success") {
        swal({
            title:"提示",
            text: "操作成功",
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"success"
        })// 提示窗口, 修改成功

        $('#' + winId).modal('hide');
        $('#table').bootstrapTable('refresh');
        $('#' + formId).data('bootstrapValidator').resetForm(true);// 此form表单设置为空
        $("#" + formId).data('bootstrapValidator').destroy(); // 销毁此form表单
        $('#' + formId).data('bootstrapValidator', null);// 此form表单设置为空

        $("#addButton").removeAttr("disabled"); // 移除不可点击
        $("input[type=reset]").trigger("click"); // 移除表单中填的值
        $("#addUserRole").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
    } else if (controllerResult.result == "fail") {
        swal({title:"",
            text:"操作失败",
            confirmButtonText:"确认",
            type:"error"})
        $("#"+formId).removeAttr("disabled");
    }
}


function addSubmit() {
    $.post(contentPath + "/user/isLogin/" + roles, function (data) {
        if (data.result == "success") {
            $("#addForm").data('bootstrapValidator').validate();
            if ($("#addForm").data('bootstrapValidator').isValid()) {
                $("#addButton").attr("disabled","disabled");
            } else {
                $("#addButton").removeAttr("disabled");
            }
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
        } else if (data.result == "notRole") {
            swal({
                text: data.message,
                confirmButtonText: "确认", // 提示按钮上的文本
                type: "error"
            })
        }
    })
}

function showEdit(){
    $.post(contentPath + "/user/isLogin/" + roles, function (data) {
        if (data.result == "success") {
            initDatePicker('editForm', 'userBirthday'); // 初始化时间框, 第一参数是form表单id, 第二参数是input的name
            var row =  $('table').bootstrapTable('getSelections');
            if(row.length >0) {
                var emp = row[0];
                if(emp.userStatus == 'N') {
                    if(emp.role.roleName == '车主') {
                        $("#editWindow").modal('show'); // 显示弹窗
                        $("#editButton").removeAttr("disabled");
                        $('#editUserRole').html('<option value="' + emp.role.roleId + '">' + emp.role.roleName + '</option>').trigger("change");
                        $('#editDatetimepicker').val(formatterDate(emp.userBirthday));
                        $('#editCity_china').val(formatterAddress(emp.userAddress));
                        $("#editForm").fill(emp);
                        validator('editForm');
                    } else {
                        swal({
                            title:"警告",
                            text: "此员工已被辞退，不能再对其进行操作", // 主要文本
                            confirmButtonColor: "#DD6B55", // 提示按钮的颜色
                            confirmButtonText:"确定", // 提示按钮上的文本
                            type:"warning"
                        }) // 提示类型
                    }
                } else {
                    $("#editWindow").modal('show'); // 显示弹窗
                    $("#editButton").removeAttr("disabled");
                    $('#editUserRole').html('<option value="' + emp.role.roleId + '">' + emp.role.roleName + '</option>').trigger("change");
                    $('#editDatetimepicker').val(formatterDate(emp.userBirthday));
                    $('#editCity_china').val(formatterAddress(emp.userAddress));
                    $("#editForm").fill(emp);
                    validator('editForm');
                }
            } else {
                swal({
                    title:"警告",
                    text: "请选中一条数据", // 主要文本
                    confirmButtonColor: "#DD6B55", // 提示按钮的颜色
                    confirmButtonText:"确定", // 提示按钮上的文本
                    type:"warning"
                }) // 提示类型
            }
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
        } else if (data.result == "notRole") {
            swal({
                text: data.message,
                confirmButtonText: "确认", // 提示按钮上的文本
                type: "error"
            })
        }
    })
}

function editSubmit() {
    $("#editForm").data('bootstrapValidator').validate();
    if ($("#editForm").data('bootstrapValidator').isValid()) {
        $("#editButton").attr("disabled","disabled");
    } else {
        $("#editButton").removeAttr("disabled");
    }
}

// 格式化地址
function formatterAddress(val) {
    var address = val.split('-');
    $("#editProvince").val(address[0]);
    $("#editCity").val(address[1]);
    $("#editArea").val(address[2]);
}

//格式化不带时分秒的时间值。
function formatterDate(value) {
    if (value == undefined || value == null || value == '') {
        return "";
    } else {
        var date = new Date(value);
        var year = date.getFullYear().toString();
        var month = (date.getMonth() + 1);
        var day = date.getDate().toString();
        if (month < 10) {
            month = "0" + month;
        }
        if (day < 10) {
            day = "0" + day;
        }
        return year + "-" + month + "-" + day
    }
}

//格式化带时分秒的时间值。
function formatterDateTime(value) {
    if (value == undefined || value == null || value == '') {
        return "";
    } else {
        var date = new Date(value);
        var year = date.getFullYear().toString();
        var month = (date.getMonth() + 1);
        var day = date.getDate().toString();
        var hour = date.getHours().toString();
        var minutes = date.getMinutes().toString();
        var seconds = date.getSeconds().toString();
        if (month < 10) {
            month = "0" + month;
        }
        if (day < 10) {
            day = "0" + day;
        }
        if (hour < 10) {
            hour = "0" + hour;
        }
        if (minutes < 10) {
            minutes = "0" + minutes;
        }
        if (seconds < 10) {
            seconds = "0" + seconds;
        }
        return year + "-" + month + "-" + day + " " + hour + ":" + minutes + ":" + seconds;
    }
}

function showReturn(){
    $.post(contentPath + "/user/isLogin/" + roles, function (data) {
        if (data.result == "success") {
            var row =  $('table').bootstrapTable('getSelections');
            if(row.length >0) {
                swal(
                    {title:"",
                        text:"您确定要辞退此员工吗",
                        type:"warning",
                        showCancelButton:true,
                        confirmButtonColor:"#DD6B55",
                        confirmButtonText:"我确定",
                        cancelButtonText:"再考虑一下",
                        closeOnConfirm:false,
                        closeOnCancel:false
                    },function(isConfirm){
                        if (isConfirm) {
                            swal({
                                title: "提示",
                                text: "禁用成功",
                                type: "success",
                                confirmButtonText: "确认",
                            }, function () {
                            })
                        }
                        else{
                            swal({title:"提示",
                                text:"已取消",
                                confirmButtonText:"确认",
                                type:"error"})
                        }
                    }
                )
            }else{
                swal({
                    title:"",
                    text: "请先选择要辞退的员工", // 主要文本
                    confirmButtonColor: "#DD6B55", // 提示按钮的颜色
                    confirmButtonText:"确定", // 提示按钮上的文本
                    type:"warning"}) // 提示类型
            }
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
        } else if (data.result == "notRole") {
            swal({
                text: data.message,
                confirmButtonText: "确认", // 提示按钮上的文本
                type: "error"
            })
        }
    })
}

// 点击显示详细信息
function showDetail() {
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
        var emp = row[0];
        var gender = emp.userGender;
        if(gender == 'M') {
            $('#detailGender').val('男');
        } else if(gender == 'F') {
            $('#detailGender').val('女');
        } else {
            $('#detailGender').val('未选择');
        }
        var createdTime = emp.userCreatedTime;  /* 创建时间 */
        var formatterCreateTime = formatterDateTime(createdTime);
        $("#detailCreatedTime").val(formatterCreateTime);

        var loginTime = emp.userLoginTime;  /* 登录时间 */
        if(formatterLoginTime == null || formatterLoginTime == '') {
            $("#detailLoginTime").val("未登录过");
        } else {
            var formatterLoginTime = formatterDateTime(loginTime);
            $("#detailLoginTime").val(formatterLoginTime);
        }

        $("#detailWindow").modal('show');
        $('#detailBirthday').val(formatterDate(emp.userBirthday));  /* 格式化不带时分秒的时间 */
        $('#detailCreatedTime').val(formatterDateTime(emp.userCreatedTime));    /* 格式化带时分秒的时间 */
        $("#detailForm").fill(emp);

        // 将获取到的userIcon 的值 赋给img的src  attr=>属性 val=>值
        $('#detailUserIcon').attr("src", "/" + emp.userIcon);

        console.log(formatterDateTime(emp.userCreatedTime));
        console.log(emp);
    }
}
