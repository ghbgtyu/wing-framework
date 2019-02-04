<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>月营收预估</title>
    <meta name="decorator" content="default"/>

    <script src="${ctxStatic}/common/fixtable.js" type="text/javascript"></script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/tools/config/list">月营收预估</a></li>
    <li><a href="${ctx}/tools/config/form">新增月营收预估</a></li>
</ul>

<tags:message content="${message}"/>
<table id="contentTable" class="datatable table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>月份</th>
        <th>新注册</th>
        <th>老用户</th>
        <th>月活跃</th>
        <th>充值人数</th>
        <th>付费率（%）</th>
        <th>ARPU</th>
        <th>收入</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="item">
        <tr>
            <td>${item.month}</td>
            <td>${item.newUser}</td>
            <td>${item.oldUser}</td>
            <td>${item.active}</td>
            <td>${item.payNum}</td>
            <td><fmt:formatNumber value="${item.payrate * 100}" pattern="#0.00"/> %</td>
            <td><fmt:formatNumber value="${item.arpu}" pattern="#0.00"/></td>
            <td>${item.income}</td>
            <td><a href="${ctx}/tools/config/form?id=${item.id}">修改</a></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<br/>
</body>
</html>