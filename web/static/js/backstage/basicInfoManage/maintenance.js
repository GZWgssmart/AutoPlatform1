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
        $.post("/maintainSchedule/queryScheduleByRecord/" + row[0].recordId, function (data) {
            // 查询出此记录所有明细进行forEach
            var htmlDiv = "";
            $.each(data, function(index, value, item) {
                if(row[0].maintainRecord.currenStatus != '已登记' || row[0].maintainRecord.currenStatus != '维修保养中') {
                    if (htmlDiv == "") {// 假如这个字符串刚开始设置,
                        htmlDiv = "<button class='btn btn-info btn-circle btn-lg' type='button' style='border-radius:45px;height:45px;'>" + (index + 1) + "</button>" +
                            "<div id='id1' style='border-bottom: 5px solid red;display:inline;'onclick='edit(this)'>&nbsp;&nbsp;" + data[index].maintainScheduleDes + "&nbsp;&nbsp;</div>"
                    } else {
                        htmlDiv += "<button class='btn btn-info btn-circle btn-lg' type='button' style='border-radius:45px;height:45px;'>" + (index + 1) + "</button>" +
                            "<div id='id2' style='border-bottom: 5px solid red;display:inline;' onclick='edit(this)'>&nbsp;&nbsp;" + data[index].maintainScheduleDes + "&nbsp;&nbsp;</div>";// 否则就加上逗号把rows里所有的id都赋给ids
                    }
                }
                $("#maintenance").html(htmlDiv);
            });
        });
    }else{
        swal({
            title:"",
            text: "请选择要查看进度的维修保养记录", // 主要文本
            confirmButtonColor: "#dd2e32", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"warning"}) // 提示类型
    }
}

// 点击修改
   function edit(obj){
    if(obj == "id1"){
        var n=document.getElementById("id1").innerText;
    }else{
        var n= document.getElementById("id2").innerText;
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

function openStatusFormatter(index, row) {
    /*处理数据*/
    if (row.workStatus == 'Y') {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='active(\""+'/maintainSchedule/statusOperate?id='+row.workId+'&status=Y'+"\")'>未完成</a>";
    } else {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='inactive(\""+'/maintainSchedule/statusOperate?id='+row.workId+'&status=N'+"\")'>已完成</a>";
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
            formSubmit("/maintainSchedule/addSchedule", formId, "addWindow");
        } else if (formId == "editForm") {
            formSubmit("/maintainSchedule/updateSchedule", formId, "editWindow");

        }
    })
}

function addSubmit(){
    $("#addForm").data('bootstrapValidator').validate();
    if($("#addForm").data('bootstrapValidator').isValid()){
        $("#addButton").attr("disabled","disabled");
    }else{
        $("#addButton").removeAttr("disabled");//按钮只能点击一次
    }
}

function editSubmit(){
    $("#editForm").data('bootstrapValidator').validate();
    if($("#editForm").data('bootstrapValidator').isValid()){
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
            }
        }, "json"
    );
}

function formSubmit(url, formId, winId) {
    $.post(contentPath + "/user/isLogin/" + roles, function (data) {
        if (data.result == "success") {
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
                            // $("input[type=reset]").trigger("click"); // 移除表单中填的值
                            // $("#addButton").removeAttr("disabled"); // 移除不可点击
                            // $("#addCompany").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                            // $("#addSupply").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                            // $("#addAccType").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                        }
                        // $("#" + formId).data('bootstrapValidator').destroy(); // 销毁此form表单
                        // $('#' + formId).data('bootstrapValidator', null);// 此form表单设置为空
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
        } else if (data.result == "notLogin") {
            swal({
                text: data.message,
                confirmButtonText: "确认", // 提示按钮上的文本
                type: "error"
            }, function (isConfirm) {
                if (isConfirm) {
                    top.location = "/user/loginPage";
                } else {
                    top.location = "/user/loginPage";
                }
            })
        } else if (data.result = "notRole") {
            swal({
                text: data.message,
                confirmButtonText: "确认", // 提示按钮上的文本
                type: "error"
            })
        }
    })
}
