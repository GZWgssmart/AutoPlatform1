<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/4/11
  Time: 15:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <title>公司信息管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/fileinput.css">
    <link rel="stylesheet" href="/static/css/laydate/laydate.css">

</head>
<body>
<%@include file="../backstage/contextmenu.jsp" %>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;">
        <!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table"
               data-toggle="table"
               data-toolbar="#toolbar"
               data-url="/table/query"
               data-method="post"
               data-query-params="queryParams"
               data-pagination="true"
               data-search="true"
               data-show-refresh="true"
               data-show-toggle="true"
               data-show-columns="true"
               data-page-size="10"
               data-height="543"
               data-id-field="id"
               data-page-list="[5, 10, 20]"
               data-cach="false"
               data-click-to-select="true"
               data-single-select="true">
            <thead>
            <tr>
                <th data-radio="true" data-field="status"></th>
                <th data-field="companyName">公司名称</th>
                <th data-field="companyAddress">公司地址</th>
                <th data-field="companyTel">联系电话</th>
                <th data-field="companyPricipal">负责人</th>
                <th data-field="companyOpenDate">公司成立时间</th>
                <th data-field="companyLogo">公司LOGO</th>

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
            <form class="form-horizontal" onsubmit="return checkAdd()" id="addForm" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <p>请填写你的公司信息</p>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司名称：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请输入公司名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司地址：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请输入公司地址" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">联系电话：</label>
                    <div class="col-sm-7">
                        <input type="number" placeholder="请输入联系方式" class="form-control" max="11">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">负责人：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请输入负责人" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司成立时间：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请输入负责人" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司logo：</label>
                    <div class="col-lg-7">
                        <div class="ibox-title">
                            <div class="input-group">
                                <input id="add_companyLogo" name="txt_file" type="file" class="form-control" multiple
                                       class="file-loading"
                                       placeholder="请选择或输入一个你想上传的相册类型,默认当天日期为类型!"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-8">
                        <button class="btn btn-sm btn-primary" type="submit">返 回</button>
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
            <form class="form-horizontal" onsubmit="return checkAdd()" id="editForm" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <p>请修改你的公司信息</p>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司名称：</label>
                    <div class="col-sm-7">
                        <input type="text" define="ceshi.price" placeholder="请输入公司名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司地址：</label>
                    <div class="col-sm-7">
                        <input type="text" define="ceshi.price" placeholder="请输入公司地址" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">联系电话：</label>
                    <div class="col-sm-7">
                        <input type="number" placeholder="请输入联系方式" class="form-control" max="11">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">负责人：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请输入负责人" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司成立时间：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请输入负责人" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">公司logo：</label>
                    <div class="col-lg-7">
                        <div class="ibox-title">
                            <div class="input-group">
                                <input id="edit_companyLogo" name="txt_file" type="file" class="form-control" multiple
                                       class="file-loading"
                                       placeholder="请选择或输入一个你想上传的相册类型,默认当天日期为类型!"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-8">
                        <button class="btn btn-sm btn-primary" type="submit">返 回</button>
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
<script src="/static/js/fileInput/fileinput.js"></script>
<script src="/static/js/fileInput/zh.js"></script>
<script src="/static/js/laydate.js"></script>


<script>

    $(function () {
        $('#table').bootstrapTable('hideColumn', 'id');

        $("#addSelect").select2({
                language: 'zh-CN'
            }
        );

        //绑定Ajax的内容
        $.getJSON("/table/queryType", function (data) {
            $("#addSelect").empty();//清空下拉框
            $.each(data, function (i, item) {
                $("#addSelect").append("<option value='" + data[i].id + "'>&nbsp;" + data[i].name + "</option>");
            });
        })
//            $("#addSelect").on("select2:select",
//                    function (e) {
//                        alert(e)
//                        alert("select2:select", e);
//            });
    });

    function showEdit() {
        var row = $('table').bootstrapTable('getSelections');
        if (row.length > 0) {
//                $('#editId').val(row[0].id);
//                $('#editName').val(row[0].name);
//                $('#editPrice').val(row[0].price);
            $("#edit").modal('show'); // 显示弹窗
            var ceshi = row[0];
            $("#editForm").fill(ceshi);
        } else {
            $("#tanchuang").modal('show');
        }
    }

    function showAdd() {

        $("#add").modal('show');
    }

    function formatRepo(repo) {
        return repo.text
    }
    function formatRepoSelection(repo) {
        return repo.text
    }

    function showDel() {
        var row = $('table').bootstrapTable('getSelections');
        if (row.length > 0) {
            $("#del").modal('show');
        } else {
            $("#tanchuang").modal('show');
        }
    }

    function checkAdd() {
        var id = $('#addId').val();
        var name = $('#addName').val();
        var price = $('#addPrice').val();
        var reslist = $("#addSelect").select2("data"); //获取多选的值
        alert(reslist.length)
        if (id != "" && name != "" && price != "") {
            return true;
        } else {
            var error = document.getElementById("addError");
            error.innerHTML = "请输入正确的数据";
            return false;
        }
    }

    function checkEdit() {
        $.post("/table/edit",
            $("#editForm").serialize(),
            function (data) {
                if (data.result == "success") {
                    $("#edit").modal('hide'); // 关闭指定的窗口
                    $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
                    swal({
                        title: "",
                        text: data.message,
                        type: "success"
                    })// 提示窗口, 修改成功
                } else if (data.result == "fail") {
                    //$.messager.alert("提示", data.result.message, "info");
                }
            }, "json"
        );
    }

    $(function () {
        //0.初始化fileinput
        var oFileInput = new FileInput();
        oFileInput.Init("add_companyLogo", "/file/addFile");
    });

    $(function () {
        //0.初始化fileinput
        var oFileInput = new FileInput();
        oFileInput.Init("edit_companyLogo", "/file/editFile");
    });

    //初始化fileinput
    var FileInput = function () {
        var oFile = new Object();
        //初始化fileinput控件（第一次初始化）
        oFile.Init = function (ctrlName, uploadUrl) {
            var control = $('#' + ctrlName);
            //初始化上传控件的样式
            control.fileinput({
                language: 'zh', //设置语言
                uploadUrl: uploadUrl, //上传的地址
                allowedFileExtensions: ['jpg', 'gif', 'png'],//接收的文件后缀
                showUpload: true, //是否显示上传按钮
                showCaption: false,//是否显示标题
                browseClass: "btn btn-primary", //按钮样式
                dropZoneEnabled: true,//是否显示拖拽区域
                //minImageWidth: 50, //图片的最小宽度
                //minImageHeight: 50,//图片的最小高度
                //maxImageWidth: 1000,//图片的最大宽度
                //maxImageHeight: 1000,//图片的最大高度
                //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
                //minFileCount: 0,
                maxFileCount: 10, //表示允许同时上传的最大文件个数
                enctype: 'multipart/form-data',
                validateInitialCount: true,
                previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
                msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
            }).on("fileuploaded", function (event, data) {
                // data 为controller返回的json
                if (data.response.result == 'success') {
                    alert('处理成功');
                }
            });
        }
        return oFile;
    };
</script>
</body>
</html>
