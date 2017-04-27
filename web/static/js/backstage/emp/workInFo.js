var contentPath = ''

/**
 *初始化表格
 * @type {string}
 */
$(function () {
    initTable("table","/Order/queryByPager");


    initSelect2("record","请选择保养记录","/maintainRecord/queryByPager");
    initSelect2("user","请选择用户","/userBasicManage/queryAll");

});



//add选择维修保养记录弹窗
function openRecord(){
    initTableNotTollbar("recordTable","/maintainRecord/queryByPager")
    $("#addWindow").modal('hide');
    $("#recordWindow").modal('show');
}
//add选择维修保养记录窗关闭
function closeRecord(){
    $("#recordWindow").modal('hide');
    $("#addWindow").modal('show');
}
//add选择用户弹窗
function openUser(){
    initTableNotTollbar("userTable","/userBasicManage/queryByPager");
    $("#addWindow").modal('hide');
    $("#userWindow").modal('show');
}
//add关闭用户弹窗
function closeUser(){
    $("#userWindow").modal('hide');
    $("#addWindow").modal('show');
}

//edit选择维修保养记录弹窗
function openEditRecord(){
    initTableNotTollbar("editRecordTable","/maintainRecord/queryByPager");
    $("#editWindow").modal('hide');
    $("#editRecordWindow").modal('show');
}


//edit选择维修保养记录窗关闭
function closeEditRecord() {
    $("#editRecordWindow").modal('hide');
    $("#editWindow").modal('show');

}
/*edit选择用户弹窗*/
function openEditUser(){
    initTableNotTollbar("editUserTable","/userBasicManage/queryByPager");
    $("#editWindow").modal('hide');
    $("#editUserWindow").modal('show');
}
/*edit用户弹窗关闭*/
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
}

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
            if (formId == "addForm") {
                formSubmit("/Order/add", formId, "addWindow");

            } else if (formId == "editForm") {
                formSubmit("/Order/edit", formId, "editWindow");

            }
        })

}

function addSubmit(){
    $("#addForm").data('bootstrapValidator').validate();
    if($("#addForm").data('bootstrapValidator').isvalid()){//已验证
        $("#addButton").attr("disbled","disabled");
    }else{
        $("#addButton").removeAttr("disabled");
    }
}

function editSubmit(){
    $("#editForm").data('bootstrapValidator').validate();
    if($("#editForm").data('bootstrapValidator').isvalid()){//已验证
        $("#editButton").attr("disbled","disabled");
    }else{
        $("#editButton").removeAttr("disabled");
    }
}
//修改
function showEdit(){
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
        $("#editWindow").modal('show'); // 显示弹窗
        $("#editButton").removeAttr("disabled");
        var workInfo = row[0];
        //$("#editForm").fill(ceshi);
    }else{
        swal({
            title:"",
            text:"请先选择一行数据",
            type:"warning"})// 提示窗口, 修改成功
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

// 激活或禁用
function statusFormatter(value, row, index) {
    if(value == 'Y') {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='inactive(\""+'/Order/statusOperate?id='+row.workId+'&status=Y'+"\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-success' onclick='active(\""+'/Order/statusOperate?id='+ row.workId+'&status=N'+ "\")'>激活</a>";
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





