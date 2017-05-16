<%--
  Created by IntelliJ IDEA.
  User: yaoyong
  Date: 2017/4/11
  Time: 15:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>物料领取</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/datetimepicker.less">
    <%--<link rel="stylesheet" href="/static/css/picking/bootstrap-spinner.css">--%>

    <style>
        .materialsSuc{
            background: url("/static/img/materialsFlag1.png") 105% -34px;
            background-size: 100%;
            background-repeat: no-repeat;
        }
        #materialsForm input[disable] {
            background: #fff;
        }
        .search {
            display: none;
        }
        .sd{
            font-weight: bold;
        }
        .modal-header h2 {
            text-align: left;
        }
        a {
            color: #337ab7;
            text-decoration: none;
        }
        .close {
            right:20px;
            position: relative;
        }
        .bgFont {
            color: #aaa;
            font-family: 微软雅黑;
        }
    </style>
</head>
<body>
<%@include file="../backstage/contextmenu.jsp"%>
<div class="container">
    <div class="nav">
        <ul id="myTab" class="nav nav-tabs">
            <li class="pull-right" onclick="initHistory()">
                <a href="#historyPanel" data-toggle="tab">
                    <h4><span class="glyphicon glyphicon-time" ></span>&nbsp;历史记录</h4>
                </a>
            </li>
            <li class="pull-right" onclick="initReviewing()">
                <a href="#reviewingPanel" data-toggle="tab">
                    <h4>申核中</h4>
                </a>
            </li>
            <li class="active pull-right">
                <a href="#workInfoPanel" data-toggle="tab">
                    <h4>我的工单</h4>
                </a>
            </li>
        </ul>
    </div>
    <div  class="tab-content">
        <div id="workInfoPanel" class="tab-pane fade in active panel-body " data-toggle="tab" style="padding-bottom:0px;"  >
            <table id="materialsTable" style="table-layout: fixed" data-search=true>
                <thead>
                <tr >
                    <th data-width="110" data-field="carplate">
                        车牌
                    </th>
                    <th data-width="180" data-hide="all" data-field="carbrand">
                        品牌
                    </th>
                    <th data-width="110" data-field="carmodel">
                        车型
                    </th>
                    <th data-width="110" data-field="colorName">
                        颜色
                    </th>
                    <th data-width="180"  data-field="workAssignTime" data-formatter=formatterDate >
                        工单指派时间
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </th>
                    <th data-width="180" data-hide="all" data-field="useRequests"  data-formatter = "userRequestsFormatter">
                        用户留言
                    </th>
                    <shiro:hasAnyRoles name="公司超级管理员,公司普通管理员,汽车公司接待员,汽车公司总技师,汽车公司技师,汽车公司学徒,汽车公司销售人员,汽车公司财务人员,汽车公司采购人员,汽车公司库管人员,汽车公司人力资源管理部">
                        <th data-width="180" data-hide="all" data-field="todoCell"  data-formatter="todoCell" >
                            操作
                        </th>
                    </shiro:hasAnyRoles>
                </tr>
                </thead>
            </table>
        </div>

        <div id="reviewingPanel" class="tab-pane fade" data-toggle="tab" style="padding-bottom:0px;"  >
            <table id="reviewingTable" style="table-layout: fixed" data-search=true>
                <thead>
                <tr >
                    <th data-field="varsMap.acc.accName"  data-width="100">物料名称</th>
                    <th data-field="varsMap.accCount" data-formatter="countFormatter" data-width="100">数量</th>
                    <th data-field="varsMap.acc.accTotal" data-formatter="countFormatter" data-width="100">总数量</th>
                    <th data-field="varsMap.acc.accPrice" data-width="100">单价</th>
                    <th data-field="reviewUser" data-formatter="reviewUserFormatter"  data-width="100">审批状态</th>
                    <shiro:hasAnyRoles name="公司超级管理员,公司普通管理员,汽车公司接待员,汽车公司总技师,汽车公司技师,汽车公司学徒,汽车公司销售人员,汽车公司财务人员,汽车公司采购人,汽车公司库管人员,汽车公司人力资源管理部">
                        <th data-field="todoCell" data-formatter="reTodoBtn" data-width="200" data-events="resubbtnevent">操作</th>
                    </shiro:hasAnyRoles>
                </tr>
                </thead>
            </table>
        </div>

        <div id="historyPanel" class="tab-pane fade" data-toggle="tab">
            <table id="historyTable" style="table-layout: fixed" data-search=true>
                <thead>
                <tr >
                    <th data-width="110" data-field="accessories.accName">零件名称</th>
                    <th data-width="110" data-field="record.checkin.carPlate">车牌</th>
                    <th data-width="110" data-field="flag" data-formatter="todoType">操作类型</th>
                    <th data-width="110" data-field="accCount">数量</th>
                    <th data-width="110" data-field="muUseDate" data-formatter=formatterDate>
                        操作时间
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
                </tr>
            </table>
        </div>
    </div>
</div>
<div id="toolbar" >
    </div>

</div>

<!-- 零件明细弹窗 -->
<shiro:hasAnyRoles name="公司超级管理员,公司普通管理员,汽车公司接待员,汽车公司总技师,汽车公司技师,汽车公司学徒,汽车公司销售人员,汽车公司财务人员,汽车公司采购人员,汽车公司库管人员,汽车公司人力资源管理部">
    <div class="modal fade" id="accsInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="margin-right:0;width:95%;">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3 class="modal-title" id="myModalLabel">零件明细
                                           <button type="button" class="btn btn-warning"  aria-hidden="true" onclick="showAppend()">追加物料</button>

                </h3>
            </div>
            <div class="modal-body">
                <input style="display: none;" id="seachRecordId" />
                <table id="workInfoAccDetailTable" style="table-layout: fixed" data-single-select="true"
                       data-show-header="false" >
                    <thead>
                        <tr >
                            <th data-width="50"  data-field="accessories.accName"></th>
                            <th data-width="110"  data-formatter="accInfoFormat"></th>
                        </tr>
                    </thead>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default"  data-dismiss="modal" >关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

    <!-- 领取/退回表单弹窗 -->
    <div class="modal fade" id="application" aria-hidden="true"  data-backdrop="static" keyboard="false" >
    <div class="modal-dialog" style="overflow:hidden;">
            <div class="modal-content">
                <div class="modal-footer" style="text-align: center;">
                    <span  class="close"  onclick = "closeModal('application','materialsForm')">&times;</span>
                    <div class="modal-header" style="overflow:auto;">
                        <h2>领取/退回 物料</h2>
                    </div>
                    <hr>
                    <form role="form"  id="materialsForm" class="form-horizontal">
                        <div class="form-group" style="display:none">
                            <input type="text" id="formTag" style="display:none"/>
                            <input type="text" name="processInstanceId" define="materials.processInstanceId" />
                            <input type="text" name="matainRecordId" define="materials.recordId"  style="display:none"/>
                            <input type="text" name="accId" define="materials.accId" style="display:none"/>
                            <input type="text" name="accCount" define="materials.accCount"  style="display: none" />
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">操作类型：</label>
                            <div class="col-sm-7">
                                <input type="text" define="materials.type" disabled class="form-control" style="background-color:#fff;border:none">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">物料名称：</label>
                            <div class="col-sm-7">
                                <input type="text" define="materials.accName" name="accessories.accName" class="form-control" style="background-color:#fff;border:none">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">物料数量：</label>
                            <div class="col-sm-7">
                                <input type="number"  define="materials.accCountView" disabled class="form-control" style="background-color:#fff;border:none">
                            </div>
                        </div>
                        <div class="form-group" >
                            <label class="col-sm-3 control-label">描述：</label>
                            <div class="col-sm-7">
                                <textarea type="textarea"  name="reqMsg" define="materials.reqMsg"  class="form-control" data-field="reqMsg"  placeholder="请输入领取/退回描述"
                                      rows="3" maxlength="100"></textarea>
                            </div>
                        </div>
                        <button type="button" class="btn btn-default" onclick = "closeModal('application','materialsForm')">取消</button>
                        <button  class="btn btn-primary" id = "subButton1" onclick = "checkForm('materialsForm','subButton1')" >确认</button>
                        <input type="reset" name="reset" style="display: none;"/>
                    </form>
                </div>
            </div><!-- /.modal-content -->

    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<!-- 追加弹窗 -->
    <div class="modal fade" id="appendModal" aria-hidden="true" aria-hidden="true" data-backdrop="static" keyboard="false" >
    <div class="modal-dialog" style="overflow:hidden;">
        <div class="modal-content">
            <div style="text-align: center;">
                <span  class="close"   onclick="closeModal('appendModal','appendMaterialsForm')">&times;</span>
                <div class="modal-header" style="overflow:auto;">
                    <h2>追加配件</h2>
                </div>
                <hr>
                <form role="form" id="appendMaterialsForm" class="form-horizontal">
                    <input name="maintainRecordId" readonly style="display:none" />
                    <div class="form-group">
                        <label class="col-sm-3 control-label">请选择零件：</label>
                        <div class="col-sm-7">
                            <select type="select" class="js-example-tags materialsCombobox"  name="accId"  style="width:300px;"></select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label" >请填写数量：</label>
                        <div class="col-sm-7">
                            <input type="number" name="materialCount" min = 1 data-field="materialCount" class="form-control">
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-3 control-label">描述：</label>
                        <div class="col-sm-7">
                                <textarea type="textarea"  name="reqMsg" class="form-control" data-field="reqMsg"  placeholder="请输入领取/退回描述" rows="3" maxlength="100"></textarea>
                        </div>
                    </div>
                    <button type="button" class="btn btn-default" onclick="closeModal('appendModal','appendMaterialsForm') ">取消</button>
                    <button  class="btn btn-primary" id="subButton2" onclick = "checkForm('appendMaterialsForm','subButton2')">确认</button>
                    <input type="reset" name="reset" style="display: none;"/>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</shiro:hasAnyRoles>


<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script src="/static/js/jquery.formFill.js"></script>
<script src="/static/js/select2/select2.js"></script>
<script src="/static/js/sweetalert/sweetalert.min.js"></script>
<script src="/static/js/contextmenu.js"></script>
<script src="/static/js/backstage/main.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<%--<script src="/static/js/backstage/picking/jquery.spinner.js"></script>--%>
<script src="/static/js/backstage/picking/materials.js"></script>

</body>

</html>

