$(function () {
    initTable('table', '/maintainRecord/queryByPager'); // 初始化表格
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

// 显示所有项目window
function showItem(windowId){
    $("#"+ windowId).modal('hide');
    initTableNotTollbar('itemTable', '/maintain/queryByPagerAll');
    $("#itemWindow").modal('show');
    $("#closeButton").addClass(windowId);
}

// 在所有项目中点击确定
function itemSubmit(){
    var row =  $('#itemTable').bootstrapTable('getSelections');
    if(row.length >0) {
        $("#itemWindow").modal('hide');
        if($("#closeButton").hasClass('addWindow')){
            $("#addItemId").val(row[0].maintainId);
            $("#addItem").val(row[0].maintainName);
            $("#addWindow").modal('show');
            $("#closeButton").removeClass('addWindow');
        }else if($("#closeButton").hasClass('editWindow')){
            $("#editItemId").val(row[0].maintainId);
            $("#editItem").val(row[0].maintainName);
            $("#editWindow").modal('show');
            $("#closeButton").removeClass('editWindow');
        }
    }else{
            swal({
                title:"",
                text: "请先选择维修保养项目", // 主要文本
                confirmButtonColor: "#DD6B55", // 提示按钮的颜色
                confirmButtonText:"确定", // 提示按钮上的文本
                type:"warning"}) // 提示类型
    }
}

// 关闭所有项目window
function closeItemWindow(){
    $("#itemWindow").modal('hide');
    if($("#closeButton").hasClass('addWindow')){
        $("#addForm").modal('show');
        $("#closeButton").removeClass('addWindow');
    }else if($("#closeButton").hasClass('editWindow')){
        $("#editForm").modal('show');
        $("#closeButton").removeClass('editWindow');
    }
}

// 生成明细
function showAddDetail(){
    var row =  $('#table').bootstrapTable('getSelections');
    if(row.length >0) {
        $("#addButton").removeAttr("disabled");
        var maintainDetail = row[0];
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

// 所有明细window中的打印按钮
function showPrint(){
    var row =  $('#table').bootstrapTable('getSelections'); // 选中的维修保养记录
    window.parent.addPrint(row[0].recordId);
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
        $("#editItemId").val(maintainDetail.maintainFix.maintainId);
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

// 项目window关闭按钮
function closeWindow(){
    $("#itemWindow").modal('hide');
    $("#addWindow").modal('show');
}

// 所有明细window的用户确认按钮
function showUserDetail(){
    tableData = $("#detailTable").bootstrapTable('getData');//获取表格的所有内容行
    if(tableData.length > 0){
        swal(
            {title:"",
                text:"确定用户已经在维修保养明细清单上签字了吗",
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
            text: "请先生成维修保养明细", // 主要文本
            confirmButtonColor: "#DD6B55", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"warning"}) // 提示类型
        }
}


// 点击确定确定用户已签字
function userConfirm(){
    tableData = $("#detailTable").bootstrapTable('getData');//获取表格的所有内容行
    var ids = "";// 设置一个字符串
        $.each(tableData, function(index, value, item) {
            if(ids == ""){// 假如这个字符串刚开始设置,
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
            maintainItemName: {
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
                }if(formId == 'editForm'){
                    $('#detailTable').bootstrapTable('refresh');
                    $("#detailWindow").modal('show');
                    $("#editButton").removeAttr("disabled"); // 移除不可点击
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