$(function () {
    initTable('table', '/carModel/queryByPagerCarModel'); // 初始化表格

    initSelect2("carBrand", "请选择品牌", "/carBrand/queryAllCarBrand");
});

function showEdit() {
    var row = $('table').bootstrapTable('getSelections');
    if (row.length > 0) {
        $("#editWindow").modal('show'); // 显示弹窗
        $("#editButton").removeAttr("disabled");
        var carModel = row[0];
        $('#editCarBrand').html('<option value="' + carModel.carBrand.brandId + '">' + carModel.carBrand.brandName + '</option>').trigger("change");
        $("#editForm").fill(carModel);
        validator('editForm');
    } else {
        swal({
            title:"",
            text: "请先选择要修改的汽车车型的相关信息", // 主要文本
            confirmButtonColor: "#DD6B55", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"warning"}) // 提示类型
    }
}

function showAdd() {
    $("#addWindow").modal('show');
    $("#addButton").removeAttr("disabled");
    validator('addForm'); // 初始化验证
}

function checkAdd() {
    var id = $('#addId').val();
    var name = $('#addName').val();
    var price = $('#addPrice').val();
    var reslist = $("#addSelect").select2("data"); //获取多选的值
    alert(reslist.length)
    if (id != "" && name != "" && price != "") {
        return true;
    } else {
        var error = document.getElementById("addError");
        error.innerHTML = "请输入正确的数据";
        return false;
    }
}

//前端验证
function validator(formId) {
    $('#' + formId).bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
            fields: {
                modelName: {
                    message: '车型名称验证失败',
                    validators: {
                        notEmpty: {
                            message: '车型名称不能为空'
                        },
                        stringLength: {
                            min: 1,
                            max: 6,
                            message: '车型名称长度必须在1到6位之间'
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
                modelDes: {
                message: '车型描述验证失败',
                validators: {
                    notEmpty: {
                        message: '车型描述不能为空'
                    }
                }
            },

        }
    })

        .on('success.form.bv', function (e) {
            if (formId == "addForm") {
                formSubmit("/carModel/addCarModel", formId, "addWindow");

            } else if (formId == "editForm") {
                formSubmit("/carModel/updateCarModel", formId, "editWindow");

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
                    $("input[type=reset]").trigger("click");
                    $('#addForm').data('bootstrapValidator').resetForm(true);
                    $("#addButton").removeAttr("disabled");
                }
            } else if (data.result == "fail") {
                swal({title:"",
                    text:"添加失败",
                    confirmButtonText:"确认",
                    type:"error"})
                $("#addButton").removeAttr("disabled");
            }
        }, "json");
}