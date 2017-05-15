$(function () {
    var roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司接待员";
    $.post("/user/isLogin/"+roles, function (data) {
        if(data.result == 'success'){
            initTable('table', '/maintainRecord/queryByPager'); // 初始化表格
        }else if(data.result == 'notLogin'){
            swal({title:"",
                    text:data.message,
                    confirmButtonText:"确认",
                    type:"error"}
                ,function(isConfirm){
                    if(isConfirm){
                        top.location = "/user/loginPage";
                    }else{
                        top.location = "/user/loginPage";
                    }
                })
        }else if(data.result == 'notRole'){
            swal({title:"",
                text:data.message,
                confirmButtonText:"确认",
                type:"error"})
        }
    });
});

// 激活或禁用
function statusFormatter(value, row, index) {
    if(value == 'Y') {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='inactive(\""+'/maintainRecord/statusOperate?id='+row.maintainRecordId+'&status=Y'+"\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-success' onclick='active(\""+'/maintainRecord/statusOperate?id='+ row.maintainRecordId+'&status=N'+ "\")'>激活</a>";
    }
}

// 查看全部未提醒
function showNoRemind(){
    // var roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司接待员";
    // $.post("/user/isLogin/"+roles, function (data) {
    //     if(data.result == 'success'){
    //         //initTable('table', '/maintainRecord/queryByPager');
    //     }else if(data.result == 'notLogin'){
    //         swal({title:"",
    //                 text:data.message,
    //                 confirmButtonText:"确认",
    //                 type:"error"}
    //             ,function(isConfirm){
    //                 if(isConfirm){
    //                     top.location = "/user/loginPage";
    //                 }else{
    //                     top.location = "/user/loginPage";
    //                 }
    //             })
    //     }else if(data.result == 'notRole'){
    //         swal({title:"",
    //             text:data.message,
    //             confirmButtonText:"确认",
    //             type:"error"})
    //     }
    //     });
}

// 查看全部已提醒
function showYesRemind(){
    // var roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司接待员";
    // $.post("/user/isLogin/"+roles, function (data) {
    //     if(data.result == 'success'){
                //initTable('table', '/maintainRecord/queryByPagerDisable');
    //     }else if(data.result == 'notLogin'){
    //         swal({title:"",
    //                 text:data.message,
    //                 confirmButtonText:"确认",
    //                 type:"error"}
    //             ,function(isConfirm){
    //                 if(isConfirm){
    //                     top.location = "/user/loginPage";
    //                 }else{
    //                     top.location = "/user/loginPage";
    //                 }
    //             })
    //     }else if(data.result == 'notRole'){
    //         swal({title:"",
    //             text:data.message,
    //             confirmButtonText:"确认",
    //             type:"error"})
    //     }
    //     });
}

// 模糊查询
function blurredQuery(){
    var roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司接待员";
    $.post("/user/isLogin/"+roles, function (data) {
        if(data.result == 'success'){
                var button = $("#ulButton");// 获取模糊查询按钮
                var text = button.text();// 获取模糊查询按钮文本
                var vaule = $("#ulInput").val();// 获取模糊查询输入框文本
                initTable('table', '/carRemind/blurredQuery?text='+text+'&value='+vaule);
        }else if(data.result == 'notLogin'){
            swal({title:"",
                    text:data.message,
                    confirmButtonText:"确认",
                    type:"error"}
                ,function(isConfirm){
                    if(isConfirm){
                        top.location = "/user/loginPage";
                    }else{
                        top.location = "/user/loginPage";
                    }
                })
        }else if(data.result == 'notRole'){
            swal({title:"",
                text:data.message,
                confirmButtonText:"确认",
                type:"error"})
        }
    });
}

// 点击提醒
function showBell(){
    var roles = "公司超级管理员,公司普通管理员,汽车公司接待员";
    $.post("/user/isLogin/"+roles, function (data) {
        if(data.result == 'success'){
            var row =  $('table').bootstrapTable('getSelections');
            // 邮件发送，短信发送，微信公众号
            if(row.length >0) {
                swal({
                    title: "",
                    text: "您确定要提车提醒吗",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "我确定",
                    cancelButtonText: "再考虑一下",
                    closeOnConfirm: false,
                    closeOnCancel: false
                }, function (isConfirm) {
                    if(isConfirm){
                        var ids = "";// 设置一个字符串
                        var phones = "";
                        $.each(row, function (index, value, item) {
                            if (ids == "") {// 假如这个字符串刚开始设置,获取到所有已经被选中的维修保养记录id
                                ids = "'" + row[index].recordId + "'";// 则直接赋上0索引上的id属性
                            } else {
                                ids += ",'" + row[index].recordId + "'";// 否则就加上逗号把rows里的id赋给ids
                            }
                            if (phones == "") {// 假如这个字符串刚开始设置,获取到所有已经被选中的维修保养记录id
                                phones = row[index].checkin.userPhone;// 则直接赋上0索引上的id属性
                            } else {
                                phones += "," + row[index].checkin.userPhone; // 否则就加上逗号把rows里的id赋给ids
                            }
                        });
                        $.get("/carRemind/remind/" + ids + "/" + phones,
                            function (data) {
                                if (data.result == "success") {
                                    swal({
                                        title: "",
                                        text: "提醒成功",
                                        confirmButtonText: "确定",
                                        type: "success"
                                    })
                                } else if (data.result == "fail") {
                                    swal({
                                        title: "",
                                        text: "提醒失败",
                                        confirmButtonText: "确认",
                                        type: "error"
                                    })
                                }
                            });
                        }else{
                            swal({
                                title: "",
                                text: "已取消",
                                confirmButtonText: "确认",
                                type: "error"
                            })
                        }
                });
            }else{
                swal({
                    title:"",
                    text: "请先选择要提醒的车主", // 主要文本
                    confirmButtonColor: "#DD6B55", // 提示按钮的颜色
                    confirmButtonText:"确定", // 提示按钮上的文本
                    type:"warning"}) // 提示类型
            }
        }else if(data.result == 'notLogin'){
            swal({title:"",
                    text:data.message,
                    confirmButtonText:"确认",
                    type:"error"}
                ,function(isConfirm){
                    if(isConfirm){
                        top.location = "/user/loginPage";
                    }else{
                        top.location = "/user/loginPage";
                    }
                })
        }else if(data.result == 'notRole'){
            swal({title:"",
                text:data.message,
                confirmButtonText:"确认",
                type:"error"})
        }
        });
}

// 全部提醒
function showBellAll(){
    var roles = "公司超级管理员,公司普通管理员,汽车公司接待员";
    $.post("/user/isLogin/"+roles, function (data) {
        if(data.result == 'success'){
            tableData = $("#table").bootstrapTable('getData');//获取表格的所有内容行
            if(tableData.length > 0) {
                swal({
                        title: "",
                        text: "您确定要提醒全部吗",
                        type: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "我确定",
                        cancelButtonText: "再考虑一下",
                        closeOnConfirm: false,
                        closeOnCancel: false
                    }, function (isConfirm) {
                    if(isConfirm){
                        var ids = "";// 设置一个字符串
                        var phones = "";
                        $.each(tableData, function (index, value, item) {
                            if (ids == "") {// 假如这个字符串刚开始设置,获取到所有已经被选中的维修保养记录id
                                ids = "'" + tableData[index].recordId + "'";// 则直接赋上0索引上的id属性
                            } else {
                                ids += ",'" + tableData[index].recordId + "'";// 否则就加上逗号把rows里的id赋给ids
                            }
                            if (phones == "") {// 假如这个字符串刚开始设置,获取到所有已经被选中的维修保养记录id
                                phones = tableData[index].checkin.userPhone;// 则直接赋上0索引上的id属性
                            } else {
                                phones += "," + tableData[index].checkin.userPhone; // 否则就加上逗号把rows里的id赋给ids
                            }
                        });
                        $.get("/carRemind/remind/" + ids + "/" + phones,
                            function (data) {
                                if (data.result == "success") {
                                    swal({
                                        title: "",
                                        text: "提醒成功",
                                        confirmButtonText: "确定",
                                        type: "success"
                                    })
                                } else if (data.result == "fail") {
                                    swal({
                                        title: "",
                                        text: "提醒失败",
                                        confirmButtonText: "确认",
                                        type: "error"
                                    })
                                }
                            });
                    }else{
                        swal({
                            title: "",
                            text: "已取消",
                            confirmButtonText: "确认",
                            type: "error"
                        })
                    }
                });
            }else{
                swal({
                    title:"",
                    text: "当前没有已完工的车辆", // 主要文本
                    confirmButtonColor: "#DD6B55", // 提示按钮的颜色
                    confirmButtonText:"确定", // 提示按钮上的文本
                    type:"warning"}) // 提示类型
            }
        }else if(data.result == 'notLogin'){
            swal({title:"",
                    text:data.message,
                    confirmButtonText:"确认",
                    type:"error"}
                ,function(isConfirm){
                    if(isConfirm){
                        top.location = "/user/loginPage";
                    }else{
                        top.location = "/user/loginPage";
                    }
                })
        }else if(data.result == 'notRole'){
            swal({title:"",
                text:data.message,
                confirmButtonText:"确认",
                type:"error"})
        }
    });
}
