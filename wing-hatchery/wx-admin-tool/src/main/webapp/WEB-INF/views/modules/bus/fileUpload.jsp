<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>


<html>
<head>
    <title>合同上传</title>

    <meta name="decorator" content="upload"/>
    <script>


        $(document).ready(function () {
            //
            //
            //   //  $("#input-id").fileinput();
            //
            //     //$("#input-id").fileinput({'showUpload':false, 'previewFileType':'any'});
            //
            //
            //     $("#uploadFile").file({
            //         title: "请上传附件",
            //         fileinput: {
            //             maxFileSize: 10240,
            //             maxFileCount:3
            //         },
            //         fileIdContainer:"[name='fileIds']",
            //         showContainer:'#attachment',
            //         //显示文件类型 edit=可编辑  detail=明细 默认为明细
            //         showType:'edit',
            //         //弹出窗口 执行上传附件后的回调函数(window:false不调用此方法)
            //         window:false,
            //         callback:function(fileIds,oldfileIds){
            //             //更新fileIds
            //             this.showFiles({
            //                 fileIds:fileIds
            //             });
            //         }
            //     });
            $('#file-1').fileinput({
                theme: 'fas',
                language: 'zh',
                uploadUrl: '${ctx}/bus/file/uploadMultipleFile',
                maxFileSize: 100000,
                maxFilesNum: 10,
                uploadAsync: false,
                uploadExtraData: function (previewId, index) {

                    return {id: "${busFile.id}"};
                }
            });
        });

    </script>


</head>


<body>

<tags:message content="${message}"/>


<%--<table id="contentTable" class="table table-striped table-bordered table-condensed">--%>

<%--</table>--%>

<%--<input type="hidden" name="fileIds" id="fileIds">--%>
<%--<div class="form-group">--%>
<%--<div class="btn btn-default btn-file" id="uploadFile">--%>
<%--<i class="fa fa-paperclip"></i> 上传附件(Max. 10MB)--%>
<%--</div>--%>
<%--</div>--%>
<%--<div class="form-group" id="file_container">--%>
<%--<input type="file" name="file"  id="attachment">--%>
<%--</div>

<div class="control-group">
    <label class="control-label">合同号:${busFile.fileId}</label>

    </div>
    <div class="control-group">
    <label class="control-label">合同标题:${busFile.content}</label>
    </div>

--%>


<form enctype="multipart/form-data">
    <div class="control-group">


    </div>
    <div class="control-group">


    </div>
    <div class="control-group">
        <div class="file-loading">
            <input id="file-1" name="file" type="file" multiple>
        </div>
    </div>
</form>

</body>
</html>

<script>


</script>