var contentPath = ''

/**
 *初始化表格
 * @type {string}
 */
$(function () {
    initTable("table","/Order/queryByPager");



    // initSelect2("record","请选择保养记录","/maintainRecord/queryByPager");
    initSelect2("user","请选择用户","/userBasicManage/queryAll");
   /* initSelect2("editRecordTable","/maintainRecord/queryByPager");
    initSelect2("editUserTable","/userBasicManage/queryByPager");*/
});



/*/!*edit选择用户弹窗*!/
function openEditUser(){
    initTableNotTollbar("editUserTable","/userBasicManage/queryByPager");
    $("#editWindow").modal('hide');
    $("#editUserWindow").modal('show');
}
/!*edit用户弹窗关闭*!/
function closeEditUser(){
    $("#editUserWindow").modal('hide');
    $("#editWindow").modal('show');
}

//添加
function showAdd(){
    initDateTimePicker('addForm', 'workAssignTime'); // 初始化时间框, 第一参数是form表单id, 第二参数是input的name
    $("#addWindow").modal('show');
    $("#addButton").removeAttr("disabled");
    validator('addForm'); // 初始化验证
}*/

/*表格验证*/
function validator(formId) {
    $('#' + formId).bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            recordId: {
                message: '工单保养记录验证失败',
                validators: {
                    notEmpty: {
                        message: '保养记录编号不能为空'
                    }
                }
            },
            userId: {
                message: '指派用户验证失败',
                validators: {
                    notEmpty: {
                        message: '用户名不能为空'
                    },
                    stringLength: {
                        min: 1,
                        max: 6,
                        message: '用户名长度必须在1到6位之间'
                    }
                }
            },
            workAssignTime: {
                message: '工单指派时间验证失败',
                validators: {
                    notEmpty: {
                        message: '工单指派时间不能为空'
                    }
                }
            },
            workCreatedTime: {
                message: '工单创建时间验证失败',
                validators: {
                    notEmpty: {
                        message: '工单创建时间不能为空'
                    }
                }
            }
        }
    })

        .on('success.form.bv', function (e) {
            if (formId == "editForm") {
                formSubmit("/Order/update", formId, "editWindow");

            } /*else if (formId == "editForm") {
                formSubmit("/Order/edit", formId, "editWindow");

            }*/
        })

}

/*function addSubmit(){
    $("#addForm").data('bootstrapValidator').validate();
    if($("#addForm").data('bootstrapValidator').isvalid()){//已验证
        $("#addButton").attr("disbled","disabled");
    }else{
        $("#addButton").removeAttr("disabled");
    }
}*/

function editSubmit(){
    $("#editForm").data('bootstrapValidator').validate();
    if($("#editForm").data('bootstrapValidator').isValid()){//已验证
        $("#editButton").attr("disbled","disabled");
    }else{
        $("#editButton").removeAttr("disabled");
    }
}

$('#editDateTimePicker').datetimepicker({
    minView: "month", //选择日期后，不会再跳转去选择时分秒
    language: 'zh-CN',
    format: 'yyyy-mm-dd',
    todayBtn: 1,
    autoclose: 1,
});


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
                    type: "success"})// 提示窗口, 修改成功
                $('#table').bootstrapTable('refresh');
                if (formId == 'addForm') {
                    $("input[type=reset]").trigger("click"); // 移除表单中填的值
                    $('#addForm').data('bootstrapValidator').resetForm(true); // 移除所有验证样式
                    $("#addButton").removeAttr("disabled"); // 移除不可点击
                    $("#" + formId).data('bootstrapValidator').destroy();//销毁此from表单
                    $('#' + fromId).data('bootstrapValidator',null);//此from表单设置为空
                    $("#editUserId").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                }
            } else if (data.result == "fail") {
                swal({
                    title: "",
                    text: "添加失败",
                    confirmButtonText: "确认",
                    type: "error"
                })
                $("#" + formId).removeAttr("disabled");
            }
        }, "json");
}

//修改
function showEdit() {
    /*//$("#editButton").removeAttr("disabled");
    initDatePicker('editForm', 'workAssignTime'); // 初始化时间框*/
    var row = $('#table').bootstrapTable('getSelections');//选择器
    if (row.length > 0) {
        $("#editWindow").modal('show'); // 显示弹窗
        $("#editButton").removeAttr('disabled');//按钮只能点击一次
        var workInfo=row[0]
        var editDate = document.getElementById("editDateTimePicker");
        $("#editDateTimePicker").val(formatterDate(workInfo.workAssignTime));
        $("#editUserId").html('<option value="' + workInfo.user.userId + '">' + workInfo.user.userNickName + '</option>').trigger("change");
        $("#editForm").fill(workInfo);
        validator('editForm');
    } else {
        swal({
            title: "",
            text: "请先选择要修改的工单信息",   //主要文本
            confirmButtonText:"确定",     //提示按钮上的文本
            type: "warning"     //提示类型
        })
    }
}

/*// 初始化没有分秒的时间框
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
 }*/

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

// 查看全部已完成
function showComplete() {
    initTable('table', '/Order/queryByPager');
}
// 查看全部未完成
function showDisable() {
    initTable('table', '/Order/queryByPagerDisable');
}


/**
 * 禁用激活
 * @param index
 * @param row
 * @returns {*}
 */
function statusFormatter(index, row) {
    /*处理数据*/
    if (row.workStatus == 'Y') {
        return "&nbsp;&nbsp;已完成";
    } else {
        return "&nbsp;&nbsp;未完成";
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
    if (row.workStatus == 'Y') {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='active(\""+'/Order/statusOperate?id='+row.workId+'&status=Y'+"\")'>未完成</a>";
    } else {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='inactive(\""+'/Order/statusOperate?id='+row.workId+'&status=N'+"\")'>已完成</a>";
    }

}




