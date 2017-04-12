<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017-04-11
  Time: 15:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/static/css/bootstrap.min.css">
        <script src="/static/js/jquery.min.js"></script>
        <script src="/static/js/bootstrap.min.js"></script>

        <title>财务统计</title>
</head>
<body >
    <div class="head">

    </div>
    <div class="container ">
        <div class="module1" >
            <h3>标题1</h3>
            <div class="echarImg clearfix" style="height:400px">
                <div class="col-md-8" style="background-color: #1eacae; height:400px" ></div>
                <div class="col-md-4" style="background-color: tan; height:400px"></div>
            </div>
            <h3>标题2</h3>
            <div class="financeTable clearfix" style="margin-top: 10px">
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
                           data-height="543"
                           data-id-field="id"
                           data-page-list="[5, 10, 20]"
                           data-cach="false"
                           data-click-to-select="true"
                           data-single-select="true">
                        <thead>
                        <tr>
                            <th data-radio="true" data-field="status"></th>
                            <th  data-field="name">财务列1</th>
                            <th data-field="price">财务列2</th>
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
        </div>

    </div>
</body>
<script>
    $("#table").bootstrapTable();
</script>
</html>
