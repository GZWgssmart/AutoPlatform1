var map;
var localSearch;
var windowId;
$(function () {
    var roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员";
    $.post("/user/isLogin/"+roles, function (data) {
        if(data.result == 'success'){
            initTable('table', '/company/queryByPagerCompany'); // 初始化表格
            //0.初始化fileinput
            var oFileInput = new FileInput();
            oFileInput.Init("file", "/company/addFile");
            // 初始化地图
            map = new BMap.Map("allmap",{minZoom:10,maxZoom:18});    // 创建Map实例
            map.centerAndZoom("赣州", 11);  // 初始化地图,设置中心点坐标和地图级别
            map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
            map.setCurrentCity("赣州");          // 设置地图显示的城市 此项是必须设置的
            map.enableScrollWheelZoom();    //启用滚轮放大缩小，默认禁用
            map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
            map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件
            map.addControl(new BMap.OverviewMapControl()); //添加默认缩略地图控件
            map.addControl(new BMap.OverviewMapControl({ isOpen: true, anchor: BMAP_ANCHOR_BOTTOM_RIGHT }));   //右下角，打开
            localSearch = new BMap.LocalSearch(map);
            localSearch.enableAutoViewport(); //允许自动调节窗体大小

        }else if(data.result == 'notLogin'){
            swal({title:"",
                    text:data.message,
                    confirmButtonText:"确认",
                    type:"error"}
                ,function(isConfirm){
                    if(isConfirm){
                        top.location = "/user/loginPage";
                    }else{
                        top.location = "/user/loginPage";
                    }
                })
        }else if(data.result == 'notRole'){
            swal({title:"",
                text:data.message,
                confirmButtonText:"确认",
                type:"error"})
        }
    });
});

//初始化fileinput
var FileInput = function () {

    var oFile = new Object();
    //初始化fileinput控件（第一次初始化）
    oFile.Init = function (ctrlName, uploadUrl) {
        var control = $('#' + ctrlName);
        $('#' + ctrlName).parent().css('width','90%');
        $('#' + ctrlName).parent().css('height','70%');
        //初始化上传控件的样式
        control.fileinput({
            language: 'zh', //设置语言
            uploadUrl: uploadUrl, //上传的地址
            allowedFileExtensions: ['jpg', 'gif', 'png'],//接收的文件后缀
            showUpload: false, //是否显示上传按钮
            showCaption: false,//是否显示标题
            browseClass: "btn btn-primary", //按钮样式
            dropZoneEnabled: true,//是否显示拖拽区域
            minImageWidth: 50, //图片的最小宽度
            minImageHeight: 50,//图片的最小高度
//                maxImageWidth: 350,//图片的最大宽度
//                maxImageHeight: 350,//图片的最大高度
//             maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
//             maxFileCount: 1, //表示允许同时上传的最大文件个数
            enctype: 'multipart/form-data',
            validateInitialCount: true,
            previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
            // msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
        }).on("fileuploaded", function (event, data) {
            // data 为controller返回的json
            var resp= data.response;
            if (resp.controllerResult.result == 'success') {
                $("#file").val(resp.imgPath)
                alert('处理成功');
            } else {
                alert("上传失败")
            }
        });
    }
    return oFile;
};

//显示弹窗
function showEdit() {
    initDatePicker('editForm', 'companyOpendate','editDatetimepicker'); // 初始化时间框
    var roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员";
    $.post("/user/isLogin/"+roles, function (data) {
        if (data.result == 'success') {
            var row = $('#table').bootstrapTable('getSelections');
            if (row.length > 0) {
                var oFileInput = new FileInput();
                oFileInput.Init("file1", "/company/addFile");
                $("#editWindow").modal('show'); // 显示弹窗
                $("#editButton").removeAttr("disabled");
                var ceshi = row[0];
                $('#editDatetimepicker').val(formatterDate(ceshi.companyOpendate));
                $("#editForm").fill(ceshi);
                validator('editForm');
                // $('#editcompanyName').bind('input propertychange', function() {
                //     companyName = $("#editcompanyName").val();
                // });
                // $('#editcompanyPricipalphone').bind('input propertychange', function() {
                //     companyPricipalphone = $("#editcompanyPricipalphone").val();
                // });
            } else {
                swal({
                    title: "",
                    text: "请选择要修改的公司信息", // 主要文本
                    confirmButtonColor: "#DD6B55", // 提示按钮的颜色
                    confirmButtonText: "确定", // 提示按钮上的文本
                    type: "warning"
                }) // 提示类型
            }
        } else if (data.result == 'notLogin') {
            swal({
                    title: "",
                    text: data.message,
                    confirmButtonText: "确认",
                    type: "error"
                }
                , function (isConfirm) {
                    if (isConfirm) {
                        top.location = "/user/loginPage";
                    } else {
                        top.location = "/user/loginPage";
                    }
                })
        } else if (data.result == 'notRole') {
            swal({
                title: "",
                text: data.message,
                confirmButtonText: "确认",
                type: "error"
            })
        }
    });
}

// 初始化没有分秒的时间框
function initDatePicker(formId, field){
    $(".datetimepicker").datetimepicker({
        minView: "month", //选择日期后，不会再跳转去选择时分秒
        language: 'zh-CN',
        format: 'yyyy-mm-dd',
        initialDate: new Date(),
        autoclose: true,
        todayHighligh:true,
        todayBtn :true, // 显示今日按钮
        autoclose: 1
    }).on('hide',function(e) {
        $('#'+formId).data('bootstrapValidator')
            .updateStatus(field, 'NOT_VALIDATED',null)
            .validateField(field);
    });
}
//格式化不带时分秒的时间值。
function formatterDate(value) {
    if (value == undefined || value == null || value == '') {
        return "";
    } else {
        var date = new Date(value);
        var year = date.getFullYear().toString();
        var month = (date.getMonth() + 1);
        var day = date.getDate().toString();
        if (month < 10) {
            month = "0" + month;
        }
        if (day < 10) {
            day = "0" + day;
        }
        return year + "-" + month + "-" + day + ""
    }
}

// 激活或禁用
function statusFormatter(value, row, index) {
    if(value == 'Y') {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-danger' onclick='inactive(\""+'/company/statusOperate?id='+row.companyId+'&status=Y'+"\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<button type='button' class='btn btn-success' onclick='active(\""+'/company/statusOperate?id='+ row.companyId+'&status=N'+ "\")'>激活</a>";
    }
}
//显示添加
function showAdd(){
    // 初始化时间框, 第一参数是form表单id, 第二参数是input的name, 第三个参数为input的id
    initDatePicker('addForm', 'companyOpendate','addDateTimePicker');
    var roles = "系统超级管理员,系统普通管理员";
    $.post("/user/isLogin/"+roles, function (data) {
        if (data.result == 'success') {
            $("#addWindow").modal('show');
            $("#addButton").removeAttr("disabled");
            // $('#addcompanyName').bind('input propertychange', function() {
            //     companyName = $("#addcompanyName").val();
            // });
            // $('#addcompanyPricipalphone').bind('input propertychange', function() {
            //     companyPricipalphone = $("#addcompanyPricipalphone").val();
            // });
            validator('addForm'); // 初始化验证
        } else if (data.result == 'notLogin') {
            swal({
                    title: "",
                    text: data.message,
                    confirmButtonText: "确认",
                    type: "error"
                }
                , function (isConfirm) {
                    if (isConfirm) {
                        top.location = "/user/loginPage";
                    } else {
                        top.location = "/user/loginPage";
                    }
                })
        } else if (data.result == 'notRole') {
            swal({
                title: "",
                text: data.message,
                confirmButtonText: "确认",
                type: "error"
            })
        }
    });
}

function validator(formId) {
    $('#' + formId).bootstrapValidator({
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            companyName: {
                message: '公司名称验证失败',
                validators: {
                    notEmpty: {
                        message: '公司名称不能为空'
                    },
                    stringLength: {
                        min: 1,
                        max: 10,
                        message: '公司名称长度必须在1到10位之间'
                    },
                    remote: {
                        url: '/company/querycompanyName',
                        message: '该公司名称已存在',
                        delay :  2000,
                        type: 'POST',
                        data: {
                            companyId: $("#"+formId + " input[name=companyId]").val(),
                            companyName: $("#" + formId + " input[name=companyName]").val()
                        }
                    }
                }
            },

            companyAddress: {
                message: '公司地址验证失败',
                validators: {
                    notEmpty: {
                        message: '公司地址不能为空'
                    }
                }
            },
            companyTel: {
                message: '公司联系电话证失败',
                validators: {
                    notEmpty: {
                        message: '公司联系电话不能为空'
                    },
                    stringLength: {
                        min: 6,
                        max: 11,
                        message: '公司联系电话长度必须在6到11位之间'
                    }
                }
            },
            companyPricipal: {
                message: '负责人验证失败',
                validators: {
                    notEmpty: {
                        message: '负责人不能为空'
                    }
                }
            },
            // companyWebsite: {
            //     message: '公司官网网址验证失败',
            //     validators: {
            //         notEmpty: {
            //             message: '公司官网网址格式为http|ftp|https://www'
            //         },
            //         regexp: {
            //             regexp: /^(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?$/,
            //                 message: '请输入正确公司官网网址'
            //         }
            //     }
            // },
            companyWebsite: {
                message: '公司官网URL验证失败',
                validators: {
                    regexp: {
                        regexp: /^(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?$/,
                        message: '请输入正确公司官网网址（http://开头）'
                    },
                    notEmpty: {
                        message: '公司官网URL不能为空'
                    },
                }

            },

            companyPricipal: {
                message: '负责人验证失败',
                validators: {
                    notEmpty: {
                        message: '负责人不能为空'
                    },
                }
            },
            companyPricipalphone: {
                message: '负责人联系电话验证失败',
                    validators: {
                    notEmpty: {
                        message: '负责人联系电话不能为空'
                    },
                    stringLength: {
                        min: 11,
                            max: 11,
                            message: '负责人联系电话必须为11位'
                    },
                    regexp: {
                        regexp: /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/,
                            message: '请输入正确的手机号'
                    },
                        remote: {
                            url: '/company/querycompanyPricipalphone',
                            message: '该负责人联系电话已存在',
                            delay :  2000,
                            type: 'POST',
                            data: {
                                companyId: $("#"+formId + " input[name=companyId]").val(),
                                companyPricipalphone: $("#" + formId + " input[name=companyPricipalphone]").val()
                            }
                        }
                }
            },
            companySize: {
                message: '公司规模验证失败',
                validators: {
                    notEmpty: {
                        message: '公司规模不能为空'
                    }
                }
            },
            companyLongitude: {
                message: '公司经度验证失败',
                validators: {
                    notEmpty: {
                        message: '公司经度不能为空'
                    }
                }
            },
            companyLatitude: {
                message: '公司纬度验证失败',
                validators: {
                    notEmpty: {
                        message: '公司纬度不能为空'
                    }
                }
            },
            companyOpendate: {
                message: '公司成立时间验证失败',
                validators: {
                    notEmpty: {
                        message: '公司成立时间不能为空'
                    }
                }
            }
            ,
            companyLogo:{
                message: '公司Logo失败',
                validators: {
                    notEmpty: {
                        message: '公司Logo不能为空'
                    }
                }
            }
        }
    })

        .on('success.form.bv', function (e) {
            if (formId == "addForm") {
                formSubmit("/company/addCompany", formId, "addWindow", "file");

            } else if (formId == "editForm") {

                formSubmit("/company/updateCompany", formId, "editWindow", "file1");


            }
        })

}

function formatterImg(value, row, index){
    if(row.companyLogo !=null){
        return [
            '<img style="width:100px;height:40px;" src="/'+ value +'">'
        ]
    }
}


// //初始化文件上传控件
// $(function () {
//
//     $("#add_companyLogo").fileinput({
//         language: 'zh', //设置语言
//         showCaption: true, //是否显示文件的标题
//         showPreview: true, //是否显示文件的预览图
//         showRemove: true, //是否显示删除/清空按钮
//         showUpload: true, //是否显示文件上传按钮
//         showCancel: true, //是否显示取消文件上传按钮
//         uploadAsync: true,
//         minFileCount: 1,
//         maxFileCount: 6,
// //        validateInitialCount: true,
//         enctype: 'multipart/form-data',
//         uploadUrl: '<%=path %>/company/editFile', //上传的地址
// //      maxFileSize: 5000,
// //      browseClass: "btn btn-primary", //按钮样式
// //        allowedPreviewTypes: ['image'], //可以配置哪些文件类型被允许显示为预览,用默认较好
// //        allowedFileTypes: ['image'],
// //        browseClass: "btn btn-primary", //按钮样式
// //        previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
//         allowedFileExtensions: ['jpg', 'png', 'gif']
//     });
// });

// $(function () {
//     //0.初始化fileinput
//     var oFileInput = new FileInput();
//     oFileInput.Init("edit_companyLogo", "/company/editFile");
// });

// //初始化fileinput
// var FileInput = function () {
//     var oFile = new Object();
//     //初始化fileinput控件（第一次初始化）
//     oFile.Init = function (ctrlName, uploadUrl) {
//         var control = $('#' + ctrlName);
//         //初始化上传控件的样式
//         control.fileinput({
//             language: 'zh', //设置语言
//             uploadUrl: uploadUrl, //上传的地址
//             allowedFileExtensions: ['jpg', 'gif', 'png'],//接收的文件后缀
//             showUpload: true, //是否显示上传按钮
//             showCaption: false,//是否显示标题
//             browseClass: "btn btn-primary", //按钮样式
//             dropZoneEnabled: true,//是否显示拖拽区域
//             //minImageWidth: 50, //图片的最小宽度
//             //minImageHeight: 50,//图片的最小高度
//             //maxImageWidth: 1000,//图片的最大宽度
//             //maxImageHeight: 1000,//图片的最大高度
//             //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
//             //minFileCount: 0,
//             maxFileCount: 10, //表示允许同时上传的最大文件个数
//             enctype: 'multipart/form-data',
//             validateInitialCount: true,
//             previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
//             msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
//         }).on("fileuploaded", function (event, data) {
//             // data 为controller返回的json
//             if (data.response.result == 'success') {
//                 alert('处理成功');
//             }
//         });
//     }
//     return oFile;
// };

function addSubmit(){
    setTimeout(function () {
        $("#addForm").data('bootstrapValidator').validate();
        if ($("#addForm").data('bootstrapValidator').isValid()) {
            $("#addButton").attr("disabled","disabled");
        } else {
            $("#addButton").removeAttr("disabled");
        }
    },100)

}

function editSubmit(){
    setTimeout(function () {
        $("#editForm").data('bootstrapValidator').validate();
        if ($("#editForm").data('bootstrapValidator').isValid()) {
            $("#editButton").attr("disabled","disabled");
        } else {
            $("#editButton").removeAttr("disabled");
        }
    },100)

}

function formSubmit(url, formId, winId, fileId) {
    var roles = "系统超级管理员,系统普通管理员,公司超级管理员,公司普通管理员";
    $.post("/user/isLogin/"+roles, function (data) {
        if (data.result == "success") {
            $.post(url, $("#"+formId).serialize(),
                function (data) {
                        if(data.company) {
                            console.log(data);
                            $('#table').bootstrapTable('refresh');
                            var fileData = document.getElementById(fileId).files[0];
                            if(fileData) {
                                var formData = new FormData();
                                formData.append("companyLogo", fileData);
                                formData.append("companyId", data.company.companyId);
                                $.ajax({
                                    url: "/company/afterUpdIcon",
                                    type: "POST",
                                    data: formData,
                                    processData: false,
                                    contentType: false,
                                    success: function (data1) {
                                        if (data1.controllerResult.result == "success") {
                                            endSuc(data, winId, formId);
                                        }
                                    }
                                })
                            } else {
                                endSuc(data, winId, formId);}
                        } else{
                            endSuc(data, winId, formId);
                        }
                    }, "json");
        } else if (data.result == "notLogin") {
            swal({
                text: data.message,
                confirmButtonText: "确认", // 提示按钮上的文本
                type: "error"
            }, function (isConfirm) {
                if (isConfirm) {
                    top.location = "/user/loginPage";
                } else {
                    top.location = "/user/loginPage";
                }
            })
        } else if (data.result = "notRole") {
            swal({
                text: data.message,
                confirmButtonText: "确认", // 提示按钮上的文本
                type: "error"
            })
        }
    })
}

function endSuc(data, winId, formId) {
    var controllerResult= data.controllerResult;
    if (controllerResult.result == "success") {
        swal({
            title:"",
            text: data.controllerResult.message,
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"success"
        })
        $('#' + winId).modal('hide');
        $('#table').bootstrapTable('refresh');
        if (formId == 'addForm') {
            $("input[type=reset]").trigger("click"); // 移除表单中填的值
            // $('#addForm').data('bootstrapValidator').resetForm(true); // 移除所有验证样式
            $("#addButton").removeAttr("disabled"); // 移除不可点击
            $("#" + formId).data('bootstrapValidator').destroy(); // 销毁此form表单
            $('#' + formId).data('bootstrapValidator', null);// 此form表单设置为空
        }else if(formId =='editForm'){
            $("#editButton").removeAttr("disabled");
        } else if (controllerResult.result == "fail") {
            swal({
                title: "",
                text: data.controllerResult.message,
                confirmButtonText: "确认",
                type: "error"
            })
            $("#" + formId).removeAttr("disabled");
        }
    }else if (data.result == "fail") {
        swal({title:"",
            text:"操作失败",
            confirmButtonText:"确认",
            type:"error"})
        $("#"+formId).removeAttr("disabled");
    }

}

// 查看全部可用
function showAvailable(){
    var roles = "系统超级管理员,系统普通管理员";
    $.post("/user/isLogin/"+roles, function (data) {
        if(data.result == 'success'){
            initTable('table', '/company/queryByPagerCompany');
        }else if(data.result == 'notLogin'){
            swal({title:"",
                    text:data.message,
                    confirmButtonText:"确认",
                    type:"error"}
                ,function(isConfirm){
                    if(isConfirm){
                        top.location = "/user/loginPage";
                    }else{
                        top.location = "/user/loginPage";
                    }
                })
        }else if(data.result == 'notRole'){
            swal({title:"",
                text:data.message,
                confirmButtonText:"确认",
                type:"error"})
        }
    });
}
// 查看全部禁用
function showDisable(){
    var roles = "系统超级管理员,系统普通管理员";
    $.post("/user/isLogin/"+roles, function (data) {
        if(data.result == 'success'){
            initTable('table', '/company/queryByPagerDisable');
        }else if(data.result == 'notLogin'){
            swal({title:"",
                    text:data.message,
                    confirmButtonText:"确认",
                    type:"error"}
                ,function(isConfirm){
                    if(isConfirm){
                        top.location = "/user/loginPage";
                    }else{
                        top.location = "/user/loginPage";
                    }
                })
        }else if(data.result == 'notRole'){
            swal({title:"",
                text:data.message,
                confirmButtonText:"确认",
                type:"error"})
        }
    });
}

function showInfo(e){
    if(windowId == 'addWindow'){
        $("#addCompanyLongitudeId").val(e.point.lng);
        $("#addCompanyLatitudeId").val(e.point.lat);
    }else{
        $("#editCompanyLongitudeId").val(e.point.lng);
        $("#editCompanyLatitudeId").val(e.point.lat);
    }
    $("#mapWindow").modal("hide");
}

function searchByStationName() {
    map.clearOverlays();//清空原来的标注
    var keyword = document.getElementById("text_").value;
    localSearch.setSearchCompleteCallback(function (searchResult) {
        var poi = searchResult.getPoi(0);
        map.centerAndZoom(poi.point, 13);
        var marker = new BMap.Marker(new BMap.Point(poi.point.lng, poi.point.lat));  // 创建标注，为要查询的地方对应的经纬度
        map.addOverlay(marker);
        var content = document.getElementById("text_").value + "<br/><br/>经度：" + poi.point.lng + "<br/>纬度：" + poi.point.lat;
        var infoWindow = new BMap.InfoWindow("<p style='font-size:14px;'>" + content + "</p>");
        marker.addEventListener("click", function () { this.openInfoWindow(infoWindow); });
        marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
    });
    localSearch.search(keyword);
}

function showMap(winId){

    $("#mapWindow").modal('show');
    $('#addForm').data('bootstrapValidator').resetForm();
    windowId = winId;
    map.addEventListener("click", showInfo);
}
