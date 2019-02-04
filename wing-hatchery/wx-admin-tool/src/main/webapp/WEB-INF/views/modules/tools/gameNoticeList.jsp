<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>公告管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(function () {
            $(".tipDiv").tooltip('show');
        });

    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/tools/gameNotice/">公告列表</a></li>
    <shiro:hasPermission name="game.notice.edit">
        <li><a href="${ctx}/tools/gameNotice/form">添加公告</a></li>
    </shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="gameNotice" action="${ctx}/tools/gameNotice/" method="post"
           class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <label>内容：</label>
    <form:input path="content" htmlEscape="false" maxlength="100" class="input-small"/>
    <label>状态：</label>
    <form:select path="noticeStatus">
        <form:option value="" label="请选择"></form:option>
        <form:options items="${fns:getDictList('notice_status')}" itemLabel="label" itemValue="value"/>
    </form:select>
    <label>间隔时间：</label>
    <form:input path="stepTime" htmlEscape="false" maxlength="50" class="input-small"/>
    <label>创建时间：</label>
    <input type="text" name="startTimeStart" class="input_search" size="10" readonly="readonly" maxlength="20"
           value="${paramMap.startTimeStart}" id="startDatePicker"
           onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
    -&nbsp;<input type="text" name="startTimeEnd" class="input_search" size="10" readonly="readonly" value="${paramMap.startTimeEnd}" id="endDatePicker" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">

    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message
        code="operation.search"/>" onclick="return page();"/>
    </div>
</form:form>
<tags:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <tr>
        <th>公告类型</th>
        <th width="20%">公告内容</th>
        <th>服务器</th>
        <th>总循环次数</th>
        <th>间隔</th>
        <th>开始时间</th>
        <th>结束时间</th>
        <th>状态</th>
        <th>创建人</th>
        <th>创建时间</th>
        <th>操作</th>
    </tr>
    <c:forEach items="${page.list}" var="gameNotice">
        <tr>
            <td>${fns:getDictLabel(gameNotice.noticeType, 'notice_type', '无')}</td>
            </td>
            <td>${gameNotice.content}</td>
            <td style="overflow:hidden;white-space:nowrap;">
                <c:if test="${gameNotice.isGlobal == 1}">全部服务器</c:if>
                <c:if test="${gameNotice.isGlobal == 0}"><a href="#" name="tipDiv" data-toggle="tooltip"
                                                            title="${gameNotice.serverIds}">${gameNotice.serverIds}</a></c:if>
            </td>
            <td>${gameNotice.repeatCount}</td>
            <td>${gameNotice.stepTime}</td>
            <td><fmt:formatDate value="${gameNotice.startTime}" type="both"/></td>
            <td><fmt:formatDate value="${gameNotice.finishTime}" type="both"/></td>
            <td>
                <c:choose>
                    <c:when test="${gameNotice.noticeStatus == 1}"><span
                            class="label label-success">${fns:getDictLabel(gameNotice.noticeStatus, 'notice_status', '无')}</span></c:when>
                    <c:when test="${gameNotice.noticeStatus == 0}"><span
                            class="label label-info">${fns:getDictLabel(gameNotice.noticeStatus, 'notice_status', '无')}</span></c:when>
                    <c:otherwise>${fns:getDictLabel(gameNotice.noticeStatus, 'notice_status', '无')}</c:otherwise>
                </c:choose>
            </td>
            <td>${gameNotice.createName}</td>
            <td><fmt:formatDate value="${gameNotice.createDate}" type="both"/></td>
            <td>
                <shiro:hasPermission name="game.notice.publish">
                    <c:if test="${gameNotice.noticeStatus == 0}"><a
                            href="${ctx}/tools/gameNotice/publish?id=${gameNotice.id}"
                            onclick="return confirmx('确认要发布该公告吗？', this.href)">发布</a></c:if>
                </shiro:hasPermission>
                    <%--<a href="${ctx}/tools/gameNotice/form?id=${gameNotice.id}">修改</a>--%>
                <shiro:hasPermission name="game.notice.delete">
                    <c:if test="${gameNotice.noticeStatus == 1 || gameNotice.noticeStatus ==2}">
                        <a href="${ctx}/tools/gameNotice/delete?id=${gameNotice.id}"
                           onclick="return confirmx('确认要取消该公告吗？', this.href)">取消</a>
                    </c:if>
                </shiro:hasPermission>
            </td>
        </tr>
    </c:forEach>
</table>
<div class="pagination">${page}</div>
</body>
</html>