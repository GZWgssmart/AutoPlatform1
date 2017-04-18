<!--电话预约管理-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-dateTimePicker/datetimepicker.less">
</head>
<body>
<%@include file="../backstage/contextmenu.jsp"%>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;"  >
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
               data-height="700"
               data-id-field="id"
               data-page-list="[5, 10, 20]"
               data-cach="false"
               data-click-to-select="true"
               data-single-select="true">
            <thead>
            <tr>
                <th data-radio="true" data-field="status"></th>
                <th data-field="userId">车主姓名</th>
                <th data-field="userPhone">车主电话</th>
                <th data-field="brandId">品牌</th>
                <th data-field="colorId">颜色</th>
                <th data-field="modelId">车型</th>
                <th data-field="plateId">车牌号</th>
                <th data-field="arriveTime">到店时间</th>
                <th data-field="maintainOrFix">
                    <select name="jungle" title="请选择一个选项" required data-width="100">
                        <option value=""></option>
                        <option value="1">美容</option>
                        <option value="2">维修</option>
                        <option value="3">保养</option>
                    </select>
                </th>
                <th data-field="appCreatedTime">预约日期</th>
                <th data-field="companyId">汽修公司</th>
                <th data-field="appotmentStatus">预约状态</th>
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
<!--添加窗口-->
<div class="modal fade" id="add" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog" style="height: auto; overflow:auto;">
        <div class="modal-content" style="overflow:auto;">
            <form class="form-horizontal" role="form" onsubmit="return checkAdd()" id="addForm" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写预约信息</h4>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">车主姓名：</label>
                    <div class="col-sm-7">
                        <input type="text" name="userId" placeholder="请输入姓名" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">车主电话：</label>
                    <div class="col-sm-7">
                        <input type="text" name="userPhone" placeholder="请输入电话" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">品牌：</label>
                    <div class="col-sm-7">
                        <select name="jungle" title="请选择一个选项" required style="width:320px;height:32px;">
                            <option value="">请选择</option>
                            <option value="1">美容</option>
                            <option value="2">维修</option>
                            <option value="3">保养</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">颜色：</label>
                    <div class="col-sm-5" style="padding-right: 0px">
                        <input name="colorId"type="text" class="form-control editColor" data-control="hue" value="">
                    </div>
                    <div class="col-sm-2" style="padding-left: 0px;">
                        <input type="button" class="btn btn-default" value="确认" onclick="showAddHex();">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">车型：</label>
                    <div class="col-sm-7">
                        <input type="text" name="modelId" placeholder="请输入车型" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">车牌号：</label>
                    <div class="col-sm-7">
                        <input type="text" name="plateId" placeholder="请输入车牌号" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">到店时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="arriveTime" id="addarriveTime" value="2012-05-15 21:05" placeholder="请选择到店时间" class="form-control" max="11">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">保养类型：</label>
                    <div class="col-sm-7">
                        <select name="jungle" title="请选择一个选项" required style="width:320px;height:32px;">
                            <option value="">请选择</option>
                            <option value="1">美容</option>
                            <option value="2">维修</option>
                            <option value="3">保养</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-3 control-label">汽修公司：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companyId" placeholder="请输入汽修公司" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">预约状态：</label>
                    <div class="col-sm-7">
                        <input type="text" name="appotmentStatus" placeholder="请选择状态" class="form-control">
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
    </div>
</div>

<!-- 修改弹窗 -->
<div class="modal fade" id="editWindow" aria-hidden="true" style="overflow:auto; ">
    <div class="modal-dialog" style="height: auto; overflow:auto;">
        <div class="modal-content" style="overflow:auto;">
            <form class="form-horizontal" role="form" onsubmit="return checkAdd()" id="editForm" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <h4>请填写预约信息</h4>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">车主姓名：</label>
                    <div class="col-sm-7">
                        <input type="text" name="userId" placeholder="请输入姓名" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">车主电话：</label>
                    <div class="col-sm-7">
                        <input type="text" name="userPhone" placeholder="请输入电话" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">品牌：</label>
                    <div class="col-sm-7">
                        <select name="brandId" title="请选择一个选项" required style="width:320px;height:32px;">
                            <option value="">对方回复</option>
                            <option value="1">美容</option>
                            <option value="2">维修</option>
                            <option value="3">保养</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">颜色：</label>
                    <div class="col-sm-5" style="padding-right: 0px">
                        <input name="colorId" type="text" class="form-control addColor" data-control="hue" value="">
                    </div>
                    <div class="col-sm-2" style="padding-left: 0px;">
                        <input type="button" class="btn btn-default" value="确认" onclick="showEditHex();">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">车型：</label>
                    <div class="col-sm-7">
                        <input type="text" name="modelId" placeholder="请输入车型" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">车牌号：</label>
                    <div class="col-sm-7">
                        <input type="text" name="plateId" placeholder="请输入车牌号" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">到店时间：</label>
                    <div class="col-sm-7">
                        <input type="text" name="arriveTime" id="editarriveTime"placeholder="请选择到店时间" class="form-control" max="11">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">保养类型：</label>
                    <div class="col-sm-7">
                        <select id="jungle" name="jungle" title="请选择一个选项" required style="width:320px;height:32px;">
                            <option value="">请选择</option>
                            <option value="1">美容</option>
                            <option value="2">维修</option>
                            <option value="3">保养</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">汽修公司：</label>
                    <div class="col-sm-7">
                        <input type="text" name="companyId" placeholder="请输入汽修公司" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">预约状态：</label>
                    <div class="col-sm-7">
                        <input type="text" name="appotmentStatus" value="2012-05-15 21:05" id="addDateTimePicker" class="form-control">
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
    </div>
</div>

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
<script src="/static/js/form/jquery.validate.js"></script>
<script src="/static/js/contextmenu.js"></script>
<script src="/static/js/minicolors/jquery.minicolors.min.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/bootstrap-datetimepicker.min.js"></script>
<script src="/static/js/bootstrap-dateTimePicker/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
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
    //修改窗口
    function showEdit(){
        var row =  $('table').bootstrapTable('getSelections');
        if(row.length > 0) {
//                $('#editId').val(row[0].id);
//                $('#editName').val(row[0].name);
//                $('#editPrice').val(row[0].price);
            $("#editWindow").modal('show'); // 显示弹窗
            var ceshi = row[0];
            $("#editForm").fill(ceshi);
        }else{
            swal({
                "title": "",
                "text": "请先选择一条数据",
                "type": "warning"
            })
        }
    }
    //添加窗口
    function showAdd(){

        $("#add").modal('show');
    }

    function formatRepo(repo){return repo.text}
    function formatRepoSelection(repo){return repo.text}

    function showDel(){
        var row =  $('table').bootstrapTable('getSelections');
        if(row.length >0) {
            $("#del").modal('show');
        }else{
            $("#tanchuang").modal('show');
        }
    }

    function checkAdd(){
        var id = $('#addId').val();
        var name = $('#addName').val();
        var price = $('#addPrice').val();
        var reslist=$("#addSelect").select2("data"); //获取多选的值
        //alert(reslist.length)
        if(id != "" && name != "" && price != ""){
            return true;
        }else{
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
                        title:"",
                        text: data.message,
                        type:"success"})// 提示窗口, 修改成功
                } else if (data.result == "fail") {
                    //$.messager.alert("提示", data.result.message, "info");
                }
            }, "json"
        );
    }
    //前台验证
    $(document).ready(function () {
        jQuery.validator.addMethod("isuserPhone", function (value, element) {
            var length = value.length;
            return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(value));
        }, "请正确填写您的手机号码。");

        $("#addForm").validate({
            errorElement: 'span',
            errorClass: 'help-block',

            rules: {
                userId: {
                    required: true,
                    minlength: 2
                },
                userPhone: {
                    required: true,
                    isuserPhone: true,
                },
                colorId: {
                    required: true,
                    minlength: 2
                },
                modelId: {
                    required: true,
                    minlength: 5
                },
                plateId: {
                    required: true,
                    minlength: 7
                },
                arriveTime: {
                    required: true,
                    date: true
                },
                appCreatedTime: {
                    required: true,
                    date: true
                },
                companyId: {
                    required: true,
                    minlength: 5
                }
            },
            messages: {
                userId: "请输入姓名",
                userPhone: {
                    required: "请输入你的联系方式",
                },
                colorId: "请你颜色",
                modelId: "请输入车型",
                plateId: "请输入车牌号",
                arriveTime: "到店时间",
                appCreatedTime: "请输入预约日期",
                companyId: "请输入公司名称"
            },
            errorPlacement: function (error, element) {
                element.next().remove();
                element.after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
                element.closest('.form-group').append(error);
            },
            highlight: function (element) {
                $(element).closest('.form-group').addClass('has-error has-feedback');
            },
            success: function (label) {
                var el = label.closest('.form-group').find("input");
                el.next().remove();
                el.after('<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
                label.closest('.form-group').removeClass('has-error').addClass("has-feedback has-success");
                label.remove();
            },
            submitHandler: function (form) {
                alert("submitted!");
            }
        }),
            $("#editForm").validate({
                errorElement: 'span',
                errorClass: 'help-block',

                rules: {
                    userId: {
                        required: true,
                        minlength: 2
                    },
                    userPhone: {
                        required: true,
                        isPhone: true,
                    },
                    colorId: {
                        required: true,
                        minlength: 2
                    },
                    modelId: {
                        required: true,
                        minlength: 5
                    },
                    plateId: {
                        required: true,
                        minlength: 7
                    },
                    arriveTime: {
                        required: true,
                        date: true
                    },
                    appCreatedTime: {
                        required: true,
                        date: true
                    },
                    companyId: {
                        required: true,
                        minlength: 5
                    }
                },
                messages: {
                    userId: "请输入姓名",
                    userPhone: {
                        required: "请输入你的联系方式",
                    },
                    colorId: "请你颜色",
                    modelId: "请输入车型",
                    plateId: "请输入车牌号",
                    arriveTime: "到店时间",
                    appCreatedTime: "请输入预约日期",
                    companyId: "请输入公司名称"

                },
                errorPlacement: function (error, element) {
                    element.next().remove();
                    element.after('<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>');
                    element.closest('.form-group').append(error);
                },
                highlight: function (element) {
                    $(element).closest('.form-group').addClass('has-error has-feedback');
                },
                success: function (label) {
                    var el = label.closest('.form-group').find("input");
                    el.next().remove();
                    el.after('<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>');
                    label.closest('.form-group').removeClass('has-error').addClass("has-feedback has-success");
                    label.remove();
                },
                submitHandler: function (form) {
                    alert("submitted!");
                }
            })
    });
    //设置到店时间
    $('#addarriveTime').datetimepicker({
        language: 'zh-CN',
        format: 'yyyy-mm-dd hh:ii'
    });
    //修改到店时间
    $('#editarriveTime').datetimepicker({
        language: 'zh-CN',
        format: 'yyyy-mm-dd hh:ii'
    });

    //颜色
    //获取hex颜色值后转换成rgb颜色值后自动添加到rgb颜色框中
    function showAddHex() {
        var a = document.getElementsByName("addColor")[0].value;
        if (a.substr(0, 1) == "#") a = a.substring(1);
        if (a.length != 6)return alert("请输入正确的十六进制颜色码！")
        a = a.toLowerCase()
        b = new Array();
        for (x = 0; x < 3; x++) {
            b[0] = a.substr(x * 2, 2)
            b[3] = "0123456789abcdef";
            b[1] = b[0].substr(0, 1)
            b[2] = b[0].substr(1, 1)
            b[20 + x] = b[3].indexOf(b[1]) * 16 + b[3].indexOf(b[2])
        }
        var rbgNumber = b[20] + "," + b[21] + "," + b[22];
        var rgbColor = document.getElementById("addrgbColor");
        rgbColor.value = rbgNumber;
    }
    function showEditHex() {
        var a = document.getElementsByName("editColor")[0].value;
        if (a.substr(0, 1) == "#") a = a.substring(1);
        if (a.length != 6)return alert("请输入正确的十六进制颜色码！")
        a = a.toLowerCase()
        b = new Array();
        for (x = 0; x < 3; x++) {
            b[0] = a.substr(x * 2, 2)
            b[3] = "0123456789abcdef";
            b[1] = b[0].substr(0, 1)
            b[2] = b[0].substr(1, 1)
            b[20 + x] = b[3].indexOf(b[1]) * 16 + b[3].indexOf(b[2])
        }
        var rbgNumber = b[20] + "," + b[21] + "," + b[22];
        var rgbColor = document.getElementById("editrgbColor");
        rgbColor.value = rbgNumber;
    }


    function getkey(e, n) {
        var keynum;
        if (window.event) keynum = e.keyCode; else if (e.which) keynum = e.which;
        if (keynum == 13) {
            if (n == 0) showRGB(); else showRGB2();
        }
    }

    //颜色控件初始化
    $(document).ready(function () {
        $('.addColor').each(function () {
            $(this).minicolors({
                control: $(this).attr('data-control') || 'hue',
                defaultValue: $(this).attr('data-defaultValue') || '',
                inline: $(this).attr('data-inline') === 'true',
                letterCase: $(this).attr('data-letterCase') || 'lowercase',
                opacity: $(this).attr('data-opacity'),
                position: $(this).attr('data-position') || 'bottom left',
                change: function (hex, opacity) {
                    if (!hex) return;
                    if (opacity) hex += ', ' + opacity;
                    try {
                        console.log(hex);
                    } catch (e) {
                    }
                },
                theme: 'bootstrap'
            });
        });
    });

    //颜色控件初始化
    $(document).ready(function () {
        $('.editColor').each(function () {
            $(this).minicolors({
                control: $(this).attr('data-control') || 'hue',
                defaultValue: $(this).attr('data-defaultValue') || '',
                inline: $(this).attr('data-inline') === 'true',
                letterCase: $(this).attr('data-letterCase') || 'lowercase',
                opacity: $(this).attr('data-opacity'),
                position: $(this).attr('data-position') || 'bottom left',
                change: function (hex, opacity) {
                    if (!hex) return;
                    if (opacity) hex += ', ' + opacity;
                    try {
                        console.log(hex);
                    } catch (e) {
                    }
                },
                theme: 'bootstrap'
            });
        });
    });
</script>
</body>
</html>

