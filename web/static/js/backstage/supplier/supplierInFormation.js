$(document).ready(function() {
    // 手机号码验证
    jQuery.validator.addMethod("isPhone", function(value, element) {
        var length = value.length;
        return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(value));
    }, "请正确填写您的手机号码。");

    // 电话号码验证
    jQuery.validator.addMethod("isTel", function(value, element) {
        var tel = /^(\d{3,4}-)?\d{7,8}$/g; // 区号－3、4位 号码－7、8位
        return this.optional(element) || (tel.test(value));
    }, "请正确填写您的电话号码。");
    // 匹配密码，以字母开头，长度在6-12之间，必须包含数字和特殊字符。
    jQuery.validator.addMethod("isPwd", function(value, element) {
        var str = value;
        if (str.length < 6 || str.length > 18)
            return false;
        if (!/^[a-zA-Z]/.test(str))
            return false;
        if (!/[0-9]/.test(str))
            return fasle;
        return this.optional(element) || /[^A-Za-z0-9]/.test(str);
    }, "以字母开头，长度在6-12之间，必须包含数字和特殊字符。");

// 身份证
    jQuery.validator.addMethod("isIdCardNo", function (value, element, param){
        var checkName = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
        return this.optional(element) || (checkName.test(value));
    },$.validator.format("请输入正确的身份证号码"));

    $("#addForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',
        rules : {
            supplyName : {
                required : true,
                minlength : 2
            },
            supplyTel : {
                required : true,
                minlength : 2
            },
            supplyPricipal : {
                required : true,
                minlength : 2
            },
            supplyAddress : {
                required : true,
                minlength : 2
            },
            supplyWechat : {
                required : true,
                minlength : 2
            },
            supplyCreatedTime : {
                required : true,
                minlength : 18
            },
            supplyTypeName : {
                required : true,
                minlength : 2
            },
            companyName : {
                required : true,
                minlength : 2
            }
        },
        messages: {
            supplyName: "请输入供应商名称",
            supplyTel: "请输入供应商联系电话",
            supplyPricipal: "请输入供应商负责人",
            supplyAddress: "请输入供应商地址",
            supplyWechat: "请输入供应商微信号",
            supplyAddress: "请输入供应商地址",
            supplyWechat: "请输入供应商微信号",
            supplyTypeName: "请选择供应商类型",
            companyName: "请选择供应商所属公司",
        },
        errorPlacement : function(error, element) {
            element.next().remove();
            element.after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
            element.closest('.form-group').append(error);
        },
        highlight : function(element) {
            $(element).closest('.form-group').addClass('has-error has-feedback');
        },
        success : function(label) {
            var el=label.closest('.form-group').find("input");
            el.next().remove();
            el.after('<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
            label.closest('.form-group').removeClass('has-error').addClass("has-feedback has-success");
            label.remove();
        },
        submitHandler: function(form) {
            alert("submitted!");
        }
    })

    $("#editForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',
        rules : {
            supplyName : {
                required : true,
                minlength : 2
            },
            supplyTel : {
                required : true,
                minlength : 2
            },
            supplyPricipal : {
                required : true,
                minlength : 2
            },
            supplyAddress : {
                required : true,
                minlength : 2
            },
            supplyWechat : {
                required : true,
                minlength : 2
            },
            supplyCreatedTime : {
                required : true,
                minlength : 18
            },
            supplyTypeName : {
                required : true,
                minlength : 2
            },
            companyName : {
                required : true,
                minlength : 2
            }
        },
        messages: {
            supplyName: "请输入供应商名称",
            supplyTel: "请输入供应商联系电话",
            supplyPricipal: "请输入供应商负责人",
            supplyAddress: "请输入供应商地址",
            supplyWechat: "请输入供应商微信号",
            supplyAddress: "请输入供应商地址",
            supplyWechat: "请输入供应商微信号",
            supplyTypeName: "请选择供应商类型",
            companyName: "请选择供应商所属公司",
        },
        errorPlacement : function(error, element) {
            element.next().remove();
            element.after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
            element.closest('.form-group').append(error);
        },
        highlight : function(element) {
            $(element).closest('.form-group').addClass('has-error has-feedback');
        },
        success : function(label) {
            var el=label.closest('.form-group').find("input");
            el.next().remove();
            el.after('<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
            label.closest('.form-group').removeClass('has-error').addClass("has-feedback has-success");
            label.remove();
        },
        submitHandler: function(form) {
            alert("submitted!");
        }
    })
});





$(function () {
    $('#table').bootstrapTable('hideColumn', 'id');

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

function showEdit(){
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
//                $('#editId').val(row[0].id);
//                $('#editName').val(row[0].name);
//                $('#editPrice').val(row[0].price);
        $("#edit").modal('show'); // 显示弹窗
        var ceshi = row[0];
        $("#editForm").fill(ceshi);
    }else{
        swal({
            title:"",
            text:"请先选择一行数据",
            type:"warning"})// 提示窗口, 修改成功
    }
}

function showAdd(){

    $("#add").modal('show');
}

function formatRepo(repo){return repo.text}
function formatRepoSelection(repo){return repo.text}

function showDel(){
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
        $("#del").modal('show');
    }else{
        $("#tanchuang").modal('show');
    }
}

function checkAdd(){
    var id = $('#addId').val();
    var name = $('#addName').val();
    var price = $('#addPrice').val();
    var reslist=$("#addSelect").select2("data"); //获取多选的值
    alert(reslist.length)
    if(id != "" && name != "" && price != ""){
        return true;
    }else{
        var error = document.getElementById("addError");
        error.innerHTML = "请输入正确的数据";
        return false;
    }
}

function checkEdit() {
    $.post("/table/edit",
        $("#editForm").serialize(),
        function (data) {
            if (data.result == "success") {
                $("#edit").modal('hide'); // 关闭指定的窗口
                $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                swal({
                    title:"",
                    text: data.message,
                    type:"success"})// 提示窗口, 修改成功
            } else if (data.result == "fail") {
                //$.messager.alert("提示", data.result.message, "info");
            }
        }, "json"
    );
}

