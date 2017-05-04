var contentPath='';

$(function () {
    validator('loginForm');
})

function userLogin() {
    $.post(contentPath+"/user/login",$("#loginForm").serialize(),function (data) {
        if(data.result=="success"){
            alert("登陆成功");
        }else{
            $("#errMsg").html(data.message);
        }
    })
}

function loginSubmit() {
    $("#loginForm").data('bootstrapValidator').validate();
    if ($("#loginForm").data('bootstrapValidator').isValid()) {
        $("#loginForm").attr("disabled", "disabled");
    } else {
        $("#loginForm").removeAttr("disabled");
    }
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
                message: '邮箱/手机号/用户名不能为空',
                validators: {
                    notEmpty: {
                        message: '邮箱/手机号/用户名不能为空'
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
            $.post(contentPath+"/user/login",$("#loginForm").serialize(),function (data) {
                if(data.result=="success"){
                    alert("登陆成功");
                }else{
                    swal({
                        title: "登陆错误",
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