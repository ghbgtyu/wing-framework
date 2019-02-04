<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>


<html>
<head>
    <title>合同文件预览</title>
    <meta name="decorator" content="default"/>

    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <style type="text/css">.sort {
        color: #0663A2;
        cursor: pointer;
    }</style>
    <script type="text/javascript">
        $(document).ready(function () {
            // 表格排序
            // var orderBy = $("#orderBy").val().split(" ");
            // $("#contentTable th.sort").each(function(){
            //     if ($(this).hasClass(orderBy[0])){
            //         orderBy[1] = orderBy[1]&&orderBy[1].toUpperCase()=="DESC"?"down":"up";
            //         $(this).html($(this).html()+" <i class=\"icon icon-arrow-"+orderBy[1]+"\"></i>");
            //     }	<!--<a href="${ctx}/bus/file/uploadView?id=${busFile.id}">上传合同文件</a>
            //<a href="${ctx}/bus/file/uploadView?id=${busFile.id}" onclick="return openUploadDialog(${busFile.id},${busFile.fileId})"> 上传合同文件</a>
            // });
            //<input type="button" class="btn btn-primary" value="上传合同文件" onclick="openUploadDialog(${busFile.id},${busFile.fileId})"></button>

            $("#contentTable th.sort").click(function () {
                var order = $(this).attr("class").split(" ");
                var sort = $("#orderBy").val().split(" ");
                for (var i = 0; i < order.length; i++) {
                    if (order[i] == "sort") {
                        order = order[i + 1];
                        break;
                    }
                }
                if (order == sort[0]) {
                    sort = (sort[1] && sort[1].toUpperCase() == "DESC" ? "ASC" : "DESC");
                    $("#orderBy").val(order + " DESC" != order + " " + sort ? "" : order + " " + sort);
                } else {
                    $("#orderBy").val(order + " ASC");
                }
                page();
            });

        });

        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctx}/sys/user/");
            $("#searchForm").submit();
            return false;
        }
    </script>


</head>

<body>

<tags:message content="${message}"/>

<table id="contentTable" class="table table-striped table-bordered table-condensed table-hover">
    <thead>
    <tr>

        <th>合同文件名</th>
        <th>上传日期</th>
        <th>上传者</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${fileList}" var="sysFile">
        <tr>
            <td>${sysFile.fileName}</td>
            <td>${sysFile.timeStr}</td>
            <td>${sysFile.uploadUserName}</td>
            <td>


                <a href="#"
                   onclick="downloadFile('${ctx}/bus/file/downloadFile?id=${sysFile.id}&fileId=${busFile.id}')">下载</a>

            </td>


        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>

<script>


</script>