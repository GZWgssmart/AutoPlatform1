<%--
  Created by IntelliJ IDEA.
  User: XiaoQiao
  Date: 2017/4/11
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>库存管理</title>
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
<body>
<%@include file="../backstage/contextmenu.jsp" %>
<div class="container ">
    <div class="panel-body" style="padding-bottom:0px;">
        <!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table">
            <thead>
            <tr>
                <th data-checkbox="true" data-field="status"></th>
                <th data-field="companyId">公司名称</th>
                <th data-field="accTypeId">配件所属类别</th>
                <th data-field="accName">配件名称</th>
                <th data-field="accCommodityCode">配件商品条码</th>
                <th data-field="accDes">配件描述</th>
                <th data-field="accPrice">配件价格</th>
                <th data-field="accSalePrice">配件售价</th>
                <th data-field="accTotal">配件数量</th>
                <th data-field="accIdle">配件可用数量</th>
                <th data-field="accUsedTime" data-formatter="formatterDateTime">最近一次领料时间</th>
                <th data-field="accBuyedTime" data-formatter="formatterDateTime">最近一次购买时间</th>
                <th data-field="accCreatedTime" data-formatter="formatterDateTime">配件创建时间</th>
                <th data-field="accStatus" data-formatter="formatterStatus">配件状态</th>
                <th data-formatter="openStatusFormatter">操作</th>
            </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <button id="btn_available" type="button" class="btn btn-default" onclick="showAvailable();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>可用登记记录
            </button>
            <button id="btn_disable" type="button" class="btn btn-default" onclick="showDisable();">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>禁用登记记录
            </button>
            <button id="btn_add" type="button" class="btn btn-default" onclick="showAdd();">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
            </button>
            <button id="btn_edit" type="button" class="btn btn-default" onclick="showEdit();">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
            </button>
        </div>
    </div>
</div>

<!-- 添加弹窗 -->
<div class="modal fade" id="addWindow" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog" style="width: 700px;height: auto;">
        <div class="modal-content" style="overflow:hidden;">
            <form class="form-horizontal" role="form" id="addForm" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写库存信息</h4>
                </div>
                <br/>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companyId" placeholder="请输入公司名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件所属类别：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accTypeId" placeholder="请输入配件所属类别" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accName" placeholder="请输入配件名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件商品条码：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accCommodityCode" placeholder="请输入配件商品条码" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件描述：</label>
                    <div class="col-sm-7">
                        <textarea type="text" name="accDes" placeholder="请输入相关内容" style="height: 100px;"
                                  class="form-control"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件价格：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accPrice" placeholder="请输入配件价格" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件售价：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accSalePrice" placeholder="请输入配件售价" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件数量：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accTotal" placeholder="请输入配件数量" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件可用数量：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accIdle" placeholder="请输入配件可用数量" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-8">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button class="btn btn-sm btn-success" type="submit">保 存</button>
                    </div>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<!-- 修改弹窗 -->
<div class="modal fade" id="editWindow" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form class="form-horizontal" role="form" id="editForm" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <input type="hidden" name="accId" define="Accessories.accId"/>
                    <h4>请填写库存信息</h4>
                </div>
                <br/>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companyId" define="Accessories.companyId" placeholder="请输入公司名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件所属类别：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accTypeId" define="Accessories.accTypeId" placeholder="请输入配件所属类别" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accName" define="Accessories.accName" placeholder="请输入配件名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件商品条码：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accCommodityCode" define="Accessories.accCommodityCode" placeholder="请输入配件商品条码" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件描述：</label>
                    <div class="col-sm-7">
                        <textarea type="text" name="accDes" define="Accessories.accDes" placeholder="请输入相关内容" style="height: 100px;"
                                  class="form-control"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件价格：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accPrice" define="Accessories.accPrice" placeholder="请输入配件价格" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件售价：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accSalePrice" define="Accessories.accSalePrice" placeholder="请输入配件售价" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件数量：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accTotal" define="Accessories.accTotal" placeholder="请输入配件数量" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">配件可用数量：</label>
                    <div class="col-sm-7">
                        <input type="text" name="accIdle" define="Accessories.accIdle" placeholder="请输入配件可用数量" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-8">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button class="btn btn-sm btn-success" type="submit">保 存</button>
                    </div>
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
<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script src="/static/js/jquery.formFill.js"></script>
<script src="/static/js/select2/select2.js"></script>
<script src="/static/js/sweetalert/sweetalert.min.js"></script>
<script src="/static/js/contextmenu.js"></script>
<script src="/static/js/bootstrap-select/bootstrap-select.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="/static/js/form/jquery.validate.js"></script>
<script src="/static/js/backstage/main.js"></script>
<script src="/static/js/backstage/accessories/accessories.js"></script>
</body>
</html>