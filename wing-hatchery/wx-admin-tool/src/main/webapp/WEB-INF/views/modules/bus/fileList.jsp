<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>


<html>
<head>
    <title>合同处理列表</title>
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
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/bus/file/list">合同处理列表</a></li>
    <li><a href="${ctx}/bus/file/create">合同创建</a></li>

</ul>
<tags:message content="${message}"/>

<table id="contentTable" class="table table-striped table-bordered table-condensed table-hover">
    <thead>
    <tr>

        <th>合同标题</th>
        <th>合同号</th>
        <th>备注</th>
        <th>创建日期</th>
        <th>创建者</th>
        <shiro:hasPermission name="bus:file:manager">
            <th>操作</th>
        </shiro:hasPermission>
        <shiro:hasPermission name="bus:file:upload">
            <th>审核操作</th>
        </shiro:hasPermission>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="busFile">
        <tr>
            <td>${busFile.content}</td>
            <td>${busFile.fileId}</td>
            <td>${busFile.uploadDesc}</td>
            <td><fmt:formatDate value="${busFile.createDate}" type="both"/></td>
            <td>${busFile.createBy.name}</td>

            <shiro:hasPermission name="bus:file:manager">
                <td>


                    <a href="#" onclick="return openUploadDialog('${busFile.id}','${busFile.fileId}')"> 上传合同文件</a>

                    <a href="#" onclick="return openUploadViewDialog('${busFile.id}','${busFile.fileId}')"> 预览合同文件</a>

                    <a href="${ctx}/bus/file/editView?id=${busFile.id}">修改</a>

                    <a href="${ctx}/bus/file/delete?id=${busFile.id}&fileId=${busFile.fileId}"
                       onclick="return confirmx('确认要删除合同吗？', this.href)">删除</a>
                </td>
            </shiro:hasPermission>

            <shiro:hasPermission name="bus:file:upload">
                <td>
                    <a href="${ctx}/bus/file/saveFile?id=${busFile.id}&fileId=${busFile.fileId}"
                       onclick="return confirmx('归档之后不能再次修改合同，确认要归档吗？', this.href)">合同归档</a>
                </td>
            </shiro:hasPermission>

        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>

<script>


</script>