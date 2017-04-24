<%--
  Created by IntelliJ IDEA.
  User: yaoyong
  Date: 2017/4/11
  Time: 15:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>物料清单管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/datetimepicker.less">
</head>
<style>
    .sd{
        font-weight: bold;
    }
</style>
<body>
<%@include file="../backstage/contextmenu.jsp"%>
<div class="container">
    <div class="panel-body" style="padding-bottom:0px;"  >
        <table id="recordTable" style="table-layout: fixed" data-search=true>
            <thead>
            <tr >
                <th data-radio="true"></th>
                <th data-width="110" data-field="carplate">
                    车牌
                </th>
                <th data-width="110" data-field="carmodel">
                    车型
                </th>
                <th data-width="100" data-hide="all" data-field="hours">
                    所需工时
                </th>
                <th data-width="180" data-hide="all" data-field="record.recordCreatedTime" data-formatter="formatterDate">
                    创建时间
                </th>
                <th data-width="180" data-hide="all" data-field="todoCell" data-formatter="todoCell">
                    操作
                </th>
            </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <button id="btn_add" type="button" class="btn btn-default" onclick="showAdd();">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
            </button>
            <button id="btn_edit" type="button" class="btn btn-default" onclick="showEdit();">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
            </button>
            <button id="btn_delete" type="button" class="btn btn-default" onclick="showDel();">
                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
            </button>
            <button id="btn_appoint" type="button" class="btn btn-warning" onclick="showAppoint();">指派员工</button>
            <button id="btn_confirm" type="button" class="btn btn-info" onclick="showConfirm();">领料确认</button>
            <button id="btn_application" type="button" class="btn btn-success" onclick="showApplication();">退料申请</button>
            <button id="btn_regress" type="button" class="btn btn-danger" onclick="showRegress();">确认退料</button>
        </div>
    </div>
</div>

<!-- 指派员工弹窗 -->
<div class="modal fade" id="appoint" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog">
        <div class="modal-content">
            <form class="form-horizontal" id="appointForm" method="post">
                <input type="text" name="recordId" placeholder="订单号" define="record.recordId" class="form-control"/>
                <div class="modal-header" style="overflow:auto;">
                    <h4 class="sd">请选择指定的员工</h4>
                </div>
                <hr>
                <div class="form-group">
                    <label class="col-sm-3 control-label">请选择员工：</label>
                    <select   class="js-example-basic-multiple addemp" name="userId"  style="width:300px;">
                    </select>
                </div>
                <div class="modal-footer" style="border: none;">
                    <span id="editError" style="color: red;"></span>
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button type="button" onclick="submitDispatcher()" class="btn btn-primary">
                        确认
                    </button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 确认领料弹窗 -->
<div class="modal fade" id="confirm" aria-hidden="true">
    <div class="modal-dialog" style="overflow:hidden;">
        <form action="/table/edit" method="post">
            <div class="modal-content">
                <input type="hidden" id="delNoticeId2"/>
                <div class="modal-footer" style="text-align: center;">
                    <h2>确认领料吗?</h2>
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">取消
                    </button>
                    <button type="sumbit" class="btn btn-primary" onclick="">
                        确认
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </form>
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 退料申请添加弹窗 -->
<div class="modal fade" id="application" aria-hidden="true">
    <div class="modal-dialog" style="overflow:hidden;">
        <form action="/table/edit" method="post">
            <div class="modal-content">
                <input type="hidden" id="delNoticeId3"/>
                <div class="modal-footer" style="text-align: center;">
                    <h2>确认退料申请吗?</h2>
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">取消
                    </button>
                    <button type="sumbit" class="btn btn-primary" onclick="">
                        确认
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </form>
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 确认退料弹窗 -->
<div class="modal fade" id="regress" aria-hidden="true">
    <div class="modal-dialog" style="overflow:hidden;">
        <form action="/table/edit" method="post">
            <div class="modal-content">
                <input type="hidden" id="delNoticeId1"/>
                <div class="modal-footer" style="text-align: center;">
                    <h2>确认退料吗?</h2>
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">取消
                    </button>
                    <button type="sumbit" class="btn btn-primary" onclick="">
                        确认
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </form>
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 添加弹窗 -->
<div class="modal fade" id="addWindow" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog">
        <div class="modal-content">
            <form class="form-horizontal" role="form" onsubmit="return checkAdd()" id="showAddFormWar" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <h4 class="sd">添加物料清单</h4>
                </div>
                <hr>
                <div class="form-group">
                    <label class="col-sm-3 control-label">物料名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="materialName" placeholder="请输入物料名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">物料说明：</label>
                    <div class="col-sm-7">
                        <input type="text" name="materielState" placeholder="请输入物料说明" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">物料数量：</label>
                    <div class="col-sm-7">
                        <input type="text" name="materielCount" placeholder="请输入物料数量" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修保养记录：</label>
                    <div class="col-sm-7">
                        <input type="text" name="maintain" placeholder="请输入维修保养记录" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">领料时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="materiel_Receive_Time" value="2012-05-15 21:05" id="materiel_Receive_Time" class="form-control">
                    </div>
                </div>
                <div class="modal-footer" style="border: none;">
                    <span id="addError"></span>
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button type="submit" class="btn btn-primary btn-sm">保存</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 修改弹窗 -->
<div class="modal fade" id="editWindow" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog">
        <div class="modal-content">
            <form class="form-horizontal" role="form" onsubmit="return checkAdd()" id="showEditFormWar" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <h4 class="sd">请修改你的物料清单</h4>
                </div>
                <hr>
                <div class="form-group">
                    <label class="col-sm-3 control-label">物料名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="materialName" placeholder="请输入物料名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">物料说明：</label>
                    <div class="col-sm-7">
                        <input type="text" name="materielState" placeholder="请输入物料说明" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">物料数量：</label>
                    <div class="col-sm-7">
                        <input type="text" name="materielCount" placeholder="请输入物料数量" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">维修保养记录：</label>
                    <div class="col-sm-7">
                        <input type="text" name="maintain" placeholder="请输入维修保养记录" class="form-control">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 control-label">领料时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="materiel_Receive_Time" define="materiel_Receive_Time" value="2012-05-15 21:05"
                               id="editDateTimePicker" class="form-control">
                    </div>
                </div>
                <div class="modal-footer" style="border: none;">
                    <span id="editError1" style="color: red;"></span>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button class="btn btn-sm btn-success" type="submit">保 存</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 删除弹窗 -->
<div class="modal fade" id="del" aria-hidden="true">
    <div class="modal-dialog" style="overflow:hidden;">
        <form action="/table/edit" method="post">
            <div class="modal-content">
                <input type="hidden" id="delNoticeId"/>
                <div class="modal-footer" style="text-align: center;">
                    <h2>确认删除吗?</h2>
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button type="sumbit" class="btn btn-primary" onclick="del()">
                        确认
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </form>
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 提示弹窗 -->
<div class="modal fade" id="tanchuang" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                提示
            </div>
            <div class="modal-body">
                请先选择某一行
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default"
                        data-dismiss="modal">关闭
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<!-- 零件明细弹窗 -->
<div class="modal fade" id="accsInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="margin-right:0;width:95%;">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">零件明细</h4>
            </div>
            <div class="modal-body">
                <input style="display: none;" id="seachRecordId" />
                <table id="accInfoTable" style="table-layout: fixed">
                    <thead>
                    <tr >
                        <th data-radio="true"></th>
                        <th data-width="110" data-field="carplate">
                           零件名称
                        </th>
                        <th data-width="110" data-field="carmodel">
                            零件数量
                        </th>
                    </tr>
                    </thead>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary">提交更改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>





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
<script src="/static/js/form/jquery.validate.js"></script>
<script src="/static/js/backstage/picking/materials.js"></script>

</body>
<script>
    $(function() {
        initTable('recordTable', '/dispatching/queryRecordByPager'); // 初始化表格
        initSelect2("addemp", "请选择员工", "/dispatching/emps"); // 初始化select2, 第一个参数是class的名字, 第二个参数是select2的提示语, 第三个参数是select2的查询url
        //initTable('accInfoTable', '/dispatching/accInfo'); // 初始化表格
//        $("#accInfoTable").bootstrapTable({
//            queryParams:  function queryParams(params) {   //设置查询参数
//                console.log(params);
//                var param = {
//                    pageNumber: params.pageNumber,
//                    pageSize: params.pageSize,
//                    recordId: $("#seachRecordId").val(),
//                    orderNum : $("#orderNum").val()
//                };
//                return param;
//            }
//        });
    });

    function todoCell(element, row, index){
        var accInfo = '<span onclick = "showInfo(\''+ row.record.recordId +'\')"><a style="float:left">查看零件明细</a></span>'
        var dispatcher = '<span onclick = "showAppoint(\''+ row.record.recordId +'\')"><a style="float:left">指派员工</a></span>'
        return accInfo + dispatcher;
    }

    function showInfo(recordId){
        $("#accsInfo").modal("show");
        $("#seachRecordId").val(recordId);
        console.log("recordId: " + recordId);

    }

// 重写了
    function showAppoint(recordId){
            $("#appoint").modal('show'); // 显示弹窗
            var record = {recordId:recordId};
            $("#appointForm").fill(record);
    }


</script>
</html>
