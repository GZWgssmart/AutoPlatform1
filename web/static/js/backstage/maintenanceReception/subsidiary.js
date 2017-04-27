$(function () {
    initTable('table', '/maintainRecord/queryByPager'); // 初始化表格
    initSelect2("maintainItem", "请选择维修保养项目", "/maintain/queryAllItem"); // 初始化select2, 第一个参数是class的名字, 第二个参数是select2的提示语, 第三个参数是select2的查询url
});
// 查看全部可用
function showAvailable(){
    initTable('table', '/maintainRecord/queryByPager');
}

// 查看全部禁用
function showDisable(){
    initTable('table', '/maintainRecord/queryByPagerDisable');
}

// 激活或禁用
function showStatusFormatter(value) {
    if(value == 'Y') {
        return "是";
    } else {
        return "否";
    }
}

// 折扣
function formatterDiscount(value) {
    if(value >= 1) {
        return "无折扣";
    } else {
        var str = value.toString();;
        var str1 = str.split('.')[1];
        str1 += "折";
        return str1;
    }
}

// 折扣后价钱
function formatterDiscountMoney(value, row, index){
    var disCount = row.maintainDiscount;
    return value * disCount;
}


// 激活或禁用
function statusFormatter(value, row, index) {
    if(value == 'Y') {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='inactive(\""+'/maintainRecord/statusOperate?id='+row.maintainRecordId+'&status=Y'+"\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-success' onclick='active(\""+'/maintainRecord/statusOperate?id='+ row.maintainRecordId+'&status=N'+ "\")'>激活</a>";
    }
}

function showAddItem(windowId){
    $("#"+ windowId).modal('hide');
    initTableNotTollbar('itemTable', '/maintainRecord/queryByPagerDisable');
    $("#itemWindow").modal('show');
    $("#closeButton").addClass(windowId);
}

function closeItemWindow(){
    $("#itemWindow").modal('hide');
    if($("#closeButton").hasClass('addWindow')){
        $("#addForm").modal('show');
    }else{
        $("#editForm").modal('show');
    }
}

// 生成明细
function showAddDetail(){
    var row =  $('#table').bootstrapTable('getSelections');
    if(row.length >0) {
        $("#addButton").removeAttr("disabled");
        var maintainDetail = row[0];
        alert(maintainDetail.recordId)
        $("#addForm").fill(maintainDetail);
        $("#addWindow").modal('show');
        validator('addForm'); // 初始化验证
    }else{
        swal({
            title:"",
            text: "请选择要生成明细的维修保养记录", // 主要文本
            confirmButtonColor: "#DD6B55", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"warning"}) // 提示类型
    }
}

function showPrintDetail(){
    $("#detailWindow").modal('hide');
    $('#printWindow').show();
    $('.modal-backdrop').show();
    var row =  $('#table').bootstrapTable('getSelections'); // 选中的维修保养记录
    var detailData = $("#detailTable").bootstrapTable('getData');//获取所有明细
    var div1 = $("#printDiv1"); // 获取div
    var div2 = $("#printDiv2"); // 获取div
    var table = $("#printTable");//获取一个table标签,此标签没子元素
    div1.html("");
    div2.html("");
    table.html(""); // 把div内部的内容设置为空字符串
    var money = 0;
    var disCountMoney = 0;
    table.append("<tr><th style='text-align: center' colspan='5'>维修保养记录明细清单</th></tr><tr><span class='fontStyle'><th style='text-align: center'>项目名称</th><th style='text-align: center'>项目折扣</th><th style='text-align: center'>原价</th><th style='text-align: center'>折扣后</th><th style='text-align: center'>创建时间</th></span></tr>");
    $.each(detailData, function(index, value, item) {
        money = parseFloat(money + detailData[index].maintainFix.maintainMoney); //总计
        disCountMoney= parseFloat(disCountMoney + formatterDiscountMoney(detailData[index].maintainFix.maintainMoney, detailData[index]));// 折扣后
        table.append("<tr><td style='text-align: center'><span class='fontStyle'>"+ detailData[index].maintainFix.maintainName +"</span></td>" +
            "<td style='text-align: center'><span class='fontStyle'>"+ formatterDiscount(detailData[index].maintainDiscount) +"</span></td>" +
            "<td style='text-align: center'><span class='fontStyle'>"+ detailData[index].maintainFix.maintainMoney +"</span></td>" +
            "<td style='text-align: center'><span class='fontStyle'>"+ formatterDiscountMoney(detailData[index].maintainFix.maintainMoney, detailData[index]) +"</span></td>"+
            "<td style='text-align: center'><span class='fontStyle'>"+ formatterDate(detailData[index].mdcreatedTime) +"</span></td><tr>");
    });
    div1.append("<span class='fontStyle'><strong>汽车公司: "+ row[0].checkin.company.companyName +"</strong></span><br/>" +
        "<span class='fontStyle'>公司联系方式:"+ row[0].checkin.company.companyTel +"</span><br/>" +
        "<span class='fontStyle'>公司地址:"+ row[0].checkin.company.companyAddress +"</span><br/>");
    div2.append("<span class='fontStyle'><strong>车主名称:"+ row[0].checkin.userName +"</strong></span><br/>" +
        "<span class='fontStyle'>车主联系方式:"+ row[0].checkin.userPhone +"</span><br/>" +
        "<span class='fontStyle'>汽车品牌:"+ row[0].checkin.brand.brandName +"</span><br/>" +
        "<span class='fontStyle'>汽车车型:"+ row[0].checkin.model.modelName +"</span><br/>" +
        "<span class='fontStyle'>总计: "+ parseFloat(money).toFixed(1) +"元</span><br/>" +
        "<span class='fontStyle' style='color:red'><strong>折扣后: "+ parseFloat(disCountMoney).toFixed(1) +"元</strong></strong></span><br/>" +
        "<span class='fontStyle'>明细日期:"+ formatterDate(new Date()) +"</span><br/>")
    $("#printWindow").modal('show');
}

function showPrint(){
    var newstr = document.all.item('divData').innerHTML;// 拿打印div所有元素
    var oldstr = document.body.innerHTML;// 原先页面所有元素
    document.body.innerHTML = newstr; // 根据打印div绘制一个网页
    window.print(); // 打印
    document.body.innerHTML = oldstr; // 重新把网页变回原先页面
    return false;
}

function closePrint(){
    $('#printWindow').hide();
    $('.modal-backdrop').hide();
}

var recordId = "";

// 显示所有明细
function showDetail(){
    var row =  $('#table').bootstrapTable('getSelections');
    if(row.length >0) {
        recordId = row[0].recordId;
        $("#detailWindow").modal('show');
        initDetailTable('detailTable', '/maintainDetail/queryByDetailPager/'+row[0].recordId+'');
    }else{
        swal({
            title:"",
            text: "请选择要查看明细的维修保养记录", // 主要文本
            confirmButtonColor: "#DD6B55", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"warning"}) // 提示类型
    }
}

// 修改明细
function showEditDetail(){
    var row =  $('#detailTable').bootstrapTable('getSelections');
    if(row.length >0) {
        $("#detailWindow").modal('hide');
        $("#editButton").removeAttr("disabled");
        var maintainDetail = row[0];
        $("#editForm").fill(maintainDetail);
        $('#editItem').html('<option value="' + maintainDetail.maintainFix.maintainId + '">' + maintainDetail.maintainFix.maintainName + '</option>').trigger("change");
        $("#editWindow").modal('show');
        validator('editForm'); // 初始化验证
    }else{
        swal({
            title:"",
            text: "请选择要修改的维修保养明细", // 主要文本
            confirmButtonColor: "#DD6B55", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"warning"}) // 提示类型
    }
}

function closeWindow(){
    $("#editWindow").modal('hide');
    $("#detailWindow").modal('show');
}

function showUserDetail(){
    tableData = $("#detailTable").bootstrapTable('getData');//获取表格的所有内容行
    if(tableData.length > 0){
        swal(
            {title:"",
                text:"确定确认维修保养明细吗",
                type:"warning",
                showCancelButton:true,
                confirmButtonColor:"#DD6B55",
                confirmButtonText:"我确定",
                cancelButtonText:"再考虑一下",
                closeOnConfirm:false,
                closeOnCancel:false
            },function(isConfirm){
                if(isConfirm){
                    userConfirm();// 点击确定确认
                }else{
                    swal({title:"",
                        text:"已取消",
                        confirmButtonText:"确认",
                        type:"error"})
                }
            })
    }else{
        swal({
            title:"",
            text: "请先生存维修保养明细", // 主要文本
            confirmButtonColor: "#DD6B55", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"warning"}) // 提示类型
        }
}


// 点击确定确认
function userConfirm(){
    tableData = $("#detailTable").bootstrapTable('getData');//获取表格的所有内容行
    var ids = "";// 设置一个字符串
        $.each(tableData, function(index, value, item) {
            alert(tableData.length)
            if(ids == ""){// 假如这个字符串刚开始设置,
                alert(tableData[index].maintainItemId)
                ids = "'"+tableData[index].maintainItemId+"'";// 则直接赋上0索引上的id属性
            }else {
                alert(tableData[index].maintainItemId)
                ids += ",'" + tableData[index].maintainItemId+"'"// 否则就加上逗号把rows里所有的id都赋给ids
            }
        });
    $.post("/maintainDetail/userConfirm/"+recordId+"/"+ids,function (data) {
        if (data.result == "success") {
            swal({
                title: "",
                text: data.message,
                type: "success",
                confirmButtonText: "确认",
            })
        }else if (data.result == "fail") {
            swal({title:"",
                text:"确认失败",
                confirmButtonText:"确认",
                type:"error"})
        }
    })
}

function validator(formId) {
    $('#' + formId).bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            maintainItemId: {
                message: '维修保养项目验证失败',
                validators: {
                    notEmpty: {
                        message: '维修保养项目不能为空'
                    }
                }
            },
            maintainDiscount: {
                message: '维修保养项目折扣验证失败',
                validators: {
                    notEmpty: {
                        message: '维修保养项目折扣不能为空'
                    }
                }
            }
        }
    })
        .on('success.form.bv', function (e) {
            if (formId == "addForm") {
                formSubmit("/maintainDetail/add", formId, "addWindow");

            } else if (formId == "editForm") {
                formSubmit("/maintainDetail/edit", formId, "editWindow");

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
                    // 设置select2的值为空
                    $("#addItem").html('<option value="' + '' + '">' + '' + '</option>').trigger("change");
                }if(formId == 'editForm'){
                    $('#detailTable').bootstrapTable('refresh');
                    $("#detailWindow").modal('show');
                    $("#editButton").removeAttr("disabled"); // 移除不可点击
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

function initDetailTable(tableId, url) {
    //先销毁表格
    $('#' + tableId).bootstrapTable('destroy');
    //初始化表格,动态从服务器加载数据
    $("#" + tableId).bootstrapTable({
        method: "get",  //使用get请求到服务器获取数据
        url: url, //获取数据的Servlet地址
        striped: false,  //表格显示条纹
        pagination: true, //启动分页
        pageSize: 10,  //每页显示的记录数
        pageNumber:1, //当前第几页
        pageList: [10, 15, 20, 25, 30],  //记录数可选列表
        showColumns: true,  //显示下拉框勾选要显示的列
        showRefresh: true,  //显示刷新按钮
        showToggle: true, // 显示详情
        strictSearch: true,
        clickToSelect: true,  //是否启用点击选中行
        uniqueId: "id",                     //每一行的唯一标识，一般为主键列
        sortable: true,                     //是否启用排序
        sortOrder: "asc",                   //排序方式
        toolbar : "#detailToolbar",// 指定工具栏
        sidePagination: "server", //表示服务端请求

        //设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder
        //设置为limit可以获取limit, offset, search, sort, order
        queryParamsType : "undefined",
        queryParams: function queryParams(params) {   //设置查询参数
            var param = {
                pageNumber: params.pageNumber,
                pageSize: params.pageSize,
                orderNum : $("#orderNum").val()
            };
            return param;
        },
    });
}