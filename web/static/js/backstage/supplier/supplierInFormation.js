$(function () {
    var roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员";
    $.post("/user/isLogin/"+roles, function (data) {
        if(data.result == 'success'){
            initTable("table", "/supply/queryByPager"); // 初始化表格

            initSelect2("company", "请选择所属公司", "/company/queryAllCompany");
            initSelect2("supplyType", "请选择供应商类型", "/supplyType/queryAllSupplyType");
        }else if(data.result == 'notLogin'){
            swal({title:"",
                    text:data.message,
                    confirmButtonText:"确认",
                    type:"error"}
                ,function(isConfirm){
                    if(isConfirm){
                        top.location = "/user/loginPage";
                    }else{
                        top.location = "/user/loginPage";
                    }
                })
        }else if(data.result == 'notRole'){
            swal({title:"",
                text:data.message,
                confirmButtonText:"确认",
                type:"error"})
        }
    });
});

// 模糊查询
function blurredQuery(){
    var roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员";
    $.post("/user/isLogin/"+roles, function (data) {
        if(data.result == 'success'){
            var button = $("#ulButton");// 获取模糊查询按钮
            var text = button.text();// 获取模糊查询按钮文本
            var vaule = $("#ulInput").val();// 获取模糊查询输入框文本
            initTable('table', '/supply/blurredQuery?text='+text+'&value='+vaule);
        }else if(data.result == 'notLogin'){
            swal({title:"",
                    text:data.message,
                    confirmButtonText:"确认",
                    type:"error"}
                ,function(isConfirm){
                    if(isConfirm){
                        top.location = "/user/loginPage";
                    }else{
                        top.location = "/user/loginPage";
                    }
                })
        }else if(data.result == 'notRole'){
            swal({title:"",
                text:data.message,
                confirmButtonText:"确认",
                type:"error"})
        }
    });
}

function showEdit(){
    var roles = "公司超级管理员,公司普通管理员";
    $.post("/user/isLogin/"+roles, function (data) {
        if (data.result == 'success') {
            var row = $('#table').bootstrapTable('getSelections');
            if (row.length > 0) {
                $("#editWindow").modal('show'); // 显示弹窗
                $("#editButton").removeAttr("disabled");
                var supply = row[0];
                $('#editSupplyType').html('<option value="' + supply.supplyType.supplyTypeId + '">' + supply.supplyType.supplyTypeName + '</option>').trigger("change");
                $('#editCompanyName').html('<option value="' + supply.company.companyId + '">' + supply.company.companyName + '</option>').trigger("change");
                $('#editCity_china').val(formatterAddress(supply.supplyAddress));
                $("#editForm").fill(supply);
                validator('editForm');
            } else {
                swal({
                    title: "",
                    text: "请选择要修改的供应商记录", // 主要文本
                    confirmButtonColor: "#DD6B55", // 提示按钮的颜色
                    confirmButtonText: "确定", // 提示按钮上的文本
                    type: "warning"
                }) // 提示类型
            }
        } else if (data.result == 'notLogin') {
            swal({
                    title: "",
                    text: data.message,
                    confirmButtonText: "确认",
                    type: "error"
                }
                , function (isConfirm) {
                    if (isConfirm) {
                        top.location = "/user/loginPage";
                    } else {
                        top.location = "/user/loginPage";
                    }
                })
        } else if (data.result == 'notRole') {
            swal({
                title: "",
                text: data.message,
                confirmButtonText: "确认",
                type: "error"
            })
        }
    });
}


function showAdd(){
    var roles = "公司超级管理员,公司普通管理员";
    $.post("/user/isLogin/"+roles, function (data) {
        if (data.result == 'success') {
            $("#addWindow").modal('show');
            $("#addButton").removeAttr("disabled");
            validator('addForm'); // 初始化验证
        } else if (data.result == 'notLogin') {
            swal({
                    title: "",
                    text: data.message,
                    confirmButtonText: "确认",
                    type: "error"
                }
                , function (isConfirm) {
                    if (isConfirm) {
                        top.location = "/user/loginPage";
                    } else {
                        top.location = "/user/loginPage";
                    }
                })
        } else if (data.result == 'notRole') {
            swal({
                title: "",
                text: data.message,
                confirmButtonText: "确认",
                type: "error"
            })
        }
    });
}

function validator(formId) {
    $('#' + formId).bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            supplyName: {
                message: '供应商名称验证失败',
                validators: {
                    notEmpty: {
                        message: '供应商名称不能为空'
                    },
                    stringLength: {
                        min: 1,
                        max: 6,
                        message: '供应商名称长度必须在1到6位之间'
                    }
                }
            },
            supplyTel: {
                message: '供应商联系电话验证失败',
                validators: {
                    notEmpty: {
                        message: '供应商联系电话不能为空'
                    },
                    stringLength: {
                        min: 11,
                        max: 11,
                        message: '手机号码必须为11位'
                    },
                    regexp: {
                        regexp: /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/,
                        message: '请输入正确的手机号'
                    }
                }
            },
            supplyPricipal: {
                message: '供应商负责人验证失败',
                validators: {
                    notEmpty: {
                        message: '供应商负责人不能为空'
                    }
                }
            },
            /*supplyAddress: {
                message: '供应商地址验证失败',
                validators: {
                    notEmpty: {
                        message: '供应商地址不能为空'
                    }
                }
            },*/
            supplyWeChat: {
                message: '供应商微信号验证失败',
                validators: {
                    notEmpty: {
                        message: '供应商微信号不能为空'
                    },
                    stringLength: {
                        min: 6,
                        max:20,
                        message: '可以使用6—20个字母、数字、下划线和减号，必须以字母开头。'
                    },
                    regexp: {
                        regexp: /^[a-zA-Z][a-zA-Z0-9_]{5,19}$/,
                        message: '请输入正确的微信号'
                    }
                }
            },
            supplyTypeId: {
                message: '供应商类型验证失败',
                validators: {
                    notEmpty: {
                        message: '供应商类型不能为空'
                    }
                }
            },
            /*companyId: {
                message: '供应商所属公司验证失败',
                validators: {
                    notEmpty: {
                        message: '供应商所属公司不能为空'
                    }
                }
            },*/
            supplyAlipay: {
                message: '供应商支付宝验证失败',
                validators: {
                    notEmpty: {
                        message: '供应商支付宝不能为空'
                    },
                    stringLength: {
                        min: 11,
                        max: 11,
                        message: '支付宝账号必须为11位'
                    },
                    regexp: {
                        regexp: /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/,
                        message: '请输入正确的支付宝帐号'
                    }
                }
            },
            supplyBank: {
                message: '开户银行全称验证失败',
                validators: {
                    notEmpty: {
                        message: '开户银行全称不能为空'
                    }
                }
            },
            supplyBankAccount: {
                message: '开户人姓名验证失败',
                validators: {
                    notEmpty: {
                        message: '开户人姓名不能为空'
                    }
                }
            },
            supplyBankNo: {
                message: '开户银行卡号验证失败',
                validators: {
                    notEmpty: {
                        message: '开户银行卡号不能为空'
                    },
                    stringLength: {
                        min: 16,
                        max: 19,
                        message: '开户银行卡号长度保持在16-19位'
                    },
                    regexp: {
                        regexp: /^(\d{16}|\d{19})$/,
                        message: '请输入正确的开户银行卡号'
                    }
                }
            }
        }
    })

        .on('success.form.bv', function (e) {
            if (formId == "addForm") {
                formSubmit("/supply/addSupply", formId, "addWindow");

            } else if (formId == "editForm") {
                formSubmit("/supply/updateSupply", formId, "editWindow");

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

// 格式化地址
function formatterAddress(val) {
    var address = val.split('-');
    $("#editProvince").val(address[0]);
    $("#editCity").val(address[1]);
    $("#editArea").val(address[2]);
}

//  修改时，点击地址的文本框后，文本框隐藏，地址下拉选择显示
var address = $("#address");
address.click(function () {
    address.css('display', 'none');
    $('#supplyAddress').css('display', 'block');
})


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
                   /* $("input[type=reset]").trigger("click"); // 移除表单中填的值
                    $('#addForm').data('bootstrapValidator').resetForm(true); // 移除所有验证样式
                    $("#addButton").removeAttr("disabled"); // 移除不可点击*/
                    // 设置select2的值为空
                    $("#addSupplyType").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                    $("#addCompanyName").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                }
            } else if (data.result == "fail") {
                swal({
                    title: "",
                    text: "添加失败",
                    confirmButtonText: "确认",
                    type: "error"
                })
                if(formId == 'addForm') {
                    $("#addButton").removeAttr("disabled");
                }else if(formId == 'editForm'){
                    $("#editButton").removeAttr("disabled");
                }
            }else if (data.result == "notLogin") {
                swal({title:"",
                        text:data.message,
                        confirmButtonText:"确认",
                        type:"error"}
                    ,function(isConfirm){
                        if(isConfirm){
                            top.location = "/user/loginPage";
                        }else{
                            top.location = "/user/loginPage";
                        }
                    })
                if(formId == 'addForm') {
                    $("#addButton").removeAttr("disabled");
                }else if(formId == 'editForm'){
                    $("#editButton").removeAttr("disabled");
                }
            }
        }, "json");
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

// 激活或禁用
function statusFormatter(value, row, index) {
    if(value == 'Y') {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='inactive(\""+'/supply/statusOperate?id='+row.supplyId+'&status=Y'+"\")'>禁用</button>&nbsp;&nbsp;"
                + "<a onclick='showDetail()' class='btn btn-info btn-sm'><span class='glyphicon glyphicon-fullscreen'></span>详细信息</a>";
    } else {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-success' onclick='active(\""+'/supply/statusOperate?id='+ row.supplyId+'&status=N'+ "\")'>激活</button>&nbsp;&nbsp;"
                + "<a onclick='showDetail()' class='btn btn-info btn-sm'><span class='glyphicon glyphicon-fullscreen'></span>详细信息</a>";
    }
}

// 查看全部可用
function searchRapidStatus(){
    var roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员";
    $.post("/user/isLogin/"+roles, function (data) {
        if(data.result == 'success'){
            initTable('table', '/supply/queryByPager');
        }else if(data.result == 'notLogin'){
            swal({title:"",
                    text:data.message,
                    confirmButtonText:"确认",
                    type:"error"}
                ,function(isConfirm){
                    if(isConfirm){
                        top.location = "/user/loginPage";
                    }else{
                        top.location = "/user/loginPage";
                    }
                })
        }else if(data.result == 'notRole'){
            swal({title:"",
                text:data.message,
                confirmButtonText:"确认",
                type:"error"})
        }
    });
}
// 查看全部禁用
function searchDisableStatus(){
    var roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员";
    $.post("/user/isLogin/"+roles, function (data) {
        if(data.result == 'success'){
            initTable('table', '/supply/queryByPagerDisable');
        }else if(data.result == 'notLogin'){
            swal({title:"",
                    text:data.message,
                    confirmButtonText:"确认",
                    type:"error"}
                ,function(isConfirm){
                    if(isConfirm){
                        top.location = "/user/loginPage";
                    }else{
                        top.location = "/user/loginPage";
                    }
                })
        }else if(data.result == 'notRole'){
            swal({title:"",
                text:data.message,
                confirmButtonText:"确认",
                type:"error"})
        }
    });
}

// 点击显示详细信息
function showDetail() {
    var row = $('table').bootstrapTable('getSelections');
    if (row.length > 0) {
        var supply = row[0];
        var createdTime = supply.supplyCreatedTime;
        /* 创建时间 */
        var formatterCreateTime = formatterDateTime(createdTime);
        $("#detailCreatedTime").val(formatterCreateTime);

        $("#detailWindow").modal('show');
        $('#detailCreatedTime').val(formatterDateTime(supply.supplyCreatedTime));
        /* 格式化带时分秒的时间 */
        $("#detailForm").fill(supply);

        // 将获取到的userIcon 的值 赋给img的src  attr=>属性 val=>值

        console.log(formatterDateTime(supply.supplyCreatedTime));
        console.log(supply);
    }
}