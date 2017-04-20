
/**
 * 初始化表格
 */
$(function () {
    initTable("table", "/salary/queryByPager"); // 初始化表格
});


//格式化不带时分秒的时间值。
function formatterDate(value) {
    if (value == undefined || value == null || value == '') {
        return "";
    } else {
        var date = new Date(value);
        var year = date.getFullYear().toString();
        var month = (date.getMonth() + 1);
        var day = date.getDate().toString();
        if (month < 10) {
            month = "0" + month;
        }
        if (day < 10) {
            day = "0" + day;
        }
        return year + "-" + month + "-" + day + ""
    }
}



function showEdit(){
    $("input[type=reset]").trigger("click");
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
        $("#edit").modal('show'); // 显示弹窗
        var salary = row[0];
        $("#salaryUpdateForm").fill(salary);
    }else{
        swal({
            title:"",
            text:"请先选择一行数据",
            type:"warning"})
    }
}

function showAdd(){
    $("input[type=reset]").trigger("click");
    $("#add").modal('show');
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

/** 选择人员 */
function checkAppointment() {
    initTableNotTollbar("appTable", "/userBasicManage/queryByPager");
    $("#add").modal('hide');
    $("#personnelWin").modal('show');
}


/** 关闭人员管理窗口 */
function closePersonnelWin() {
    $("#personnelWin").modal('hide');
    $("#add").modal('show')
}

/** 选择人员 */
function checkPersonnel () {
    var selectRow = $("#appTable").bootstrapTable('getSelections');
    if (selectRow.length != 1) {
        swal('选择失败', "只能选择一条数据", "error");
        return false;
    } else {
        $("#personnelWin").modal('hide');
        $("#add").modal('show');
        var user = selectRow[0];
        $("#userName").val(user.userName);
        $("#userId").val(user.userId);
        $("#addWin").modal('show');
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

function addWinClose() {
    $("#add").modal('hide'); // 关闭指定的窗口
    $("#userId").val("");
}


/**
 * 前台验证及form提交
 */
$(document).ready(function () {

    $("#salaryInsertForm").validate({
        errorElement: 'span',
        errorClass: 'help-block',
        rules: {
            userName: {
                required: true,
                remote:{                         //自带远程验证存在的方法
                    url:"/salary/checkUserId",
                    type:"get",
                    dataType:"json",
                    async:false,
                    data:{
                        userId:function(){return $("#userId").val();}
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

            minusSalay: {
                number: true,

            },

            prizeSalary: {
                number: true,
            },

            totalSalary: {
                required: true,
                number: true,
            },


        },
        messages: {
            userName: {
                required: "请点击你要选择的员工",
                remote:"该员工已经录入过工资信息"
            },

            minusSalay: {
                number: '请输入合法的数字',
            },

            prizeSalary: {
                number: '请输入合法的数字',
            },

            totalSalary: {
                required: '请输入员工总工资确定数字无误',
                number: '请输入合法的数字',
            },
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
            $.post("/salary/add",
                $("#salaryInsertForm").serialize(),
                function (data) {
                    if (data.result == "success") {
                        $("#add").modal('hide'); // 关闭指定的窗口
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

    $("#salaryUpdateForm").validate({
        errorElement: 'span',
        errorClass: 'help-block',
        rules: {
            userName: {
                required: true,

            },

            minusSalay: {
                number: true,

            },

            prizeSalary: {
                number: true,
            },

            totalSalary: {
                required: true,
                number: true,
            },


        },
        messages: {
            userName: {
                required: "请点击你要选择的员工",
            },

            minusSalay: {
                number: '请输入合法的数字',
            },

            prizeSalary: {
                number: '请输入合法的数字',
            },

            totalSalary: {
                required: '请输入员工总工资确定数字无误',
                number: '请输入合法的数字',
            },
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
            $.post("/salary/update",
                $("#salaryUpdateForm").serialize(),
                function (data) {
                    if (data.result == "success") {
                        $("#edit").modal('hide'); // 关闭指定的窗口
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
});