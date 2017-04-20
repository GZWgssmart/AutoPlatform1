<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                    <th data-field="brandName">
                        汽车品牌
                    </th>
                    <th data-field="brandDes">
                        汽车品牌描述
                    </th>
                    <th data-field="brandStatus">
                        汽车品牌状态
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
        </div>
    </div>
</div>

<!-- 添加弹窗 -->
<div class="modal fade" id="add" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog" style="width: 700px;height: auto;">
        <div class="modal-content" style="overflow:hidden;">
            <form class="form-horizontal" id="showAddFormWar" method="post">
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
                <%--<div class="form-group">--%>
                    <%--<label class="col-sm-3 control-label">汽车品牌Logo：</label>--%>
                    <%--<div class="col-lg-7">--%>
                        <%--<div class="ibox-title">--%>
                            <%--<div class="input-group" style="padding-left: 15px;">--%>
                                <%--<input id="add_carBrandLogo"  define="carBrand.brandLogo" name="txt_file"--%>
                                       <%--type="file" class="form-control" multiple--%>
                                       <%--class="file-loading"--%>
                                       <%--placeholder="请选择或输入一个你想上传的相册类型,默认当天日期为类型!"/>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
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


<!-- 修改弹窗 -->
<div class="modal fade" id="edit" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog" style="width: 700px;height: auto;">
        <div class="modal-content" style="overflow:hidden;">
            <form class="form-horizontal" id="showEditFormWar">
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
                <%--<div class="form-group">--%>
                    <%--<label class="col-sm-3 control-label">汽车品牌Logo：</label>--%>
                    <%--<div class="col-lg-7">--%>
                        <%--<div class="ibox-title">--%>
                            <%--<div class="input-group" style="padding-left: 15px;">--%>
                                <%--<input id="edit_carBrandLogo" define="carBrand.brandLogo" name="txt_file"--%>
                                       <%--type="file" class="form-control" multiple--%>
                                       <%--class="file-loading"--%>
                                       <%--placeholder="请选择或输入一个你想上传的相册类型,默认当天日期为类型!"/>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
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
<script src="/static/js/backstage/main.js"></script>
<script src="/static/js/fileInput/fileinput.js"></script>
<script src="/static/js/fileInput/zh.js"></script>
<script src="/static/js/form/jquery.validate.js"></script>
<script src="/static/js/backstage/basicInfoManage/carBrand.js"></script>
</body>
</html>
