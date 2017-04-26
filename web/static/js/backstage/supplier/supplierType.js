var contentPath = ''
$(function () {
    initTable("table", "/supplyType/queryByPager"); // 初始化表格

    initSelect2("company", "请选择所属公司", "/company/queryAllCompany");
});

/*
// 模糊查询
function blurredQuery(){
    var button = $("#ulButton");// 获取模糊查询按钮
    var text = button.text();// 获取模糊查询按钮文本
    var vaule = $("#ulInput").val();// 获取模糊查询输入框文本
    initTable('table', '/supplyType/blurredQuery?text='+text+'&value='+vaule);
}
*/

function showEdit(){
    var row =  $('#table').bootstrapTable('getSelections');
    if(row.length >0) {
        $("#editWindow").modal('show'); // 显示弹窗
        $("#editButton").removeAttr("disabled");
        var supplyType = row[0];
        $('#editCompanyName').html('<option value="' + supplyType.company.companyId + '">' + supplyType.company.companyName + '</option>').trigger("change");
        $("#editForm").fill(supplyType);
        validator('editForm');
    }else{
        swal({
            title:"",
            text: "请选择要修改的供应商类型记录", // 主要文本
            confirmButtonColor: "#DD6B55", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"warning"}) // 提示类型
    }
}

function showAdd(){
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
            supplyTypeName: {
                message: '供应商类型名称验证失败',
                validators: {
                    notEmpty: {
                        message: '供应商类型名称不能为空'
                    },
                    stringLength: {
                        min: 1,
                        max: 6,
                        message: '供应商类型名称长度必须在1到6位之间'
                    }
                }
            },
            companyId: {
                message: '供应商类型所属公司验证失败',
                validators: {
                    notEmpty: {
                        message: '供应商类型所属公司不能为空'
                    }
                }
            },
            supplyTypeDes: {
                message: '供应商类型描述内容验证失败',
                validators: {
                    notEmpty: {
                        message: '供应商类型描述内容不能为空'
                    }
                }
            }
        }
    })

        .on('success.form.bv', function (e) {
            if (formId == "addForm") {
                formSubmit("/supplyType/addSupplyType", formId, "addWindow");

            } else if (formId == "editForm") {
                formSubmit("/supplyType/updateSupplyType", formId, "editWindow");

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
                    $("#" + formId).data('bootstrapValidator').destroy(); // 销毁此form表单
                    $('#' + formId).data('bootstrapValidator', null);// 此form表单设置为空
                    // 设置select2的值为空
                    $("#addCompanyName").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
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

// 激活或禁用
function statusFormatter(value, row, index) {
    if(value == 'Y') {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='inactive(\""+'/supplyType/statusOperate?id='+row.supplyTypeId+'&status=Y'+"\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-success' onclick='active(\""+'/supplyType/statusOperate?id='+ row.supplyTypeId+'&status=N'+ "\")'>激活</a>";
    }
}


/**
 * 查询禁用支出类型
 * @param id
 */
function searchDisableStatus() {
    initTable('table', '/supplyType/queryByPagerDisable');
}

/**
 * 查询激活支出类型
 * @param id
 */
function searchRapidStatus() {
    initTable('table', '/supplyType/queryByPager');
}



