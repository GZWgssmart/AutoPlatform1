$(function () {
    initTable('table', '/appointment/queryByPager'); // 初始化表格
});


$('#addArriveTime').datetimepicker({ // 初始化添加框中的时间框
    language: 'zh-CN',
    format: 'yyyy-mm-dd hh:ii'
});

$('#appCreatedTime').datetimepicker({ // 初始化添加框中的时间框
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
    $.post("/appointment/inactive?id="+id,
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
    $.post("/appointment/active?id="+id,
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
    initTable('table', '/appointment/queryByPager');
}
// 查看全部禁用
function showDisable(){
    initTable('table', '/appointment/queryByPagerDisable');
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
                swal({
                    title: "",
                    text: "",
                    confirmButtonText: "删除成功",
                    type: "error"
                })
            }
        }, "json"
    );
}

//前端验证
$(document).ready(function () {

    $("#showAddFormWar").validate({
        errorElement: 'span',
        errorClass: 'help-block',

        rules: {
            userName: {
                required: true,
                minlength: 2
            },
            userPhone: {
                required: true,
                minlength: 2
            },
            brandId: {
                required: true,
                minlength: 2
            },
            colorId: {
                required: true,
                minlength: 2
            },
            modelId: {
                required: true,
                minlength: 2
            },
            plateId: {
                required: true,
                minlength: 2
            },
            carPlate: {
                required: true,
                minlength: 2
            },
            arriveTime: {
                required: true,
            },
            maintainOrFix: {
                required: true,
                minlength: 2
            },
            appCreatedTime: {
                required: true,
            },
            companyId: {
                required: true,
                minlength: 2
            },
            appoitmentStatus: {
                required: true,
                minlength: 2
            },
        },
        messages: {
            userName: "车主姓名",
            userPhone: "车主电话",
            brandId: "汽车品牌",
            colorId: "车辆颜色",
            modelId: "车辆车型",
            carPlate: "汽车车牌",
            plateId: "汽车车牌编号",
            arriveTime: "到店时间",
            maintainOrFix: "维修或保养",
            appCreatedTime: "预约记录创建时间",
            companyId: "汽车公司编号",
            appoitmentStatus: "状态"
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
            $.post("/appointment/addApp",
                $("#showAddFormWar").serialize(),
                function (data) {
                    if (data.result == "success") {
                        $("#addWindow").modal('hide'); // 关闭指定的窗口
                        $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                        swal({
                            title: "",
                            text: data.message,
                            confirmButtonText: "确定", // 提示按钮上的文本
                            type: "success"
                        })// 提示窗口, 修改成功
                    } else if (data.result == "fail") {
                        swal({
                            title: "",
                            text: "添加失败",
                            confirmButtonText: "确认",
                            type: "error"
                        })
                    }
                }, "json"
            );
        }
    })


    $("#showEditFormWar").validate({
        errorElement: 'span',
        errorClass: 'help-block',

        rules: {
            userName: {
                required: true,
                minlength: 2
            },
            userPhone: {
                required: true,
                minlength: 2
            },
            brandId: {
                required: true,
                minlength: 2
            },
            colorId: {
                required: true,
                minlength: 2
            },
            modelId: {
                required: true,
                minlength: 2
            },
            plateId: {
                required: true,
                minlength: 2
            },
            carPlate: {
                required: true,
                minlength: 2
            },
            arriveTime: {
                required: true,
            },
            maintainOrFix: {
                required: true,
                minlength: 2
            },
            appCreatedTime: {
                required: true,
            },
            companyId: {
                required: true,
                minlength: 2
            },
            appoitmentStatus: {
                required: true,
                minlength: 2
            },
        },
        messages: {
            userName: "车主姓名",
            userPhone: "车主电话",
            brandId: "汽车品牌编号",
            colorId: "车辆颜色",
            modelId: "车辆车型",
            carPlate: "汽车车牌",
            plateId: "汽车车牌编号",
            arriveTime: "到店时间",
            maintainOrFix: "维修或保养",
            appCreatedTime: "预约记录创建时间",
            companyId: "汽车公司编号",
            appoitmentStatus: "状态"
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
            $.post("/appointment/update",
                $("#showEditFormWar").serialize(),
                function (data) {
                    if (data.result == "success") {
                        $("#editWindow").modal('hide'); // 关闭指定的窗口
                        $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                        swal({
                            title: "",
                            text: data.message,
                            confirmButtonText: "确定", // 提示按钮上的文本
                            type: "success"
                        })// 提示窗口, 修改成功
                    } else if (data.result == "fail") {
                        swal({
                            title: "",
                            text: "修改失败",
                            confirmButtonText: "确认",
                            type: "error"
                        })
                    }
                }, "json"
            );
        }

    })
})
