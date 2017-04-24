$(function () {
    $('#table').bootstrapTable('hideColumn', 'id');

    $("#addSelect").select2({
            language: 'zh-CN'
        }
    );

    //绑定Ajax的内容
    // $.getJSON("/dispatching/users", function (data) {
    //     $("#addSelect").empty();//清空下拉框
    //     $.each(data, function (i, item) {
    //         $("#addSelect").append("<option value='" + data[i].id + "'>&nbsp;" + data[i].name + "</option>");
    //     });
    // })
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
        $("#editWindow").modal('show'); // 显示弹窗
        var ceshi = row[0];
        $("#AppointForm").fill(ceshi);
    }else{
        //layer.msg("请先选择某一行", {time : 1500, icon : 2});
        swal({
            title:"",
            text:"请先选择一行数据",
            type:"warning"})// 提示窗口, 修改成功
    }
}
//指派员工
function showAppoint(){
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
//                $('#editId').val(row[0].id);
//                $('#editName').val(row[0].name);
//                $('#editPrice').val(row[0].price);
        $("#appoint").modal('show'); // 显示弹窗
        var ceshi = row[0];
        $("#AppointForm").fill(ceshi);
    }else{
        //layer.msg("请先选择某一行", {time : 1500, icon : 2});
        swal({
            title:"",
            text:"请先选择一行数据",
            type:"warning"})// 提示窗口, 修改成功
    }
}

//领料确认
function showConfirm(){
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
//                $('#editId').val(row[0].id);
//                $('#editName').val(row[0].name);
//                $('#editPrice').val(row[0].price)
        $("#confirm").modal('show'); // 显示弹窗
    }else{
        //layer.msg("请先选择某一行", {time : 1500, icon : 2});
        swal({
            title:"",
            text:"请先选择一行数据",
            type:"warning"})// 提示窗口, 修改成功
    }
}

//退料申请
function showApplication(){
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
//                $('#editId').val(row[0].id);
//                $('#editName').val(row[0].name);
//                $('#editPrice').val(row[0].price)
        $("#application").modal('show'); // 显示弹窗
    }else{
        //layer.msg("请先选择某一行", {time : 1500, icon : 2});
        swal({
            title:"",
            text:"请先选择一行数据",
            type:"warning"})// 提示窗口, 修改成功
    }
}

//确认退料
function showRegress(){
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
//                $('#editId').val(row[0].id);
//                $('#editName').val(row[0].name);
//                $('#editPrice').val(row[0].price);
        $("#regress").modal('show'); // 显示弹窗
    }else{
        //layer.msg("请先选择某一行", {time : 1500, icon : 2});
        swal({
            title:"",
            text:"请先选择一行数据",
            type:"warning"})// 提示窗口, 修改成功
    }

}

function showAdd(){

    $("#addWindow").modal('show');
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

function checkAdd(){
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

function submitDispatcher() {
    $.post("/dispatching/insert",
        $("#appointForm").serialize(),
        function (data) {
            if (data.result == "success") {
                $("#editWindow").modal('hide'); // 关闭指定的窗口
                $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                swal({
                    title:"",
                    text: data.message,
                    type:"success"})// 提示窗口, 修改成功
            } else if (data.result == "fail") {
                $.messager.alert("提示", data.result.message, "info");
            }
        }, "json"
    );
}

//前段验证
$(document).ready(function () {
    $("#showAddFormWar").validate({
        errorElement: 'span',
        errorClass: 'help-block',

        rules: {
            materialName: {
                required: true,
                minlength: 2
            },
            materielState: {
                required: true,
                minlength: 2
            },
            materielCount: {
                required: true,
                minlength:2
            },
            maintain: {
                required: true,
                minlength:2
            },
            materiel_Receive_Time: {
                required: true,
                date:true
            }
        },
        messages: {
            materialName: "请输入物料名称",
            materielState: "请输入物料说明",
            materielCount: "请输入物料数量",
            maintain:"请输入维修保养记录",
            materiel_Receive_Time:"请输入领料时间"
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
            alert("submitted!");
        }
    })
    $("#showEditFormWar").validate({
        errorElement: 'span',
        errorClass: 'help-block',

        rules: {
            materialName: {
                required: true,
                minlength: 2
            },
            materielState: {
                required: true,
                minlength: 2
            },
            materielCount: {
                required: true,
                minlength:2
            },
            maintain: {
                required: true,
                minlength:2
            },
            materiel_Receive_Time: {
                required: true,
                date:true
            }
        },
        messages: {
            materialName: "请输入物料名称",
            materielState: "请输入物料说明",
            materielCount: "请输入物料数量",
            maintain:"请输入维修保养记录",
            materiel_Receive_Time:"请输入领料时间",
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
            alert("submitted!");
        }
    })
});