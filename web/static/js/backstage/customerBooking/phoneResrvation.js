var contentPath='';
$(function () {
    initTable('table', '/appointment/queryByPager'); // 初始化表格

    initSelect2("carBrand", "请选择品牌", "/carBrand/queryAllCarBrand");
    initSelect2("carColor", "请选择颜色", "/carColor/queryAllCarColor");
    initSelect2("carModel", "请选择车型", "/carModel/queryAllCarModel");
    initSelect2("carPlate", "请选择车牌", "/carPlate/queryAllCarPlate");
});

function showAvailable() {
    initTable('table', '/appointment/queryByPager'); // 初始化表格
}

function showDisable() {
    initTable('table', '/appointment/queryByPagerDisable'); // 初始化表格
}

// 这个方法别看
$("#addCarBrand").change(function(){
    var div = $("#addModelDiv");
    var select = $("#addCarBrand").select2("val");
    div.css("display","block");
    $('#addCarModel').html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
    initSelect2("carModel", "请选择车型", "/carModel/queryByBrandId/"+ select);
});
// 这个别看
$("#editCarBrand").change(function(){
    var div = $("#editModelDiv");
    var select = $("#editCarBrand").select2("val");
    div.css("display","block");
    $('#editCarModel').html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
    initSelect2("carModel", "请选择车型", "/carModel/queryByBrandId/"+select);
});

// 激活或禁用
function showStatusFormatter(value) {
    if(value == 'Y') {
        return "是";
    } else {
        return "否";
    }

}

// 激活或禁用
function statusFormatter(value, row, index) {
    if(value == 'Y') {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='inactive(\""+row.appointmentId+"\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-success' onclick='active(\""+ row.appointmentId+ "\")'" +
            "" +
            "" +
            ">激活</a>";
    }
}

//禁用状态
function inactive(appointmentId) {
    $.post(contentPath + "/appointment/statusOperate?appointmentId=" + appointmentId + "&" + "appoitmentStatus=" + "Y", function (data) {
        if (data.result == "success") {
            $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
        }
    })
}

//激活状态
function active(appointmentId) {
    $.post(contentPath + "/appointment/statusOperate?appointmentId=" + appointmentId + "&" + "appoitmentStatus=" + 'N', function (data) {
        if (data.result == "success") {
            $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
        }
    })
}
/** 判断是否选中 */
function checkAppointment(combox) {
    var val = combox.value;
    if (val == "Y") {
        //调用函数，初始化表格
        initTableNotTollbar("appTable", "/appointment/queryByPager");
        //当点击查询按钮的时候执行
        $("#search").bind("click", initTable);
        $("#addWindow").modal('hide');
        $("#appWindow").modal('show');
    } else {
        $("#appWindow").modal('hide');
        $("#addWindow").modal('show');
        $("input[type=reset]").trigger("click");
    }
}
// 关闭预约
function closeAppWin() {
    $("#appWindow").modal('hide');
    $("#addWindow").modal('show')
    $("#app").val("N");
}

// 选择预约记录
function checkApp() {
    var row = $("#appTable").bootstrapTable('getSelections');
    if (row.length != 1) {
        swal({title:"",
            text:"只能选择一条数据",
            confirmButtonText:"确认",
            type:"error"})
        return false;
    } else {
        $("#appWindow").modal('hide');
        var appointment = row[0];
        $("#addUserName").val(appointment.userName);
        $("#addUserPhone").val(appointment.userPhone);
        $('#addArriveTime').val(formatterDate(appointment.arriveTime));
        $('#addCarBrand').html('<option value="' + appointment.brand.brandId + '">' + appointment.brand.brandName + '</option>').trigger("change");
        $('#addCarColor').html('<option value="' + appointment.color.colorId + '">' + appointment.color.colorName + '</option>').trigger("change");
        $('#addCarModel').html('<option value="' + appointment.model.modelId + '">' + appointment.model.modelName + '</option>').trigger("change");
        $('#addCarPlate').html('<option value="' + appointment.plate.carPlate + '">' + appointment.plate.plateName + '</option>').trigger("change");
        $("#addMaintainOrFix").val(appointment.maintainOrFix);
        $("#addWindow").modal('show');
    }
}
function showEdit(){
    initDateTimePicker('editForm', 'arriveTime');
    var row =  $('#table').bootstrapTable('getSelections');
    //alert(row)
    if(row.length >0) {
        $("#editWindow").modal('show'); // 显示弹窗
        $("#editButton").removeAttr("disabled");
        var appointment = row[0];
        $("#editForm").fill(appointment);
        $("#editUserName").fill(appointment.username);
        $("#editUserPhone").fill(appointment.userPhone);
        $('#editCarBrand').html('<option value="' + appointment.brand.brandId + '">' + appointment.brand.brandName + '</option>').trigger("change");
        $('#editCarColor').html('<option value="' + appointment.color.colorId + '">' + appointment.color.colorName + '</option>').trigger("change");
        $('#editCarModel').html('<option value="' + appointment.model.modelId + '">' + appointment.model.modelName + '</option>').trigger("change");
        $('#editCarPlate').html('<option value="' + appointment.plate.plateId + '">' + appointment.plate.plateName + '</option>').trigger("change");
        $('#editArriveTime').val(formatterDate(appointment.arriveTime));
        validator('editForm'); // 初始化验证
    }else{
        swal({
            title:"",
            text: "请选择要修改的登记记录", // 主要文本
            confirmButtonColor: "#DD6B55", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"warning"}) // 提示类型
    }
}

function showAdd(){
    initDateTimePicker('addForm', 'arriveTime');
    $("#addButton").removeAttr("disabled");
    $("#addWindow").modal('show');
    validator('addForm'); // 初始化验证
}

function validator(formId) {
    $('#' + formId).bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            userName: {
                message: '用户名验证失败',
                validators: {
                    notEmpty: {
                        message: '用户名不能为空'
                    },
                    stringLength: {
                        min: 1,
                        max: 6,
                        message: '用户名长度必须在1到6位之间'
                    }
                }
            },
            userPhone: {
                message: '用户名验证失败',
                validators: {
                    notEmpty: {
                        message: '用户手机号码不能为空'
                    },
                    stringLength: {
                        min: 11,
                        max: 11,
                        message: '手机号码必须为11位'
                    },
                    regexp: {
                        regexp: /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/,
                        message: '请输入正确的手机号'
                    }
                }
            },
            brandId: {
                message: '汽车品牌验证失败',
                validators: {
                    notEmpty: {
                        message: '汽车品牌不能为空'
                    }
                }
            },
            colorId: {
                message: '汽车颜色验证失败',
                validators: {
                    notEmpty: {
                        message: '汽车颜色不能为空'
                    }
                }
            },
            modelId: {
                message: '汽车车型验证失败',
                validators: {
                    notEmpty: {
                        message: '汽车车型不能为空'
                    }
                }
            },
            carPlate: {
                message: '汽车车牌验证失败',
                validators: {
                    notEmpty: {
                        message: '汽车车牌不能为空'
                    }, stringLength: {
                        min: 6,
                        max: 6,
                        message: '车牌号码必须为6位'
                    },
                }
            },
            carMileage: {
                message: '汽车当前行驶里程验证失败',
                validators: {
                    notEmpty: {
                        message: '汽车当前行驶里程不能为空'
                    }
                }
            },
            plateId: {
                message: '汽车车牌号验证失败',
                validators: {
                    notEmpty: {
                        message: '汽车车牌号不能为空'
                    }
                }
            },
            arriveTime: {
                message: '汽车到店时间验证失败',
                validators: {
                    notEmpty: {
                        message: '汽车到店时间不能为空'
                    }
                }
            },
            maintainOrFix: {
                message: '维修|保养验证失败',
                validators: {
                    notEmpty: {
                        message: '维修|保养不能为空'
                    }
                }
            },
            appCreatedTime: {
                message: '预约记录时间验证失败',
                validators: {
                    notEmpty: {
                        message: '预约记录时间不能为空'
                    }
                }
            },
        }
    })

        .on('success.form.bv', function (e) {
            if (formId == "addForm") {
                formSubmit(contentPath+"/appointment/add", formId, "addWindow");

            } else if (formId == "editForm") {
                formSubmit(contentPath+"/appointment/update", formId, "editWindow");

            }
        })

}

function addSubmit(){
    $("#addForm").data('bootstrapValidator').validate();
    if ($("#addForm").data('bootstrapValidator').isValid()) {
        $("#addButton").attr("disabled","disabled");
    } else {
        $("#addButton").removeAttr("disabled");
    }
}

function editSubmit(){
    $("#editForm").data('bootstrapValidator').validate();
    if ($("#editForm").data('bootstrapValidator').isValid()) {
        $("#editButton").attr("disabled","disabled");
    } else {
        $("#editButton").removeAttr("disabled");
    }
}

function formSubmit(url, formId, winId){
    $.post(url,
        $("#" + formId).serialize(),
        function (data) {
            if (data.result == "success") {
                $('#' + winId).modal('hide');
                swal({
                    title:"",
                    text: data.message,
                    confirmButtonText:"确定", // 提示按钮上的文本
                    type:"success"})// 提示窗口, 修改成功
                $('#table').bootstrapTable('refresh');
                if(formId == 'addForm'){
                    $("input[type=reset]").trigger("click"); // 移除表单中填的值
                    $('#addForm').data('bootstrapValidator').resetForm(true); // 移除所有验证样式
                    $("#addButton").removeAttr("disabled"); // 移除不可点击
                    // 设置select2的值为空
                    $("#addCarBrand").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                    $("#addCarModel").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                    $("#addCarColor").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                    $("#addCarPlate").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                }
                $("#" + formId).data('bootstrapValidator').destroy(); // 销毁此form表单
                $('#' + formId).data('bootstrapValidator', null);// 此form表单设置为空
            } else if (data.result == "fail") {
                swal({title:"",
                    text:"添加失败",
                    confirmButtonText:"确认",
                    type:"error"})
                $("#"+formId).removeAttr("disabled");
            }
        }, "json");
}
