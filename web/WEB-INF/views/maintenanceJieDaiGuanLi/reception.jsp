<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <script src="/static/js/jqueryVaildate/jquery.validate.js"></script>
    <script src="/static/js/jqueryVaildate/messages_zh.js"></script>
    <script>
        $.validator.setDefaults({
            submitHandler: function() {
                alert("提交事件!");
            }
        });
        $().ready(function() {
            $("#commentForm").validate();
        });
    </script>
    <style>
        label.error {
            color: red;
            font-weight: 100;
            font-size: 16px;
        }

        label {
            font-weight: 100;
            font-size: 16px;
        }
    </style>

    <title>接待登记管理</title>
</head>
<body>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;"  >
        <!--show-refresh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table" data-toggle="table" data-toolbar="#toolbar"
               data-url="/table/query" data-method="post" data-query-params="queryParams"
               data-pagination="true" data-search="true" data-show-refresh="true"
               data-show-toggle="true" data-show-columns="true" data-page-size="10"
               data-height="543" data-id-field="id" data-page-list="[5, 10, 20]"
               data-cach="false" data-click-to-select="true" data-single-select="true">
            <thead>
                <tr>
                    <th data-radio="true" data-field="status"></th>
                    <%-- 车主信息也从预约记录中获取,如果不是预约的则手动输入 --%>
                    <th data-field="name">车主名字</th>
                    <th data-field="email">车主邮箱</th>
                    <th data-field="plate">车主车牌号</th>
                    <th data-field="phone">车主手机号</th>
                    <th data-field="isClear">是否洗车</th>
                    <th data-field="goods">车内物品</th>
                    <th data-field="currentOil">当前油量</th>
                    <th data-field="color">车颜色</th>
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
<div class="modal fade" id="add" aria-hidden="true" style="overflow:hidden;">
    <div class="modal-dialog" style="overflow:hidden;">
        <div class="modal-content" style="overflow:hidden;">
            <div class="container" style="width: 80%;">
                <form action="/table/edit" onsubmit=" return checkAdd()" id="addForm" method="post">
                    <fieldset>
                        <legend>被接待的车主信息录入</legend>
                        <label for="cname">车主名字</label>
                        <input class="form-control" id="cname" name="name" minlength="2" type="text" required="true">
                        <label for="cemail">车主E-Mail</label>
                        <input class="form-control" id="cemail" type="email" name="email" required>
                        <label for="plateNum">车主车牌号</label>
                        <input class="form-control" id="plateNum" type="byteRangeLength" name="plate">
                        <label for="cphone">手机号</label>
                        <input class="form-control" id="cphone" name="phone" type="phone" required></input>
                    <!-- radio 的 required 表示必须选中一个。 -->
                        <label for="cComment">是否洗车</label><br/>
                        <input type="radio" id="gender_Y" value="Y" name="isClear"/> 是
                        <input type="radio" id="gender_N" value="N" name="isClear" /> 否 <br/>
                        <label for="cComment">当前油量</label>
                        <input class="form-control" id="cComment" name="currentOil" type="isIdCardNo" required></input>
                        <label for="cGoods">车内物品</label>
                        <textarea class="form-control" id="cGoods" name="goods" required></textarea>
                    <%-- 注: 暂时先这么写，颜色是选择不是输入,看到这句说明你要更改这部分 --%>
                        <label for="cGoods">车的颜色</label>
                        <textarea class="form-control" name="color" required></textarea>
                    </fieldset>
                    <div class="modal-footer" style="overflow:hidden;">
                        <span id="addError" style="color: red;"></span>
                        <button type="button" class="btn btn-default" data-dismiss="modal"> 关闭 </button>
                        <button type="button" class="btn btn-primary"> 保存 </button>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 修改弹窗 -->
<div class="modal fade" id="edit" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="container" style="width: 80%;">
                <form action="/table/edit" onsubmit=" return checkAdd()" id="editForm" method="post">
                    <fieldset>
                        <%--<legend>输入您的名字，邮箱，URL，备注。</legend>--%>
                        <p hidden>
                            <label for="cname">id</label>
                            <input name="ceshi.id" minlength="2">
                        </p>
                        <p>
                            <label for="cname">车主名字</label>
                            <input class="form-control" name="ceshi.name" minlength="2" type="text" required="true">
                        </p>
                        <p>
                            <label for="cemail">车主E-Mail</label>
                            <input class="form-control" type="email" name="ceshi.email" required>
                        </p>
                        <p>
                            <label for="plateNum">车主车牌号</label>
                            <input class="form-control" type="byteRangeLength" name="ceshi.plate">
                        </p>
                        <p>
                            <label for="cphone">手机号</label>
                            <input class="form-control" name="ceshi.phone" type="phone" required></input>
                        </p>
                        <p><!-- radio 的 required 表示必须选中一个。 -->
                            <label for="cComment">是否洗车</label><br/>
                            <input type="radio" value="f" name="ceshi.isclear"/> 是
                            <input type="radio" value="m" name="ceshi.isclear" /> 否
                        </p>
                        <p>
                            <label for="cComment">当前油量</label>
                            <input class="form-control" name="ceshi.currentOil" type="isIdCardNo" required></input>
                        </p>
                        <p>
                            <label for="cGoods">车内物品</label>
                            <textarea class="form-control" name="ceshi.goods" required></textarea>
                        </p>
                        <%-- 注: 暂时先这么写，颜色是选择不是输入,看到这句说明你要更改这部分 --%>
                        <p>
                            <label for="cGoods">车的颜色</label>
                            <textarea class="form-control" name="ceshi.color" required></textarea>
                        </p>
                    </fieldset>
                    <div class="modal-footer" style="overflow:hidden;">
                        <button type="button" class="btn btn-default" data-dismiss="modal"> 关闭 </button>
                        <button type="button" class="btn btn-primary"> 保存 </button>
                    </div>
                </form>
            </div>
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

        function showEdit(){
            var row =  $('table').bootstrapTable('getSelections');
            if(row.length >0) {
    //                $('#editId').val(row[0].id);
    //                $('#editName').val(row[0].name);
    //                $('#editPrice').val(row[0].price);
                $("#edit").modal('show'); // 显示弹窗
                var ceshi = row[0];
                $("#editForm").fill(ceshi);
            }else{
                //layer.msg("请先选择某一行", {time : 1500, icon : 2});
                $("#tanchuang").modal('show');
            }
        }

        function showAdd(){
            $("#add").modal('show');
        }

        function formatRepo(repo) {
            return repo.text
        }
        function formatRepoSelection(repo) {
            return repo.text
        }

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
            var name = $('#email').val();
            var price = $('#plate').val();
            var price = $('#phone').val();
            var price = $('#isclear').val();
            var price = $('#currentOil').val();
            var price = $('#goods').val();
            var price = $('#color').val();
//            var reslist=$("#phone").select2("data"); //获取多选的值
            alert(reslist.length)
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

    </script>
</body>
</html>
