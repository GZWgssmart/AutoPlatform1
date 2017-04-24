/**
 *初始化表格
 * @type {string}
 */
$(function () {
    initTable("table","/Order/queryAll");
});
var contentPath='';
$(function () {
    $('#table').bootstrapTable('hideColumn', 'wordId');

    $("#addSelect").select2({
            language: 'zh-CN'
        }
    );

}

//添加
function showAdd(){
    //initDateTimePicker('addForm','workAssignTime');
    $("#addWindow").modal('show');
    $("#addButton").removeAttr("disabled");
    validator('addForm');//初始化验证
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
function showEdit(){
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
//                $('#editId').val(row[0].id);
//                $('#editName').val(row[0].name);
//                $('#editPrice').val(row[0].price);
        $("#editWindow").modal('show'); // 显示弹窗
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


/*function getIdSelections() {
    return $.map($table.bootstrapTable('getSelections'), function (row) {
        return row.id
    });
}
$remove.click(function () {
    var ids = getIdSelections();
    $table.bootstrapTable('remove', {
        field: 'id',
        values: ids
    });
    $remove.prop('disabled', true);
})*/;

function showDel(){
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
        $("#del").modal('show');
        $('#table').bootstrapTable("delete");//重新加载网格数据
        swal({
            title:"",
            text:"删除成功",
            confirmButtonText:"确认",
            type:"success"
        })
    }else{
        swal({
            title:"",
            text:"删除失败",
            confirmButtonText:"确认",
            type:"fail"
        })
    }

    // $.post(contentPath + "/Order/edit",
    //     $("#del").serialize(),
    //     function (data) {
    //         if (data.result == "success") {
    //             $("#edit").modal('hide'); // 关闭指定的窗口
    //             $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
    //             swal({
    //                 title:"",
    //                 text: data.message,
    //                 type:"success"})// 提示窗口, 修改成功
    //         } else if (data.result == "fail") {
    //             //$.messager.alert("提示", data.result.message, "info");
    //         }
    //     }, "json"
    // );
}

/*function checkAdd(){
    var id = $('#addId').val();
    var name = $('#addName').val();
    var price = $('#addPrice').val();
    var reslist=$("#addSelect").select2("data"); //获取多选的值
    //alert(reslist.length)
    if(id != "" && name != "" && price != ""){
        return true;
    }else{
        var error = document.getElementById("addError");
        error.innerHTML = "请输入正确的数据";
        return false;
    }
}


function checkEdit() {
    $.post("/table/edit",
        $("#editForm").serialize(),
        function (data) {
            if (data.result == "success") {
                $("#edit").modal('hide'); // 关闭指定的窗口
                $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                swal({
                    title:"",
                    text: data.message,
                    type:"success"})// 提示窗口, 修改成功
            } else if (data.result == "fail") {
                //$.messager.alert("提示", data.result.message, "info");
            }
        }, "json"
    );
}*/



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





