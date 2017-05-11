$(function () {
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
                for(var x in parsed){
                    arr.push(parsed[x]);
                }
                return {
                    results: arr
                };
            }
        },

    });

    // $("#addButton").click(function(){
    //     var v =$("#addUserName").select2("val");
    //     $("#addUserName").val(v);
    //     $("#addForm").submit();//表单的id
    // });
});

//显示弹窗
function showEdit() {
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

function addSubmit(){
    $("#addForm").data('bootstrapValidator').validate();
    if ($("#addForm").data('bootstrapValidator').isValid()) {
        $("#addButton").attr("disabled","disabled");
    } else {
        $("#addButton").removeAttr("disabled");
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