/**
 * 初始化表格
 */
$(function () {
    initTable("table", "/outGoingType/queryByPager"); // 初始化表格
});

/**
 * 禁用激活
 * @param index
 * @param row
 * @returns {*}
 */
function statusFormatter(index, row) {
    /*处理数据*/
    if (row.outTypeStatus == 'Y') {
        return "&nbsp;&nbsp;激活";
    } else {
        return "&nbsp;&nbsp;禁用";
    }

}

/**
 * 操作禁用激活
 * @param index
 * @param row
 * @returns {string}
 */
function openStatusFormatter(index, row) {
    /*处理数据*/
    if (row.outTypeStatus == 'Y') {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='inactive(\""+row.outTypeId+ "\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='active(\""+row.outTypeId+ "\")'>激活</a>";
    }

}


/**
 * 禁用支出类型
 * @param id
 */
function inactive(id) {
    $.post("/outGoingType/inactive?id=" + id,
        function (data) {
            if (data.result == "success") {
                $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
            }
        })
}


/**
 * 激活支出类型
 * @param id
 */
function active(id) {
    $.post("/outGoingType/active?id=" + id,
        function (data) {
            if (data.result == "success") {
                $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
            }
        })
}

/**
 * 查询禁用支出类型
 * @param id
 */
function searchDisableStatus() {
    initTable('table', '/outGoingType/queryByPagerDisable');
}

/**
 * 查询激活支出类型
 * @param id
 */
function searchRapidStatus() {
    initTable('table', '/outGoingType/queryByPager');
}


/**
 * 点击修改窗口
 */
function showEdit() {
    $("#editButton").removeAttr("disabled");
    var row = $('table').bootstrapTable('getSelections');
    if (row.length > 0) {
//                $('#editId').val(row[0].id);
//                $('#editName').val(row[0].name);
//                $('#editPrice').val(row[0].price);
        $("#edit").modal('show'); // 显示弹窗
        var outGoingType = row[0];
        $("#editForm").fill(outGoingType);
        validator("editForm");
    } else {
        swal({
            title: "",
            text: "请先选择一行数据",
            type: "warning"
        })
    }
}

/**
 * 点击添加窗口
 */
function showAdd() {
    $("#addButton").removeAttr("disabled");
    $("#outTypeName").val("");
    $("#add").modal('show');
    validator("addForm");
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
            outTypeName: {
                message: '类型名称不能为空',
                validators: {
                    notEmpty: {
                        message: '类型名称不能为空',
                    }

                }
            },
        }
    })

        .on('success.form.bv', function (e) {
            if (formId == "addForm") {
                formSubmit("/outGoingType/add", formId, "add");

            } else if (formId == "editForm") {
                formSubmit("/outGoingType/update", formId, "edit");

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
