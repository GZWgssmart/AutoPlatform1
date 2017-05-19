var contentPath='';

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
                    }
                },
                regexp: {
                    regexp: /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/,
                    message: '请输入正确的手机号'
                }
            },
        }
    }).on('success.form.bv', function (e) {
        if (formId == "loginForm") {
            $.post("/company/addCompany",$("#loginForm").serialize(),function (data) {
                if(data.result=="success"){
                    window.location.href="/backstageIndex";
                }else{
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