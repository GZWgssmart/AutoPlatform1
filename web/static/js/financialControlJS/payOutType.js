var context = '';

function statusFormatter(index, row) {
    /*处理数据*/
    if(row.outTypeStatus == 'Y') {
        return "&nbsp;&nbsp;激活";
    } else {
        return "&nbsp;&nbsp;禁用";
    }

}

function openStatusFormatter(index, row) {
    /*处理数据*/
    if(row.outTypeStatus == 'Y') {
        return "&nbsp;&nbsp;<a href='javascript:;' onclick='inactive(\""+row.outTypeId+ "\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<a href='javascript:;' onclick='active(\""+row.outTypeId+ "\")'>激活</a>";
    }

}

function inactive(id) {
    $.post(context + "/outGoingType/inactive?id="+id,
        function(data){
            $('#table').bootstrapTable(
                "refresh",
                {
                }
            );
        },"json");
    location.reload()
}

function active(id) {
    $.post(context + "/outGoingType/active?id="+id,

        function(data){
            $('#table').bootstrapTable(
                "refresh",
                {

                }
            );
        },"json");
    location.reload()

}

$(function () {
    $('#table').bootstrapTable('hideColumn', 'id');

    $("#addSelect").select2({
            language: 'zh-CN'
        }
    );

    //绑定Ajax的内容
    $.getJSON("/outGoingType/queryByPage", function (data) {
        $("#addSelect").empty();//清空下拉框
        $.each(data, function (i, item) {
            $("#addSelect").append("<option value='" + data[i].inTypeId + "'>&nbsp;" + data[i].inTypeName + "</option>");
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
        var outGoingType = row[0];
        $("#outTypeUpdateForm").fill(outGoingType);
    }else{
        swal({
            title:"",
            text:"请先选择一行数据",
            type:"warning"})
    }
}

function showAdd(){
    $("#add").modal('show');
}

function formatRepo(repo) {
    return repo.text
}
function formatRepoSelection(repo) {
    return repo.text
}

function showDel(){
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
        $("#del").modal('show');
    }else{
        swal({
            title:"",
            text:"请先选择一行数据",
            type:"warning"})
    }
}




$(document).ready(function() {

    $("#outTypeInsertForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',
        rules : {
            outTypeName : {
                required : true,
                minlength : 2
            },

        },
        messages : {
            outTypeName : {
                required : "请输入类型名称",
                minlength : jQuery.format("类型名称不能少于{2}个字符")
            },
        },
        errorPlacement : function(error, element) {
            element.next().remove();
            element.after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
            element.closest('.form-group').append(error);
        },
        highlight : function(element) {
            $(element).closest('.form-group').addClass('has-error has-feedback');
        },
        success : function(label) {
            var el=label.closest('.form-group').find("input");
            el.next().remove();
            el.after('<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
            label.closest('.form-group').removeClass('has-error').addClass("has-feedback has-success");
            label.remove();
        },
        submitHandler: function(form) {
            $.post("/outGoingType/add",
                $("#outTypeInsertForm").serialize(),
                function (data) {
                    if (data.result == "success") {
                        $("#add").modal('hide'); // 关闭指定的窗口
                        $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                        swal({
                            title:"",
                            text: data.message,
                            confirmButtonText:"确定", // 提示按钮上的文本
                            type:"success"})// 提示窗口, 修改成功
                    } else if (data.result == "fail") {
                        swal({title:"",
                            text:"添加失败",
                            confirmButtonText:"确认",
                            type:"error"})
                    }
                }, "json"
            );
        }

    })

    $("#outTypeUpdateForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',
        rules : {
            outTypeName : {
                required : true,
                minlength : 2
            },

        },
        messages : {
            outTypeName : {
                required : "请输入类型名称",
                minlength : jQuery.format("类型名称不能少于{2}个字符")
            },
        },
        errorPlacement : function(error, element) {
            element.next().remove();
            element.after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
            element.closest('.form-group').append(error);
        },
        highlight : function(element) {
            $(element).closest('.form-group').addClass('has-error has-feedback');
        },
        success : function(label) {
            var el=label.closest('.form-group').find("input");
            el.next().remove();
            el.after('<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
            label.closest('.form-group').removeClass('has-error').addClass("has-feedback has-success");
            label.remove();
        },
        submitHandler: function(form) {
            $.post("/outGoingType/update",
                $("#outTypeUpdateForm").serialize(),
                function (data) {
                    if (data.result == "success") {
                        $("#edit").modal('hide'); // 关闭指定的窗口
                        $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                        swal({
                            title:"",
                            text: data.message,
                            confirmButtonText:"确定", // 提示按钮上的文本
                            type:"success"})// 提示窗口, 修改成功
                    } else if (data.result == "fail") {
                        swal({title:"",
                            text:"添加失败",
                            confirmButtonText:"确认",
                            type:"error"})
                    }
                }, "json"
            );
        }

    })
});