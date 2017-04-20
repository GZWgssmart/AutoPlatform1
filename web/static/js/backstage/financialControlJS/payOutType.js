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
        return "&nbsp;&nbsp;<a href='javascript:;' onclick='inactive(\"" + row.outTypeId + "\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<a href='javascript:;' onclick='active(\"" + row.outTypeId + "\")'>激活</a>";
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
    var row = $('table').bootstrapTable('getSelections');
    if (row.length > 0) {
//                $('#editId').val(row[0].id);
//                $('#editName').val(row[0].name);
//                $('#editPrice').val(row[0].price);
        $("#edit").modal('show'); // 显示弹窗
        var outGoingType = row[0];
        $("#outTypeUpdateForm").fill(outGoingType);
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
    $("#outTypeName").val("");
    $("#add").modal('show');
}


/**
 * 前台验证及form提交
 */
$(document).ready(function () {

    $("#outTypeInsertForm").validate({
        errorElement: 'span',
        errorClass: 'help-block',
        rules: {
            outTypeName: {
                required: true,
                minlength: 2
            },

        },
        messages: {
            outTypeName: {
                required: "请输入类型名称",
                minlength: jQuery.format("类型名称不能少于{2}个字符")
            },
        },
        errorPlacement: function (error, element) {
            element.next().remove();
            element.after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
            element.closest('.form-group').append(error);
        },
        highlight: function (element) {
            $(element).closest('.form-group').addClass('has-error has-feedback');
        },
        success: function (label) {
            var el = label.closest('.form-group').find("input");
            el.next().remove();
            el.after('<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
            label.closest('.form-group').removeClass('has-error').addClass("has-feedback has-success");
            label.remove();
        },
        submitHandler: function (form) {
            $.post("/outGoingType/add",
                $("#outTypeInsertForm").serialize(),
                function (data) {
                    if (data.result == "success") {
                        $("#add").modal('hide'); // 关闭指定的窗口
                        $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                        swal({
                            title: "",
                            text: data.message,
                            confirmButtonText: "确定", // 提示按钮上的文本
                            type: "success"
                        })// 提示窗口, 修改成功
                    } else if (data.result == "fail") {
                        swal({
                            title: "",
                            text: "添加失败",
                            confirmButtonText: "确认",
                            type: "error"
                        })
                    }
                }, "json"
            );
        }

    })

    $("#outTypeUpdateForm").validate({
        errorElement: 'span',
        errorClass: 'help-block',
        rules: {
            outTypeName: {
                required: true,
                minlength: 2
            },

        },
        messages: {
            outTypeName: {
                required: "请输入类型名称",
                minlength: jQuery.format("类型名称不能少于{2}个字符")
            },
        },
        errorPlacement: function (error, element) {
            element.next().remove();
            element.after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
            element.closest('.form-group').append(error);
        },
        highlight: function (element) {
            $(element).closest('.form-group').addClass('has-error has-feedback');
        },
        success: function (label) {
            var el = label.closest('.form-group').find("input");
            el.next().remove();
            el.after('<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
            label.closest('.form-group').removeClass('has-error').addClass("has-feedback has-success");
            label.remove();
        },
        submitHandler: function (form) {
            $.post("/outGoingType/update",
                $("#outTypeUpdateForm").serialize(),
                function (data) {
                    if (data.result == "success") {
                        $("#edit").modal('hide'); // 关闭指定的窗口
                        $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                        swal({
                            title: "",
                            text: data.message,
                            confirmButtonText: "确定", // 提示按钮上的文本
                            type: "success"
                        })// 提示窗口, 修改成功
                    } else if (data.result == "fail") {
                        swal({
                            title: "",
                            text: "添加失败",
                            confirmButtonText: "确认",
                            type: "error"
                        })
                    }
                }, "json"
            );
        }

    })
});