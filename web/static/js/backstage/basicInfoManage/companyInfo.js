$(function () {
    initTable('table', '/company/queryByPagerCompany'); // 初始化表格
});

//显示弹窗
function showEdit() {
    initDatePicker('editForm', 'companyOpendate'); // 初始化时间框
    var row = $('#table').bootstrapTable('getSelections');
    if (row.length > 0) {
        $("#editWindow").modal('show'); // 显示弹窗
        $("#editButton").removeAttr("disabled");
        var ceshi = row[0];
        $('#editDatetimepicker').val(formatterDate(ceshi.companyOpendate));
        $("#editForm").fill(ceshi);
        validator("editForm")
    } else {
        swal({
            title:"",
            text: "请选择要修改的公司信息", // 主要文本
            confirmButtonColor: "#DD6B55", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"warning"}) // 提示类型
    }
}

// 初始化没有分秒的时间框
function initDatePicker(formId, field){
    $(".datetimepicker").datetimepicker({
        minView: "month", //选择日期后，不会再跳转去选择时分秒
        language: 'zh-CN',
        format: 'yyyy-mm-dd',
        initialDate: new Date(),
        autoclose: true,
        todayHighligh:true,
        todayBtn :true, // 显示今日按钮
        autoclose: 1
    }).on('hide',function(e) {
        $('#'+formId).data('bootstrapValidator')
            .updateStatus(field, 'NOT_VALIDATED',null)
            .validateField(field);
    });
}
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

//显示添加
function showAdd(){
    initDatePicker('addForm', 'companyOpendate'); // 初始化时间框, 第一参数是form表单id, 第二参数是input的name
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
            companyName: {
                message: '公司名称验证失败',
                validators: {
                    notEmpty: {
                        message: '公司名称不能为空'
                    },
                    stringLength: {
                        min: 1,
                        max: 10,
                        message: '公司名称长度必须在1到10位之间'
                    }
                }
            },

            companyAddress: {
                message: '公司地址验证失败',
                validators: {
                    notEmpty: {
                        message: '公司地址不能为空'
                    }
                }
            },
            companyTel: {
                message: '联系电话验证失败',
                validators: {
                    notEmpty: {
                        message: '联系电话不能为空'
                    },
                    stringLength: {
                        min: 11,
                        max: 11,
                        message: '联系电话必须为11位'
                    },
                    regexp: {
                        regexp: /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/,
                        message: '请输入正确的手机号'
                    }
                }
            },
            companyPricipal: {
                message: '负责人验证失败',
                validators: {
                    notEmpty: {
                        message: '负责人不能为空'
                    },
                }
            },
            companyOpendate: {
                message: '公司成立时间验证失败',
                validators: {
                    notEmpty: {
                        message: '公司成立时间不能为空'
                    }
                }
            },

            companyLogo:{
                message: '公司LOGO验证失败',
                validators: {
                    notEmpty: {
                        message: '公司LOGO不能为空'
                    }
                }
            }
        }
    })

        .on('success.form.bv', function (e) {
            if (formId == "addForm") {
                formSubmit("/company/addCompany", formId, "addWindow");

            } else if (formId == "editForm") {
                formSubmit("/company/updateCompany", formId, "editWindow");

            }
        })

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