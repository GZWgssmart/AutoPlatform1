var contentPath = '';

$(function () {
    validator('loginForm');
})

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
            companyName: {
                message: '公司名称',
                validators: {
                    notEmpty: {
                        message: '公司名称'
                    }
                }
            },
            companyAddress: {
                message: '公司地址不能为空',
                validators: {
                    notEmpty: {
                        message: '公司地址不能为空'
                    }
                }
            },
            companyTel: {
                message: '公司电话不能为空',
                validators: {
                    notEmpty: {
                        message: '公司电话不能为空'
                    },
                    regexp: {
                        regexp: /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/,
                        message: '请输入正确的手机号'
                    }
                }

            },
            companyPricipal: {
                message: '公司负责人验证失败',
                validators: {
                    notEmpty: {
                        message: '公司负责人不能为空'
                    }
                }
            },
            companyPricipalphone: {
                message: '公司负责人电话不能为空',
                validators: {
                    notEmpty: {
                        message: '公司负责人电话不能为空'
                    },
                    stringLength: {
                        min: 11,
                        max: 11,
                        message: '负责人联系电话必须为11位'
                    },
                    regexp: {
                        regexp: /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/,
                        message: '请输入正确的手机号'
                    },
                    remote: {
                        url: '/company/queryPhone',
                        message: '该负责人联系电话已存在',
                        delay: 2000,
                        type: 'post',
                        data: {
                            companyPricipalphone: $("#" + formId + " input[name=companyPricipalphone]").val()
                        }
                    },


                }
            },
            companyOpenDate: {
                message: '公司成立时间验证失败',
                validators: {
                    notEmpty: {
                        message: '公司成立时间不能为空'
                    }
                }
            }
        }
    }).on('success.form.bv', function (e) {
        if (formId == "loginForm") {
            $.post("/company/enterCompany", $("#loginForm").serialize(), function (data) {
                var controllerResult = data.controllerResult;
                if (controllerResult.result == "success") {
                    swal({
                        title: "",
                        text: data.controllerResult.message,
                        confirmButtonText: "确定", // 提示按钮上的文本
                        url: "www.baidu.co",
                        type: "success"
                    }, function (isConfirm) {
                        top.location = "/user/loginPage";
                    })
                } else {
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