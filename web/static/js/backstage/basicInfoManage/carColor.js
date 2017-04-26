$(function () {
    initTable('table', '/carColor/queryByPagerCarColor'); // 初始化表格
});

function showEdit() {
    var row = $('table').bootstrapTable('getSelections');
    if (row.length > 0) {
        $("#editWindow").modal('show'); // 显示弹窗
        $("#editButton").removeAttr("disabled");
        var ceshi = row[0];
        $("#editForm").fill(ceshi);
        validator('editForm');
    } else {
        swal({
            "title": "",
            "text": "请先选择一条数据",
            "type": "warning"
        })
    }
}

function showAdd() {
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
            colorName: {
                message: '颜色命名验证失败',
                validators: {
                    notEmpty: {
                        message: '颜色命名不能为空'
                    },
                    stringLength: {
                        min: 1,
                        max: 5,
                        message: '颜色命名长度必须在1到5位之间'
                    }
                }
            },
            colorHex: {
                message: '颜色的16进制值验证失败',
                validators: {
                    notEmpty: {
                        message: '颜色的16进制值不能为空'
                    }
                }
            },
            colorDes :{
                message: '颜色的描述验证失败',
                validators: {
                    notEmpty: {
                        message: '颜色的描述不能为空'
                    }
                }
            },
        }
    })
        .on('success.form.bv', function (e) {
            if (formId == "addForm") {
                formSubmit("/carColor/addCarColor", formId, "addWindow");

            } else if (formId == "editForm") {
                formSubmit("/carColor/updateCarColor", formId, "editWindow");

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
                    $("#" + formId).data('bootstrapValidator').destroy(); // 销毁此form表单
                    $('#' + formId).data('bootstrapValidator', null);// 此form表单设置为空
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


//获取hex颜色值后转换成rgb颜色值后自动添加到rgb颜色框中
function showAddHex() {
    var a = document.getElementById("addColor").value;
    if (a.substr(0, 1) == "#") a = a.substring(1);
    if (a.length != 6)return alert("请输入正确的十六进制颜色码！")
    a = a.toLowerCase()
    b = new Array();
    for (x = 0; x < 3; x++) {
        b[0] = a.substr(x * 2, 2)
        b[3] = "0123456789abcdef";
        b[1] = b[0].substr(0, 1)
        b[2] = b[0].substr(1, 1)
        b[20 + x] = b[3].indexOf(b[1]) * 16 + b[3].indexOf(b[2])
    }
    var rbgNumber = b[20] + "," + b[21] + "," + b[22];
    var rgbColor = document.getElementById("addrgbColor");
    rgbColor.value = rbgNumber;
}

//获取hex颜色值后转换成rgb颜色值后自动添加到rgb颜色框中
function showEditHex() {
    var a = document.getElementById("editColor").value;
    if (a.substr(0, 1) == "#") a = a.substring(1);
    if (a.length != 6)return alert("请输入正确的十六进制颜色码！")
    a = a.toLowerCase()
    b = new Array();
    for (x = 0; x < 3; x++) {
        b[0] = a.substr(x * 2, 2)
        b[3] = "0123456789abcdef";
        b[1] = b[0].substr(0, 1)
        b[2] = b[0].substr(1, 1)
        b[20 + x] = b[3].indexOf(b[1]) * 16 + b[3].indexOf(b[2])
    }
    var rbgNumber = b[20] + "," + b[21] + "," + b[22];
    var rgbColorinput = document.getElementById("editrgbColor");
        rgbColorinput.value = rbgNumber;
}


function getkey(e, n) {
    var keynum;
    if (window.event) keynum = e.keyCode; else if (e.which) keynum = e.which;
    if (keynum == 13) {
        if (n == 0) showRGB(); else showRGB2();
    }
}


//颜色控件初始化
$(document).ready(function () {
    $('#addColor').each(function () {
        $(this).minicolors({
            control: $(this).attr('data-control') || 'hue',
            defaultValue: $(this).attr('data-defaultValue') || '',
            inline: $(this).attr('data-inline') === 'true',
            letterCase: $(this).attr('data-letterCase') || 'lowercase',
            opacity: $(this).attr('data-opacity'),
            position: $(this).attr('data-position') || 'bottom left',
            change: function (hex, opacity) {
                if (!hex) return;
                if (opacity) hex += ', ' + opacity;
                try {
                    console.log(hex);
                } catch (e) {
                }
            },
            theme: 'bootstrap'
        });
    });
});


//颜色控件初始化
$(document).ready(function () {
    $('#editColor').each(function () {
        $(this).minicolors({
            control: $(this).attr('data-control') || 'hue',
            defaultValue: $(this).attr('data-defaultValue') || '',
            inline: $(this).attr('data-inline') === 'true',
            letterCase: $(this).attr('data-letterCase') || 'lowercase',
            opacity: $(this).attr('data-opacity'),
            position: $(this).attr('data-position') || 'bottom left',
            change: function (hex, opacity) {
                if (!hex) return;
                if (opacity) hex += ', ' + opacity;
                try {
                    console.log(hex);
                } catch (e) {
                }
            },
            theme: 'bootstrap'
        });
    });
});
