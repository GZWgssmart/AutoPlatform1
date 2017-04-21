
var contentPath=''


//初始化表格
$(function () {
    initTable('table', '/accInv/queryByPage'); // 初始化表格
});

// 查看全部可用
function showAvailable(){
    initTable('table', '/accInv/queryByPage');
}
// 查看全部禁用
function showDisable(){
    initTable('table', '/accInv/queryByPagerDisable');
}

$(function () {
    $('#table').bootstrapTable('hideColumn', 'accId');
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
    language: 'zh-CN',
    format: 'yyyy-mm-dd hh:ii'
});
$('#addDateTimePicker2').datetimepicker({
    language: 'zh-CN',
    format: 'yyyy-mm-dd hh:ii'
});
$('#addDateTimePicker3').datetimepicker({
    language: 'zh-CN',
    format: 'yyyy-mm-dd hh:ii'
});
$('#editDateTimePicker').datetimepicker({
    language: 'zh-CN',
    format: 'yyyy-mm-dd hh:ii'
});
$('#editDateTimePicker2').datetimepicker({
    language: 'zh-CN',
    format: 'yyyy-mm-dd hh:ii'
});
$('#editDateTimePicker3').datetimepicker({
    language: 'zh-CN',
    format: 'yyyy-mm-dd hh:ii'
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
            accTypeId: {
                required: true,
                minlength: 2
            },
            accName: {
                required: true,
                minlength: 2
            },
            accCommodityCode: {
                required: true,
                minlength: 2
            },
            accDes: {
                required: true,
                minlength: 2
            },
            accPrice: {
                required: true,
                minlength: 2
            },
            accSalePrice: {
                required: true,
                minlength: 2
            },
            accTotal: {
                required: true,
                minlength: 2
            },
            accIdle: {
                required: true,
                minlength: 2
            }
        },
        messages: {
            companyId: "请输入公司名称",
            accTypeId: "请输入配件所属类别",
            accName: "请输入配件名称",
            accCommodityCode: "请输入配件商品条码",
            accDes: "请输入配件描述",
            accPrice: "请输入配件价格",
            accSalePrice: "请输入配件售价",
            accTotal: "请输入配件数量",
            accIdle: "请输入配件可用数量",
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
            $.post(contentPath+"/accInv/addAccInv",$("#addForm").serialize(),function (data) {
                if(data.result=="success"){
                    $("#addWindow").modal('hide'); // 关闭指定的窗口
                    $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                    swal({
                        title: "",
                        text: data.message,
                        type: "success"
                    })
                }else{
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
            accTypeId: {
                required: true,
                minlength: 2
            },
            accName: {
                required: true,
                minlength: 2
            },
            accCommodityCode: {
                required: true,
                minlength: 2
            },
            accDes: {
                required: true,
                minlength: 2
            },
            accPrice: {
                required: true,
                minlength: 2
            },
            accSalePrice: {
                required: true,
                minlength: 2
            },
            accTotal: {
                required: true,
                minlength: 2
            },
            accIdle: {
                required: true,
                minlength: 2
            }
        },
        messages: {
            companyId: "请输入公司名称",
            accTypeId: "请输入配件所属类别",
            accName: "请输入配件名称",
            accCommodityCode: "请输入配件商品条码",
            accDes: "请输入配件描述",
            accPrice: "请输入配件价格",
            accSalePrice: "请输入配件售价",
            accTotal: "请输入配件数量",
            accIdle: "请输入配件可用数量"
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
            $.post(contentPath+"/accInv/updateAccInv",$("#editForm").serialize(),function (data) {
                if(data.result=="success"){
                    $("#editWindow").modal('hide'); // 关闭指定的窗口
                    $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                    swal({
                        title: "",
                        text: data.message,
                        type: "success"
                    })
                }else{
                    swal({
                        title: "",
                        text: data.message,
                        type: "fail"
                    })
                }
            })
        }
    })
});
