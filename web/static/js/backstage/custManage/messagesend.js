$(function () {
    initTable('table', '/messageSend/queryByPager'); // 初始化表格
});

//显示弹窗
function showEdit() {
    var row = $('table').bootstrapTable('getSelections');
    if (row.length > 0) {
        $("#editWindow").modal('show'); // 显示弹窗
        var MessageSend = row[0];
        $("#editForm").fill(MessageSend);
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
}


// userId: "请选择用户",
// sendTime: "请选择发送时间",
// sendCreatedTime: "请选择发送记录创建时间",
// sendMsg: "请输入发送内容",