<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <meta charset="utf-8">
    <title>人员角色管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/css/bootstrap-table.css">
    <link rel="stylesheet" href="/static/css/select2.min.css">
    <link rel="stylesheet" href="/static/css/sweetalert.css">
    <link rel="stylesheet" href="/static/css/table/table.css">
    <link rel="stylesheet" href="/static/css/systemManage/bootstrap.vertical-tabs.css">
    <link rel="stylesheet" href="/static/css/systemManage/icon.css">
    <link rel="stylesheet" href="/static/css/systemManage/gijgo.css">
    <style>
        .gj-checkbox-md input[type="checkbox"]:checked + span::after {
            top: 0px;
        }
        .gj-checkbox-md input[type="checkbox"]:indeterminate + span::after {
            top:0px;
        }
        h3, h4{
            font-weight: bold;
        }
    </style>
</head>
<body>
<%@include file="../backstage/contextmenu.jsp"%>
<div class="head">
</div>
<div class="container">
    <div class="panel-body" style="padding-bottom:0px;" >
        <div class="col-xs-3">
            <ul class="nav nav-tabs tabs-left" id="bar">
            </ul>
        </div>
        <div class="col-xs-9" style="background: #E5E5E5;border-radius: 5px;">
            <div class="tab-content" id="panel">
                <div class="tab-pane active" id="home">
                    <div class="panel title">
                        <h3></h3><input style="display:none" />
                        <div  style="float: right; ">
                            <button type="button" class="btn btn-default" style="margin-right:5px;" onclick="showAdd()"><span class="glyphicon glyphicon-plus" style="margin-right:5px"></span>添加</button>
                            <button type="button" class="btn btn-default" style="margin-right:5px;" onclick="showEdit()"><span class="glyphicon glyphicon-edit" style="margin-right:5px"></span>修改</button>
                            <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-plus" style="margin-right:5px"></span>回收</button>
                        </div>
                        <p class="clearfix"></p>
                    </div>
                    <div class="panel permissions">
                        <div class="panel-heading">
                            <h4>拥有的权限</h4>
                            <span class="glyphicon glyphicon-edit" style="float:right" onclick="showEditPermission()">修改</span>
                        </div>
                        <div class="panel-body" id="permissionPanel">
                            <div id="dnyTree" ></div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane" id = "recyclebin">
                    <h3>这是回收站</h3>
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
            <form class="form-horizontal" role="form" id="addForm" method="post">
                <input type="reset" name="reset" style="display: none;"/>
                <div class="modal-header" style="overflow:auto;">
                    <p>添加角色</p>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">角色名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="roleName"  class="form-control" maxlength="20">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">角色描述：</label>
                    <div class="col-sm-7">
                        <input type="text" name="roleDes" class="form-control" maxlength="20">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button id="addButton" type="submit" class="btn btn-primary btn-sm">保存</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 修改弹窗 -->
<div class="modal fade" id="edit" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="editForm" class="form-horizontal" method="post">
                <input type="reset" name="reset" style="display: none;"/>
                <div class="modal-header" style="overflow:auto;">
                    <p>修改角色</p>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">角色名称：</label>
                    <div class="col-sm-7">
                        <input type="text" name="roleName" define="emp.name" class="form-control" maxlength="20">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">角色描述：</label>
                    <div class="col-sm-7">
                        <input type="text" name="roleDes" define="emp.name" class="form-control" maxlength="20">
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

<!-- 修改角色权限弹窗 -->
<div class="modal fade" id="editPermission" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
           <div class="panel-heading">
               <h4 style="display: inline-block">修改角色权限</h4>
               <div style="float:right"><span data-dismiss="modal">关闭</span></div>
           </div>
            <div class="panel-body" style="width: 60%;margin-left: auto;margin-right: auto;">
                <div class="col-md-7">
                    <div id = "staTree" ></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default">关闭</button>
                <button  type="submit" class="btn btn-primary btn-sm">保存</button>
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
<script src="/static/js/form/jquery.validate.js"></script>
<script src="/static/js/backstage/systemManage/roleManage.js"></script>
<script src="/static/js/backstage/systemManage/gijgo.js"></script>
</body>

<script>
    var initObj = [];
$(function(){
    var roleId;
    //setModules(modules);
    //setPermission(permissions);
    initAll();
    //testinitModules(modules);
    //testinitRolePermission(rolePermissions);
   // testinitPermission(permissions);

    //setModules(modules);
    //setPermission(permissions);

   // staTree = initStaticTree("#staTree", permissions, modules, rolePermissions);
    //dnyTree =initDynTree("#dnyTree",modules, rolePermissions);
});
    function initAll(){
        initObj.modules =  $.ajax({url:"/module/queryAll",async:false});
        initObj.permissions=  $.ajax({url:"/permission/queryAll",async:false});
        initObj.roles =  $.ajax({url:"/role/queryAll",async:false});
        setTimeout(function(){
            initRoleTabs("#bar", "#home", initObj.roles.responseJSON);  //初始左侧菜单栏
        },300);
        setTimeout(function(){
            initObj.rolePermissions=  $.ajax({url:"/role/permissions/"+initObj.roles.responseJSON[0].roleId ,async:false});
            setPageTitle(initObj.roles.responseJSON[0]);
            var dnyTree = initDnyTree("#dnyTree",initObj.modules.responseJSON, initObj.rolePermissions.responseJSON);//初始了树
            initStaticTree("#staTree", initObj.permissions.responseJSON,initObj.modules.responseJSON, initObj.rolePermissions.responseJSON)
        },500);
    }

    function initRoleTabs(barId, panelId, roles) {
        var tabMsg = {data:roles, barId:barId, panelId:panelId,idCol: "roleId"};
        initTabs(tabMsg);
    }
    function initTabs(tabMsg) {
        var data = tabMsg.data;
        var bar = $(tabMsg.barId);
        var panelId = tabMsg.panelId;
        var idCol = tabMsg.idCol;
        for(var i = 0,len = data.length; i<len; i++ ){
            var oneBar = [];
            var role = data[i];
            if(i===0){
                oneBar.push("<li class='active'>");
                // setId(role.roleId);
            } else {
                oneBar.push("<li>");
            }
            oneBar.push("<a href='"+panelId + "' data-toggle='tab' onclick='resetRoleId(\"" + role.roleId + "\")'>");
            oneBar.push(role.roleName);
            oneBar.push("</a></li>");
            bar.append(oneBar.join(""));
        }
        var recyclebin = '<li><a href="#recyclebin" data-toggle="tab"  onclick="recyclebin()"><span class="glyphicon glyphicon-trash" style="margin-right:6px"></span>回收站</a></li>'
        bar.append(recyclebin);
    }

    function setPageTitle(role){
        var title = $("#home .title:eq(0)")
        title.find("h3").text(role.roleName);
        title.find("input:eq(0)").val(role.roleId);

    }
function recyclebin(){
    $.get("/role/queryRecyclebin",function(data){
        console.log(data);
    });
}

function resetRoleId(roleId){ // 用于点击更换右侧数值的
    setRolePermission(roleId);
    var curObj = initObj;
    var modules = curObj.modules.responseJSON;
    var rolePermissions = curObj.rolePermissions.responseJSON;
    var permissions = curObj.permissions.responseJSON;
    // reloadStatic($("staTree").tree(),permissions, modules, rolePermissions);
    reloadDny(modules, rolePermissions);
}

function reloadStatic(staTree,permissions, modules, rolePermissions){
    var nodeData = bean4StaTreeData(permissions,modules, rolePermissions);
    $("#staTree").tree().render(nodeData);
    $("#staTree").tree().expandAll();		// 展开全部
}
function reloadDny(modules, rolePermissions) {
    var nodeData =  bean4DnyTreeData(modules,rolePermissions);
    $("#dnyTree").tree().render(nodeData);
    $("#dnyTree").tree().expandAll();
}
function setRolePermission(roleId){
        initObj.rolePermissions=  $.ajax({url:"/role/permissions/"+roleId ,async:false});
    }

 function initDnyTree(treeid,modules, rolePermissions){
        var treenodes = bean4DnyTreeData(modules, rolePermissions);
        var dnyTree = $(treeid).tree({
            primaryKey: 'id',
            uiLibrary: 'materialdesign',
            childrenField: 'permissions',
            dataSource: treenodes
        });
        dnyTree.expandAll();
        return dnyTree;
    }
    function initStaticTree(treeid, permissions, modules, rolePermissions) {		//添加了方法
        var treenodes = bean4StaTreeData(permissions,modules, rolePermissions);
        var staTree = $(treeid).tree({
            primaryKey: 'id',
            uiLibrary: 'materialdesign',
            childrenField: 'permissions',
            checkedField: 'checked',
            dataSource: treenodes,
            checkboxes: true
        })
        return staTree;
    }

    function bean4DnyTreeData(modules,rolePermissions){
        var molnodes= [];
        modules = setModulePermissions(rolePermissions, modules);
        for(var i = 0,len = modules.length; i<len; i++ ){
            var module = modules[i];
            var molnode = {};
            var pernodes = [];
            molnode.id = "module-"+module.moduleId;
            molnode.text = module.moduleName;
            for(var j=0,jlen = rolePermissions.length; j<jlen; j++) {
                var permission = rolePermissions[j];
                if(permission.moduleId === module.moduleId) {
                    var pernode ={};
                    pernode.id = "permission-"+permission.permissionId;
                    pernode.text = permission.permissionName;
                    pernodes.push(pernode);
                }
            }
            molnode.permissions = pernodes;
            molnodes.push(molnode);
        }
        return molnodes;
    }
    function bean4StaTreeData(permissions, modules, rolePermissions){
        var molnodes = [];
        modules = setModulePermissions(permissions, modules);
        for(var i = 0,len = modules.length; i<len; i++){
            var pernodes = [];
            var module = modules[i];
            var molnode = {};
            molnode.id = "module-" + module.moduleId;
            molnode.text = module.moduleName;
            for(var j = 0,jlen=permissions.length; j<jlen; j++){
                var pernode = {};
                var permission = permissions[j];
                pernode.id = "permission-"+permission.permissionId;
                pernode.text=permission.permissionName;
                if(permission.moduleId === module.moduleId){
                    for(var k = 0,klen=rolePermissions.length; k<klen; k++) {
                        if(rolePermissions[k].permissionId === permission.permissionId){
                            pernode.checked = true;
                            break;
                        }else {
                            pernode.checked = false;
                        }
                    }
                    pernodes.push(pernode);
                }
            }
            molnode.permissions =pernodes;
            molnodes.push(molnode);
        }
        return molnodes;
    }

    function setModulePermissions(permissions, modules){
        for(var m = 0,mLen = modules.length; m<mLen; m++) {
            var module = modules[m]
            var mPers = [];
            for(var p=0,pLen = permissions.length; p<pLen; p++){
                var permission = permissions[p]
                var pmId = permission.moduleId;
                if(pmId === module.moduleId){
                    mPers.push(permission);
                }
            }
            module.permission = mPers;
        }
        return modules;
    }

    function showEditPermission(){
        var curObj = initObj;
        reloadStatic($("staTree").tree(),curObj.permissions.responseJSON, curObj.modules.responseJSON, curObj.rolePermissions.responseJSON);
        $("#editPermission").modal("show");

    }



</script>
</html>
