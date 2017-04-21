var contentPath = '';

//初始化表格
$(function () {
    initTable('table', '/accSale/queryByPage'); // 初始化表格
});

// 查看全部可用
function showAvailable(){
    initTable('table', '/accSale/queryByPage');
}
// 查看全部禁用
function showDisable(){
    initTable('table', '/accSale/queryByPagerDisable');
}


$(function () {
    $('#table').bootstrapTable('hideColumn', 'accSaleId');
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
        $("#editWindow").modal('show'); // 显示弹窗
        var ceshi = row[0];
        var editDate = document.getElementById("editDateTimePicker");
        $("#editForm").fill(ceshi);
        editDate.value = formatterDate(row[0].accSaledTime);
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


// //日期时间控件初始化
// $(document).ready(function () {
//     // 带时间的控件
//     // if ($(".iDate.full").length > 0) {
//     //     $(".iDate.full").datetimepicker({
//     //         locale: "zh-cn",
//     //         format: "YYYY-MM-DD a hh:mm",
//     //         dayViewHeaderFormat: "YYYY年 MMMM"
//     //     });
//     // }
//
//     //不带时间的控件
//     if ($(".iDate.date").length > 0) {
//         $(".iDate.date").datetimepicker({
//             locale: "zh-cn",
//             format: "YYYY-MM-DD",
//             dayViewHeaderFormat: "YYYY年 MMMM"
//         });
//     }
// })

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
            accId: {
                required: true,
                minlength: 2
            },
            accSaledTime: {
                required: true,
                minlength: 2
            },
            accSaleCount: {
                required: true,
                minlength: 2
            },
            accSalePrice: {
                required: true,
                minlength: 2
            },
            accSaleTotal: {
                required: true,
                minlength: 2
            },
            accSaleDiscount: {
                required: true,
                minlength: 2
            },
            accSaleMoney: {
                required: true,
                minlength: 2
            }
        },
        messages: {
            companyId: "请输入所属公司",
            accId: "请输入配件编号",
            accSaledTime: "请输入销售时间",
            accSaleCount: "请输入配件销售数量",
            accSalePrice: "请输入配件销售单价",
            accSaleTotal: "请输入配件销售总价",
            accSaleDiscount: "请输入配件销售折扣",
            accSaleMoney: "请输入配件销售最终价"
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
            $.post(contentPath + "/accSale/addAccSale", $("#addForm").serialize(), function (data) {
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
            accId: {
                required: true,
                minlength: 2
            },
            accSaledTime: {
                required: true,
                minlength: 2
            },
            accSaleCount: {
                required: true,
                minlength: 2
            },
            accSalePrice: {
                required: true,
                minlength: 2
            },
            accSaleTotal: {
                required: true,
                minlength: 2
            },
            accSaleDiscount: {
                required: true,
                minlength: 2
            },
            accSaleMoney: {
                required: true,
                minlength: 2
            }
        },
        messages: {
            companyId: "请输入所属公司",
            accId: "请输入配件编号",
            accSaledTime: "请输入销售时间",
            accSaleCount: "请输入配件销售数量",
            accSalePrice: "请输入配件销售单价",
            accSaleTotal: "请输入配件销售总价",
            accSaleDiscount: "请输入配件销售折扣",
            accSaleMoney: "请输入配件销售最终价"
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
            $.post(contentPath + "/accSale/updateAccSale", $("#editForm").serialize(), function (data) {
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