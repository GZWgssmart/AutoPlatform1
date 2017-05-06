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

function showEdit(){
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
        $("#edit").modal('show'); // 显示弹窗
        var ceshi = row[0];
        $("#editForm").fill(ceshi);
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
            maintainItemName: {
                message: '维修保养项目验证失败',
                validators: {
                    notEmpty: {
                        message: '维修保养项目不能为空'
                    }
                }
            },
            maintainDiscount: {
                message: '维修保养项目折扣验证失败',
                validators: {
                    notEmpty: {
                        message: '维修保养项目折扣不能为空'
                    }
                }
            }
        }
    })
        .on('success.form.bv', function (e) {
            if (formId == "addForm") {
                formSubmit("/maintainDetail/add", formId, "addWindow");

            } else if (formId == "editForm") {
                formSubmit("/maintainDetail/edit", formId, "editWindow");

            }
        })

}