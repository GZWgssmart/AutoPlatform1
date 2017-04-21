var contentPath='';
$(function () {
    $('#table').bootstrapTable('hideColumn', 'wordId');

    $("#addSelect").select2({
            language: 'zh-CN'
        }
    );

    //绑定Ajax的内容
    $.getJSON("/table/queryType", function (data) {
        $("#addSelect").empty();//清空下拉框
        $.each(data, function (i, item) {
            $("#addSelect").append("<option value='" + data[i].id + "'>&nbsp;" + data[i].name + "</option>");
        });
    })
//            $("#addSelect").on("select2:select",
//                    function (e) {
//                        alert(e)
//                        alert("select2:select", e);
//            });
});

function showEdit(){
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
//                $('#editId').val(row[0].id);
//                $('#editName').val(row[0].name);
//                $('#editPrice').val(row[0].price);
        $("#edit").modal('show'); // 显示弹窗
        var ceshi = row[0];
        $("#editForm").fill(ceshi);
    }else{
        swal({
            title:"",
            text:"请先选择一行数据",
            type:"warning"})// 提示窗口, 修改成功
    }
}

function showAdd(){

    $("#add").modal('show');
}

function formatRepo(repo){return repo.text}
function formatRepoSelection(repo){return repo.text}

function showDel(){
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
        $("#del").modal('show');
    }else{
        $("#tanchuang").modal('show');
    }
}

// function checkAdd(){
//     var id = $('#addId').val();
//     var name = $('#addName').val();
//     var price = $('#addPrice').val();
//     var reslist=$("#addSelect").select2("data"); //获取多选的值
//     //alert(reslist.length)
//     if(id != "" && name != "" && price != ""){
//         return true;
//     }else{
//         var error = document.getElementById("addError");
//         error.innerHTML = "请输入正确的数据";
//         return false;
//     }
// }

//
// function checkEdit() {
//     $.post("/table/edit",
//         $("#editForm").serialize(),
//         function (data) {
//             if (data.result == "success") {
//                 $("#edit").modal('hide'); // 关闭指定的窗口
//                 $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
//                 swal({
//                     title:"",
//                     text: data.message,
//                     type:"success"})// 提示窗口, 修改成功
//             } else if (data.result == "fail") {
//                 //$.messager.alert("提示", data.result.message, "info");
//             }
//         }, "json"
//     );
// }

//前台验证
$(document).ready(function () {
    jQuery.validator.addMethod("isPhone", function (value, element) {
        var length = value.length;
        return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(value));
    }, "请正确填写您的手机号码。");

    $("#addForm").validate({
        errorElement: 'span',
        errorClass: 'help-block',

        rules: {
            recordId: {
                required: true,
                minlength: 2
            },
            userId: {
                required: true,
                minlength: 2
            },
            workAssignTime: {
                required: true,
                date: true
            },
            workCreateTime: {
                required: true,
                date: true
            }
        },
        messages: {
            recordId: "请输保养记录编号",
            userId: "请输入指派用户编号",
            workAssignTime: "请输入工单指派时间",
           workCreateTime: "请输入工单创建时间"
        },
        errorPlacement: function (error, element) {
            element.next().remove();
            element.after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
            element.closest('.form-group').append(error);
        },
        highlight: function (element) {
            $(element).closest('.form-group').addClass('has-error has-feedback');
        },
        success: function (label) {
            var el = label.closest('.form-group').find("input");
            el.next().remove();
            el.after('<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
            label.closest('.form-group').removeClass('has-error').addClass("has-feedback has-success");
            label.remove();
        },
        submitHandler: function (form) {
            $.post(contentPath+"/Order/add",
                $("#addForm").serialize(),
                function(data){
                    if(data.result == "success"){
                       $("#add").modal('hide');//关闭指定的窗口
                       $('#table').bootstrapTable("refresh");//重新加载
                        swal({
                            title:"",
                            text:data.messages,
                            confirmButtonText:"确定",//提示按钮上的文本
                            type:"success"})  //提示窗口 修改成功
                    }else if(data.result == "fail"){
                        swal({
                            title:"",
                            text:"添加失败",
                            confirmButtonText:"确认",
                            type:"fail"
                        })
                    }
            },"json")
        }
    }),
        $("#editForm").validate({
            errorElement: 'span',
            errorClass: 'help-block',

            rules: {
                recordId: {
                    required: true,
                    minlength: 2
                },
                userId: {
                    required: true,
                    minlength: 2
                },
                workAssignTime: {
                    required: true,
                    date: true
                },
                workCreateTime: {
                    required: true,
                    date: true
                }
            },
            messages: {
                recordId: "请输保养记录编号",
                userId: "请输入指派用户编号",
                workAssignTime: "请输入工单指派时间",
                workCreateTime: "请输入工单创建时间"
            },
            errorPlacement: function (error, element) {
                element.next().remove();
                element.after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
                element.closest('.form-group').append(error);
            },
            highlight: function (element) {
                $(element).closest('.form-group').addClass('has-error has-feedback');
            },
            success: function (label) {
                var el = label.closest('.form-group').find("input");
                el.next().remove();
                el.after('<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
                label.closest('.form-group').removeClass('has-error').addClass("has-feedback has-success");
                label.remove();
            },
            submitHandler: function (form) {
                $.post(contentPath+"/Order/update",
                $("#editForm").serialize(),
                    function(data){
                        if(data.result == "success"){
                            $("#edit").modal('hide');//隐藏
                            $('#table').bootstrapTable("refresh");//重新加载网格数据
                            swal({
                                title:"",
                                text:data.messages,
                                confirmButtonText:"确定",
                                type:"success"
                            })
                        }else if(data.result == "fail"){
                            swal({
                                title:"",
                                text:"修改失败",
                                confirmButtonText:"确定",
                                type:"fail"
                            })
                        }
                    },"json"
                )
            }
        })
});
// //add日期插件
// $('#addwrokAssignTime').datetimepicker({
//     language: 'zh-CN',
//     format: 'yyyy-mm-dd hh:ii'
// });
// $('#addworkCreateTime').datetimepicker({
//     language: 'zh-CN',
//     format: 'yyyy-mm-dd hh:ii'
// });
//
// //edit日期插件
// $('#editwrokAssignTime').datetimepicker({
//     language: 'zh-CN',
//     format: 'yyyy-mm-dd hh:ii'
// });
// $('#editworkCreateTime').datetimepicker({
//     language: 'zh-CN',
//     format: 'yyyy-mm-dd hh:ii'
// });

// 获取当前时间
function getDate(id){
    $('#'+id).val((new Date()).toLocaleDateString() + " " + (new Date()).toLocaleTimeString());
}

/**
 * 时间格式化，传递进来的时间
 */
function formatterDate(value) {
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

$("#editForm").submit(function(){
    $(":submit",this).attr("disabled","disabled"); // 当修改表单提交时, 按钮不可点击
});

$("#addForm").submit(function(){
    $(":submit",this).attr("disabled","disabled");// 当添加表单提交时, 按钮不可点击
});


$('#addworkAssignTime').datetimepicker({
    minView: "month", //选择日期后，不会再跳转去选择时分秒
    language: 'zh-CN',
    format: 'yyyy-mm-dd',
    todayBtn: 1,
    autoclose: 1,
});

$('#addworkCreateTime').datetimepicker({
    minView: "month", //选择日期后，不会再跳转去选择时分秒
    language: 'zh-CN',
    format: 'yyyy-mm-dd',
    todayBtn: 1,
    autoclose: 1,
});

$('#editworkAssignTime').datetimepicker({
    minView: "month", //选择日期后，不会再跳转去选择时分秒
    language: 'zh-CN',
    format: 'yyyy-mm-dd',
    todayBtn: 1,
    autoclose: 1,
});

$('#editworkCreateTime').datetimepicker({
    minView: "month", //选择日期后，不会再跳转去选择时分秒
    language: 'zh-CN',
    format: 'yyyy-mm-dd',
    todayBtn: 1,
    autoclose: 1,
});
//工单的状态
function formatterStatus(index,row){
    if(row.workStatus == 'Y'){
        return "已完成"
    }else{
        return "未完成"
    }
}

//工单未完成状态
function inactive(workId) {
    $.post(contentPath + "/Order/statusWork?workId=" + workId + "&" + "workStatus=" + "Y",
        function (data) {
            if(data.result == "success"){
                $('#table').bootstrapTable("refresh");//重新加载数据网格的数据
            }
        } )
}
function active(workId) {
    $.post(contentPath + "/Order/statusWork?workId=" + workId + "&" + "workStatus=" + "N",
        function (data) {
            if(data.result == "success"){
                $('#table').bootstrapTable("refresh");//重新加载数据网格的数据
            }

        } )
}
function openStatusFormatter(index, row) {
    /*处理数据*/
    if (row.workStatus == 'Y') {
        return "&nbsp;&nbsp;<a href='javascript:;' onclick='inactive(\"" + row.workId + "\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<a href='javascript:;' onclick='active(\"" + row.workId + "\")'>激活</a>";
    }

}





