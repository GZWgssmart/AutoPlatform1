

/**
 * 初始化表格
 */
$(function () {
    initTable("table", "/incomingType/queryByPager"); // 初始化表格
});


/**
 * 页面状态显示
 * @param index
 * @param row
 * @returns {*}
 */
function statusFormatter(index, row) {
    /*处理数据*/
    if(row.inTypeStatus == 'Y') {
        return "&nbsp;&nbsp;激活";
    } else {
        return "&nbsp;&nbsp;禁用";
    }

}

/**
 * 激活禁用显示
 * @param index
 * @param row
 * @returns {string}
 */
function openStatusFormatter(index, row) {
    /*处理数据*/
    if(row.inTypeStatus == 'Y') {
        return "&nbsp;&nbsp;<a href='javascript:;' onclick='inactive(\""+row.inTypeId+ "\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<a href='javascript:;' onclick='active(\""+row.inTypeId+ "\")'>激活</a>";
    }

}


/**
 * 禁用操作方法
 * @param id
 */
function inactive(id) {
    $.post( "/incomingType/inactive?id="+id,
        function (data) {
            if (data.result == "success") {
                $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
            }
        })
}

/**
 * 激活操作方法
 * @param id
 */
function active(id) {
    $.post( "/incomingType/active?id="+id,
        function (data) {
            if (data.result == "success") {
                $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
            }
        })
}

/**
 * 查询禁用支出类型
 * @param id
 */
function searchDisableStatus() {
    initTable('table', '/incomingType/queryByPagerDisable');
}

/**
 * 查询激活支出类型
 * @param id
 */
function searchRapidStatus() {
    initTable('table', '/incomingType/queryByPager');
}


/**
 * 修改窗口
 */
function showEdit(){
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
//                $('#editId').val(row[0].id);
//                $('#editName').val(row[0].name);
//                $('#editPrice').val(row[0].price);
        $("#edit").modal('show'); // 显示弹窗
        var incomingType = row[0];
        $("#incomingTypeUpdateForm").fill(incomingType);
    }else{
        swal({
            title:"",
            text:"请先选择一行数据",
            type:"warning"})
    }
}

/**
 * 添加窗口
 */
function showAdd(){
    $("#inTypeName").val("");
    $("#add").modal('show');
}

/**
 * 前台验证及form表单提交
 */
$(document).ready(function() {

    $("#incomingTypeInsertForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',
        rules : {
            inTypeName : {
                required : true,
                minlength : 2,
                remote:{                         //自带远程验证存在的方法
                    url:"/incomingType/checkInTypeName",
                    type:"get",
                    dataType:"json",
                    async:false,
                    data:{
                        inTypeName:function(){
                            return $("#inTypeName").val();
                        }
                    },
                    dataFilter: function(data, type) {
                        if (data == 'false'){
                            return true;
                        }else{
                            return false;
                        }


                    }
                }

            },

        },
        messages : {
            inTypeName : {
                required : "请输入类型名称",
                minlength : jQuery.format("类型名称不能少于{2}个字符"),
                remote:'已经存在此类型'
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
            $.post( "/incomingType/add",
                $("#incomingTypeInsertForm").serialize(),
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

    $("#incomingTypeUpdateForm").validate({
        errorElement : 'span',
        errorClass : 'help-block',
        rules : {
            inTypeName : {
                required : true,
                minlength : 2,
                remote:{                         //自带远程验证存在的方法
                    url:"/incomingType/checkInTypeName",
                    type:"get",
                    dataType:"json",
                    async:false,
                    data:{
                        inTypeName:function(){
                            return $("#inUpdateTypeName").val();
                        }
                    },
                    dataFilter: function(data, type) {
                        if (data == 'false'){
                            return true;
                        }else{
                            return false;
                        }
                    }
                }
            },
        },
        messages : {
            inTypeName : {
                required : "请输入类型名称",
                minlength : jQuery.format("类型名称不能少于{2}个字符"),
                remote:"该类型已存在"
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
            $.post("/incomingType/update",
                $("#incomingTypeUpdateForm").serialize(),
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