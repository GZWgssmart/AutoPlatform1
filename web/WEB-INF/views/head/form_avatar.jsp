<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>富头像上传编辑器</title>

    <link href="/static/jsp/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="/static/jsp/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="/static/jsp/animate.css" rel="stylesheet">

    <link href="/static/jsp/style.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">
<div class="wrapper wrapper-content">

    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>富头像上传编辑器</h5>
                    <div class="ibox-tools">
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>
                        <a class="dropdown-toggle" data-toggle="dropdown" href="<%=path %>/form_editors.html#">
                            <i class="fa fa-wrench"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-user">
                            <li><a href="<%=path %>/form_editors.html#">选项1</a>
                            </li>
                            <li><a href="<%=path %>/form_editors.html#">选项2</a>
                            </li>
                        </ul>
                        <a class="close-link">
                            <i class="fa fa-times"></i>
                        </a>
                    </div>
                </div>
                <div class="ibox-content">
                    <ul class="nav nav-tabs" id="avatar-tab">
                        <li class="active" id="upload"><a href="javascript:;">本地上传</a>
                        </li>
                        <li id="webcam"><a href="javascript:;">视频拍照</a>
                        </li>
                        <li id="albums"><a href="javascript:;">相册选取</a>
                        </li>
                    </ul>
                    <div class="m-t m-b">
                        <div id="flash1">
                            <p id="swf1">本组件需要安装Flash Player后才可使用，请从<a
                                    href="http://www.adobe.com/go/getflashplayer">这里</a>下载安装。</p>
                        </div>
                        <div id="editorPanelButtons" style="display:none">
                            <p class="m-t">
                                <label class="checkbox-inline">
                                    <input type="checkbox" id="src_upload">是否上传原图片？</label>
                            </p>
                            <p>
                                <a href="javascript:;" class="btn btn-w-m btn-primary button_upload"><i
                                        class="fa fa-upload"></i> 上传</a>
                                <a href="javascript:;" class="btn btn-w-m btn-white button_cancel">取消</a>
                            </p>
                        </div>
                        <p id="webcamPanelButton" style="display:none">
                            <a href="javascript:;" class="btn btn-w-m btn-info button_shutter"><i
                                    class="fa fa-camera"></i> 拍照</a>
                        </p>
                        <div id="userAlbums" style="display:none">
                            <a href="<%=path %>/img/a1.jpg" class="fancybox" title="选取该照片">
                                <img src="<%=path %>/img/a1.jpg" alt="示例图片1"/>
                            </a>
                            <a href="<%=path %>/img/a2.jpg" class="fancybox" title="选取该照片">
                                <img src="<%=path %>/img/a2.jpg" alt="示例图片2"/>
                            </a>
                            <a href="<%=path %>/img/a3.jpg" class="fancybox" title="选取该照片">
                                <img src="<%=path %>/img/a3.jpg" alt="示例图片2"/>
                            </a>
                            <a href="<%=path %>/img/a4.jpg" class="fancybox" title="选取该照片">
                                <img src="<%=path %>/img/a4.jpg" alt="示例图片2"/>
                            </a>
                            <a href="<%=path %>/img/a5.jpg" class="fancybox" title="选取该照片">
                                <img src="<%=path %>/img/a5.jpg" alt="示例图片2"/>
                            </a>
                            <a href="<%=path %>/img/a6.jpg" class="fancybox" title="选取该照片">
                                <img src="<%=path %>/img/a6.jpg" alt="示例图片2"/>
                            </a>
                            <a href="<%=path %>/img/a7.jpg" class="fancybox" title="选取该照片">
                                <img src="<%=path %>/img/a7.jpg" alt="示例图片2"/>
                            </a>
                            <a href="<%=path %>/img/a8.jpg" class="fancybox" title="选取该照片">
                                <img src="<%=path %>/img/a8.jpg" alt="示例图片2"/>
                            </a>
                            <a href="<%=path %>/img/a9.jpg" class="fancybox" title="选取该照片">
                                <img src="<%=path %>/img/a9.jpg" alt="示例图片2"/>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 全局js -->
<script src="/static/jsp/jquery.min.js?v=2.1.4"></script>
<script src="/static/jsp/bootstrap.min.js?v=3.3.6"></script>


<!-- 自定义js -->
<script src="/static/jsp/content.js?v=1.0.0"></script>


<!-- fullavatareditor -->
<script type="text/javascript" src="/static/scripts/swfobject.js"></script>
<script type="text/javascript" src="/static/scripts/fullAvatarEditor.js"></script>
<script type="text/javascript" src="/static/scripts/jQuery.Cookie.js"></script>
<script type="text/javascript" src="/static/scripts/test.js"></script>

<%--<script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>--%>
<!--统计代码，可删除-->
</body>

</html>
