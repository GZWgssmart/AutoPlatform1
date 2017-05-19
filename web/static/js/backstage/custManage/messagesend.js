$(function () {
    var roles = "公司超级管理员,公司普通管理员,汽车公司接待员";
    $.post("/user/isLogin/" + roles, function (data) {
        if (data.result == 'success') {
            initTable('table', '/messageSend/queryByPager'); // 初始化表格

            $(".messageSend").select2({
                tags: true,
                language: 'zh-CN',
                minimumResultsForSearch: -1,
                maximumSelectionLength: 5,
                placeholder: '请选择用户',
                ajax: {
                    url: "/messageSend/queryCombox",
                    processResults: function (data, page) {
                        var parsed = data;
                        var arr = [];
                        for (var x in parsed) {
                            arr.push(parsed[x]);
                        }
                        return {
                            results: arr
                        };
                    }
                },

            });
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
    // $("#addButton").click(function(){
    //     var v =$("#addUserName").select2("val");
    //     $("#addUserName").val(v);
    //     $("#addForm").submit();//表单的id
    // });
});

//显示弹窗
function showEdit() {
    var roles = "公司超级管理员,公司普通管理员,汽车公司接待员";
    $.post("/user/isLogin/" + roles, function (data) {
        if (data.result == 'success') {
            var row = $('table').bootstrapTable('getSelections');
            if (row.length > 0) {
                $("#editWindow").modal('show'); // 显示弹窗
                $("#editButton").removeAttr("disabled");
                var MessageSend = row[0];
                $("#editForm").fill(MessageSend);
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

function validator(formId) {
    $('#' + formId).bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            userName: {
                message: '用户验证失败',
                validators: {
                    notEmpty: {
                        message: '用户不能为空'
                    }
                }
            },
            sendTime: {
                message: '发送时间验证失败',
                validators: {
                    notEmpty: {
                        message: '发送时间不能为空'
                    }
                }
            },
            sendCreatedTime: {
                message: '发送记录创建时间验证失败',
                validators: {
                    notEmpty: {
                        message: '发送记录创建时间不能为空'
                    }
                }
            },
            sendMsg: {
                message: '发送内容验证失败',
                validators: {
                    notEmpty: {
                        message: '发送内容不能为空'
                    }
                }
            }
        }
    })

        .on('success.form.bv', function (e) {
            if (formId == "addForm") {
                formSubmit("/messageSend/insert", formId, "addWindow");

            } else if (formId == "editForm") {
                formSubmit("/messageSend/update", formId, "editWindow");
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

function showMessageSend() {
    $("#showMessageSendWindow").modal('show');
    initTableMessageNotTollbar("showMessageSendTable", "/maintainRecord/queryByPagerSuccess");
}

function closeMessageSend() {
    $("#addWindow").modal('hide');
    $("#showMessageSendWindow").modal('show');
    $("#addForm").data('bootstrapValidator').destroy(); // 销毁此form表单
    $("#addForm").data('bootstrapValidator', null);// 此form表单设置为空
}


function showMessageSendUser() {
    var row = $('#showMessageSendTable').bootstrapTable('getSelections');
    if (row.length < 1) {
        swal({
            "title": "",
            "text": "只能选择一条数据",
            "type": "warning"
        })
    } else if(row.length >= 1) {
        var ids = "";
        $.each(row, function (index, value, item) {
            if (ids == "") {
                ids = row[index].checkin.user.userId;
            } else {
                ids += "," + row[index].checkin.user.userId
            }
            alert(row[index].checkin.user.userId);

        });
        // alert(row[0].checkin.user.userId);
        // alert(row[0].checkin.user.userName);
        // $("#addUserId").val(ids);
        $("#showMessageSendWindow").modal('hide');
        $("#addWindow").modal('show');
        $("#addButton").removeAttr("disabled");
        // validator('addForm'); // 初始化验证
    }
}

function closeMessageSendUserWin() {
    $("#showMessageSendWindow").modal('hide');
}

function initTableMessageNotTollbar(tableId, url) {
    //先销毁表格
    $('#' + tableId).bootstrapTable('destroy');
    //初始化表格,动态从服务器加载数据
    $("#" + tableId).bootstrapTable({
        method: "get",  //使用get请求到服务器获取数据
        url: url, //获取数据的Servlet地址
        striped: false,  //表格显示条纹
        pagination: true, //启动分页
        pageSize: 10,  //每页显示的记录数
        pageNumber: 1, //当前第几页
        pageList: [10, 15, 20, 25, 30],  //记录数可选列表
        showColumns: true,  //显示下拉框勾选要显示的列
        showRefresh: true,  //显示刷新按钮
        showToggle: true, // 显示详情
        strictSearch: true,
        clickToSelect: true,  //是否启用点击选中行
        uniqueId: "id",                     //每一行的唯一标识，一般为主键列
        sortable: true,                     //是否启用排序
        sortOrder: "asc",
        toolbar: "#messageSendToolbar",//排序方式
        sidePagination: "server", //表示服务端请求


        //设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder
        //设置为limit可以获取limit, offset, search, sort, order
        queryParamsType: "undefined",
        queryParams: function queryParams(params) {   //设置查询参数
            var param = {
                pageNumber: params.pageNumber,
                pageSize: params.pageSize,
                orderNum: $("#orderNum").val()
            };
            return param;
        },
    });
}