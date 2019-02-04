<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>道具获得列表</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>

</head>
<body>

<form:form id="searchForm" modelAttribute="gainPropDetail" action="${ctx}/log/gainProp/" method="post"
           class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <input id="orderBy" name="orderBy" type="hidden" value="${page.orderBy}"/>
    <div>
        <label>玩家角色账号：</label><form:input path="userRoleId" htmlEscape="false" maxlength="50" class="input-small"/>
        &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
        &nbsp;<input id="btnExport" class="btn btn-primary" type="button" value="导出"
                     onclick="doExport('${ctx}/log/gainProp/export')"/>
    </div>
</form:form>

<table id="contentTable" class="table table-striped table-bordered table-condensed table-hover">
    <thead>
    <tr>
        <th>玩家角色账号</th>
        <th>玩家角色名称</th>
        <th>事件类型</th>
        <th>物品编号</th>
        <th>物品名称</th>
        <th>次数</th>
        <th>时间</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="gainProp">
        <tr>
            <td>${gainProp.userRoleId}</td>
            <td>${gainProp.userName}</td>
            <td>${gainProp.eventType}</td>
            <td>${gainProp.goodsId}</td>
            <td>${gainProp.goodsName}</td>
            <td>${gainProp.count}</td>
            <td><fmt:formatDate value="${gainProp.logTime}" type="both"/></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>
