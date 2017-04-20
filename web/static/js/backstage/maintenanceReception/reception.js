$(function () {
    initTable('table', '/checkin/queryByPager'); // 初始化表格
});


$('#addArriveTime').datetimepicker({ // 初始化添加框中的时间框
    language: 'zh-CN',
    format: 'yyyy-mm-dd hh:ii'
});
$('#addCheckinCreatedTime').datetimepicker({// 初始化添加框中的时间框
    language: 'zh-CN',
    format: 'yyyy-mm-dd hh:ii'
});
$('#editArriveTime').datetimepicker({// 初始化修改框中的时间框
    language: 'zh-CN',
    format: 'yyyy-mm-dd hh:ii'
});
$('#editCheckinCreatedTime').datetimepicker({// 初始化修改框中的时间框
    language: 'zh-CN',
    format: 'yyyy-mm-dd hh:ii'
});


// 激活或禁用
function statusFormatter(value, row, index) {
    if(value == 'Y') {
        return "&nbsp;&nbsp;<a href='javascript:;' onclick='inactive(\""+row.checkinId+ "\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<a href='javascript:;' onclick='active(\""+row.checkinId+ "\")'>激活</a>";
    }

}

// 禁用
function inactive(id) {
    $.post("/checkin/inactive?id="+id,
        function(data){
            if(data.result == 'success'){
                $('#table').bootstrapTable("refresh");
                swal({
                    title:"",
                    text: data.message,
                    confirmButtonText:"确定", // 提示按钮上的文本
                    type:"success"})// 提示窗口, 修改成功
            }else{
                swal({title:"",
                    text:"禁用失败",
                    confirmButtonText:"确认",
                    type:"error"})
            }
        },"json");
}
// 激活
function active(id) {
    $.post("/checkin/active?id="+id,
        function(data){
            if(data.result == 'success'){
                $('#table').bootstrapTable("refresh");
                swal({
                    title:"",
                    text: data.message,
                    confirmButtonText:"确定", // 提示按钮上的文本
                    type:"success"})// 提示窗口, 修改成功
            }else{
                swal({title:"",
                    text:"激活失败",
                    confirmButtonText:"确认",
                    type:"error"})
            }
        },"json");
}

// 查看全部可用
function showAvailable(){
    initTable('table', '/checkin/queryByPager');
}
// 查看全部禁用
function showDisable(){
    initTable('table', '/checkin/queryByPagerDisable');
}

function showEdit(){
    var row =  $('#table').bootstrapTable('getSelections');
    console.log($('#table').bootstrapTable("getOptions"));
    //alert(row)
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
            type:"warning"})
    }
}

function showAdd(){
    $("#addWindow").modal('show');
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

function checkEdit(url) {
    $.post(url,
        $("#editForm").serialize(),
        function (data) {
            if (data.result == "success") {
                $("#editWindow").modal('hide'); // 关闭指定的窗口
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