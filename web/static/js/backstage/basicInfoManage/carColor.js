$(function () {
    $('#table').bootstrapTable('hideColumn', 'colorId');
    //
    // $("#addSelect").select2({
    //         language: 'zh-CN'
    //     }
    // );
    //
    // //绑定Ajax的内容
    // $.getJSON("/table/queryType", function (data) {
    //     $("#addSelect").empty();//清空下拉框
    //     $.each(data, function (i, item) {
    //         $("#addSelect").append("<option value='" + data[i].id + "'>&nbsp;" + data[i].name + "</option>");
    //     });
    // })
//            $("#addSelect").on("select2:select",
//                    function (e) {
//                        alert(e)
//                        alert("select2:select", e);
//            });
});

function showEdit() {
    var row = $('table').bootstrapTable('getSelections');
    if (row.length > 0) {
//                $('#editId').val(row[0].id);
//                $('#editName').val(row[0].name);
//                $('#editPrice').val(row[0].price);
        $("#editWindow").modal('show'); // 显示弹窗
        var ceshi = row[0];
        $("#editForm").fill(ceshi);
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
}

function formatRepo(repo) {
    return repo.text
}
function formatRepoSelection(repo) {
    return repo.text
}

function showDel() {
    var row = $('table').bootstrapTable('getSelections');
    if (row.length > 0) {
        $("#del").modal('show');
    } else {
        $("#tanchuang").modal('show');
    }
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

function checkEdit() {
    $.post("/table/edit",
        $("#editForm").serialize(),
        function (data) {
            if (data.result == "success") {
                $("#editWindow").modal('hide'); // 关闭指定的窗口
                $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                swal({
                    title: "",
                    text: data.message,
                    type: "success"
                })// 提示窗口, 修改成功
            } else if (data.result == "fail") {
                //$.messager.alert("提示", data.result.message, "info");
            }
        }, "json"
    );
}

//获取hex颜色值后转换成rgb颜色值后自动添加到rgb颜色框中
function showAddHex() {
    var a = document.getElementsByName("addColor")[0].value;
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
    var a = document.getElementsByName("editColor")[0].value;
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
    var rgbColor = document.getElementById("editrgbColor");
    rgbColor.value = rbgNumber;
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
    $('.addColor').each(function () {
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
    $('.editColor').each(function () {
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

//前端验证
$(document).ready(function () {
    $("#showAddFormWar").validate({
        errorElement: 'span',
        errorClass: 'help-block',

        rules: {
            colorName: {
                required: true,
                minlength: 2
            },
            colorHex: {
                required: true,
                minlength: 2
            },
            colorDes: {
                required: true,
                minlength: 2
            },
        },
        messages: {
            colorName: "请输入颜色名称",
            colorHex: "请输入16进制色值",
            colorDes: "请输入该颜色的描述"
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
            alert("submitted!");
        }
    })
    $("#showEditFormWar").validate({
        errorElement: 'span',
        errorClass: 'help-block',

        rules: {
            colorName: {
                required: true,
                minlength: 2
            },
            colorHex: {
                required: true,
                minlength: 2
            },
            colorDes: {
                required: true,
                minlength: 2
            },
        },
        messages: {
            colorName: "请输入颜色名称",
            colorHex: "请输入16进制色值",
            colorDes: "请输入该颜色的描述"
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
            alert("submitted!");
        }
    })
});