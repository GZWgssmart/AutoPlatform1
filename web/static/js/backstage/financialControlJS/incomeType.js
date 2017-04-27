

/**
 * 初始化表格
 */
$(function () {
    initTable("table", "/incomingType/queryByPager"); // 初始化表格
});


/**
 * 页面状态显示
 * @param index
 * @param row
 * @returns {*}
 */
function statusFormatter(index, row) {
    /*处理数据*/
    if(row.inTypeStatus == 'Y') {
        return "&nbsp;&nbsp;激活";
    } else {
        return "&nbsp;&nbsp;禁用";
    }

}

/**
 * 激活禁用显示
 * @param index
 * @param row
 * @returns {string}
 */
function openStatusFormatter(index, row) {
    /*处理数据*/
    if(row.inTypeStatus == 'Y') {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='active(\""+'/incomingType/statusOperate?id='+row.inTypeId+'&status=Y'+"\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='active(\""+'/incomingType/statusOperate?id='+row.inTypeId+'&status=N'+"\")'>激活</a>";
    }

}


/**
 * 查询禁用支出类型
 * @param id
 */
function searchDisableStatus() {
    initTable('table', '/incomingType/queryByPagerDisable');
}

/**
 * 查询激活支出类型
 * @param id
 */
function searchRapidStatus() {
    initTable('table', '/incomingType/queryByPager');
}


/**
 * 修改窗口
 */
function showEdit(){
    $("#editButton").removeAttr("disabled");
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
//                $('#editId').val(row[0].id);
//                $('#editName').val(row[0].name);
//                $('#editPrice').val(row[0].price);
        $("#edit").modal('show'); // 显示弹窗
        var incomingType = row[0];
        $("#editForm").fill(incomingType);
        validator("editForm");
    }else{
        swal({
            title:"",
            text:"请先选择一行数据",
            type:"warning"})
    }
}

/**
 * 添加窗口
 */
function showAdd(){
    $("#inTypeName").val("");
    $("#add").modal('show');
    $("#addButton").removeAttr("disabled");
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
            inTypeName: {
                message: '类型名称不能为空',
                remote:{                         //自带远程验证存在的方法
                    url:'/incomingType/checkInTypeName',
                    message: '用户已存在',//提示消息
                },
                validators: {
                    notEmpty: {
                        message: '类型名称不能为空',
                        remote:'此类型已经存在'
                    }

                }
            },
        }
    })

        .on('success.form.bv', function (e) {
            if (formId == "addForm") {
                formSubmit("/incomingType/add", formId, "add");

            } else if (formId == "editForm") {
                formSubmit("/incomingType/update", formId, "edit");

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
