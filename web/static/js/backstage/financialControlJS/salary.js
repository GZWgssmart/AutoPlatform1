/**
 * 初始化表格
 */
$(function () {
    initTable("table", "/salary/queryByPager"); // 初始化表格
});


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
        return year + "-" + month + "-" + day + ""
    }
}

/**
 * 导出
 */
function exportFile() {
    window.location.href = "/salary/export";
}

function showEdit() {
    $("#editButton").removeAttr("disabled");
    $("input[type=reset]").trigger("click");
    var row = $('table').bootstrapTable('getSelections');
    if (row.length > 0) {
        $("#edit").modal('show'); // 显示弹窗
        var editDate = document.getElementById("salaryTimeUpdate");
        var salary = row[0];
        editDate.val = formatterDate(row[0].salaryTime);
        $("#editForm").fill(salary);
        validator("editForm");

    } else {
        swal({
            title: "",
            text: "请先选择一行数据",
            type: "warning"
        })
    }
}

function showAdd() {
    $("input[type=reset]").trigger("click");
    $("#add").modal('show');
    $("#addButton").removeAttr("disabled");
    validator("addForm");
}

/** 选择人员 */
function checkAppointment() {
    initTableNotTollbar("appTable", "/userBasicManage/queryByPager");
    $("#add").modal('hide');
    $("#personnelWin").modal('show');
}


/** 关闭人员管理窗口 */
function closePersonnelWin() {
    $("#personnelWin").modal('hide');
    $("#add").modal('show')
}

/** 选择人员 */
function checkPersonnel() {
    var selectRow = $("#appTable").bootstrapTable('getSelections');
    if (selectRow.length != 1) {
        swal('选择失败', "只能选择一条数据", "error");
        return false;
    } else {
        $("#personnelWin").modal('hide');
        $("#add").modal('show');
        var user = selectRow[0];
        $("#userName").val(user.userName);
        $("#userId").val(user.userId);
        $("#addWin").modal('show');
    }
}

function checkEdit() {
    $.post("/table/edit",
        $("#editForm").serialize(),
        function (data) {
            if (data.result == "success") {
                $("#edit").modal('hide'); // 关闭指定的窗口
                $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                swal({
                    title: "",
                    text: data.message,
                    type: "success"
                })// 提示窗口, 修改成功
            } else if (data.result == "fail") {
                //$.messager.alert("提示", data.result.message, "info");
            }
        }, "json"
    );
}

function addWinClose() {
    $("#add").modal('hide'); // 关闭指定的窗口

}


/**
 * 前台验证
 * @param formId
 */
function validator(formId) {
    $('#' + formId).bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            userName: {
                message: '人员不能为空',

                validators: {
                    notEmpty: {
                        message: '请点击选择人员',
                    }

                }
            },
            minusSalay: {
                validators: {
                    numeric: {message: '请输入合法的数字'}
                }
            },
            prizeSalary: {
                validators: {
                    numeric: {message: '请输入合法的数字'}
                }
            },

            totalSalary: {
                message: '请输入总工资',
                number: true,
                validators: {
                    notEmpty: {
                        message: '请输入总工资',
                        number: '请输入合法的数字'
                    }

                }
            },

            salaryTime: {
                message: '请选择工资发放时间',
                data: true,
                validators: {
                    notEmpty: {
                        message: '请选择工资发放时间',
                        data: '请选择正确的时间格式'
                    }

                }
            }
        }
    })

        .on('success.form.bv', function (e) {
            if (formId == "addForm") {
                formSubmit("/salary/add", formId, "add");

            } else if (formId == "editForm") {
                formSubmit("/salary/update", formId, "edit");

            }
        })

}

function addSubmit() {
    $("#addForm").data('bootstrapValidator').validate();
    if ($("#addForm").data('bootstrapValidator').isValid()) {
        $("#addButton").attr("disabled", "disabled");
    } else {
        $("#addButton").removeAttr("disabled");
    }
}

function editSubmit() {
    $("#editForm").data('bootstrapValidator').validate();
    if ($("#editForm").data('bootstrapValidator').isValid()) {
        $("#editButton").attr("disabled", "disabled");
    } else {
        $("#editButton").removeAttr("disabled");
    }
}

function formSubmit(url, formId, winId) {
    $.post(url,
        $("#" + formId).serialize(),
        function (data) {
            if (data.result == "success") {
                $('#' + winId).modal('hide');
                swal({
                    title: "",
                    text: data.message,
                    confirmButtonText: "确定", // 提示按钮上的文本
                    type: "success"
                })// 提示窗口, 修改成功
                $('#table').bootstrapTable('refresh');
                if (formId == 'addForm') {
                    $("input[type=reset]").trigger("click"); // 移除表单中填的值
                    $('#addForm').data('bootstrapValidator').resetForm(true); // 移除所有验证样式
                    $("#addButton").removeAttr("disabled"); // 移除不可点击
                }
            } else if (data.result == "fail") {
                swal({
                    title: "",
                    text: "添加失败",
                    confirmButtonText: "确认",
                    type: "error"
                })
                $("#" + formId).removeAttr("disabled");
            }
        }, "json");
}



