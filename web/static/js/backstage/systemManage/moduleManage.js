$(function () {
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

function showCollapse(id){
    var coll = "collapse"+id; // 获取到被打开的collapse Id;
    $("#"+coll).on('hide.bs.collapse', function () { // 当一个折叠窗被折叠时, 清空其所内所有事件
        var collapseDiv = $("#collapse"+id);
        collapseDiv.html("");
    })
    $.post("/role/permission/"+id,
        function (data) {
            var div = $("#collapse"+id);
            div.html("");
            var psYes = "<div id='yesPermission" + id + "' class='panel-body'><h4>已有权限</h4>";
            var psNo = "<div id='notPermission" + id + "' class='panel-body'><h4>未有权限</h4>";
            $.each(data, function (index, item) {
                if(data[index].status == 'true') {
                    psYes += "<div id='permission_"+ data[index].permissionId +"' class='biaoqian'>"+data[index].permissionDes+"<a href='javascript:;' onclick='remove("+id+", "+data[index].permissionId+",\""+data[index].permissionDes + "\")';>&nbsp;✖</a></div>";
                }else{
                    psNo += "<div id='permission_"+ data[index].permissionId +"' class='biaoqian'>"+ data[index].permissionDes+"<a href='javascript:;' onclick='add("+id+", "+data[index].permissionId+", \""+data[index].permissionDes + "\")';>&nbsp;➕</a></div>";
                }
            });
            psYes += "</div>";
            psNo += "</div>";
            var permission = psYes + psNo;
            div.html(permission);
        }, "json"
    );
}

function remove(roleId, permissionId, permissionDes){
    $.get("/role/removePermission/"+roleId+"/"+permissionId,
        function (data) {
            if(data.result == 'success'){
                document.getElementById("permission_"+ permissionId).remove();
                var notPermission = document.getElementById("notPermission"+roleId);
                var div2 = document.createElement("newDiv"+permissionId);
                div2.innerHTML="<div id='permission_"+ permissionId +"' class='biaoqian'>"+ permissionDes+ "<a href='javascript:;' onclick='add("+roleId+", "+permissionId+", \""+permissionDes + "\")';>&nbsp;➕</a></div>";
                notPermission.appendChild(div2);
            }
        }, "json");
}

function add(roleId, permissionId, permissionDes){
    $.get("/role/addPermission/"+roleId+"/"+permissionId,
        function (data) {
            if(data.result == 'success') {
                document.getElementById("permission_" + permissionId).remove();
                var yesPermission = document.getElementById("yesPermission" + roleId);
                var div2 = document.createElement("newDiv" + roleId + permissionId);
                div2.innerHTML = "<div id='permission_" + permissionId + "' class='biaoqian'>" + permissionDes + "<a href='javascript:;' onclick='remove(" + roleId + ", " + permissionId + ", \" " + permissionDes + "\")';>&nbsp;✖</a></div>";
                yesPermission.appendChild(div2);
            }
        }, "json"
    );
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
            text: "请先选择要修改的单据", // 主要文本
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

function showDel(){
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
        swal(
            {title:"",
                text:"您确定要禁用此模块吗",
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
            text: "请先选择要禁用的模块", // 主要文本
            confirmButtonColor: "#DD6B55", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"warning"}) // 提示类型
    }
}

$(document).ready(function() {
    $("#addForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',
        rules : {
            moduleName : {
                required : true,
            },
            moduleDes : {
                required : true,
            }
        },
        messages : {
            moduleName : "请输入模块名称",
            moduleDes : "请输入模块描述"
        },
        errorPlacement : function(error, element) {
            $("#addButton").removeAttr("disabled");
            element.next().remove();
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
                $("#addForm").serialize(),
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

    $("#editForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',
        rules : {
            moduleName : {
                required : true,
            },
            moduleDes : {
                required : true,
            }
        },
        messages : {
            moduleName : "请输入模块名称",
            moduleDes : "请输入模块描述"
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
                            text: data.message,
                            confirmButtonText:"确定", // 提示按钮上的文本
                            type:"success"})// 提示窗口, 修改成功
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
