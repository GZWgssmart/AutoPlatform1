<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>汽车品牌管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/fileinput.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/css/bootstrap-validate/bootstrapValidator.min.css">
</head>
<body>
<%@include file="../backstage/contextmenu.jsp" %>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;">
        <!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table">
            <thead>
                <tr>
                    <th data-checkbox="true"></th>
                    <th data-field="brandName">汽车品牌</th>
                    <th data-field="brandDes">汽车品牌描述</th>
                    <th data-field="brandStatus" data-formatter="statusFormatter">汽车品牌状态</th>
                </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <shiro:hasAnyRoles name="系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司接待员,汽车公司总技师,汽车公司技师,汽车公司学徒,汽车公司销售人员,汽车公司财务人员,汽车公司采购人员,汽车公司库管人员,汽车公司人力资源管理部">
                <button id="btn_available" type="button" class="btn btn-success" onclick="showAvailable();">
                    <span class="glyphicon glyphicon-search" aria-hidden="true"></span>可用汽车品牌记录
                </button>
            </shiro:hasAnyRoles>
            <shiro:hasAnyRoles name="系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员,汽车公司接待员,汽车公司总技师,汽车公司技师,汽车公司学徒,汽车公司销售人员,汽车公司财务人员,汽车公司采购人员,汽车公司库管人员,汽车公司人力资源管理部">
                 <button id="btn_disable" type="button" class="btn btn-danger" onclick="showDisable();">
                      <span class="glyphicon glyphicon-search" aria-hidden="true"></span>禁用汽车品牌记录
                 </button>
            </shiro:hasAnyRoles>
            <shiro:hasAnyRoles name="系统超级管理员,系统普通管理员">
                <button id="btn_add" type="button" class="btn btn-default" onclick="showAdd();">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
                </button>
            </shiro:hasAnyRoles>
            <shiro:hasAnyRoles name="系统超级管理员,系统普通管理员">
                <button id="btn_edit" type="button" class="btn btn-default" onclick="showEdit();">
                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
                </button>
            </shiro:hasAnyRoles>
        </div>
    </div>
</div>

<!-- 添加弹窗 -->
<div id="addWindow" class="modal fade" style="overflow-y:scroll" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <form role="form" class="form-horizontal" id="addForm">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写汽车品牌的相关信息</h4>
                </div>
                <br/>
                <div class="form-group">
                    <label class="col-sm-3 control-label">汽车品牌：</label>
                    <div class="col-sm-7">
                        <input type="text" name="brandName" placeholder="请输入汽车品牌的名字" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">汽车品牌描述：</label>
                    <div class="col-sm-7">
                        <textarea type="text" name="brandDes" placeholder="请输入关于该品牌的描述" style="height: 100px;" class="form-control"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button id="addButton" type="button" onclick="addSubmit()" class="btn btn-primary">添加
                    </button>
                    <input type="reset" name="reset" style="display: none;"/>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<!-- 修改弹窗 -->
<div class="modal fade" id="editWindow" style="overflow-y:scroll" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <form form role="form" class="form-horizontal" id="editForm">
                <input type="hidden"name="brandId" define="carBrand.brandId">
                <input type="hidden"name="brandStatus" define="carBrand.brandStatus">
                <div class="modal-header" style="overflow:auto;">
                    <p>请修改该品牌的相关信息</p>
                </div>
                <br/>
                <div class="form-group">
                    <label class="col-sm-3 control-label">汽车品牌名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="brandName" define="carBrand.brandName" placeholder="请输入汽车品牌名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">汽车品牌描述：</label>
                    <div class="col-sm-7">
                        <textarea type="text" name="brandDes" define="carBrand.brandDes" placeholder="请输入关于该品牌的描述" style="height: 100px;" class="form-control"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-8">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button id="editButton" type="button" onclick="editSubmit()" class="btn btn-sm btn-success">保存</button>
                    </div>
                </div>
            </form>
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
<script src="/static/js/fileInput/fileinput.js"></script>
<script src="/static/js/fileInput/zh.js"></script>
<script src="/static/js/form/jquery.validate.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/backstage/basicInfoManage/carBrand.js"></script>
</body>
</html>
