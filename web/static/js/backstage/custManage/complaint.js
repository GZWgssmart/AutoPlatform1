$(function () {
    initTable('table', '/complaint/queryByPager'); // 初始化表格

    initSelect2("user", "请选择用户", "/complaint/queryCombox");
    initSelect2("admin", "请选择回复人", "/complaint/queryCombox");
});

// 模糊查询
function blurredQuery(){
    var button = $("#ulButton");// 获取模糊查询按钮
    var text = button.text();// 获取模糊查询按钮文本
    var vaule = $("#ulInput").val();// 获取模糊查询输入框文本
    initTable('table', '/complaint/queryName?text='+text+'&value='+vaule);
}

function formatterUserName(value, row, index) {
    if(row.admin != null) {
        return row.admin.userName;
    }
}

//显示弹窗
function showEdit() {
    var row = $('table').bootstrapTable('getSelections');
    if (row.length > 0) {
        if(row[0].complaintReplyTime != null || row[0].complaintReply != null) {
            $("#editWindow").modal('show'); // 显示弹窗
            $("#editButton").removeAttr("disabled"); // 移除不可点击
            var Complaint = row[0];
            $("#editForm").fill(Complaint);
            $('#editAdminName').html('<option value="' + Complaint.admin.userId + '">' + Complaint.admin.userName + '</option>').trigger("change");
            $("#editComplaintReplyTime").val(formatterDate(Complaint.complaintReplyTime));
            validator('editForm');
        } else {
            // swal({
            //     "title": "",
            //     "text": "该记录没有回复，您可以进行回复",
            //     "type": "warning"
            // })
            swal({
                    title: "该记录没有回复哦！",
                    text: "您可以点击确认进行回复",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#0ec4f2",
                    confirmButtonText: "确定",
                    cancelButtonText: "取消",
                    closeOnConfirm: true
                },
                function(){
                    $("#addReplyWindow").modal('show'); // 显示弹窗
                    $("#replyButton").removeAttr("disabled"); // 移除不可点击
                    var Complaint = row[0];
                    $("#addReplyForm").fill(Complaint);
                    $("#addReplyComplaintReplyTime").val(formatterDate(Complaint.complaintReplyTime));
                    validator('addReplyForm');
                });
        }
    } else {
        swal({
            "title": "",
            "text": "请先选择一条数据",
            "type": "warning"
        })
    }
}

function showReply() {
    var row = $('table').bootstrapTable('getSelections');
    if (row.length > 0) {
        if(row[0].complaintReplyTime == null || row[0].complaintReply == null) {
            $("#addReplyWindow").modal('show'); // 显示弹窗
            $("#replyButton").removeAttr("disabled"); // 移除不可点击
            var Complaint = row[0];
            $("#addReplyForm").fill(Complaint);
            $("#addReplyComplaintReplyTime").val(formatterDate(Complaint.complaintReplyTime));
            validator('addReplyForm');
        } else {
            swal({
                "title": "",
                "text": "该记录已经回复了",
                "type": "warning"
            })
        }
    } else {
        swal({
            "title": "",
            "text": "请先选择一条数据",
            "type": "warning"
        })
    }
}

function showAdd(){
    $("#addWindow").modal('show');
    $("#addButton").removeAttr("disabled");
    validator('addForm'); // 初始化验证
}


function validator(formId) {
    $('#' + formId).bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            userName: {
                message: '投诉人验证失败',
                validators: {
                    notEmpty: {
                        message: '投诉人不能为空'
                    }
                }
            },
            complaintCreatedTime: {
                message: '投诉时间验证失败',
                validators: {
                    notEmpty: {
                        message: '投诉时间不能为空'
                    }
                }
            },
            complaintContent: {
                message: '投诉内容验证失败',
                validators: {
                    notEmpty: {
                        message: '投诉内容不能为空'
                    }
                }
            },
            complaintReplyUser: {
                message: '投诉回复人验证失败',
                validators: {
                    notEmpty: {
                        message: '投诉回复人不能为空'
                    }
                }
            },
            complaintReplyTime: {
                message: '投诉回复时间验证失败',
                validators: {
                    notEmpty: {
                        message: '投诉回复时间不能为空'
                    }
                }
            },
            complaintReply: {
                message: '投诉回复内容验证失败',
                validators: {
                    notEmpty: {
                        message: '投诉回复内容不能为空'
                    }
                }
            }
        }
    })

        .on('success.form.bv', function (e) {
            if (formId == "addForm") {
                formSubmit("/complaint/insert", formId, "addWindow");

            } else if (formId == "editForm") {
                formSubmit("/complaint/update", formId, "editWindow");

            } else if (formId == "addReplyForm") {
                formSubmit("/complaint/updateReply", formId, "addReplyWindow");

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

function editSubmit(){
    $("#editForm").data('bootstrapValidator').validate();
    if ($("#editForm").data('bootstrapValidator').isValid()) {
        $("#editButton").attr("disabled","disabled");
    } else {
        $("#editButton").removeAttr("disabled");
    }
}

function addReplySubmit(){
    $("#addReplyForm").data('bootstrapValidator').validate();
    if ($("#addReplyForm").data('bootstrapValidator').isValid()) {
        $("#replyButton").attr("disabled","disabled");
    } else {
        $("#replyButton").removeAttr("disabled");
    }
}

$("#addReplyForm").submit(function(){
    $(":submit",this).attr("disabled","disabled");
});

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
                if(formId == 'addForm'){
                    $("input[type=reset]").trigger("click"); // 移除表单中填的值
                    $('#addForm').data('bootstrapValidator').resetForm(true); // 移除所有验证样式
                    $("#addButton").removeAttr("disabled"); // 移除不可点击
                    $("#" + formId).data('bootstrapValidator').destroy(); // 销毁此form表单
                    $('#' + formId).data('bootstrapValidator', null);// 此form表单设置为空
                    $("#addUserName").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                }
                // else if(formId == 'addReplyForm'){
                //     $("input[type=reset]").trigger("click"); // 移除表单中填的值
                //     $('#addReplyForm').data('bootstrapValidator').resetForm(true); // 移除所有验证样式
                //     $("#replyButton").removeAttr("disabled"); // 移除不可点击
                //     $("#" + formId).data('bootstrapValidator').destroy(); // 销毁此form表单
                //     $('#' + formId).data('bootstrapValidator', null);// 此form表单设置为空
                //     $("#addAdminName").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                // }
            } else if (data.result == "fail") {
                swal({title:"",
                    text:"添加失败",
                    confirmButtonText:"确认",
                    type:"error"})
                $("#"+formId).removeAttr("disabled");
            }
        }, "json");
}