var contentPath = ''

/*初始化表格*/
$(function(){
    initTable('table','/Order/queryByPager');
    initSelect2("maintainRecord","请选择保养记录编号","/maintainRecord/queryByPager");
})

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

