<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>公告管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        //       $(function(){
        //           $("#tipDiv").tooltip('show');
        //       });

    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/tools/gameConfig/">配置文件列表</a></li>
    <li><a href="${ctx}/tools/gameConfig/form">添加配置</a></li>
</ul>

<tags:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <tr>
        <th>配置文件名</th>
        <th>原始文件名</th>
        <th>文件描述</th>
        <th>文件类型</th>
        <th>创建时间</th>
        <th>更新时间</th>
        <th>操作</th>
    </tr>
    <c:forEach items="${page.list}" var="configFile">
        <tr>
            <td>${configFile.newName}</td>
            <td>${configFile.fileName}</td>
            <td>${configFile.fileDesc}</td>
            <td>${fns:getCommon(configFile.fileType)}</td>
            <td><fmt:formatDate value="${configFile.createDate}" type="both"/></td>
            <td><fmt:formatDate value="${configFile.updateDate}" type="both"/></td>

            <td>
                <a href="${ctx}/tools/gameConfig/form?id=${configFile.id}">修改</a>
                <a href="${ctx}/tools/gameConfig/delete?id=${configFile.id}"
                   onclick="return confirmx('确认要删除吗？', this.href)">删除</a>
            </td>
        </tr>
    </c:forEach>
</table>
<div class="pagination">${page}</div>
</body>
</html>