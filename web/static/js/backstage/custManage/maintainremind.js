$(function () {
    initTable('table', '/maintainRemind/queryByPager'); // 初始化表格

    initSelect2("user", "请选择用户", "/maintainRemind/queryCombox");
});

//显示弹窗
function showEdit() {
    var row = $('table').bootstrapTable('getSelections');
    if (row.length > 0) {
        alert(row[0].remindId);
        $("#editWindow").modal('show'); // 显示弹窗
        $("#editButton").removeAttr("disabled"); // 移除不可点击
        var MaintainRemind = row[0];
        $("#editForm").fill(MaintainRemind);
        $('#editUserName').html('<option value="' + MaintainRemind.user.userId + '">' + MaintainRemind.user.userName + '</option>').trigger("change");
        validator('editForm');
    } else {
        swal({
            "title": "",
            "text": "请先选择一条数据",
            "type": "warning"
        })
    }
}

function showCheckUser() {
    $("#showUserWindow").modal('show');
    initTableNotTollbar("addUserTable","/maintainRemind/queryByPagerNull");
}

function closeUserWin() {
    $("#showUserWindow").modal('hide');
    // $("#addWindow").modal('show');
}

function checkUser() {
    var row = $('#addUserTable').bootstrapTable('getSelections');
    if(row.length != 1) {
        swal({
            "title": "",
            "text": "只能选择一条数据",
            "type": "warning"
        })
    } else {
        alert(row[0].user.userId);
        alert(row[0].user.userName);
        $("#addRemindId").val(row[0].remindId);
        $("#addLastMaintainTime").val(formatterDate(row[0].lastMaintainTime));
        $("#addLastMaintainMileage").val(row[0].lastMaintainMileage);
        $('#addUserId').val(row[0].user.userId);
        $('#addUserName').val(row[0].user.userName);
        $("#showUserWindow").modal('hide');
    }
}

//显示添加
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
            userName: {
                message: '用户验证失败',
                validators: {
                    notEmpty: {
                        message: '用户不能为空'
                    }
                }
            },
            // lastMaintainTime: {
            //     message: '上次维修保养时间验证失败',
            //     validators: {
            //         notEmpty: {
            //             message: '上次维修保养时间不能为空'
            //         }
            //     }
            // },
            // lastMaintainMileage: {
            //     message: '上次汽车行驶里程验证失败',
            //     validators: {
            //         notEmpty: {
            //             message: '上次汽车行驶里程不能为空'
            //         }
            //     }
            // },
            remindMsg: {
                message: '维修保养提醒内容验证失败',
                validators: {
                    notEmpty: {
                        message: '维修保养提醒内容不能为空'
                    }
                }
            },
            remindTime: {
                message: '维修保养提醒时间验证失败',
                validators: {
                    notEmpty: {
                        message: '维修保养提醒时间不能为空'
                    }
                }
            },
            remindType: {
                message: '维修保养提醒方式验证失败',
                validators: {
                    notEmpty: {
                        message: '维修保养提醒方式不能为空'
                    }
                }
            },
            remindCreatedTime: {
                message: '提醒记录创建时间验证失败',
                validators: {
                    notEmpty: {
                        message: '提醒记录创建时间不能为空'
                    }
                }
            }
        }
    })

        .on('success.form.bv', function (e) {
            if (formId == "addForm") {
                formSubmit("/maintainRemind/update", formId, "addWindow");

            } else if (formId == "editForm") {
                formSubmit("/maintainRemind/update", formId, "editWindow");
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
    if ($("#editFobootstrapValidatorrm").data('bootstrapValidator').isValid()) {
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
                    $("#" + formId).data('bootstrapValidator').destroy(); // 销毁此form表单
                    $('#' + formId).data('bootstrapValidator', null);// 此form表单设置为空
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