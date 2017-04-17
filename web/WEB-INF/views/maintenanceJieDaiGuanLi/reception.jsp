<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">

    <title>接待登记管理</title>
</head>
<body>

<%@include file="../backstage/contextmenu.jsp"%>

<div class="container">
    <div class="panel-body" style="padding-bottom:0px;"  >
        <!--show-refredata-single-sesh, show-toggle的样式可以在bootstrap-table.js的948行修改-->
        <!-- table里的所有属性在bootstrap-table.js的240行-->
        <table id="table" data-toggle="table" data-toolbar="#toolbar"
               data-url="/table/query" data-method="post" data-query-params="queryParams"
               data-pagination="true" data-search="true" data-show-refresh="true"
               data-show-toggle="true" data-show-columns="true" data-page-size="10"
               data-height="543" data-id-field="id" data-page-list="[5, 10, 20]"
               data-cach="false" data-click-to-select="true" lect="true">
            <thead>
                <tr>
                    <th data-radio="true" data-field="status"></th>
                    <%-- 车主信息也从预约记录中获取,如果不是预约的则手动输入 --%>
                    <%-- 这个可能是判断车主用户是否有注册的，自己改 --%>
                    <th data-field="userName">接待员</th>      <%-- 当t_user为空,表示非注册车主登记 --%>
                    <th data-field="appointment">预约号</th>   <%-- t_appointment,可为空,当为空时说明没有预约过 --%>
                    <th data-field="name">车主名字</th>
                    <th data-field="email">车主邮箱</th>
                    <th data-field="phone">车主手机号</th>
                    <th data-field="brand">品牌</th>
                    <th data-field="color">车颜色</th>
                    <th data-field="mode">车型</th>
                    <th data-field="carPlate">车主车牌号</th>
                    <th data-field="arriverTime">到店时间</th>
                    <th data-field="mileage">汽车行驶里程</th>
                    <th data-field="carThings">车内物品</th>
                    <th data-field="intactDegrees">车身完好度</th>
                    <th data-field="userRequests">用户要求描述</th>
                    <th data-field="maintainOrFix">保养还是维修</th>
                    <th data-field="checkinCreatedTime">登记创建时间</th>  <%-- 由系统创建 --%>
                    <th data-field="company">汽修公司名称</th>    <%-- t_company --%>
                    <th data-field="checkStatus">状态</th>
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
<div class="modal fade" id="addWindow" aria-hidden="true" style="overflow:auto;">
    <div class="modal-dialog" style="overflow:auto;">
        <div class="modal-content" style="overflow:hidden;">
            <div class="container" style="width: 80%;">
                <form class="form-horizontal" onsubmit="return checkAdd()" id="addForm" method="post">
                    <div class="modal-header" style="align-content: center;overflow:auto;">
                        <h4>被接待的车主信息录入</h4>
                    </div><hr/>
                    <br/>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">车主名字：</label>
                        <div class="col-sm-7">
                            <input type="text" placeholder="请输入车主姓名" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">车主E-Mail</label>
                        <div class="col-sm-7">
                            <input type="email" placeholder="请输入车主E-Mail" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">车主车牌号</label>
                        <div class="col-sm-7">
                            <input type="number" placeholder="请输入车主车牌号" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">车主手机号</label>
                        <div class="col-sm-7">
                            <input type="number" placeholder="请输入车主手机号" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">车的品牌：</label>
                        <div class="col-sm-7">
                            <select>
                                <option>请选择品牌</option>
                                <option>品牌一</option>
                                <option>品牌二</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">车的颜色：</label>
                        <div class="col-sm-7">
                            <input type="text" placeholder="请输入车的颜色" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">车型：</label>
                        <div class="col-sm-7">
                            <input type="text" placeholder="请输入车型" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">车主到店时间：</label>
                        <div class="col-sm-7">
                            <input type="datetime" placeholder="2017/04/12 20:31" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">汽车行驶里程：</label>
                        <div class="col-sm-7">
                            <input type="text" placeholder="请输入汽车行驶里程" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">车身完好度：</label>
                        <div class="col-sm-7">
                            <input type="text" placeholder="请输入车身完好度" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">汽修公司名称：</label>
                        <div class="col-sm-7">
                            <input type="text" placeholder="请输入汽修公司名称" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">当前油量</label>
                        <div class="col-sm-7">
                            <input type="number" placeholder="请输入车主当前油量" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">车内物品：</label>
                        <div class="col-sm-7">
                            <textarea type="text" placeholder="请输入车内物品" style="height: 50px;"
                                      class="form-control"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">用户要求描述：</label>
                        <div class="col-sm-7">
                            <textarea type="text" placeholder="请输入用户要求描述" style="height: 50px;"
                                      class="form-control"></textarea>
                        </div>
                    </div>
                    <%-- 注: 暂时先这么写，颜色是选择不是输入,看到这句说明你要更改这部分 --%>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">车的颜色：</label>
                        <div class="col-sm-7">
                        <textarea type="text" placeholder="请输入车的颜色" style="height: 50px;"
                                  class="form-control"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-8">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            <button class="btn btn-sm btn-success" type="submit">保 存</button>
                        </div>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 修改弹窗 -->
<div class="modal fade" id="editWindow" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <form class="form-horizontal" id="editForm" method="post" onclick="return checkEdit('table/edit');">
                <div class="modal-header" style="overflow:auto;">
                    <h4>被接待的车主信息修改</h4>
                </div>
                <br/>
                <div class="form-group">
                    <label class="col-sm-5 control-label">车主名字：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请输入车主姓名" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 control-label">车主E-Mail</label>
                    <div class="col-sm-7">
                        <input type="email" placeholder="请输入车主E-Mail" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 control-label">车主车牌号</label>
                    <div class="col-sm-7">
                        <input type="number" placeholder="请输入车主车牌号" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 control-label">车主手机号</label>
                    <div class="col-sm-7">
                        <input type="number" placeholder="请输入车主手机号" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 control-label">车的品牌：</label>
                    <div class="col-sm-7">
                        <select>
                            <option>请选择品牌</option>
                            <option>品牌一</option>
                            <option>品牌二</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 control-label">车的颜色：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请输入车的颜色" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 control-label">车型：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请输入车型" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 control-label">车主到店时间：</label>
                    <div class="col-sm-7">
                        <input type="datetime" placeholder="2017/04/12 20:31" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 control-label">汽车行驶里程：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请输入汽车行驶里程" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 control-label">车身完好度：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请输入车身完好度" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-5 control-label">汽修公司名称：</label>
                    <div class="col-sm-7">
                        <input type="text" placeholder="请输入汽修公司名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">当前油量</label>
                    <div class="col-sm-7">
                        <input type="number" placeholder="请输入车主当前油量" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">车内物品：</label>
                    <div class="col-sm-7">
                            <textarea type="text" placeholder="请输入车内物品" style="height: 50px;"
                                      class="form-control"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">用户要求描述：</label>
                    <div class="col-sm-7">
                            <textarea type="text" placeholder="请输入用户要求描述" style="height: 50px;"
                                      class="form-control"></textarea>
                    </div>
                </div>
                <%-- 注: 暂时先这么写，颜色是选择不是输入,看到这句说明你要更改这部分 --%>
                <div class="form-group">
                    <label class="col-sm-3 control-label">车的颜色：</label>
                    <div class="col-sm-7">
                        <textarea type="text" placeholder="请输入车的颜色" style="height: 50px;"
                                  class="form-control"></textarea>
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
                    <button type="sumbit" class="btn btn-primary" onclick="showDel()">
                        确认
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </form>
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
    <script src="/static/js/maintenanceJieDaiGuanLi/reception.js"></script>
    <script src="/static/js/bootstrap-select/bootstrap-select.js"></script>

</body>
</html>
