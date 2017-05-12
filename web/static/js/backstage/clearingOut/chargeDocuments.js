$(function () {
    initTable('table', '/charge/queryByPager'); // 初始化表格
});

// 激活或禁用
function statusFormatter(value, row, index) {
    if(value == 'Y') {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='inactive(\""+'/charge/statusOperate?id='+row.chargeBillId+'&status=Y'+"\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-success' onclick='active(\""+'/charge/statusOperate?id='+ row.chargeBillId+'&status=N'+ "\")'>激活</a>";
    }
}

// 查看全部可用
function showAvailable(){
    initTable('table', '/charge/queryByPager');
}

// 查看全部禁用
function showDisable(){
    initTable('table', '/charge/queryByPagerDisable');
}

// 模糊查询
function blurredQuery(){
    var button = $("#ulButton");// 获取模糊查询按钮
    var text = button.text();// 获取模糊查询按钮文本
    var vaule = $("#ulInput").val();// 获取模糊查询输入框文本
    initTable('table', '/charge/blurredQuery?text='+text+'&value='+vaule);
}

function showEdit(){
    initDateTimePicker('editForm', 'chargeTime'); // 初始化时间框
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
        $("#editWindow").modal('show'); // 显示弹窗
        var chargeBill = row[0];
        $("#editForm").fill(chargeBill);
        $('#addDatetimepicker').val(formatterDate(chargeBill.chargeTime));
        validator('editForm'); // 初始化验证
    }else{
        swal({
            title:"",
            text: "请先选择要修改的单据", // 主要文本
            confirmButtonColor: "#DD6B55", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"warning"}) // 提示类型
    }
}

// 所有明细window中的打印按钮
function showPrint(){
    var row =  $('#table').bootstrapTable('getSelections'); // 选中的维修保养记录
    if(row.length >0) {
        window.parent.addChargeBillPrint(row[0].chargeBillId);
    }else{
        swal({
            title:"",
            text: "请先选择要修改的单据", // 主要文本
            confirmButtonColor: "#DD6B55", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"warning"}) // 提示类型
    }
}

function validator(formId) {
    $('#' + formId).bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            paymentMethod: {
                message: '付款方式验证失败',
                validators: {
                    notEmpty: {
                        message: '付款方式不能为空'
                    }
                }
            },
            chargeBillMoney: {
                message: '总金额验证失败',
                validators: {
                    notEmpty: {
                        message: '总金额不能为空'
                    }
                }
            },
            actualPayment: {
                message: '实际付款验证失败',
                validators: {
                    notEmpty: {
                        message: '实际付款不能为空'
                    }
                }
            },chargeTime: {
                message: '收费时间验证失败',
                validators: {
                    notEmpty: {
                        message: '收费时间不能为空'
                    }
                }
            },chargeBillDes: {
                message: '收费单据描述验证失败',
                validators: {
                    notEmpty: {
                        message: '收费单据描述不能为空'
                    }
                }
            }
        }
    })
        .on('success.form.bv', function (e) {
            if (formId == "editForm") {
                formSubmit("/charge/edit", formId, "editWindow");
            }
        })
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
                $("#" + formId).data('bootstrapValidator').destroy(); // 销毁此form表单
                $('#' + formId).data('bootstrapValidator', null);// 此form表单设置为空
            } else if (data.result == "fail") {
                swal({title:"",
                    text:data.message,
                    confirmButtonText:"确认",
                    type:"error"})
                $("#"+formId).removeAttr("disabled");
            }
        }, "json");
}