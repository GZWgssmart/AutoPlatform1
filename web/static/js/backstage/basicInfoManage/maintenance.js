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



// 显示所有明细
function showSchedule(){
    var row =  $('#table').bootstrapTable('getSelections');
    if(row.length >0) {
        //maintainId = row[0].maintainId;
        $("#ScheduleWindow").modal('show');
        //initDetailTable('detailTable', '/maintain/queryByDetailsByPager?maintainId='+row[0].maintainId);
    }else{
        swal({
            title:"",
            text: "请选择要查看明细的维修保养记录", // 主要文本
            confirmButtonColor: "#dd2e32", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"warning"}) // 提示类型
    }
}

//显示添加
function showAdd() {
    $("#addWindow").modal('show');
    $("#addButton").removeAttr("disabled");//按钮只能点击一次
    validator('addForm');//初始化验证
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

//显示删除
function showDel() {

    var row = $('table').bootstrapTable('getSelections');
    if (row.length > 0) {
        $("#del").modal('show');
        var ceshi = row[0];
        $("#tanchuang").fill(ceshi);
    } else {
        swal({
            "title": "",
            "text": "请先选择一条数据",
            "type": "warning"
        })
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
            maintainRecordId: {
                message: '维修记录编号不能为空',
                validators: {
                    notEmpty: {
                        message: '维修记录编号不能为空'
                    }
                }
            },
            maintainScheduleDes: {
                message: '进度不能为空',
                validators: {
                    notEmpty: {
                        message: '进度不能为空'
                    }
                }
            },
            msCreatedTime: {
                message: '维修创建时间不能为空',
                validators: {
                    notEmpty: {
                        message: '维修创建时间不能为空'
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
        return year + "-" + month + "-" + day
    }
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
