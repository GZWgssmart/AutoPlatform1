var userPhone;
$(function () {
    // 监听手机输入的唯一验证
    $('#phone').bind('input propertychange', function() {
        userPhone = $("#phone").val();
        $("#phonecode-caveat").css("display","none");
    });
    validator('loginForm');
    validator2('regform');
})

// 登录按钮
function loginSubmit() {
    $("#loginForm").data('bootstrapValidator').validate();
    if ($("#loginForm").data('bootstrapValidator').isValid()) {
        $("#loginForm").attr("disabled", "disabled");
    } else {
        $("#loginForm").removeAttr("disabled");
    }
}

// 注册按钮
function regSubmit() {
    $("#regform").data('bootstrapValidator').validate();
    if ($("#regform").data('bootstrapValidator').isValid()) {
        $("#regform").attr("disabled", "disabled");
    } else {
        $("#regform").removeAttr("disabled");
    }
}

// 点击发送短信
var wait = 60;
function  sendCode(button) {
    time(button);
}

function time(o) {
    if (wait == 0) {
        $("#phonecode-caveat").css("display","none");
        o.removeAttribute("disabled");
        o.innerHTML = "获取短信验证码";
        wait = 60;
    } else {
        var phone = $("#phone").val();
        if(phone!= null && phone != ""){
            if(phone.length != 11){
            }else{
                $.get("/user/sendSms?phone="+phone, function (data) {
                    if(data.result == "success"){
                        o.setAttribute("disabled", true);
                        o.innerHTML = wait + "秒后可以重新发送";
                        wait--;
                        setTimeout(function () {
                                time1(o, phone)
                        }, 1000)
                    }else if(data.result == "fail"){
                        o.innerHTML = "发送失败"
                    }
                });
            }
        }else{
            $("#phonecode-caveat").html("请先输入手机号码");
            $("#phonecode-caveat").css("display","block");
        }
    }
}

function time1(o, phone) {
    if (wait == 0) {
        $("#phonecode-caveat").css("display","none");
        o.removeAttribute("disabled");
        o.innerHTML = "获取短信验证码";
        wait = 60;
    } else {
           o.setAttribute("disabled", true);
           o.innerHTML = wait + "秒后可以重新发送";
           wait--;
           setTimeout(function () {
               time1(o, phone)
           }, 1000)
    }
}

/*用户注册验证*/
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
                        message: '请先输入手机号码'
                    },
                    stringLength: {
                        min: 11,
                        max: 11,
                        message: '手机号码格式错误'
                    },
                    remote: {
                        url: '/user/queryPhoneByOne',
                        message: '该手机号已存在',
                        delay :  2000,
                        type: 'GET'
                    }
                }
            },
            phonecode: {
                message: '验证码验证错误',
                validators: {
                    notEmpty: {
                        message: '请先输入验证码'
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

// 登录验证
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