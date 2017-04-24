var contentPath = ''


//初始化表格
$(function () {
    initTable('table', '/accInv/queryByPage'); // 初始化表格
});

// 查看全部可用
function showAvailable() {
    initTable('table', '/accInv/queryByPage');
}
// 查看全部禁用
function showDisable() {
    initTable('table', '/accInv/queryByPagerDisable');
}

//显示弹窗
function showEdit() {
    var row = $('table').bootstrapTable('getSelections');
    if (row.length > 0) {
        $("#editWindow").modal('show'); // 显示弹窗
        var ceshi = row[0];
        $("#editForm").fill(ceshi);
        validator('editForm'); // 初始化验证
    } else {
        swal({
            "title": "",
            "text": "请先选择一条数据",
            "type": "warning"
        })
    }
}

//显示添加
function showAdd() {
    $("#addWindow").modal('show');
    $("#addButton").removeAttr("disabled");
    validator('addForm'); // 初始化验证
}


//格式化页面上的配件分类状态
function formatterStatus(value) {
    if (value == "Y") {
        return "可用";
    } else {
        return "不可用";
    }
}

function openStatusFormatter(index, row) {
    /*处理数据*/
    if (row.accStatus == 'Y') {
        return "&nbsp;&nbsp;<a href='javascript:;' onclick='inactive(\"" + row.accId + "\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<a href='javascript:;' onclick='active(\"" + row.accId + "\")'>激活</a>";
    }
}

//禁用状态
function inactive(accId) {
    $.post(contentPath + "/accInv/statusOperate?accId=" + accId + "&" + "accStatus=" + "Y", function (data) {
        if (data.result == "success") {
            $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
        }
    })
}

//激活状态
function active(accId) {
    $.post(contentPath + "/accInv/statusOperate?accId=" + accId + "&" + "accStatus=" + 'N', function (data) {
        if (data.result == "success") {
            $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
        }
    })
}


//格式化带时分秒的时间值。
function formatterDateTime(value) {
    if (value == undefined || value == null || value == '') {
        return "";
    }
    else {
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

//格式化不带时分秒的时间值
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


function formatRepo(repo) {
    return repo.text
}
function formatRepoSelection(repo) {
    return repo.text
}

//显示删除
function showDel() {
    var row = $('table').bootstrapTable('getSelections');
    if (row.length > 0) {
        $("#del").modal('show');
    } else {
        swal({
            "title": "",
            "text": "请先选择一条数据",
            "type": "warning"
        })
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
            companyId: {
                message: '所属公司名称不能为空',
                validators: {
                    notEmpty: {
                        message: '所属公司名称不能为空'
                    }
                }
            },
            accTypeId: {
                message: '配件分类名称不能为空',
                notEmpty: {
                    message: '配件分类名称不能为空'
                }
            }
        },
        accName: {
            message: '配件名称不能为空',
            validators: {
                notEmpty: {
                    message: '配件名称不能为空'
                }
            }
        },
        accCommodityCode: {
            message: '配件商品条形码不能为空',
            validators: {
                notEmpty: {
                    message: '配件商品条形码不能为空'
                }
            }
        },
        accPrice: {
            message: '配件价格不能为空',
            validators: {
                notEmpty: {
                    message: '配件价格不能为空'
                }
            }
        },
        accSalePrice: {
            message: '配件售价不能为空',
            validators: {
                notEmpty: {
                    message: '配件售价不能为空'
                }
            }
        },
        accTotal: {
            message: '配件数量不能为空',
            validators: {
                notEmpty: {
                    message: '配件数量不能为空'
                }
            }
        },
        accIdle: {
            message: '配件可用数量不能为空',
            validators: {
                notEmpty: {
                    message: '配件可用数量不能为空'
                }
            }
        },
    }).on('success.form.bv', function (e) {
        if (formId == "addForm") {
            formSubmit(contentPath+"/accInv/addAccInv", formId, "addWindow");

        } else if (formId == "editForm") {
            formSubmit(contentPath+"/accInv/updateAccInv", formId, "editWindow");

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
