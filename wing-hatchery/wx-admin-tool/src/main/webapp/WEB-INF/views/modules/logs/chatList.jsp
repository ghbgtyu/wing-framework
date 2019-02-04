<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>聊天日志</title>
    <meta name="decorator" content="default"/>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/game/chat">聊天日志</a></li>
</ul>
<form id="searchForm" action="${ctx}/game/chat" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <label>角色名：</label>
    <input type="text" id="roleName" name="roleName" class="input-small" value="${paramMap.roleName}"/>

    <label>聊天频道：</label>
    <select id="channel" name="channel">
        <option value="">请选择</option>
        <c:forEach items="${fns:getDictList('chat_channel')}" var="channel">
            <option value="${channel.value}"<c:if
                    test="${channel.value eq paramMap.channel}"></c:if> >${channel.label}</option>
        </c:forEach>
    </select>
    <label>私聊对象 ：</label>
    <input type="text" id="chatWithName" name="chatWithName" class="input-small" value="${paramMap.chatWithName}"/>

    <label>时间 ：</label>
    <input type="text" name="chatTimeStart" class="input_search" size="10" readonly="readonly" maxlength="20"
           value="${paramMap.chatTimeStart}" id="startDatePicker"
           onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
    -&nbsp;<input type="text" name="chatTimeEnd" class="input_search" size="10" readonly="readonly"
                  value="${paramMap.chatTimeEnd}" id="endDatePicker"
                  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">

    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>"
                 onclick="return page();"/>
</form>
<tags:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <tr>
        <th>角色名</th>
        <th>频道</th>
        <th>聊天对象</th>
        <th>内容</th>
        <th>时间</th>
    </tr>
    <c:forEach items="${page.list}" var="item">
        <tr>
            <td>${item.roleName}</td>
            <td>${fns:getDictLabel(item.channel, "chat_channel","无")}</td>
            <td>${item.chatWithName}</td>
            <td>${item.content}</td>
            <td>${fns:parseLong(item.chatTime)}</td>
        </tr>
    </c:forEach>
</table>
<div class="pagination">${page}</div>
</body>
</html>