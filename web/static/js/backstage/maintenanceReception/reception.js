$(function () {
    initTable('table', '/checkin/queryByPager'); // 初始化表格

    initDateTimePicker('addForm', 'arriveTime'); // 初始化时间框

    $("#addCarBrand").select2({
        language: 'zh-CN'
    });

    $.getJSON("/arBrand/queryAllCarBrand", function (data) {
        $("#addCarBrand").empty();//清空下拉框
        $.each(data, function (i, item) {
            $("#addCarBrand").append("<option value='" + data[i].brandId + "'>&nbsp;" + data[i].brandName + "</option>");
        });
    })
    $("#addCarPlate").select2({
        language: 'zh-CN'
    });

    $.getJSON("/carPlate/queryAllCarPlate", function (data) {
        $("#addCarPlate").empty();//清空下拉框
        $.each(data, function (i, item) {
            $("#addCarPlate").append("<option value='" + data[i].plateId + "'>&nbsp;" + data[i].plateName + "</option>");
        });
    })
    $("#addCarColor").select2({
        language: 'zh-CN'
    });

    $.getJSON("/carColor/queryAllCarColor", function (data) {
        $("#addCarColor").empty();//清空下拉框
        $.each(data, function (i, item) {
            $("#addCarColor").append("<option value='" + data[i].colorId + "'>&nbsp;" + data[i].colorName + "</option>");
        });
    })
    $("#addCarModel").select2({
        language: 'zh-CN'
    });

    $.getJSON("/carModel/queryAllCarModel", function (data) {
        $("#addCarModel").empty();//清空下拉框
        $.each(data, function (i, item) {
            $("#addCarModel").append("<option value='" + data[i].modelId + "'>&nbsp;" + data[i].modelName + "</option>");
        });
    })
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
    var column;
    if(text == "车主"){
        column = 'userName';
    }else if(text =="汽车公司"){
        column = 'company';
    }else if(text == "汽车车牌"){
        column = 'userName';
    }
    alert(column+vaule)
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
    validator('addForm');
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
                if (formId == "addForm") {
                    $('#input[type=reset]').data('bootstrapValidator').resetForm(true);
                }
            } else if (data.result == "fail") {
                swal({title:"",
                    text:"添加失败",
                    confirmButtonText:"确认",
                    type:"error"})
            }
        }, "json");
}