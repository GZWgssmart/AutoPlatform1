$(function () {
    initTable('table', '/maintain/queryByPagerService'); // 初始化表格

    // 初始化select2, 第一个参数是class的名字, 第二个参数是select2的提示语, 第三个参数是select2的查询url
    initSelect2("company", "请选择公司", "/company/queryAllCompany");
});

function showEdit() {
    var row = $('#table').bootstrapTable('getSelections');
    if (row.length > 0) {
        $("#editWindow").modal('show'); // 显示弹窗
        $("#editButton").removeAttr("disabled");
        var MaintainFixMap = row[0];
        $('#editcompany').html('<option value="' + MaintainFixMap.company.companyId + '">' + MaintainFixMap.company.companyName + '</option>').trigger("change");
        $("#editForm").fill(MaintainFixMap);
        validator('editForm');
    } else {
        swal({
            "title": "",
            "text": "请先选择一条数据",
            "type": "warning"
        })
    }
}

function showAdd() {
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
            maintainName: {
                message: '维修项目名称验证失败',
                validators: {
                    notEmpty: {
                        message: '维修项目名称不能为空'
                    },
                    stringLength: {
                        min: 1,
                        max: 10,
                        message: '维修项目名称长度必须在1到10位之间'
                    }
                }
            },
            maintainHour: {
                message: '维修项目工时验证失败',
                validators: {
                    notEmpty: {
                        message: '维修项目工时不能为空'
                    }
                }
            },
            maintainManHourFee: {
                message: '维修项目工时费验证失 败',
                validators: {
                    notEmpty: {
                        message: '维修项目工时费不能为空'
                    }
                }
            },
            maintainMoney: {
                message: '维修项目基础费用验证失败',
                validators: {
                    notEmpty: {
                        message: '维修项目基础费用不能为空'
                    }
                }
            },
            maintainDes :{
                message: '维修项目描述验证失败',
                validators: {
                    notEmpty: {
                        message: '维修项目描述不能为空'
                    }
                }
            },
            companyId: {
                message: '维修项目所属公司证失败',
                validators: {
                    notEmpty: {
                        message: '维修项目所属公司不能为空'
                    }
                }
            }
        }
    })
        .on('success.form.bv', function (e) {
            if (formId == "addForm") {
                formSubmit("/maintain/addService", formId, "addWindow");

            } else if (formId == "editForm") {
                formSubmit("/maintain/updateMaintain", formId, "editWindow");

            }
        })

}

function addSubmit(){
    $("#addForm").data('bootstrapValidator').validate();
    if ($("#addForm").data('bootstrapValidator').isValid()) {
        $("#addButton").attr("disabled","disabled");
    } else {
        $("#addButton").removeAttr("disabled");
    }
}

function editSubmit(){
    $("#editForm").data('bootstrapValidator').validate();
    if ($("#editForm").data('bootstrapValidator').isValid()) {
        $("#editButton").attr("disabled","disabled");
    } else {
        $("#editButton").removeAttr("disabled");
    }
}

function formSubmit(url, formId, winId){
    $.post(url,
        $("#" + formId).serialize(),
        function (data) {
            if (data.result == "success") {
                $('#' + winId).modal('hide');
                swal({
                    title:"",
                    text: data.message,
                    confirmButtonText:"确定", // 提示按钮上的文本
                    type:"success"})// 提示窗口, 修改成功
                $('#table').bootstrapTable('refresh');
                if(formId == 'addForm'){
                    $("input[type=reset]").trigger("click"); // 移除表单中填的值
                    $('#addForm').data('bootstrapValidator').resetForm(true); // 移除所有验证样式
                    $("#addButton").removeAttr("disabled"); // 移除不可点击
                }
            } else if (data.result == "fail") {
                swal({title:"",
                    text:"添加失败",
                    confirmButtonText:"确认",
                    type:"error"})
                $("#"+formId).removeAttr("disabled");
            }
        }, "json");
}
