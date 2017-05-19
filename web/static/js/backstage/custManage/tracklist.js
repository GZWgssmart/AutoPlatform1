$(function () {
    var roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司接待员,车主";
    $.post("/user/isLogin/" + roles, function (data) {
        if (data.result == 'success') {
            initTable('table', '/tracklist/queryByPager'); // 初始化表格

            initSelect2("admin", "请选择回访人", "/tracklist/queryAdmin");
            initSelect2("user", "请选择跟踪回访用户", "/tracklist/queryUser");
        } else if (data.result == 'notLogin') {
            swal({
                    title: "",
                    text: data.message,
                    confirmButtonText: "确认",
                    type: "error"
                }
                , function (isConfirm) {
                    if (isConfirm) {
                        top.location = "/user/loginPage";
                    } else {
                        top.location = "/user/loginPage";
                    }
                })
        } else if (data.result == 'notRole') {
            swal({
                title: "",
                text: data.message,
                confirmButtonText: "确认",
                type: "error"
            })
        }
    });
});

// 模糊查询
function blurredQuery() {
    var roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司接待员,车主";
    $.post("/user/isLogin/" + roles, function (data) {
        if (data.result == 'success') {
            var button = $("#ulButton");// 获取模糊查询按钮
            var text = button.text();// 获取模糊查询按钮文本
            var vaule = $("#ulInput").val();// 获取模糊查询输入框文本
            initTable('table', '/tracklist/queryName?text=' + text + '&value=' + vaule);
        } else if (data.result == 'notLogin') {
            swal({
                    title: "",
                    text: data.message,
                    confirmButtonText: "确认",
                    type: "error"
                }
                , function (isConfirm) {
                    if (isConfirm) {
                        top.location = "/user/loginPage";
                    } else {
                        top.location = "/user/loginPage";
                    }
                })
        } else if (data.result == 'notRole') {
            swal({
                title: "",
                text: data.message,
                confirmButtonText: "确认",
                type: "error"
            })
        }
    });
}

//显示弹窗
function showEdit() {
    var roles = "公司超级管理员,公司普通管理员,汽车公司接待员";
    $.post("/user/isLogin/" + roles, function (data) {
        if (data.result == 'success') {
            initDateTimePicker('editForm', 'trackCreatedTime', 'editTrackCreatedTime');
            var row = $('table').bootstrapTable('getSelections');
            if (row.length > 0) {
                $("#editWindow").modal('show'); // 显示弹窗
                $("#editButton").removeAttr("disabled"); // 移除不可点击
                var TrackList = row[0];
                $("#editForm").fill(TrackList);
                // $("#editTrackCreatedTime").val(formatterDate(TrackList.trackCreatedTime));
                // $('#editAdminName').html('<option value="' + TrackList.user.userId + '">' + TrackList.user.userName + '</option>').trigger("change");
                // $('#editUserName').html('<option value="' + TrackList.checkin.userId + '">' + TrackList.checkin.userName + '</option>').trigger("change");
                $("#editUserName").val(TrackList.checkin.userName);
                validator('editForm');
            } else {
                swal({
                    "title": "",
                    "text": "请先选择一条数据",
                    "type": "warning"
                })
            }
        } else if (data.result == 'notLogin') {
            swal({
                    title: "",
                    text: data.message,
                    confirmButtonText: "确认",
                    type: "error"
                }
                , function (isConfirm) {
                    if (isConfirm) {
                        top.location = "/user/loginPage";
                    } else {
                        top.location = "/user/loginPage";
                    }
                })
        } else if (data.result == 'notRole') {
            swal({
                title: "",
                text: data.message,
                confirmButtonText: "确认",
                type: "error"
            })
        }
    });
}

//显示添加
function showAdd() {
    var roles = "公司超级管理员,公司普通管理员,汽车公司接待员";
    $.post("/user/isLogin/" + roles, function (data) {
        if (data.result == 'success') {
            initDateTimePicker('addForm', 'trackCreatedTime', 'addTrackCreatedTime');
            $("#addWindow").modal('show');
            $("#addButton").removeAttr("disabled");
            validator('addForm'); // 初始化验证
        } else if (data.result == 'notLogin') {
            swal({
                    title: "",
                    text: data.message,
                    confirmButtonText: "确认",
                    type: "error"
                }
                , function (isConfirm) {
                    if (isConfirm) {
                        top.location = "/user/loginPage";
                    } else {
                        top.location = "/user/loginPage";
                    }
                })
        } else if (data.result == 'notRole') {
            swal({
                title: "",
                text: data.message,
                confirmButtonText: "确认",
                type: "error"
            })
        }
    });
}

function closeUserWin() {
    $("#showRemindWindow").modal('hide');
    // $("#addWindow").modal('show');
}

function showRemindUser() {
    $("#showRemindWindow").modal('show');
    initTableNotTollbar("addRemindTable", "/maintainRecord/queryByPagerSuccess");
}

function checkRemind() {
    var row = $('#addRemindTable').bootstrapTable('getSelections');
    if (row.length != 1) {
        swal({
            "title": "",
            "text": "只能选择一条数据",
            "type": "warning"
        })
    } else {
        alert(row[0].recordId);
        alert(row[0].checkin.userName);
        $("#addTrackUser").val(row[0].checkin.userName);
        $("#addTrackUserId").val(row[0].checkin.userId);
        $("#showRemindWindow").modal('hide');
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

function addSubmit() {
    $("#addForm").data('bootstrapValidator').validate();
    if ($("#addForm").data('bootstrapValidator').isValid()) {
        $("#addButton").attr("disabled", "disabled");
    } else {
        $("#addButton").removeAttr("disabled");
    }
}

function editSubmit() {
    $("#editForm").data('bootstrapValidator').validate();
    if ($("#editForm").data('bootstrapValidator').isValid()) {
        $("#editButton").attr("disabled", "disabled");
    } else {
        $("#editButton").removeAttr("disabled");
    }
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
                    $("input[type=reset]").trigger("click"); // 移除表单中填的值
                    // $('#addForm').data('bootstrapValidator').resetForm(true); // 移除所有验证样式
                    $("#addButton").removeAttr("disabled"); // 移除不可点击
                    $("#addAdminName").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                    $("#addUserName").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                }
                $("#" + formId).data('bootstrapValidator').destroy(); // 销毁此form表单
                $('#' + formId).data('bootstrapValidator', null);// 此form表单设置为空
            } else if (data.result == "fail") {
                swal({
                    title: "",
                    text: data.message,
                    confirmButtonText: "确认",
                    type: "error"
                })
                if (formId == 'addForm') {
                    $("#addButton").removeAttr("disabled");
                } else if (formId == 'editForm') {
                    $("#editButton").removeAttr("disabled");
                }
            } else if (data.result == "notLogin") {
                swal({
                        title: "",
                        text: data.message,
                        confirmButtonText: "确认",
                        type: "error"
                    }
                    , function (isConfirm) {
                        if (isConfirm) {
                            top.location = "/user/loginPage";
                        } else {
                            top.location = "/user/loginPage";
                        }
                    })
                if (formId == 'addForm') {
                    $("#addButton").removeAttr("disabled");
                } else if (formId == 'editForm') {
                    $("#editButton").removeAttr("disabled");
                }
            }
        }, "json");
}