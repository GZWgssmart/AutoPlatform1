var contentPath = ''
var roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,车主,汽车公司总技师,汽车公司技师"
/*初始化表格*/
$(function(){
    $.post(contentPath + "/user/isLogin/" + roles, function (data) {
        if(data.result == 'success'){
            initTable('table','/Order/queryBySche');//初始化表格
            // initSelect2("maintainRecord","请选择保养记录编号","/maintainRecord/queryByPager");
        }else if(data.result == 'notLogin'){
            swal({
                title:"",
                confirmButtonText:"确认",
                type:"error"
            },function (isConfirm) {
                if(isConfirm){
                    top.location = "/user/loginPage";
                }else{
                    top.location = "/user/loginPage";
                }
            })
        }else if(data.result == 'notRole'){
            swal({
                title:"",
                confirmButtonText:"确认",
                type:"error"})
        }
    });
});



// 显示所有进度
function showSchedule(){
    var row =  $('#table').bootstrapTable('getSelections');
    if(row.length >0) {
        $("#ScheduleWindow").modal('show');
    }else{
        swal({
            title:"",
            text: "请选择要查看进度的维修保养记录", // 主要文本
            confirmButtonColor: "#dd2e32", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"warning"}) // 提示类型
    }
}
function statusFormatter(index, row) {
    /*处理数据*/
    if (row.workStatus == 'Y') {
        return "&nbsp;&nbsp;已完成";
    } else {
        return "&nbsp;&nbsp;未完成";
    }

}

//显示添加
function showAdd() {
    var row = $("#table").bootstrapTable('getSelections');
    if(row.length > 0){
        $("#addMaintainRecordId").val(row[0].maintainRecord.recordId);
        $("#ScheduleWindow").modal('hide');
        $("#addWindow").modal('show');
        $("#addButton").removeAttr("disabled");//按钮只能点击一次
        validator('addForm');//初始化验证
    }else{
        swal({
            title:"",
            text: "请选择要添加进度描述的维修保养记录", // 主要文本
            confirmButtonColor: "#DD6B55", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"warning"}) // 提示类型
    }
}


//显示修改
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

 function openAddSchedule(){
     initTableNotTollbar("addScheudleTable","/maintainRecord/queryByPager");
     // initTableNotTollbar("addScheudleTable","/maintainRecord/queryByPager");
     // initTable("maintainRecord","请选择保养记录编号","/maintainRecord/queryByPager");
     $("#addWindow").modal('hide');
     $("#AddScheduleWindow").modal('show');
 }

 function closeAddSchedule(){
     $("#AddScheduleWindow").modal('hide');
     $("#addWindow").modal('show');
 }

/** add维修保养记录 */
function checkPersonnel() {
    var selectRow = $("#addScheudleTable").bootstrapTable('getSelections');
    if (selectRow.length != 1) {
        swal('选择失败', "只能选择一条数据", "error");
        return false;
    } else {
        $("#AddScheduleWindow").modal('hide');
        $("#add").modal('show');
        var user = selectRow[0];
        $("#checkin.userName").val(user.userName);
        $("#userId").val(user.userId);
        $("#addWindow").modal('show');
    }
}

//验证数据格式
function validator(formId) {
    $('#' + formId).bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            maintainScheduleDes: {
                message: '进度不能为空',
                validators: {
                    notEmpty: {
                        message: '进度不能为空'
                    }
                }
            }
        }
    }).on('success.form.bv', function (e) {
        if (formId == "addForm") {
            formSubmit(contentPath + "/maintainSchedule/addSchedule", formId, "addWindow");
        } else if (formId == "editForm") {
            formSubmit(contentPath + "/maintainSchedule/updateSchedule", formId, "editWindow");

        }
    })
}

function addSubmit(){
    $("#addForm").data('bootstrapValidator').validate();
    if(("#addForm").data('bootstrapValidator').isValid()){
        $("#addButton").attr("disabled","disabled");
    }else{
        $("#addButton").removeAttr("disabled");//按钮只能点击一次
    }
}

function editSubmit(){
    $("#editForm").data('bootstrapValidator').validate();
    if(("#editForm").data('bootstrapValidator').isValid()){
        $("#editButton").attr("disabled","disabled");
    }else{
        $("#editButton").removeAttr("disabled");//按钮只能点击一次
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
                    /*  $("input[type=reset]").trigger("click"); // 移除表单中填的值
                     $('#addForm').data('bootstrapValidator').resetForm(true); // 移除所有验证样式
                     $("#addButton").removeAttr("disabled"); // 移除不可点击*/
                    // 设置select2的值为空
                   // $("#addCompanyName").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
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
