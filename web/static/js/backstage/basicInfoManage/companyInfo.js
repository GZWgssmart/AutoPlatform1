$(function () {
    $('#table').bootstrapTable('hideColumn', 'companyId');
    $("#addSelect").select2({
            language: 'zh-CN'
        }
    );
    //绑定Ajax的内容
    // $.getJSON("/table/queryAll", function (data) {
    //     $("#addSelect").empty();//清空下拉框
    //     $.each(data, function (i, item) {
    //         $("#addSelect").append("<option value='" + data[i].id + "'>&nbsp;" + data[i].name + "</option>");
    //     });
    // })
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
        $("#edit").modal('show'); // 显示弹窗
        var ceshi = row[0];
        $("#showEditFormWar").fill(ceshi);
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
    $("#add").modal('show');
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
        $("#tanchuang").modal('show');
    }
}

//初始化文件上传控件
$(function () {
    //0.初始化fileinput
    var oFileInput = new FileInput();
    oFileInput.Init("add_companyLogo", "/file/addFile");
});

$(function () {
    //0.初始化fileinput
    var oFileInput = new FileInput();
    oFileInput.Init("edit_companyLogo", "/file/editFile");
});

//初始化fileinput
var FileInput = function () {
    var oFile = new Object();
    //初始化fileinput控件（第一次初始化）
    oFile.Init = function (ctrlName, uploadUrl) {
        var control = $('#' + ctrlName);
        //初始化上传控件的样式
        control.fileinput({
            language: 'zh', //设置语言
            uploadUrl: uploadUrl, //上传的地址
            allowedFileExtensions: ['jpg', 'gif', 'png'],//接收的文件后缀
            showUpload: true, //是否显示上传按钮
            showCaption: false,//是否显示标题
            browseClass: "btn btn-primary", //按钮样式
            dropZoneEnabled: true,//是否显示拖拽区域
            //minImageWidth: 50, //图片的最小宽度
            //minImageHeight: 50,//图片的最小高度
            //maxImageWidth: 1000,//图片的最大宽度
            //maxImageHeight: 1000,//图片的最大高度
            //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
            //minFileCount: 0,
            maxFileCount: 10, //表示允许同时上传的最大文件个数
            enctype: 'multipart/form-data',
            validateInitialCount: true,
            previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
            msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
        }).on("fileuploaded", function (event, data) {
            // data 为controller返回的json
            if (data.response.result == 'success') {
                alert('处理成功');
            }
        });
    }
    return oFile;
};

$('#addDateTimePicker').datetimepicker({
    language: 'zh-CN',
    format: 'yyyy-mm-dd hh:ii'
});
$('#editDateTimePicker').datetimepicker({
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

$(document).ready(function () {
    jQuery.validator.addMethod("isPhone", function (value, element) {
        var length = value.length;
        return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(value));
    }, "请正确填写您的手机号码。");

    $("#showAddFormWar").validate({
        errorElement: 'span',
        errorClass: 'help-block',

        rules: {
            companyName: {
                required: true,
                minlength: 2
            },
            companyAddress: {
                required: true,
                minlength: 2
            },
            companyTel: {
                required: true,
                isPhone: true,
            },
            companyPricipal: {
                required: true,
                minlength: 2
            },
            companyOpenDate: {
                required: true,
                date: true
            }
        },
        messages: {
            companyName: "请输入你的公司名",
            companyAddress: "请输入你的公司地址",
            companyTel: {
                required: "请输入你的联系方式",
            },
            companyPricipal: "请输入你的公司负责人",
            companyOpenDate: "请输入公司成立时间"
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
        submitHandler: function(form) {
            $.post("/company/add",
                $("#showAddFormWar").serialize(),
                function (data) {
                    if (data.result == "success") {
                        $("#add").modal('hide'); // 关闭指定的窗口
                        $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                        swal({
                            title:"",
                            text: data.message,
                            confirmButtonText:"确定", // 提示按钮上的文本
                            type:"success"})// 提示窗口, 修改成功
                    } else if (data.result == "fail") {
                        swal({title:"",
                            text:"添加失败",
                            confirmButtonText:"确认",
                            type:"error"})
                    }
                }, "json"
            );
        }
    }),


    $("#showEditFormWar").validate({
        errorElement: 'span',
        errorClass: 'help-block',

        rules: {
            companyName: {
                required: true,
                minlength: 2
            },
            companyAddress: {
                required: true,
                minlength: 2
            },
            companyTel: {
                required: true,
                isPhone: true,
            },
            companyPricipal: {
                required: true,
                minlength: 2
            },
            companyOpenDate: {
                required: true,
                date: true
            }
        },
        messages: {
            companyName: "请输入你的公司名",
            companyAddress: "请输入你的公司地址",
            companyTel: {
                required: "请输入你的联系方式",
            },
            companyPricipal: "请输入你的公司负责人",
            companyOpenDate: "请输入公司成立时间"
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
        submitHandler: function(form) {
            $.post("/company/update",
                $("#showEditFormWar").serialize(),
                function (data) {
                    if (data.result == "success") {
                        $("#edit").modal('hide'); // 关闭指定的窗口
                        $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                        swal({
                            title:"",
                            text: data.message,
                            confirmButtonText:"确定", // 提示按钮上的文本
                            type:"success"})// 提示窗口, 修改成功
                    } else if (data.result == "fail") {
                        swal({title:"",
                            text:"修改失败",
                            confirmButtonText:"确认",
                            type:"error"})
                    }
                }, "json"
            );
        }

    })
});