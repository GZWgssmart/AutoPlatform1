$(function () {
    initTable('table', '/tracklist/queryByPager'); // 初始化表格

    initSelect2("admin", "请选择回访人", "/tracklist/queryCombox");
    initSelect2("user", "请选择跟踪回访用户", "/tracklist/queryCombox");
});

// 模糊查询
function blurredQuery(){
    var button = $("#ulButton");// 获取模糊查询按钮
    var text = button.text();// 获取模糊查询按钮文本
    var vaule = $("#ulInput").val();// 获取模糊查询输入框文本
    initTable('table', '/tracklist/queryName?text='+text+'&value='+vaule);
}

//显示弹窗
function showEdit() {
    var row = $('table').bootstrapTable('getSelections');
    if (row.length > 0) {
        $("#editWindow").modal('show'); // 显示弹窗
        $("#editButton").removeAttr("disabled"); // 移除不可点击
        var TrackList = row[0];
        $("#editForm").fill(TrackList);
        $("#editTrackCreatedTime").val(formatterDate(TrackList.trackCreatedTime));
        $('#editAdminName').html('<option value="' + TrackList.admin.userId + '">' + TrackList.admin.userName + '</option>').trigger("change");
        $('#editUserName').html('<option value="' + TrackList.user.userId + '">' + TrackList.user.userName + '</option>').trigger("change");
        validator('editForm');
    } else {
        swal({
            "title": "",
            "text": "请先选择一条数据",
            "type": "warning"
        })
    }
}

//显示添加
function showAdd() {
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
                message: '回访人验证失败',
                validators: {
                    notEmpty: {
                        message: '回访人不能为空'
                    }
                }
            },
            trackContent: {
                message: '回访问题内容验证失败',
                validators: {
                    notEmpty: {
                        message: '回访问题内容不能为空'
                    }
                }
            },
            serviceEvaluate: {
                message: '本次服务评价验证失败',
                validators: {
                    notEmpty: {
                        message: '本次服务评价不能为空'
                    }
                }
            },
            trackUser: {
                message: '跟踪回访用户验证失败',
                validators: {
                    notEmpty: {
                        message: '跟踪回访用户不能为空'
                    }
                }
            },
            trackCreatedTime: {
                message: '维修跟踪回访创建时间验证失败',
                validators: {
                    notEmpty: {
                        message: '维修跟踪回访创建时间不能为空'
                    }
                }
            }
        }
    })

        .on('success.form.bv', function (e) {
            if (formId == "addForm") {
                formSubmit("/tracklist/insert", formId, "addWindow");

            } else if (formId == "editForm") {
                formSubmit("/tracklist/update", formId, "editWindow");
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
                    $("#addAdminName").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                    $("#addUserName").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                }
            } else if (data.result == "fail") {
                swal({title:"",
                    text:"添加失败",
                    confirmButtonText:"确认",
                    type:"error"})
                $("#"+formId).removeAttr("disabled");
            }
        }, "json");
}