<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <meta charset="utf-8">
    <title>模块管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/css/systemManage/distribution.css">

    <style type="text/css">

        .cf:after { visibility: hidden; display: block; font-size: 0; content: " "; clear: both; height: 0; }
        * html .cf { zoom: 1; }
        *:first-child+html .cf { zoom: 1; }

        html { margin: 0; padding: 0; }
        body { font-size: 100%; margin: 0; padding: 1.75em; font-family: 'Helvetica Neue', Arial, sans-serif; }

        h1 { font-size: 1.75em; margin: 0 0 0.6em 0; }

        a { color: #2996cc; }
        a:hover { text-decoration: none; }

        p { line-height: 1.5em; }
        .small { color: #666; font-size: 0.875em; }
        .large { font-size: 1.25em; }

        /**
         * Nestable
         */

        .dd { position: relative; display: block; margin: 0; padding: 0; max-width: 600px; list-style: none; font-size: 13px; line-height: 20px; }

        .dd-list { display: block; position: relative; margin: 0; padding: 0; list-style: none; }
        .dd-list .dd-list { padding-left: 30px; }
        .dd-collapsed .dd-list { display: none; }

        .dd-item,
        .dd-empty,
        .dd-placeholder { display: block; position: relative; margin: 0; padding: 0; min-height: 20px; font-size: 13px; line-height: 20px; }

        .dd-handle { display: block; height: 30px; margin: 5px 0; padding: 5px 10px;  text-decoration: none; font-weight: bold; border: 1px solid #ccc;
            background: #fafafa;
            -webkit-border-radius: 3px;
            border-radius: 3px;
            box-sizing: border-box; -moz-box-sizing: border-box;
        }
        .dd-handle:hover { color: #2ea8e5; background: #fff; }

        .dd-item > button { display: block; position: relative; cursor: pointer; float: left; width: 25px; height: 20px; margin: 5px 0; padding: 0; text-indent: 100%; white-space: nowrap; overflow: hidden; border: 0; background: transparent; font-size: 12px; line-height: 1; text-align: center; font-weight: bold; }
        .dd-item > button:before { content: '+'; display: block; position: absolute; width: 100%; text-align: center; text-indent: 0; }
        .dd-item > button[data-action="collapse"]:before { content: '-'; }

        .dd-placeholder,
        .dd-empty { margin: 5px 0; padding: 0; min-height: 30px; background: #f2fbff; border: 1px dashed #b6bcbf; box-sizing: border-box; -moz-box-sizing: border-box; }
        .dd-empty { border: 1px dashed #bbb; min-height: 100px; background-color: #e5e5e5;
            background-image: -webkit-linear-gradient(45deg, #fff 25%, transparent 25%, transparent 75%, #fff 75%, #fff),
            -webkit-linear-gradient(45deg, #fff 25%, transparent 25%, transparent 75%, #fff 75%, #fff);
            background-image:    -moz-linear-gradient(45deg, #fff 25%, transparent 25%, transparent 75%, #fff 75%, #fff),
            -moz-linear-gradient(45deg, #fff 25%, transparent 25%, transparent 75%, #fff 75%, #fff);
            background-image:         linear-gradient(45deg, #fff 25%, transparent 25%, transparent 75%, #fff 75%, #fff),
            linear-gradient(45deg, #fff 25%, transparent 25%, transparent 75%, #fff 75%, #fff);
            background-size: 60px 60px;
            background-position: 0 0, 30px 30px;
        }

        .dd-dragel { position: absolute; pointer-events: none; z-index: 9999; }
        .dd-dragel > .dd-item .dd-handle { margin-top: 0; }
        .dd-dragel .dd-handle {
            -webkit-box-shadow: 2px 4px 6px 0 rgba(0,0,0,.1);
            box-shadow: 2px 4px 6px 0 rgba(0,0,0,.1);
        }

        /**
         * Nestable Extras
         */

        .nestable-lists { display: block; clear: both; padding: 30px 0; width: 100%; border: 0; border-top: 2px solid #ddd; border-bottom: 2px solid #ddd; }

        #nestable-menu { padding: 0; margin: 20px 0; }

        #nestable-output,
        #nestable2-output { width: 100%; height: 7em; font-size: 0.75em; line-height: 1.333333em; font-family: Consolas, monospace; padding: 5px; box-sizing: border-box; -moz-box-sizing: border-box; }

        #nestable2 .dd-handle {
            color: #fff;
            border: 1px solid #999;
            background: #bbb;
            background: -webkit-linear-gradient(top, #bbb 0%, #999 100%);
            background:    -moz-linear-gradient(top, #bbb 0%, #999 100%);
            background:         linear-gradient(top, #bbb 0%, #999 100%);
        }
        #nestable2 .dd-handle:hover { background: #bbb; }
        #nestable2 .dd-item > button:before { color: #fff; }

        @media only screen and (min-width: 700px) {

            .dd { float: left; width: 48%; }
            .dd + .dd { margin-left: 2%; }

        }

        .dd-hover > .dd-handle { background: #2ea8e5 !important; }

        /**
         * Nestable Draggable Handles
         */

        .dd3-content { display: block; height: 30px; margin: 5px 0; padding: 5px 10px 5px 40px; color: #333; text-decoration: none; font-weight: bold; border: 1px solid #ccc;
            background: #fafafa;
            -webkit-border-radius: 3px;
            border-radius: 3px;
            box-sizing: border-box; -moz-box-sizing: border-box;
        }
        .dd3-content:hover { color: #2ea8e5; background: #fff; }

        .dd-dragel > .dd3-item > .dd3-content { margin: 0; }

        .dd3-item > button { margin-left: 30px; }

        .dd3-handle { position: absolute; margin: 0; left: 0; top: 0; cursor: pointer; width: 30px; text-indent: 100%; white-space: nowrap; overflow: hidden;
            border: 1px solid #aaa;
            background: #ddd;
            background: -webkit-linear-gradient(top, #ddd 0%, #bbb 100%);
            background:    -moz-linear-gradient(top, #ddd 0%, #bbb 100%);
            background:         linear-gradient(top, #ddd 0%, #bbb 100%);
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
        }
        .dd3-handle:before { content: '≡'; display: block; position: absolute; left: 0; top: 3px; width: 100%; text-align: center; text-indent: 0; color: #fff; font-size: 20px; font-weight: normal; }
        .dd3-handle:hover { background: #ddd; }

        .dd-item  span{
            position:relative;
            float:right;
            margin-right:15px;
            top:10px;

        }

        #notInModulePers {
            color:#d58512;
        }
        #notInModulePers .dd-handle:hover {
            color: #d43f3a;
        }
        #modules {
            color:#5cb85c;
        }
        #modules .dd-handle:hover {
            color: #24a528;
        }
    </style>

</head>


<body>
<%@include file="../backstage/contextmenu.jsp"%>

<div class="container">
    <div class="head">
        <div>
            <h3>模块管理</h3>
        </div>
        <div style="float:right;position:relative; right:15px;">
            <button id="btn_add" type="button" class="btn btn-default" onclick="showAdd();">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
            </button>
        </div>
    </div>
    <div class="panel-body" style="padding-bottom:0px;"  >
        <div class="cf nestable-lists" >
            <div style="width:70%;"  class="pull-left" >
                <h4>已有模块</h4>
                <div id="modules" class="dd"  style="width:70%" >
                    <ul class="dd-list">
                    </ul>
                </div>
            </div>
            <div style="width:25%;" class="pull-right">
                <h4>孤立的权限</h4>
                <div id="notInModulePers" class="dd"  style="width:70%">
                    <ul class="dd-list">
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 添加弹窗 -->
<div class="modal fade" id="add" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <hr/>
            <form id="addForm" class="form-horizontal" method="post">
                <input type="reset" name="reset" style="display: none;"/>
                <div class="modal-header" style="overflow:auto;">
                    <p>修改模块</p>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">模块名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="moduleName" define="emp.name" class="form-control" maxlength="20">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">模块描述：</label>
                    <div class="col-sm-7">
                        <input type="text" name="moduleDes" define="emp.name" class="form-control" maxlength="500">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button id="addButton" type="submit" class="btn btn-primary btn-sm" onsubmit="return perSubmit()">保存</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<!-- 修改弹窗 -->
<div class="modal fade" id="edit" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <hr/>
            <form id="editForm" class="form-horizontal" method="post">
                <div class="modal-header" style="overflow:auto;">
                    <p>修改模块</p>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">模块名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="moduleName" define="module.moduleName" class="form-control" maxlength="20">
                        <input type="text" name="moduleId" define="module.moduleId"  class="form-control" maxlength="20" style="display:none">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">模块描述：</label>
                    <div class="col-sm-7">
                        <input type="text" name="moduleDes" define="module.moduleDes" class="form-control" maxlength="500">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button id="editButton" type="submit" class="btn btn-primary btn-sm">保存</button>
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
<script src="/static/js/form/jquery.validate.js"></script>
<script src="/static/js/systemManage/jquery.nestable.js"></script>
<script src="/static/js/backstage/systemManage/moduleManage.js"></script>
</body>
<script>
        var tempNetsModuleAndPer = [];
        var netsModuleAndPer ;
        var moduleSou = [];
        var perSou = [];
    $(function(){
        $("#modules").nestable({
            listNodeName: "ul",
            maxDepth:1
        }).on('change', function() {
            //console.log("modules")
            var ul=  $("#modules").children("ul");
            var currParent = $(netsModuleAndPer).parent();
            var bool = isEq(ul, currParent);
            var mou ;
            var per;
            if(bool){
               $(netsModuleAndPer).appendTo(  $("#notInModulePers"));
                mouid = "not has";
            }else {
                mou = currParent.parent();
            }
            if(!isModule($(netsModuleAndPer))){
                per = $(netsModuleAndPer);
            }else {
                per = "not has per";
            }
            setServerPerModule(mou,per); //更换后立即向服务器传数据更新数据库


        });
        $("#notInModulePers").nestable({
            listNodeName: "ul",
            maxDepth:2
        }).on('change', function() {
            //console.log("notInModulePers")
            var ul=  $("#modules").children("ul");
            var curnets =  $(netsModuleAndPer);
            var childrens = $(ul).children();
            childrens.each(function(index, value){
                var bool = isEq($(value), curnets);
                if(bool){
                    curnets.appendTo(  $("#notInModulePers"));
                }
            });
        });

        queryAll();

        $("#modules .dd-item").on("mousedown",function(event){
            var bool = isModule(this);
            tempNetsModuleAndPer.push(this);
            var len = tempNetsModuleAndPer.length;
            if(isModule(this)){
                if(len != 0 ) {
                    netsModuleAndPer = tempNetsModuleAndPer[0];
                }
                tempNetsModuleAndPer = [];
            }
        });

        $("#notInModulePers .dd-item").on("mousedown", function(event) {
            tempNetsModuleAndPer = [];
            tempNetsModuleAndPer.push(this);
            netsModuleAndPer = tempNetsModuleAndPer[0];
        })
    });

    function queryAll(){
        $.get("/module/queryAll",function(moduleData) {
            $.get("/permission/queryAll",function(permissionData){
                var mlen = moduleData.length;
                var tempModule = [];
                for(var m = 0; m<mlen; m++) {
                    var mdl = moduleData[m];
                    var permissions = [];
                    //console.log(mdl);
                    if(mdl.moduleStatus == 'Y') {
                        tempModule.push(mdl);
                        mdl.permissions = setPermissions(permissions, permissionData, mdl.moduleId);
                    }
                }

                var notInModulePers =  getNotInModulePers(permissionData, "moduleId");
                var moduleMsg = {data:tempModule,id:"moduleId", name: "moduleName"};
                var perMsg = {id:"permissionId", name:"permissionName", colName: "permissions"};
                var otherPersMsg = {data:notInModulePers, id:"permissionId", name:"permissionName"};
                addNestableList(moduleMsg,otherPersMsg, perMsg);
                perSou = permissionData;
            })
            moduleSou = moduleData;
        })
    }

    function setPermissions(arr,permissionData,checkId){
        var plen = permissionData.length;
        for(var p = 0; p<plen; p++){
            var per = permissionData[p];
            if(per!=null){
                if(per.permissionStatus === 'Y'){
                    if(per.moduleId === checkId) {
                        arr.push(per);
                        per = null;
                    }
                }
            }
        }
        return arr;
    }

    function addNestableList(moduleMsg,otherMsg, childMsg) {
        var data = moduleMsg.data;
        var dataLen = data.length;
        var childCol = childMsg.colName;

        for(var i = 0; i<dataLen; i++) {
            var module = data[i];
            var childs = module[childCol];
            var moduleHtml = "<li  class='dd-item' data-id='" +module[moduleMsg.id] +"'>" +
                    "<span class='glyphicon glyphicon-trash' ></span>"+
                    "<span class='glyphicon glyphicon-edit'onclick ='showEdit(this)'></span>"+
                    "<div class='dd-handle'>" + module[moduleMsg.name] +"</div>";
            moduleHtml += "<ul class='dd-list'>"
            if(childs !== null &&  childs.length >0){
                var childHtml = getChildListHTML(childs,childMsg )
                moduleHtml += childHtml;
            }
            moduleHtml +="</ul></li>";
            $("#modules>ul").append(moduleHtml);
        }
        getNotInModulePerList(otherMsg.data,{id:otherMsg.id,name:otherMsg.name});
    }

    function getNotInModulePerList(pers, perIdName){
        var lisHtml = "";
        $.each(pers, function(index,value){
            lisHtml +="<li class='dd-item' data-id='"+ value[perIdName.id] +"'><div class='dd-handle'>"+ value[perIdName.name] +"</div></li>";
        });
        $("#notInModulePers>ul").append(lisHtml);
    }

    function getNotInModulePers(pers, molCol){
            var len = pers.length;
            var notInpers = [];
            for(var i = 0; i< len; i++) {
                if(!pers[i][molCol]){
                    notInpers.push(pers[i]);
                }
            }
            return notInpers;
        }

    function getChildListHTML(childs,childIdName){
            var lis = "";
            var len = childs.length;
            for(var i = 0; i<len; i++) {
                var child = childs[i];
                lis+="<li class='dd-item' data-id='"+ child[childIdName.id] +"'>" +
                        "<div class='dd-handle' >"+ child[childIdName.name] +"</div></li>";
            }
            return lis;
        }

    function isModule(el){
        var obj = $(el).find("ul");
        return obj.length !== 0;
    }

    function isEq(el1, el2){
        return el1.html() === el2.html();
    }

    function perSubmit(){
        $("#modules>ul").nestable();
    }

    function setServerPerModule(mod, per){
        console.log("moduleId: " + mod+ "   perId: " + per)
        // mod is null ,clear
        // per is null ,dont server
    }

    function showEdit(el){
        var moduleEl = $(el).parent();
        var moduleId = moduleEl.attr("data-id")
        var module;
        moduleSou.forEach(function(value, idx, array){
            if(moduleId == value.moduleId) {
                module = value;
                return false;
            }
        });
        $("#editForm").fill(module);
        $("#edit").modal('show');
    }

</script>
</html>
