var contentPath = '';

//初始化表格
$(function () {
    initTable('table', '/accSale/queryByPage'); // 初始化表格
    initSelect2("company", "请选择所属公司", "/company/queryAllCompany");
    initSelect2("accInv", "请选择配件", "/accInv/queryAllAccInv");
});

// 查看全部可用
function showAvailable(){
    initTable('table', '/accSale/queryByPage');
}
// 查看全部禁用
function showDisable(){
    initTable('table', '/accSale/queryByPagerDisable');
}

// 模糊查询
function blurredQuery(){
    var button = $("#ulButton");// 获取模糊查询按钮
    var text = button.text();// 获取模糊查询按钮文本
    var vaule = $("#ulInput").val();// 获取模糊查询输入框文本
    initTable('table', '/accSale/blurredQuery?text='+text+'&value='+vaule);
}

//显示弹窗
function showEdit() {
    var row = $('table').bootstrapTable('getSelections');
    if (row.length > 0) {
        $("#editWindow").modal('show'); // 显示弹窗
        $("#editButton").removeAttr("disabled");
        var ceshi = row[0];
        $('#editCompany').html('<option value="' + ceshi.company.companyId + '">' + ceshi.company.companyName + '</option>').trigger("change");
        $('#editAccInv').html('<option value="' + ceshi.accessories.accId + '">' + ceshi.accessories.accName + '</option>').trigger("change");
        $('#editDateTimePicker').val(formatterDate(ceshi.accSaledTime));
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


function formatRepo(repo) {
    return repo.text
}
function formatRepoSelection(repo) {
    return repo.text
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
    if (row.accSaleStatus == 'Y') {
        return "&nbsp;&nbsp;<a href='javascript:;' onclick='inactive(\"" + row.accSaleId + "\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<a href='javascript:;' onclick='active(\"" + row.accSaleId + "\")'>激活</a>";
    }
}

//禁用状态
function inactive(accSaleId) {
    $.post(contentPath + "/accSale/statusOperate?accSaleId=" + accSaleId + "&" + "accSaleStatus=" + "Y", function (data) {
        if (data.result == "success") {
            $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
        }
    })
}

//激活状态
function active(accSaleId) {
    $.post(contentPath + "/accSale/statusOperate?accSaleId=" + accSaleId + "&" + "accSaleStatus=" + 'N', function (data) {
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


$('#addDateTimePicker').datetimepicker({
    minView: "month", //选择日期后，不会再跳转去选择时分秒
    language: 'zh-CN',
    format: 'yyyy-mm-dd',
    todayBtn: 1,
    autoclose: 1,
});
$('#editDateTimePicker').datetimepicker({
    minView: "month", //选择日期后，不会再跳转去选择时分秒
    language: 'zh-CN',
    format: 'yyyy-mm-dd',
    todayBtn: 1,
    autoclose: 1,
});

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

function validator(formId) {
    $('#' + formId).bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            companyId: {
                message: '所属公司不能为空',
                validators: {
                    notEmpty: {
                        message: '所属公司不能为空'
                    }
                }
            },
            accId: {
                message: '配件编号不能为空',
                validators: {
                    notEmpty: {
                        message: '配件编号不能为空'
                    }
                }
            },
            accSaledTime: {
                message: '配件销售时间不能为空',
                validators: {
                    notEmpty: {
                        message: '配件销售时间不能为空'
                    }
                }
            },
            accSaleCount: {
                message: '配件销售数量不能为空',
                validators: {
                    notEmpty: {
                        message: '配件销售数量不能为空'
                    }
                }
            },
            accSalePrice: {
                message: '配件销售单价不能为空',
                validators: {
                    notEmpty: {
                        message: '配件销售单价不能为空'
                    }
                }
            },
            accSaleTotal: {
                message: '配件销售总价不能为空',
                validators: {
                    notEmpty: {
                        message: '配件销售总价不能为空'
                    }
                }
            },
            accSaleDiscount: {
                message: '配件销售折扣不能为空',
                validators: {
                    notEmpty: {
                        message: '配件销售折扣不能为空'
                    }
                }
            },
            accSaleMoney: {
                message: '配件销售最终价不能为空',
                validators: {
                    notEmpty: {
                        message: '配件销售最终价不能为空'
                    }
                }
            },
        }
    }).on('success.form.bv', function (e) {
        if (formId == "addForm") {
            formSubmit("/accSale/addAccSale", formId, "addWindow");

        } else if (formId == "editForm") {
            formSubmit("/accSale/updateAccSale", formId, "editWindow");

        }
    })
}
