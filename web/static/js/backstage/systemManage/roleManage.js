$(function () {
    $('#table').bootstrapTable('hideColumn', 'id');

    $("#userNameSelect").select2({
            language: 'zh-CN'
        }
    );
    $("#roleNameSelect").select2({
            language: 'zh-CN'
        }
    );
    $("#userNameSelect1").select2({
            language: 'zh-CN'
        }
    );
    $("#roleNameSelect1").select2({
            language: 'zh-CN'
        }
    );

    //绑定Ajax的内容
    $.getJSON("/table/queryType", function (data) {
        $("#userNameSelect").empty();//清空下拉框
        $.each(data, function (i, item) {
            $("#userNameSelect").append("<option value='" + data[i].id + "'>&nbsp;" + data[i].name + "</option>");
        });
    })
//            $("#addSelect").on("select2:select",
//                    function (e) {
//                        alert(e)
//                        alert("select2:select", e);
//            });

    $.getJSON("/table/queryType", function (data) {
        $("#roleNameSelect").empty();//清空下拉框
        $.each(data, function (i, item) {
            $("#roleNameSelect").append("<option value='" + data[i].id + "'>&nbsp;" + data[i].name + "</option>");
        });
    })

    $.getJSON("/table/queryType", function (data) {
        $("#userNameSelect1").empty();//清空下拉框
        $.each(data, function (i, item) {
            $("#userNameSelect1").append("<option value='" + data[i].id + "'>&nbsp;" + data[i].name + "</option>");
        });
    })

    $.getJSON("/table/queryType", function (data) {
        $("#roleNameSelect1").empty();//清空下拉框
        $.each(data, function (i, item) {
            $("#roleNameSelect1").append("<option value='" + data[i].id + "'>&nbsp;" + data[i].name + "</option>");
        });
    })
});

$("#editForm").submit(function(){
    $(":submit",this).attr("disabled","disabled");
});

$("#addForm").submit(function(){
    $(":submit",this).attr("disabled","disabled");
});

function showAvailable(){
    alert("可用");
}

function showDisable(){
    alert("禁用");
}

function showEdit(){
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
//                $('#editId').val(row[0].id);
//                $('#editName').val(row[0].name);
//                $('#editPrice').val(row[0].price);
        $("#editButton").removeAttr("disabled");
        $("#edit").modal('show'); // 显示弹窗
        var ceshi = row[0];
        $("#editForm").fill(ceshi);
    }else{
        swal({
            title:"",
            text: "请先选择要修改的角色", // 主要文本
            confirmButtonColor: "#DD6B55", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"warning"}) // 提示类型
    }
}

function showDel(){
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
        swal(
            {title:"",
                text:"您确定要禁用此角色吗",
                type:"warning",
                showCancelButton:true,
                confirmButtonColor:"#DD6B55",
                confirmButtonText:"我确定",
                cancelButtonText:"再考虑一下",
                closeOnConfirm:false,
                closeOnCancel:false
            },function(isConfirm){
                if(isConfirm)
                {
                    swal({title:"",
                        text:"禁用成功",
                        type:"success",
                        confirmButtonText:"确认",
                    },function(){
                    })
                }
                else{
                    swal({title:"",
                        text:"已取消",
                        confirmButtonText:"确认",
                        type:"error"})
                }
            })
    }else{
        swal({
            title:"",
            text: "请先选择要禁用的角色", // 主要文本
            confirmButtonColor: "#DD6B55", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"warning"}) // 提示类型
    }
}

function showAdd(){
    $("input[type=reset]").trigger("click");
    $("#addButton").removeAttr("disabled");
    $("#add").modal('show');
}

$(document).ready(function() {
    $("#addForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',
        rules : {
            roleDes : {
                required : true
            },
            roleName : {
                required : true
            },
        },
        messages : {
            roleName : "请输入角色名称",
            roleDes : "请输入角色描述"
        },
        errorPlacement : function(error, element) {
            $("#addButton").removeAttr("disabled");
                element.after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
                element.closest('.form-group').append(error);
        },
        highlight : function(element) {
            $("#addButton").removeAttr("disabled");
                $(element).closest('.form-group').addClass('has-error has-feedback');
        },
        success : function(label) {
            $("#addButton").removeAttr("disabled");
                var el=label.closest('.form-group').find("input");
                el.next().remove();
                el.after('<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
                label.closest('.form-group').removeClass('has-error').addClass("has-feedback has-success");
                label.remove();
        },
        submitHandler: function(form) {
            $.post("/table/add",
                $("#editForm").serialize(),
                function (data) {
                    if (data.result == "success") {
                        $("#add").modal('hide'); // 关闭指定的窗口
                        $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                        swal({
                            title:"",
                            text: data.message, // 主要文本
                            confirmButtonText:"确定", // 提示按钮上的文本
                            type:"success"}) // 提示类型
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

    $("#editForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',
        rules : {
            roleDes : {
                required : true
            },
            roleName : {
                required : true
            },
        },
        messages : {
            roleName : "请输入角色名称",
            roleDes : "请输入角色描述"
        },
        errorPlacement : function(error, element) {
            $("#editButton").removeAttr("disabled");
            element.next().remove();
            element.after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
            element.closest('.form-group').append(error);
        },
        highlight : function(element) {
            $("#editButton").removeAttr("disabled");
            $(element).closest('.form-group').addClass('has-error has-feedback');
        },
        success : function(label) {
            $("#editButton").removeAttr("disabled");
            var el=label.closest('.form-group').find("input");
            el.next().remove();
            el.after('<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
            label.closest('.form-group').removeClass('has-error').addClass("has-feedback has-success");
            label.remove();
        },
        submitHandler: function(form) {
            $.post("/table/edit",
                $("#editForm").serialize(),
                function (data) {
                    if (data.result == "success") {
                        $("#edit").modal('hide'); // 关闭指定的窗口
                        $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                        swal({
                            title:"",
                            text: data.message, // 主要文本
                            confirmButtonText:"确定", // 提示按钮上的文本
                            type:"success"}) // 提示类型
                    } else if (data.result == "fail") {
                        swal({title:"",
                            text:"修改失败",
                            confirmButtonText:"确认",
                            type:"error"})
                    }
                }, "json"
            );
        }
    })
});