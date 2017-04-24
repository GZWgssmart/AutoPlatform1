

/**
 * 初始化表格
 */
$(function () {
    initTable("table", "/incomingOutgoing/queryByPager"); // 初始化表格
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
 * 收支类型状态判断显示
 * @param value
 * @param row
 * @param index
 * @returns {*}
 */
function ioTypeFormatter(value, row, index) {
    if (row.outgoingType != null) {
        return "支出类型:" +row.outgoingType.outTypeName
    } else {
        return "收入类型:" +row.incomingType.inTypeName
    }
}

/**
 * 状态显示
 * @param value
 * @returns {*}
 */
function statusFormatter(value) {
    /*处理数据*/
    if (value == 'Y') {
        return "&nbsp;&nbsp;激活";
    } else {
        return "&nbsp;&nbsp;禁用";
    }

}

/**
 * 查询禁用支出类型
 * @param id
 */
function searchDisableStatus() {
    initTable('table', '/incomingOutgoing/queryByPagerDisable');
}

/**
 * 查询激活支出类型
 * @param id
 */
function searchRapidStatus() {
    initTable('table', '/incomingOutgoing/queryByPager');
}


/**
 * 操作禁用激活
 * @param index
 * @param row
 * @returns {string}
 */
function openStatusFormatter(value, row) {
    /*处理数据*/
    if (value == 'Y') {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='inactive(\""+ row.inOutId + "\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='active(\""+ row.inOutId + "\")'>激活</a>";
    }

}


/**
 * 禁用收支记录状态
 * @param id
 */
function inactive(id) {
    $.post("/incomingOutgoing/inactive?id=" + id,
        function (data) {
            if (data.result == "success") {
                $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
            }
        })
}


/**
 * 启用收支记录状态
 * @param id
 */
function active(id) {
    $.post("/incomingOutgoing/active?id=" + id,
        function (data) {
            if (data.result == "success") {
                $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
            }
        })
}


function showEdit(){
    $("#editButton").removeAttr("disabled");
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
//                $('#editId').val(row[0].id);
//                $('#editName').val(row[0].name);
//                $('#editPrice').val(row[0].price);
        $("#editIOWin").modal('show'); // 显示弹窗
        var io = row[0];
        $("#editIOWin").fill(io);
        validator("editIOForm");
        if ($("#inType").val() == "") {
            $("#inTypeDiv").hide();
        }
        if ($("#outType").val() == "") {
            $("#outTypeDiv").hide();
        }

    }else{
        swal({
            title:"",
            text:"请先选择一行数据",
            type:"warning"})
    }
}

function outAddWin(){
    $("#addOutWin").modal('show');
    $("#addOutButton").removeAttr("disabled");
    validator("addOutForm");
}

function inAddWin(){
    $("#addInWin").modal('show');
    $("#addInButton").removeAttr("disabled");
    validator("addInForm");
}

$("#addOutForm").submit(function(){
    $(":submit",this).attr("disabled","disabled");
});

$("#addInForm").submit(function(){
    $(":submit",this).attr("disabled","disabled");
});

$("#editIOForm").submit(function(){
    $(":submit",this).attr("disabled","disabled");
});


/** 选择支出类型窗体 */
function openCheckOutType() {
    initTableNotTollbar("outTable", "/outGoingType/queryByPager");
    $("#addOutWin").modal('hide');
    $("#outWin").modal('show');
}


/** 关闭支出类型 */
function closeOutTypeWin() {
    $("input[type=reset]").trigger("click");
    $("#outWin").modal('hide');
    $("#addOutWin").modal('show')
}

/** 选择支出类型 */
function checkOutType () {
    var selectRow = $("#outTable").bootstrapTable('getSelections');
    if (selectRow.length != 1) {
        swal('选择失败', "只能选择一条数据", "error");
        return false;
    } else {
        $("#outWin").modal('hide');
        $("#addOutWin").modal('show');
        var outType = selectRow[0];
        $("#outTypeName").val(outType.outTypeName);
        $("#outTypeId").val(outType.outTypeId);
        $("#addOutWin").modal('show');
    }
}

/** 选择人员 */
function checkAppointment() {
    initTableNotTollbar("appTable", "/userBasicManage/queryByPager");
    $("#add").modal('hide');
    $("#personnelWin").modal('show');
}


/** 关闭人员管理窗口 */
function closePersonnelWin() {
    $("input[type=reset]").trigger("click");
    $("#personnelWin").modal('hide');
    $("#add").modal('show')
}

/** 选择人员 */
function checkPersonnel () {
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

/** 选择收入类型窗体 */
function inOpenCheckInType() {
    initTableNotTollbar("inTable", "/incomingType/queryByPager");
    $("#addInWin").modal('hide');
    $("#inWin").modal('show');
}


/** 关闭收入类型 */
function inCloseInTypeWin() {
    $("input[type=reset]").trigger("click");
    $("#inWin").modal('hide');
    $("#addInWin").modal('show')
}



/** 选择收入类型 */
function inCheckInType () {
    var selectRow = $("#inTable").bootstrapTable('getSelections');
    if (selectRow.length != 1) {
        swal('选择失败', "只能选择一条数据", "error");
        return false;
    } else {
        $("#inWin").modal('hide');
        $("#addInWin").modal('show');
        var inType = selectRow[0];
        $("#inTypeName").val(inType.inTypeName);
        $("#inTypeId").val(inType.inTypeId);
        $("#addinWin").modal('show');
    }
}

/** 选择人员 */
function inCheckAppointment() {
    initTableNotTollbar("inAppTable", "/userBasicManage/queryByPager");
    $("#addInWin").modal('hide');
    $("#inPersonnelWin").modal('show');
}


/** 关闭人员管理窗口 */
function inClosePersonnelWin() {
    $("input[type=reset]").trigger("click");
    $("#inPersonnelWin").modal('hide');
    $("#addInWin").modal('show')
}

/** 选择人员 */
function inCheckPersonnel () {
    var selectRow = $("#inAppTable").bootstrapTable('getSelections');
    if (selectRow.length != 1) {
        swal('选择失败', "只能选择一条数据", "error");
        return false;
    } else {
        $("#inPersonnelWin").modal('hide');
        $("#addInWin").modal('show');
        var user = selectRow[0];
        $("#inUserName").val(user.userName);
        $("#inUserId").val(user.userId);
        $("#addWin").modal('show');
    }
}




/** 选择支出类型窗体 */
function updateOpenCheckOutType() {
    initTableNotTollbar("updateOutTable", "/outGoingType/queryByPager");
    $("#editIOWin").modal('hide');
    $("#updateOutWin").modal('show');
}


/** 关闭支出类型 */
function updateCloseOutTypeWin() {
    $("input[type=reset]").trigger("click");
    $("#updateOutWin").modal('hide');
    $("#editIOWin").modal('show')
}

/** 选择支出类型 */
function updateCheckOutType () {
    var selectRow = $("#updateOutTable").bootstrapTable('getSelections');
    if (selectRow.length != 1) {
        swal('选择失败', "只能选择一条数据", "error");
        return false;
    } else {
        $("#updateOutWin").modal('hide');
        $("#editIOWin").modal('show');
        var outType = selectRow[0];
        $("#outType").val(outType.outTypeName);
        $("#updateOutTypeId").val(outType.outTypeId);
    }
}

/**
 * 选择人员
 */
function updateCheckAppointment() {
    initTableNotTollbar("updateAppTable", "/userBasicManage/queryByPager");
    $("#editIOWin").modal('hide');
    $("#updatePersonnelWin").modal('show');
}


/** 关闭人员管理窗口 */
function updateClosePersonnelWin() {
    $("input[type=reset]").trigger("click");
    $("#updatePersonnelWin").modal('hide');
    $("#editIOWin").modal('show')
}

/** 选择人员 */
function updateCheckPersonnel () {
    var selectRow = $("#updateAppTable").bootstrapTable('getSelections');
    if (selectRow.length != 1) {
        swal('选择失败', "只能选择一条数据", "error");
        return false;
    } else {
        $("#updatePersonnelWin").modal('hide');
        var user = selectRow[0];
        $("#updateUserName").val(user.userName);
        $("#updateUserId").val(user.userId);
        $("#editIOWin").modal('show');
    }
}


function updateInOpenCheckInType() {
    initTableNotTollbar("updateInTable", "/incomingType/queryByPager");
    $("#editIOWin").modal('hide');
    $("#updateInWin").modal('show');
}


/** 关闭收入类型 */
function updateInCloseInTypeWin() {
    $("input[type=reset]").trigger("click");
    $("#updateInWin").modal('hide');
    $("#editIOWin").modal('show')
}



/** 选择收入类型 */
function updateInCheckInType () {
    var selectRow = $("#updateInTable").bootstrapTable('getSelections');
    if (selectRow.length != 1) {
        swal('选择失败', "只能选择一条数据", "error");
        return false;
    } else {
        $("#updateInWin").modal('hide');
        var inType = selectRow[0];
        $("#inType").val(inType.inTypeName);
        $("#updateInTypeId").val(inType.inTypeId);
        $("#editIOWin").modal('show');
    }
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
            inTypeId: {
                validators: {
                    notEmpty: {
                        message: '请选择收支类型',
                    },
                }
            },
            outTypeId: {
                validators: {
                    notEmpty: {
                        message: '请选择收支类型',
                    },
                }
            },
            inOutMoney: {
                validators: {
                    notEmpty: {
                        message: '请输入收支金额',
                    },
                    numeric: {message: '请输入合法的数字'}
                }
            },

            inOutCreatedUser: {
                message: '请选择创建人',
                validators: {
                    notEmpty: {
                        message: '请选择创建人',
                    }

                }
            },
        }
    })

        .on('success.form.bv', function (e) {
            if (formId == "addOutForm") {
                formSubmit("/incomingOutgoing/add", formId, "addOutWin");
            } else if (formId == "addInForm") {
                formSubmit("/incomingOutgoing/add", formId, "addInWin");
            } else if (formId == "editIOForm") {
                formSubmit("/incomingOutgoing/update", formId, "editIOWin");
            }
        })

}

function addInSubmit() {
    $("#addInForm").data('bootstrapValidator').validate();
    if ($("#addInForm").data('bootstrapValidator').isValid()) {
        $("#addInButton").attr("disabled", "disabled");
    } else {
        $("#addInButton").removeAttr("disabled");
    }
}

function addOutSubmit() {
    $("#addOutForm").data('bootstrapValidator').validate();
    if ($("#addOutForm").data('bootstrapValidator').isValid()) {
        $("#addOutButton").attr("disabled", "disabled");
    } else {
        $("#addOutButton").removeAttr("disabled");
    }
}

function editSubmit() {
    $("#editIOForm").data('bootstrapValidator').validate();
    if ($("#editIOForm").data('bootstrapValidator').isValid()) {
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
                if (formId == 'addOutForm') {
                    $("input[type=reset]").trigger("click"); // 移除表单中填的值
                    $('#addOutForm').data('bootstrapValidator').resetForm(true); // 移除所有验证样式
                    $("#addOutButton").removeAttr("disabled"); // 移除不可点击
                } else if  (formId == 'addInForm') {
                    $("input[type=reset]").trigger("click"); // 移除表单中填的值
                    $('#addInForm').data('bootstrapValidator').resetForm(true); // 移除所有验证样式
                    $("#addInButton").removeAttr("disabled"); // 移除不可点击
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

