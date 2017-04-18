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
        var ceshi = row[0];
        $("#editForm").fill(ceshi);
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

function checkAdd(){
    var id = $('#addId').val();
    var name = $('#email').val();
    var price = $('#plate').val();
    var price = $('#phone').val();
    var price = $('#isclear').val();
    var price = $('#currentOil').val();
    var price = $('#goods').val();
    var price = $('#color').val();
//            var reslist=$("#phone").select2("data"); //获取多选的值
    alert(reslist.length)
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
}