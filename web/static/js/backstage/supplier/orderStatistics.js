var contentPath = ''

//初始化表格
$(function () {
    initTable('table', '/accBuy/queryByPage'); // 初始化表格
    initSelect2("company", "请选择所属公司", "/company/queryAllCompany");
    initSelect2("accInv", "请选择配件", "/accInv/queryAllAccInv");
});

// 查看全部可用
function showAvailable() {
    initTable('table', '/accBuy/queryByPage');
}
// 查看全部禁用
function showDisable() {
    initTable('table', '/accBuy/queryByPagerDisable');
}

// 模糊查询
function blurredQuery() {
    var button = $("#ulButton");// 获取模糊查询按钮
    var text = button.text();// 获取模糊查询按钮文本
    var vaule = $("#ulInput").val();// 获取模糊查询输入框文本
    initTable('table', '/accBuy/blurredQuery?text=' + text + '&value=' + vaule);
}

//显示弹窗
function showEdit() {
    var row = $('table').bootstrapTable('getSelections');
    if (row.length > 0) {
        $("#editWindow").modal('show'); // 显示弹窗
        $("#editButton").removeAttr("disabled");
        var ceshi = row[0];
        var editDate = document.getElementById("editDateTimePicker");
        $("#editForm").fill(ceshi);
        $("#editDateTimePicker").val(formatterDate(ceshi.accBuyTime))
        $('#editCompany').html('<option value="' + ceshi.company.companyId + '">' + ceshi.company.companyName + '</option>').trigger("change");
        $('#editAccInv').html('<option value="' + ceshi.accessories.accId + '">' + ceshi.accessories.accName + '</option>').trigger("change");
        validator('editForm'); // 初始化验证
    } else {
        swal({
            "title": "",
            "text": "请先选择一条数据",
            "type": "warning"
        })
    }
}

//显示添加
function showAdd() {
    $("#addWindow").modal('show');
    $("#addButton").removeAttr("disabled");
    validator('addForm'); // 初始化验证
}


function formatRepo(repo) {
    return repo.text
}
function formatRepoSelection(repo) {
    return repo.text
}

function openStatusFormatter(index, row) {
    /*处理数据*/
    if (row.accBuyStatus == 'Y') {
        return "&nbsp;&nbsp;<a href='javascript:;' onclick='inactive(\"" + row.accBuyId + "\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<a href='javascript:;' onclick='active(\"" + row.accBuyId + "\")'>激活</a>";
    }
}

//格式化页面上的配件分类状态
function formatterStatus(value) {
    if (value == "Y") {
        return "可用";
    } else {
        return "不可用";
    }
}

// 激活或禁用
function statusFormatter(value, row, index) {
    if (value == 'Y') {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='inactive(\"" + '/accBuy/statusOperate?accBuyId=' + row.accBuyId + '&accBuyStatus=Y' + "\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-success' onclick='active(\"" + '/accBuy/statusOperate?accBuyId=' + row.accBuyId + '&accBuyStatus=N' + "\")'>激活</a>";
    }
}

//格式化带时分秒的时间值。
function formatterDateTime(value) {
    if (value == undefined || value == null || value == '') {
        return "";
    }
    else {
        var date = new Date(value);
        var year = date.getFullYear().toString();
        var month = (date.getMonth() + 1);
        var day = date.getDate().toString();
        var hour = date.getHours().toString();
        var minutes = date.getMinutes().toString();
        var seconds = date.getSeconds().toString();
        if (month < 10) {
            month = "0" + month;
        }
        if (day < 10) {
            day = "0" + day;
        }
        if (hour < 10) {
            hour = "0" + hour;
        }
        if (minutes < 10) {
            minutes = "0" + minutes;
        }
        if (seconds < 10) {
            seconds = "0" + seconds;
        }
        return year + "-" + month + "-" + day + " " + hour + ":" + minutes + ":" + seconds;
    }
}

//格式化不带时分秒的时间值
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


//显示删除
function showDel() {
    var row = $('table').bootstrapTable('getSelections');
    if (row.length > 0) {
        $("#del").modal('show');
    } else {
        swal({
            "title": "",
            "text": "请先选择一条数据",
            "type": "warning"
        })
    }
}

//展示冻结状态的采购记录
function showInactiveAccBuy() {
    $.post(contentPath + "/accBuy/queryAccBuyStatus?accBuyStatus=N", function (data) {
        $("#table").load(data);
    })
}
//展示激活状态的采购记录
function showActiveAccBuy() {
    $.post(contentPath + "/accBuy/queryAccBuyStatus?accBuyStatus=Y", function (data) {
        $("#table").load(data);
    })
}

$('#addDateTimePicker').datetimepicker({
    minView: "month", //选择日期后，不会再跳转去选择时分秒
    language: 'zh-CN',
    format: 'yyyy-mm-dd',
    todayBtn: 1,
    autoclose: 1,
});

$('#editDateTimePicker').datetimepicker({
    minView: "month", //选择日期后，不会再跳转去选择时分秒
    language: 'zh-CN',
    format: 'yyyy-mm-dd',
    todayBtn: 1,
    autoclose: 1,
});


function validator(formId) {
    $('#' + formId).bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            companyId: {
                message: '所属公司名称不能为空',
                validators: {
                    notEmpty: {
                        message: '所属公司名称不能为空'
                    }
                }
            },
            accId: {
                message: '配件编号不能为空',
                validators: {
                    notEmpty: {
                        message: '配件编号不能为空'
                    }
                }
            },
            accBuyTime: {
                message: '购买时间不能为空',
                validators: {
                    notEmpty: {
                        message: '购买时间不能为空'
                    }
                }
            },
            accBuyCount: {
                message: '购买数量不能为空',
                validators: {
                    notEmpty: {
                        message: '购买数量不能为空'
                    }
                }
            },
            accBuyPrice: {
                message: '购买单价不能为空',
                validators: {
                    notEmpty: {
                        message: '购买单价不能为空'
                    }
                }
            },
            accBuyTotal: {
                message: '购买总价不能为空',
                validators: {
                    notEmpty: {
                        message: '购买总价不能为空'
                    }
                }
            },
            accBuyMoney: {
                message: '购买最终价不能为空',
                validators: {
                    notEmpty: {
                        message: '购买最终价不能为空'
                    }
                }
            }
        }
    }).on('success.form.bv', function (e) {
        if (formId == "addForm") {
            formSubmit(contentPath + "/accBuy/addAccBuy", formId, "addWindow");

        } else if (formId == "editForm") {
            formSubmit(contentPath + "/accBuy/updateAccBuy", formId, "editWindow");
        }
    })
}

function addSubmit() {
    $("#addForm").data('bootstrapValidator').validate();
    if ($("#addForm").data('bootstrapValidator').isValid()) {
        $("#addButton").attr("disabled", "disabled");
    } else {
        $("#addButton").removeAttr("disabled");
    }
}

function editSubmit() {
    $("#editForm").data('bootstrapValidator').validate();
    if ($("#editForm").data('bootstrapValidator').isValid()) {
        $("#editButton").attr("disabled", "disabled");
    } else {
        $("#editButton").removeAttr("disabled");
    }
}

function formSubmit(url, formId, winId) {
    $.post(url,
        $("#" + formId).serialize(),
        function (data) {
            if (data.result == "success") {
                $('#' + winId).modal('hide');
                swal({
                    title: "",
                    text: data.message,
                    confirmButtonText: "确定", // 提示按钮上的文本
                    type: "success"
                })// 提示窗口, 修改成功
                $('#table').bootstrapTable('refresh');
                if (formId == 'addForm') {
                    $("input[type=reset]").trigger("click"); // 移除表单中填的值
                    $('#addForm').data('bootstrapValidator').resetForm(true); // 移除所有验证样式
                    $("#addButton").removeAttr("disabled"); // 移除不可点击
                    $("#" + formId).data('bootstrapValidator').destroy(); // 销毁此form表单
                    $('#' + formId).data('bootstrapValidator', null);// 此form表单设置为空
                    $("#addCompany").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                    $("#addAccType").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                }
            } else if (data.result == "fail") {
                swal({
                    title: "",
                    text: "添加失败",
                    confirmButtonText: "确认",
                    type: "error"
                })
                $("#" + formId).removeAttr("disabled");
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

function Addcalculate() {
    //购买数量
    var countNum = document.getElementById("addCountNum").value;
    //购买单价
    var buyPrice = document.getElementById("addBuyPrice").value;
    //购买折扣
    var buyDiscount = document.getElementById("addBuyDiscount").value;
    //购买总价
    var addBuyTotal = document.getElementById("addBuyTotal");
    //如果有折扣，则加入折扣进行计算，如果没有最终价格为购买总价。
    var addBuyMoney = document.getElementById("addBuyMoney");
    if (countNum != null && buyPrice != null && countNum != "" && buyPrice != "") {
        //计算出的总价需要进行四舍五入计算。
        var totalPrice = Math.floor(parseFloat(buyPrice * 100 * countNum)) / 100;
        //把计算后的值，填入购买总价中。
        addBuyTotal.value = totalPrice;
        if (buyDiscount != null && buyDiscount != "") {
            addBuyMoney.value = totalPrice * buyDiscount;
        } else {
            addBuyMoney.value = totalPrice;
        }
    }
}

function Editcalculate() {
    //购买数量
    var countNum = document.getElementById("editBuyNum").value;
    //购买单价
    var buyPrice = document.getElementById("editBuyPrice").value;
    //购买折扣
    var buyDiscount = document.getElementById("editBuyDiscount").value;
    //购买总价
    var addBuyTotal = document.getElementById("editBuyTotal");
    //如果有折扣，则加入折扣进行计算，如果没有最终价格为购买总价。
    var addBuyMoney = document.getElementById("editBuyMoney");
    if (countNum != null && buyPrice != null && countNum != "" && buyPrice != "") {
        //计算出的总价需要进行四舍五入计算。
        var totalPrice = Math.floor(parseFloat(buyPrice * 100 * countNum)) / 100;
        //把计算后的值，填入购买总价中。
        addBuyTotal.value = totalPrice;
        if (buyDiscount != null && buyDiscount != "") {
            addBuyMoney.value = totalPrice * buyDiscount;
        } else {
            addBuyMoney.value = totalPrice;
        }
    }
}