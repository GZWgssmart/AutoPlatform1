<%--
  Created by IntelliJ IDEA.
  User: yaoyong
  Date: 2017/4/11
  Time: 15:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>物料管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
</head>
<body>
<%@include file="../backstage/contextmenu.jsp"%>
<div class="container">
    <div class="nav">
        <ul id="myTab" class="nav nav-tabs">
            <li class="pull-right" onclick="initHistoryTab()">
                <a href="#historyPanel" data-toggle="tab">
                    <h4><span class="glyphicon glyphicon-time" ></span>&nbsp;历史记录</h4>
                </a>
            </li>
            <li class="pull-right" onclick = "initReturnedTab()">
                <a href="#workInfoPanel" data-toggle="tab">
                    <h4>退料管理</h4>
                </a>
            </li>
            <li class="active pull-right" onclick = "initAcquisitionTab()">
                <a href="#workInfoPanel" data-toggle="tab">
                    <h4>领料管理</h4>
                </a>
            </li>
        </ul>
    </div>
    <div  class="tab-content">
        <div id="workInfoPanel" class="tab-pane fade in active panel-body " data-toggle="tab" style="padding-bottom:0px;"  >
            <table id="materialsTable">
                <thead>
                <tr>
                    <th data-radio="true" data-field="status"></th>
                    <th data-field="varsMap.startName">申请人</th>
                    <th data-field="varsMap.startUserRoleName">申请人角色</th>
                    <th data-field="endUser" data-formatter="endUserFormatter">审批人</th>
                    <th data-field="varsMap.acc.accName">物料名称</th>
                    <th data-field="varsMap.accCount"  data-formatter="accCountFormatter">数量</th>
                    <th data-field="varsMap.acc.accTotal">总数量</th>
                    <th data-field="varsMap.acc.accUnit">计量单位</th>
                    <th data-field="varsMap.acc.accPrice">单价</th>
                    <th data-field="varsMap.reqMsg" >领料原因</th>
                    <th data-field="processInstance.startTime" data-formatter="dateTimeFormatter">时间
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
                    <th data-field="todoCell" data-formatter="todoCell" data-events="btnevent">操作</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>


<div class="modal fade" id="reviewModal" style="overflow-y:scroll" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <span class="glyphicon glyphicon-remove closeModal" data-dismiss="modal"></span>
                <form role="form" class="form-horizontal" id="reviewForm">
                    <div class="modal-header">
                    </div>
                    <input type="text" name="isOK"  readonly  define = "obj.isOK" style="display: none;"/>
                    <input type="text" name="processInstanceId"  readonly define="obj.processInstanceId"  style="display: none;"/>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">结果说明：</label>
                        <div class="col-sm-7">
                                <textarea type="textarea" class="form-control" placeholder="请输入审核结果说明"
                                          name="respMsg" rows="3" maxlength="100"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default"
                                onclick = "closeModal('reviewModal','form')">关闭
                        </button>
                        <button id="subButton1" type="button" onclick="checkReview()" class="btn btn-success">保存</button>
                        <input type="reset" name="reset" style="display: none;"/>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->



<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script src="/static/js/jquery.formFill.js"></script>
<script src="/static/js/select2/select2.js"></script>
<script src="/static/js/sweetalert/sweetalert.min.js"></script>
<script src="/static/js/contextmenu.js"></script>
<script src="/static/js/backstage/main.js"></script>
<script src="/static/js/bootstrap-select/bootstrap-select.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/backstage/picking/acquisition.js"></script>
</body>
<script>

    window.btnevent ={
        "click .ok": y,
        "click .no": n
    }
    $(function () {
        initAcquisitionTab(); //初始化表格
    })

    function initAcquisitionTab(){
        initTable('materialsTable', '/flow/queryAcquisition'); // 重置领料表格
        $('#materialsTable').bootstrapTable('hideColumn', 'endUser');
        $('#materialsTable').bootstrapTable('showColumn', 'todoCell');
    };
    function initReturnedTab(){
        initTable('materialsTable', '/flow/queryReturned'); // 重置退料表格
        $('#materialsTable').bootstrapTable('hideColumn', 'endUser');
        $('#materialsTable').bootstrapTable('showColumn', 'todoCell');
    };
    function initHistoryTab(){
        initTable('materialsTable', '/flow/queryAccManagerHistory'); // 重置历史表格
        $('#materialsTable').bootstrapTable('hideColumn', 'todoCell');
        $('#materialsTable').bootstrapTable('showColumn', 'endUser');
    };

    function todoCell(el, row, index) {
        var okbtn = '<button type="button"  class="btn btn-primary ok" style="margin-right:10px" >同意'
                + '</button>';
        if(row.varsMap.accCount > row.varsMap.acc.accTotal) {
            okbtn = '<button type="button" disabled class="btn btn-primary ok" style="margin-right:10px" >同意'
                    + '</button>';
        }
        var nobtn = '<button type="button" class="btn btn-warning no" >不同意'
                + '</button>';
        return okbtn+ nobtn;
    }


    function validator(formId) {
        $('#' + formId).bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                respMsg: {
                    message: '结果说明验证失败',
                    validators: {
                        notEmpty: {
                            message: '请输入审核结果说明'
                        },
                        stringLength: {
                            min: 3,
                            max: 100,
                            message: '说明至少3至100个字符'
                        }
                    }
                }
            }
        }).on('success.form.bv', function (e) {
            formSubmit("/materials/doReview", "reviewModal", formId, "subButton1");
//            if (formId == "materialsForm") {
//                formSubmit("/flow/subForm", "addWindow", formId,"subButton1");
//            } else if (formId == "editForm") {
//                formSubmit("/checkin/edit","editWindow", formId, "subButton2");
//            }
        })
    }

    function formSubmit(url, modalId, formId, btnId) {
        $.post(url,
                $("#" + formId).serialize(),
                function (data) {
                    console.log("success");
                    console.log(data);
                    var type="error";
                    if(data.result === "success"){
                        type = "success";
                        $('#materialsTable').bootstrapTable('refresh');
                    }

                    swal({
                        title:"",
                        text: data.message,
                        confirmButtonText:"确定", // 提示按钮上的文本
                        type:type})// 提示窗口, 修改成功
                    closeModal(modalId, formId);
                }
        )
    }

    function endUserFormatter(el, row, index) {
        var workInfo = row.workInfo;
        console.log(workInfo);
        if(workInfo != null) {
            return workInfo.user.userName;
        }
        return "";
    }

    function accCountFormatter(el, row, index) {
        return Math.abs(el);
    }

    function dateTimeFormatter(el, row, index) {
        var proIns = row.processInstance;
        var begin = formatterDate(proIns.startTime);
        var end = "";
        var htmlTest = begin;
        console.log(proIns);
        if(proIns.endTime != null ) {
            end = formatterDate(proIns.endTime)
            htmlTest += "<br/>"+ end;
        }
        return htmlTest;
    }

    function checkReview() {
        $("#reviewForm").data('bootstrapValidator').validate();
        if ($("#reviewForm").data('bootstrapValidator').isValid()) {
            $("#subButton1").attr("disabled","disabled");
        } else {
            $("#subButton1").removeAttr("disabled");
        }
    }

    function closeModal(modalId, formId) {
        $("#"+ modalId).modal("hide");
        $('#'+ formId + " input[type=reset]").trigger("click"); // 移除表单中填的值
        $('#'+ formId).data('bootstrapValidator').resetForm(true); // 移除所有验证
        $("#" + formId).data('bootstrapValidator').destroy(); // 销毁此form表单
        // $('#' + formId).data('bootstrapValidator', null);// 此form表单设置为空
    }

    function showModal(modalId ,formId, obj) {
        validator(formId);
        $("#"+modalId).modal("show");
        $("#"+formId).fill(obj);
    }

    function y(e, value, row, index) {
        var resp = {};
        resp.isOK = true;
        resp.processInstanceId = row.processInstanceId;
        $("#subButton1").removeAttr("disable");
        showModal("reviewModal","reviewForm", resp);
    }
    function n(e, value, row, index) {
        var resp = {};
        resp.isOK = false;
        resp.processInstanceId = row.processInstanceId;
        $("#subButton1").removeAttr("disable");
        showModal("reviewModal","reviewForm", resp);
    }
</script>
</html>
