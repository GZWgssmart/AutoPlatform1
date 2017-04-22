$(function () {
    initTable('table', '/checkin/queryByPager'); // 初始化表格

    initSelect2("carColor", "请选择颜色", "/carColor/queryAllCarColor"); // 初始化select2, 第一个参数是class的名字, 第二个参数是select2的提示语, 第三个参数是select2的查询url
    initSelect2("carBrand", "请选择品牌", "/carBrand/queryAllCarBrand");
    initSelect2("carPlate", "请选择车牌", "/carPlate/queryAllCarPlate");
});

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
        return "&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='inactive(\""+row.checkinId+ "\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-success' onclick='active(\""+row.checkinId+ "\")'>激活</a>";
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

// 模糊查询
function blurredQuery(){
    var button = $("#ulButton");// 获取模糊查询按钮
    var text = button.text();// 获取模糊查询按钮文本
    var vaule = $("#ulInput").val();// 获取模糊查询输入框文本
    alert(text)
    var column;
    if(text == '车主/汽车公司/汽车车牌'){
        column = 'all'
    }else if(text == "车主"){
        column = 'userName';
    }else if(text =="汽车公司"){
        column = 'companyId';
    }else if(text == "汽车车牌"){
        column = 'plateId';
    }
    initTable('table', '/checkin/blurredQuery/'+column+'/'+vaule);
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
    $("#addWinow").modal('show')
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
        $("#addDatetimepicker").val(formatterDate(appointment.arriveTime));
        $('#addCarBrand').html('<option value="' + appointment.brand.brandId + '">' + appointment.brand.brandName + '</option>').trigger("change");
        $('#addCarColor').html('<option value="' + appointment.color.colorId + '">' + appointment.color.colorName + '</option>').trigger("change");
        $('#addCarModel').html('<option value="' + appointment.model.modelId + '">' + appointment.model.modelName + '</option>').trigger("change");
        $('#addCarPlate').html('<option value="' + appointment.plate.plateId + '">' + appointment.plate.plateName + '</option>').trigger("change");
        $("#addMaintainOrFix").val(appointment.maintainOrFix);
        $("#addWindow").modal('show');
    }
}

function showEdit(){
    initDateTimePicker('editForm', 'arriveTime'); // 初始化时间框
    var row =  $('#table').bootstrapTable('getSelections');
    if(row.length >0) {
        $("#editWindow").modal('show'); // 显示弹窗
        $("#editButton").removeAttr("disabled");
        var checkin = row[0];
        $('#editCarBrand').html('<option value="' + checkin.brand.brandId + '">' + checkin.brand.brandName + '</option>').trigger("change");
        $('#editCarColor').html('<option value="' + checkin.color.colorId + '">' + checkin.color.colorName + '</option>').trigger("change");
        $('#editCarModel').html('<option value="' + checkin.model.modelId + '">' + checkin.model.modelName + '</option>').trigger("change");
        $('#editCarPlate').html('<option value="' + checkin.plate.plateId + '">' + checkin.plate.plateName + '</option>').trigger("change");
        $('#editDatetimepicker').val(formatterDate(checkin.arriveTime));
        alert(checkin.checkinId)
        $("#editForm").fill(checkin);
        validator('editForm');
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
    initDateTimePicker('addForm', 'arriveTime'); // 初始化时间框, 第一参数是form表单id, 第二参数是input的name
    $("#addWindow").modal('show');
    $("#addButton").removeAttr("disabled");
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
            plateId: {
                message: '汽车车牌验证失败',
                validators: {
                    notEmpty: {
                        message: '汽车车牌不能为空'
                    }
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
            carPlate: {
                message: '汽车车牌号验证失败',
                validators: {
                    notEmpty: {
                        message: '汽车车牌号不能为空'
                    },
                    stringLength: {
                        min: 6,
                        max: 6,
                        message: '车牌号码必须为6位'
                    },
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
            nowOil: {
                message: '汽车当前油量验证失败',
                validators: {
                    notEmpty: {
                        message: '汽车当前油量不能为空'
                    }
                }
            },
            carThings: {
                message: '汽车物品描述验证失败',
                validators: {
                    notEmpty: {
                        message: '汽车物品描述不能为空'
                    }
                }
            },
            intactDegrees :{
                message: '汽车完好度描述验证失败',
                validators: {
                    notEmpty: {
                        message: '汽车完好度描述不能为空'
                    }
                }
            },
            userRequests:{
                message: '用户要求描述验证失败',
                validators: {
                    notEmpty: {
                        message: '用户要求描述不能为空'
                    }
                }
            }
        }
    })

        .on('success.form.bv', function (e) {
            if (formId == "addForm") {
                formSubmit("/checkin/add", formId, "addWindow");

            } else if (formId == "editForm") {
                formSubmit("/checkin/edit", formId, "editWindow");

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
                }
            } else if (data.result == "fail") {
                swal({title:"",
                    text:"添加失败",
                    confirmButtonText:"确认",
                    type:"error"})
                $("#"+formId).removeAttr("disabled");
            }
        }, "json");
}