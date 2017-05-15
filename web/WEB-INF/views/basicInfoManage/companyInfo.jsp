<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>公司信息管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/css/fileinput.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/bootstrap-validate/bootstrapValidator.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet/less" href="/static/css/bootstrap-dateTimePicker/datetimepicker.less">
</head>
<body>
<%@include file="../backstage/contextmenu.jsp" %>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;">
        <table id="table">
            <thead>
                <tr>
                    <th data-radio="true"></th>
                    <th data-field="companyName">公司名称</th>
                    <th data-field="companyAddress">公司地址</th>
                    <th data-field="companyTel">联系电话</th>
                    <th data-field="companyPricipal">负责人</th>
                    <th data-field="companyWebsite">公司官网网址</th>
                    <th data-field="companyLogo">公司LOGO</th>
                    <th data-field="companyOpendate" data-formatter="formatterDate">公司成立时间</th>
                    <th data-field="companySize">公司规模</th>
                    <th data-field="companyLongitude">公司经度</th>
                    <th data-field="companyLatitude">公司纬度</th>
                    <th data-field="companyDes">公司描述</th>
                    <th data-field="companyStatus" data-formatter="statusFormatter">公司状态</th>
                </tr>
            </thead>
        </table>
        <div id="toolbar" class="btn-group">
            <shiro:hasAnyRoles name="系统超级管理员,系统普通管理员">
                <button id="btn_available" type="button" class="btn btn-success" onclick="showAvailable();">
                    <span class="glyphicon glyphicon-search" aria-hidden="true"></span>可用公司记录
                </button>
            </shiro:hasAnyRoles>
            <shiro:hasAnyRoles name="系统超级管理员,系统普通管理员">
                <button id="btn_disable" type="button" class="btn btn-danger" onclick="showDisable();">
                    <span class="glyphicon glyphicon-search" aria-hidden="true"></span>禁用公司记录
                </button>
            </shiro:hasAnyRoles>
            <shiro:hasAnyRoles name="系统超级管理员,系统普通管理员">
                <button id="btn_add" type="button" class="btn btn-default" onclick="showAdd();">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
                </button>
            </shiro:hasAnyRoles>
            <shiro:hasAnyRoles name="系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员">
                <button id="btn_edit" type="button" class="btn btn-default" onclick="showEdit();">
                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
                </button>
            </shiro:hasAnyRoles>
        </div>
    </div>
</div>

<!-- 添加弹窗 -->
<div class="modal fade"  id="addWindow" style="overflow-y:scroll" data-backdrop="static" >
    <div class="modal-dialog">
        <div class="modal-content">
            <form class="form-horizontal" role="form" id="addForm">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写公司信息</h4>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司名称：</label>
                    <div class="col-sm-7">
                        <input type="text" id="companyName" name="companyName" placeholder="请输入公司名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司地址：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companyAddress" placeholder="请输入公司地址" class="form-control">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 control-label">联系电话：</label>
                    <div class="col-sm-7">
                        <input type="number" id="addcompanyTel" placeholder="请输入联系方式" name="companyTel" class="form-control" style="width:100%"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">负责人：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companyPricipal" placeholder="请输入负责人" class="form-control">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 control-label">公司官网网址：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companyWebsite" placeholder="请输入公司官网网址" class="form-control">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 control-label">公司规模：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companySize" placeholder="请输入公司规模" class="form-control">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 control-label">公司成立时间：</label>
                    <div class="col-sm-7">     <!-- 当设置不可编辑后, 会修改颜色, 在min.css里搜索.form-control{background-color:#eee;opacity:1} -->
                        <input id="addDateTimePicker" placeholder="请选择公司成立时间" onclick="getDate('addDateTimePicker')" readonly="true" type="text" name="companyOpendate"
                               class="form-control datetimepicker"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司经度：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companyLongitude" placeholder="请输入公司经度" class="form-control">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 control-label">公司纬度：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companyLatitude" placeholder="请输入公司纬度" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司描述：</label>
                    <div class="col-sm-7">
                                <textarea class="form-control" placeholder="请输入公司描述" name="companyDes"
                                          rows="3" maxlength="500"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司logo：</label>
                    <div class="col-lg-7">
                        <div class="ibox-title">
                            <div class="input-group" style="padding-left: 15px;">
                                <input id="add_companyLogo" name="txt_file" type="file" class="form-control" multiple
                                       class="file-loading"
                                       placeholder="请选择或输入一个你想上传的相册类型,默认当天日期为类型!"/>
                            </div>
                        </div>
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
            <form class="form-horizontal" role="form" id="editForm" method="post">
                <input type="hidden"name="companyId" define="company.companyId">
                <input type="hidden"name="companyStatus" define="company.companyStatus">
                <div class="modal-header" style="overflow:auto;">
                    <p>请修改公司信息</p>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companyName" define="companyInfo.companyName" placeholder="请输入公司名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司地址：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companyAddress" define="companyInfo.companyAddress" placeholder="请输入公司地址"
                               class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">联系电话：</label>
                    <div class="col-sm-7">
                        <input type="number" name="companyTel" placeholder="联系电话电话" define="companyInfo.companyTel" class="form-control" style="width:100%"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 control-label">负责人：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companyPricipal" define="companyInfo.companyPricipal" placeholder="请输入负责人"
                               class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司官网网址：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companyWebsite" define="companyInfo.companyWebsite" placeholder="请输入公司官网网址"
                               class="form-control">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 control-label">公司规模：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companySize" define="companyInfo.companySize" placeholder="请输入公司规模"
                               class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司成立时间：</label>
                    <div class="col-sm-7">     <!-- 当设置不可编辑后, 会修改颜色, 在min.css里搜索.form-control{background-color:#eee;opacity:1} -->
                        <input id="editDatetimepicker" placeholder="请选择公司成立时间" readonly="true" type="text" name="companyOpendate"
                               class="form-control datetimepicker"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司经度：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companyLongitude" define="companyInfo.companyLongitude" placeholder="请输入公司经度"
                               class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司纬度：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companyLatitude" define="companyInfo.companyLatitude" placeholder="请输入公司经度"
                               class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司描述：</label>
                    <div class="col-sm-7">
                                <textarea type="textarea" class="form-control" placeholder="请输入公司描述" define="companyInfo.companyDes" name="companyDes"
                                          rows="3" maxlength="500"></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 control-label">公司logo：</label>
                    <div class="col-lg-7">
                        <div class="ibox-title">
                            <div class="input-group" style="padding-left: 15px;">
                                <input id="edit_companyLogo" define="companyInfo.companyLogo" name="txt_file"
                                       type="file" class="form-control" multiple
                                       class="file-loading"
                                       placeholder="请选择或输入一个你想上传的相册类型,默认当天日期为类型!"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button id="editButton" type="button" onclick="editSubmit()" class="btn btn-primary">保存
                    </button>
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
    <script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
    <script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
    <script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
    <script src="/static/js/backstage/basicInfoManage/companyInfo.js"></script>
</body>
</html>
