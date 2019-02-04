<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>开服回本数据</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/highcharts.jsp" %>
    <script type="text/javascript">
        function deleteCrossAreaList(url) {
            var oldUrl = $("form:first").attr("action");
            $("form:first").attr("action", url);
            $("form:first").submit();
            $("form:first").attr("action", oldUrl);
        }
    </script>
    <style type="text/css">
        span.input-group-btn {
            display: none;
        }
    </style>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/tools/crossArea/crossAreaManage">战区管理</a></li>
    <li><a href="${ctx}/tools/crossArea/crossAreaAdd?crossAreaType=0">添加战区</a></li>
</ul>
<form id="searchForm" action="${ctx}/tools/crossArea/crossAreaManage" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

    <label>玩法选择 ：</label>
    <select id="crossAreaType" name="crossAreaType">
        <option value="">请选择</option>
        <c:forEach items="${fns:getDictList('crossType')}" var="item">
            <option value="${item.value}">${item.label}</option>
        </c:forEach>
    </select>
    <label>赛区名称 ：</label>
    <input type="text" name="crossAreaName" value="${crossAreaName}"/>
    <label>IP ：</label>
    <input type="text" name="innerIp" value="${innerIp}"/>
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>"
                 onclick="return page();"/>
    &nbsp;<input id="btnExport" class="btn btn-primary" type="button" value="导出"
                 onclick="exportXls('${ctx}/tools/crossArea/exportXls')"/>
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="button" value="删除跨服的服务器列表"
                 onclick="deleteCrossAreaList('${ctx}/tools/crossArea/deleteAllCrossArea')"/>

</form>
<tags:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>类型</th>
        <th>跨服ID</th>
        <th>跨服名字</th>
        <th>赛区名称</th>
        <th>IP</th>
        <th>port</th>
        <th>
            <c:choose>
                <c:when test="${crossAreaType==0}">竞技服务器</c:when>
                <c:when test="${crossAreaType==1}">国家</c:when>
                <c:otherwise>竞技服务器/国家</c:otherwise>
            </c:choose>
        </th>
        <th>操作</th>
    </thead>
    <tbody>
    <c:forEach items="${crossAreaList}" var="item">
        <tr>
            <td>${fns:getDictLabel(item.crossType,"crossType","")}</td>
            <td>${item.crossServer.worldId}</td>
            <td>${item.crossServer.worldName}</td>
            <td>${item.crossAreaName}</td>
            <td>${item.crossServer.innerIp}</td>
            <td>${item.crossServer.innerPort}</td>

            <td>
                    ${item.serverName}
            </td>
            <td>
                <a href="${ctx}/tools/crossArea/deleteCrossAreaById?crossType=${item.crossType}&crossAreaId=${item.crossServer.worldId}">删除</a>
                <a href="${ctx}/tools/crossArea/updateCrossArea?crossType=${item.crossType}&crossAreaId=${item.crossServer.worldId}">修改</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

</body>
</html>