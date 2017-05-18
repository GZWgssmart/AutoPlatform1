var userPhone;
$(function () {
    // 监听手机输入的唯一验证
    $('#phone').bind('input propertychange', function() {
        userPhone = $("#phone").val();
    });
    validator('loginForm');
    validator2('regform');
})

function loginSubmit() {
    $("#loginForm").data('bootstrapValidator').validate();
    if ($("#loginForm").data('bootstrapValidator').isValid()) {
        $("#loginForm").attr("disabled", "disabled");
    } else {
        $("#loginForm").removeAttr("disabled");
    }
}


function regSubmit() {
    $("#regform").data('bootstrapValidator').validate();
    if ($("#regform").data('bootstrapValidator').isValid()) {
        $("#regform").attr("disabled", "disabled");
    } else {
        $("#regform").removeAttr("disabled");
    }
}

/*用户注册*/
function validator2(formId) {
    $('#' + formId).bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            userPhone: {
                message: '手机号错误',
                validators: {
                    notEmpty: {
                        message: '手机号错误'
                    },
                    stringLength: {
                        min: 11,
                        max: 11,
                        message: '手机号格式必须为11位'
                    },
                    remote: {
                        url: '/user/queryPhoneByOne',
                        message: '该手机号已存在',
                        delay :  2000,
                        type: 'GET'
                    }
                }
            },
            userPwd: {
                message: '用户密码不能为空',
                validators: {
                    notEmpty: {
                        message: '用户密码不能为空'
                    }, identical: {
                        field: 'password2',
                        message: '两次输入的密码不一致'
                    },
                    stringLength: {
                        min: 6,
                        max: 18,
                        message: '用户密码长度必须在6到18位之间'
                    }
                }
            },
            password2: {
                message: '密码不一致',
                validators: {
                    notEmpty: {
                        message: '密码不一致'
                    },
                    identical: {
                        field: 'userPwd',
                        message: '两次输入的密码不一致'
                    },
                    stringLength: {
                        min: 6,
                        max: 18,
                        message: '用户密码长度必须在6到18位之间'
                    }
                }
            },
        }
    }).on('success.form.bv', function (e) {
            $.post("/user/register", $("#regform").serialize(), function (data) {
                if (data.result == "success") {
                    swal({
                        title: "",
                        text: data.message,
                        confirmButtonText: "确认",
                        type: "success"
                    }, function (isConfirm) {
                        $.post("/user/login1",$("#regform").serialize(),function (data) {
                            if(data.result=="success"){
                                window.location.href="/backstageIndex";
                            }else if(data.result == "isOwner"){
                                window.location.href="/userpage";
                            }else if(data.result=="fail"){
                                swal({
                                    title: "",
                                    text: data.message,
                                    confirmButtonText: "确认",
                                    type: "error"
                                })
                                $("#" + formId).removeAttr("disabled");
                            }
                        });
                    })
                    $("#" + formId).removeAttr("disabled");
                } else if (data.result == "fail") {
                    swal({
                        title: "",
                        text: data.message,
                        confirmButtonText: "确认",
                        type: "error"
                    })
                    $("#" + formId).removeAttr("disabled");
                }
            })
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
            userEmail: {
                message: '邮箱/手机号',
                validators: {
                    notEmpty: {
                        message: '邮箱/手机号'
                    }
                }
            },
            userPwd: {
                message: '用户密码不能为空',
                validators: {
                    notEmpty: {
                        message: '用户密码不能为空'
                    }
                }
            },
            checkCode: {
                message: '验证码不能为空',
                validators: {
                    notEmpty: {
                        message: '验证码不能为空'
                    }
                }
            },
        }
    }).on('success.form.bv', function (e) {
        if (formId == "loginForm") {
            $.post("/user/login",$("#loginForm").serialize(),function (data) {
                if(data.result=="success"){
                    window.location.href="/backstageIndex";
                }else if(data.result == "isOwner"){
                    window.location.href="/userpage";
                }else if(data.result=="fail"){
                    swal({
                        title: "",
                        text: data.message,
                        confirmButtonText: "确认",
                        type: "error"
                    })
                    $("#" + formId).removeAttr("disabled");
                }
            })
        }
    })
}