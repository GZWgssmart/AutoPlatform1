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
    <link rel="stylesheet" href="/static/css/bootstrap-validate/bootstrapValidator.min.css">
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
        li[data-id|=module]>div[data-role="wrapper"]{
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
        <div class="col-xs-9" >
            <div class="tab-content" id="panel">
                <div class="tab-pane active" id="home">
                    <div class="panel title" style="margin-bottom:1px">
                        <h3 class="col-md-4"></h3>
                        <div class="col-md-8" >
                            <div style="float: right;">
                                <button type="button" class="btn btn-default" style="margin-right:5px;" onclick="showEdit()"><span class="glyphicon glyphicon-edit" style="margin-right:5px"></span>修改</button>
                                <button type="button" class="btn btn-default" style="margin-right:5px;" onclick="showAdd()"><span class="glyphicon glyphicon-plus" style="margin-right:5px"></span>添加</button>
                                <button type="button" class="btn btn-default" onclick="showDel()"><span class="	glyphicon glyphicon-minus" style="margin-right:5px"></span>回收</button>
                            </div>
                        </div>
                        <p class="clearfix"></p>
                    </div>
                    <hr />
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
                    <div class="panel" style="margin-bottom:1px;">
                        <h3>这是回收站</h3>
                    </div>
                    <div class="panel" style="margin-bottom:1px">
                        <table class="table table-hover" id="recycleTable">
                            <thead>
                            <tr>
                                <th data-checkbox="true"></th>
                                <th data-field="roleName">
                                    角色名称
                                </th>
                                <th data-field="roleDes">
                                    角色简介
                                </th>
                                <th data-field="todoCell" data-formatter="todoCell">
                                    操作
                                </th>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 添加弹窗 -->
<div class="modal fade" id="addModal" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">

            <form class="form-horizontal" role="form" id="addForm" >
                <input type="reset" name="reset" style="display: none;"/>
                <div class="modal-header" style="overflow:auto;">
                    <h3></h3><input style="display: none;">
                </div>
                <hr/>
                <input define="role.roleId" type="text" name="roleId" style="width:100%;display: none" />
                <div class="form-group">
                    <label class="col-sm-3 control-label">角色名称：</label>
                    <div class="col-sm-7">
                        <input type="text" define="role.roleName" data-field="roleName" name="roleName" placeholder="请输入角色名称"  class="form-control" style="width:100%"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">角色描述：</label>
                    <div class="col-sm-7">
                        <textarea type="textarea"  name="roleDes" define="role.roleDes" data-field="roleDes" class="form-control"  placeholder="请输入角色描述"
                                  rows="3" maxlength="500"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">关闭
                    </button>
                    <button id="addButton" type="button" class="btn btn-primary btn-sm" onclick="addSubmit()" >保存</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->



<script src="/static/js/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table.js"></script>
<script src="/static/js/bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script src="/static/js/bootstrap-validate/bootstrapValidator.js"></script>
<script src="/static/js/jquery.formFill.js"></script>
<script src="/static/js/select2/select2.js"></script>
<script src="/static/js/backstage/main.js"></script>
<script src="/static/js/sweetalert/sweetalert.min.js"></script>
<script src="/static/js/contextmenu.js"></script>
<script src="/static/js/backstage/systemManage/gijgo.js"></script>

<%--<script src="/static/js/backstage/systemManage/roleManage.js"></script>--%>
</body>

<script>
    var initObj = {};
    var trees = {};
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
    function resetModules() {
        initObj.modules =  $.ajax({url:"/module/queryAll",async:false});
    }
    function resetRole(){
        initObj.roles  = $.ajax({url:"/role/queryAll",async:false});
    }
    function resetPermissions(){
        initObj.permissions = $.ajax({url:"/permission/noStatusQueryAll",async:false});
    }
    function initAll(){
        resetModules();
        resetPermissions();
        resetRole();

        setTimeout(function(){
            initRoleTabs();  //初始左侧菜单栏
        },300);
        setTimeout(function(){
            initObj.rolePermissions=  $.ajax({url:"/role/permissions/"+initObj.roles.responseJSON[0].roleId ,async:false});
            initObj.role = initObj.roles.responseJSON[0];
            setPageTitle();
            var dnyTree = initDnyTree("#dnyTree",initObj.modules.responseJSON, initObj.rolePermissions.responseJSON);//初始了树
            trees.staTree = initStaticTree("#staTree", initObj.permissions.responseJSON,initObj.modules.responseJSON, initObj.rolePermissions.responseJSON)
        },500);
    }

    function initRoleTabs() {
        var tabMsg = {data: initObj.roles.responseJSON, barId:"#bar", panelId: "#home",idCol: "roleId"};
        initTabs(tabMsg);
    }
    function initTabs(tabMsg) {
        $(tabMsg.barId).empty();
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
            oneBar.push("<a href='"+panelId + "' data-toggle='tab' data-id =" +role.roleId +"  onclick='resetRoleId(this)'>");
            oneBar.push(role.roleName);
            oneBar.push("</a></li>");
            bar.append(oneBar.join(""));
        }
        var recyclebin = '<li><a href="#recyclebin" data-toggle="tab"  onclick="recyclebin()"><span class="glyphicon glyphicon-trash" style="margin-right:6px"></span>回收站</a></li>'
        bar.append(recyclebin);
    }

 function setPageTitle(){
     var role = initObj.role;
     var title = $("#home .title:eq(0)")
     var roleNameNode = "<span>" + role.roleName + "</span>";
     var roleDesNode = "<small style='font-size:9px;color:#999; margin-left:10px;'>"+ role.roleDes +"</small>"
      title.find("h3").html(roleNameNode+ roleDesNode);
        title.find("input:eq(0)").val(role.roleId);
    }
    function setNavName () {
        var role = initObj.role;
        var navul = $("#bar");
        var navlia = navul.find("a[data-id=" + role.roleId + "]");
        $(navlia).text(role.roleName);
    }

function resetRoleId(thisEl){ // 用于点击更换右侧数值的
    var roleId = $(thisEl).attr("data-id");
    setRolePermission(roleId);
    var curObj = initObj;
    var modules = curObj.modules.responseJSON;
    var rolePermissions = curObj.rolePermissions.responseJSON;
    var permissions = curObj.permissions.responseJSON;
    setRole(roleId);
    setPageTitle();
    reloadDny(modules, rolePermissions);
    $("#roleId").val(roleId);
}

function setRole(roleId){
    var roles = initObj.roles.responseJSON;
    var len = roles.length;
    for(var i = 0; i<len; i++) {
        var role = roles[i];
        if(role.roleId ===roleId){
            initObj.role = role;
            return;
        }
    }
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
        var otherMolnode = {};
        var otherPernodes = [];
        otherMolnode.id = "module-";
        otherMolnode.text ="其它";
        for(var i =0,len =rolePermissions.length; i<len; i++ ){
            var permission = rolePermissions[i];
            if(permission.moduleId === "" || permission.moduleId === null) {
                var pernode ={};
                pernode.id = "permission-"+permission.permissionId;
                pernode.text = permission.permissionName;
                otherPernodes.push(pernode);
            }
        }
        otherMolnode.permissions = otherPernodes;
        molnodes.push(otherMolnode);
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
                if(permission.permissionStatus==='Y'){
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
            }
            molnode.permissions =pernodes;
            molnodes.push(molnode);
        }
        var otherMolnode = getModuleByAlonePers(permissions,rolePermissions);
        molnodes.push(otherMolnode);
        return molnodes;
    }
    function getModuleByAlonePers(permissions, rolePermissions){
        var molnode = {};
        var pernodes = [];
        molnode.id = "module-";
        molnode.text = "其它";
        for(var i =0,len = permissions.length; i<len; i++) {
            var permission = permissions[i];
           if(permission.permissionStatus==='Y' && (permission.moduleId === "" || permission.moduleId === null)) {
               var pernode = {};
               pernode.id = "permission-"+permission.permissionId;
               pernode.text=permission.permissionName;
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
        return molnode;
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
        reloadStatic($("#staTree").tree(),curObj.permissions.responseJSON, curObj.modules.responseJSON, curObj.rolePermissions.responseJSON);
        $("#editPermission").modal("show");
    }

    /**
     *  添加 相关
     * */
    function showAdd(){
        $("input[type=reset]").trigger("click");
        $("#addButton").removeAttr("disabled");
        $("#addModal").modal('show');
        validator('addForm');
        $("#addModal .modal-header> h3").text("添加角色");
        $("#addModal .modal-header> input").val("addForm");
    }
    function showEdit(){
        $("input[type=reset]").trigger("click");
        $("#addButton").removeAttr("disabled");
        $("#addModal").modal('show');
        validator('addForm');
        $("#addModal .modal-header> h3").text("修改角色");
        $("#addModal .modal-header> input").val("editForm");
        var role = initObj.role;
        $("#addForm").fill(role);
    }
    function addSubmit() {
        $("#addForm").data('bootstrapValidator').validate();
        if ($("#addForm").data('bootstrapValidator').isValid()) {
            $("#addButton").attr("disabled","disabled");
        } else {
            $("#addButton").removeAttr("disabled");
        }
    }
    function validator(formId) {
        $('#' + formId).bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                roleDes: {
                    message: '角色简介验证失败',
                    validators: {
                        notEmpty: {
                            message: '角色简介不能为空'
                        },
                        stringLength: {
                            min: 1,
                            max: 100,
                            message: "角色简介长度必须在1至100个字符之间"
                        }
                    }
                },
                roleName: {
                    message: '角色名称验证失败',
                    validators: {
                        notEmpty: {
                            message: '角色名称不能为空'
                        },
                        stringLength: {
                            min: 1,
                            max: 20,
                            message: '角色名称必须为11位'
                        },
                        regexp: {
                            regexp: /^[^$&,""''\s]+$/,
                            message: '名称不允许存在符号'
                        }
                    }
                }
            }
        }) .on('success.form.bv', function (e) {
                    var title =$("#addModal .modal-header> input").val();
                    if(title === "addForm") {
                        formSubmit("/role/insert", "addModal",formId, title);
                    }else if (title === "editForm"){
                        formSubmit("/role/edit", "addModal",formId, title);
                    }
                })
    }

    function formSubmit(url, modalId ,formId, flag) {
        $.post(url,
                $("#" + formId).serialize(),
                function(data) {
                    if (data.result == "success") {
                        swal({
                            title:"",
                            text: data.message,
                            confirmButtonText:"确定", // 提示按钮上的文本
                            type:"success"});// 提示窗口, 修改成功
                        if(flag === "addForm") {
                            resetRole();
                            initRoleTabs();
                        } else {
                            // todo updateTitle();
                            console.log("修改成功")
                            var roleNameEl = $("#"+formId).find("input[name=roleName]")[0];
                            var roleIdEl = $("#"+formId).find("input[name=roleId]")[0];
                            var roleDesEl = $("#" + formId).find("textarea")[0];
                            var role = {}
                            role.roleId = $(roleIdEl).val();
                            role.roleName = $(roleNameEl).val();
                            role.roleDes = $(roleDesEl).val();
                            console.log(role);
                            updateRole(role);
                            setPageTitle();
                            setNavName();
                        }
                        formModalclose(modalId,formId);
                    } else if (data.result == "fail") {
                        swal({title:"",
                            text:data.message,
                            confirmButtonText:"确认",
                            type:"error"});
                        $("#"+formId).removeAttr("disabled");
                    }
                }, "json"
        )

    }

function formModalclose(modalId,formId ) {

    $("#"+modalId).modal('hide');
    $("#" + formId).data('bootstrapValidator').resetForm(true);
    $("#" + formId).data('bootstrapValidator').destroy(); // 销毁此form表单
    $('#' + formId).data('bootstrapValidator', null);// 此form表单设置为空
}
    /**
     * 修改相关
     */
    function savePermission(){
        var addAndRemoveIds = getAddedAndRemovePermissionIds();
        var roleId = initObj.role.roleId;
        var seachText = "roleId="+ roleId+"&added="+addAndRemoveIds.added+"&removed="+addAndRemoveIds.removed;
        $.post("/role/updatePermission",
                seachText,
                function(data){
                    if (data.result == "success") {
                        swal({
                            title:"",
                            text: data.message,
                            type:"success"}, function(isConfirm) {
                            setRolePermission(roleId);
                            var rolePermissions = initObj.rolePermissions.responseJSON;
                            reloadDny(initObj.modules.responseJSON, rolePermissions);
                        });// 提示窗口, 修改成功
                    } else if (data.result == "fail") {
                        swal({
                            title:"",
                            text: data.message,
                            type:"error"});// 提示窗口, 修改成功
                        //$.messager.alert("提示", data.result.message, "info");
                    }
                })
    }
function getAddedAndRemovePermissionIds(){
    var nodes = trees.staTree.getCheckedNodes();
    var oldRolePermission= initObj.rolePermissions.responseJSON;
    var currPermissionIds = filterPermissionIds(nodes);
    var oldPermissionIds = rolePermissionsObj2permissionIds(oldRolePermission);
    var addedPermissionIds = contrast(currPermissionIds,oldPermissionIds);
    var removedPermissionIds = contrast(oldPermissionIds, currPermissionIds);
    var resultObj = {added: addedPermissionIds.join("-"), removed: removedPermissionIds.join("-")};
    return resultObj;
}
function  filterPermissionIds(nodes){
    var permissionNodes = removeModuleId(nodes);
    var permissionIds = filterPermission(permissionNodes);
    return permissionIds;
}
function removeModuleId(nodes) {
    var len = nodes.length;
    var moduleReg = /^module-/;
    var permissionReg = /^permission-/;
    var permissionNodes = [];
    for(var i = 0; i<len; i++) {
        var node = nodes[i];
        if(moduleReg.exec(node)) {
            nodes[i] = undefined;
        } else if(permissionReg.exec(node)){
            permissionNodes.push(node);
        }
    }
    return permissionNodes;
}
function filterPermission(permissionNodes){
    var permissionReg = /^permission-/;
    var len = permissionNodes.length;
    var permissionIds = [];
    for(var i = 0; i<len; i++ ){
        var permissionNode = permissionNodes[i];
        if(permissionNode.replace(permissionReg,"","")){
            permissionIds.push(permissionNode.replace(permissionReg,"",""));
        }
    }
    return permissionIds;
}
function rolePermissionsObj2permissionIds(permissions){
    var len = permissions.length;
    var permissionIds = [];
    for(var i = 0; i<len; i++) {
        permissionIds.push(permissions[i].permissionId);
    }
    return permissionIds;
}
function updateRole(role){
    var roles = initObj.roles.responseJSON
    for(var i = 0, len = roles.length; i<len; i++) {
        var roleTemp = roles[i];
        if(roleTemp.roleId == role.roleId) {
            initObj.role =  role;
            return ;
        }
    }
}
function contrast(cur, sou){
    var added = [];
    var ilen = sou.length;
    var jlen = cur.length;
    var tempCurrPermission = cur.slice(0,jlen);
    for(var j = 0; j<jlen; j++){
        for(var i = 0; i<ilen; i++){
            if(tempCurrPermission[j] === sou[i]){
                tempCurrPermission[j] = undefined;
            }
        }
        if(tempCurrPermission[j]){
            added.push(tempCurrPermission[j])
        }
    }
    return added;
}

// 回收站
    function showDel(){ //删除角色
            swal(
                    {title:"",
                        text:"您确定要删除此角色吗",
                        type:"warning",
                        showCancelButton:true,
                        confirmButtonColor:"#DD6B55",
                        confirmButtonText:"我确定",
                        cancelButtonText:"再考虑一下",
                        closeOnConfirm:false,
                        closeOnCancel:false
                    },function(isConfirm){
                        if(isConfirm) {
                            var role = initObj.role;
                            $.get("/role/updateStatus?roleStatus=Y&roleId=" + role.roleId,function (data) {
                                swal({title:"",
                                    text:"删除成功",
                                    type:"success",
                                    confirmButtonText:"确认",
                                },function(){
                                    resetRole();
                                    initRoleTabs();
                                })
                            })
                        } else {
                            swal({title:"",
                                text:"已取消",
                                confirmButtonText:"确认",
                                type:"error"})
                        }
                    })

    }

    function recyclebin(){
        initTable('recycleTable', '/role/recycle'); // 初始化表格

    }

    function todoCell(ele, row, index) {
        var btnhtml = '<button type="button" class="btn btn-info" style="margin-right:5px;" onclick="restore(\''+ row.roleId +'\')">还原</button>'
        return btnhtml;
    }

    function restore(roleId){
        $.get("/role/updateStatus?roleStatus=N&roleId=" + roleId,function (data) {
            swal({title:"",
                text:"还原成功",
                confirmButtonText:"确认",
                type:"success"},function(isConfirm){
                initTable('recycleTable', '/role/recycle');
                resetRole();
                initRoleTabs();
            });
        });
    }
</script>
</html>
