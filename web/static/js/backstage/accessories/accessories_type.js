var contentPath = ''

//初始化表格
$(function () {
    initTable('table', '/accType/queryByPage'); // 初始化表格
});

// 查看全部可用
function showAvailable(){
    initTable('table', '/accType/queryByPage');
}
// 查看全部禁用
function showDisable(){
    initTable('table', '/accType/queryByPagerDisable');
}

$(function () {
    $('#table').bootstrapTable('hideColumn', 'accTypeId');
    $("#addSelect").select2({
            language: 'zh-CN'
        }
    );

    //绑定Ajax的内容
    $.getJSON("/table/queryType", function (data) {
        $("#addSelect").empty();//清空下拉框
        $.each(data, function (i, item) {
            $("#addSelect").append("<option value='" + data[i].id + "'>&nbsp;" + data[i].name + "</option>");
        });
    })
//            $("#addSelect").on("select2:select",
//                    function (e) {
//                        alert(e)
//                        alert("select2:select", e);
//            });
});

//显示弹窗
function showEdit() {
    var row = $('table').bootstrapTable('getSelections');
    if (row.length > 0) {
//                $('#editId').val(row[0].id);
//                $('#editName').val(row[0].name);
//                $('#editPrice').val(row[0].price);
        $("#editWindow").modal('show'); // 显示弹窗
        var ceshi = row[0];
        $("#editForm").fill(ceshi);
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
    if (row.accTypeStatus == 'Y') {
        return "&nbsp;&nbsp;<a href='javascript:;' onclick='inactive(\"" + row.accTypeId + "\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<a href='javascript:;' onclick='active(\"" + row.accTypeId + "\")'>激活</a>";
    }
}

//禁用状态
function inactive(accTypeId) {
    $.post(contentPath + "/accType/statusOperate?accTypeId=" + accTypeId + "&" + "accTypeStatus=" + "Y", function (data) {
        if (data.result == "success") {
            $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
        }
    })
}

//激活状态
function active(accTypeId) {
    $.post(contentPath + "/accType/statusOperate?accTypeId=" + accTypeId + "&" + "accTypeStatus=" + 'N', function (data) {
        if (data.result == "success") {
            $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
        }
    })
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

//检查添加
function checkAdd() {
    var id = $('#addId').val();
    var name = $('#addName').val();
    var price = $('#addPrice').val();
    var reslist = $("#addSelect").select2("data"); //获取多选的值
    if (id != "" && name != "" && price != "") {
        return true;
    } else {
        var error = document.getElementById("addError");
        error.innerHTML = "请输入正确的数据";
        return false;
    }
}

//检查修改
function checkEdit() {
    $.post("/table/edit",
        $("#editForm").serialize(),
        function (data) {
            if (data.result == "success") {
                $("#editWindow").modal('hide'); // 关闭指定的窗口
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

//前端验证
$(document).ready(function () {
    $("#addForm").validate({
        errorElement: 'span',
        errorClass: 'help-block',

        rules: {
            companyId: {
                required: true,
                minlength: 2
            },
            accTypeName: {
                required: true,
                minlength: 2
            },
            accTypeDes: {
                required: false,
                minlength: 2
            }
        },
        messages: {
            companyId: "请输入所属公司",
            accTypeName: "请输入配件分类名称",
            accTypeDes: "请输入配件分类描述",
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
            $.post(contentPath + "/accType/addAccType", $("#addForm").serialize(), function (data) {
                if (data.result == "success") {
                    $("#addWindow").modal('hide'); // 关闭指定的窗口
                    $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                    swal({
                        title: "",
                        text: data.message,
                        type: "success"
                    })
                } else {
                    swal({
                        title: "",
                        text: data.message,
                        type: "fail"
                    })
                }
            })
        }
    })
    $("#editForm").validate({
        errorElement: 'span',
        errorClass: 'help-block',

        rules: {
            companyId: {
                required: true,
                minlength: 2
            },
            accTypeName: {
                required: true,
                minlength: 2
            },
            accTypeDes: {
                required: true,
                minlength: 2
            }
        },
        messages: {
            companyId: "请输入所属公司",
            accTypeName: "请输入配件分类名称",
            accTypeDes: "请输入配件分类描述"
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
            $.post(contentPath + "/accType/updateAccType", $("#editForm").serialize(), function (data) {
                if (data.result == "success") {
                    $("#editWindow").modal('hide'); // 关闭指定的窗口
                    $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                    swal({
                        title: "",
                        text: data.message,
                        type: "success"
                    })
                } else {
                    swal({
                        title: "",
                        text: data.message,
                        type: "fail"
                    })// 提示窗口, 修改成功
                }
            })
        }
    })
});
