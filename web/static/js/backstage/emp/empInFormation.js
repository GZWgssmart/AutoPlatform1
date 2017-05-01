$(function () {
    initTable('table', '/userBasicManage/queryByPager'); // 初始化表格

    // 初始化select2, 第一个参数是class的名字, 第二个参数是select2的提示语, 第三个参数是select2的查询url
    initSelect2("userRole", "请选择角色", "/role/role2CheckBox");
    initSelect2("userCompany", "请选择所属公司", "/company/queryAllCompany");

});

function addSubmit() {
    $("#addForm").data('bootstrapValidator').validate();
    if ($("#addForm").data('bootstrapValidator').isValid()) {
        $("#addButton").attr("disabled","disabled");
    } else {
        $("#addButton").removeAttr("disabled");
    }
}

function editSubmit() {
    $("#editForm").data('bootstrapValidator').validate();
    if ($("#editForm").data('bootstrapValidator').isValid()) {
        $("#editButton").attr("disabled","disabled");
    } else {
        $("#editButton").removeAttr("disabled");
    }
}

function showEdit(){
    initDatePicker('editForm', 'userBirthday'); // 初始化时间框, 第一参数是form表单id, 第二参数是input的name
    var row =  $('table').bootstrapTable('getSelections');
    var editAddress = row.userAddress;
    console.log(editAddress);
    if(row.length >0) {
        $("#editWindow").modal('show'); // 显示弹窗
        $("#editButton").removeAttr("disabled");
        var emp = row[0];
        $('#editUserRole').html('<option value="' + emp.role.roleId + '">' + emp.role.roleName + '</option>').trigger("change");
        $('#editUserCompany').html('<option value="' + emp.company.companyId + '">' + emp.company.companyName + '</option>').trigger("change");
        $('#editDatetimepicker').val(formatterDate(emp.userBirthday));
        $("#editForm").fill(emp);
        validator('editForm');
    }else{
        swal({
            title:"警告",
            text: "请先选择要修改的员工信息", // 主要文本
            confirmButtonColor: "#DD6B55", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"warning"}) // 提示类型
    }
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

function showAdd(){
    initDatePicker('addForm', 'userBirthday'); // 初始化时间框, 第一参数是form表单id, 第二参数是input的name
    $("#addWindow").modal('show');
    $("#addButton").removeAttr("disabled");
    validator('addForm'); // 初始化验证
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
    $.post(url,
        $("#" + formId).serialize(),
        function (data) {
            if (data.result == "success") {
                $('#' + winId).modal('hide');
                swal({
                    title:"",
                    text: data.message,
                    confirmButtonText:"确定", // 提示按钮上的文本
                    type:"success"
                })// 提示窗口, 修改成功
                $('#table').bootstrapTable('refresh');
                if(formId == 'addForm'){
                    $("input[type=reset]").trigger("click"); // 移除表单中填的值
                    $('#addForm').data('bootstrapValidator').resetForm(true); // 移除所有验证样式
                    $("#addButton").removeAttr("disabled"); // 移除不可点击
                    $("#" + formId).data('bootstrapValidator').destroy(); // 销毁此form表单
                    $('#' + formId).data('bootstrapValidator', null);// 此form表单设置为空
                    // 设置select2的值为空
                    $("#addUserRole").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                    $("#addUserCompany").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                }
            } else if (data.result == "fail") {
                swal({title:"",
                    text:"添加失败",
                    confirmButtonText:"确认",
                    type:"error"})
                $("#"+formId).removeAttr("disabled");
            }
        }, "json"
    );
}


function showReturn(){
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
}
