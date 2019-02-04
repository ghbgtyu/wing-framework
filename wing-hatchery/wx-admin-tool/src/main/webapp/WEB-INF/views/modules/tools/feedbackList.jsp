<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>玩家反馈</title>
    <meta name="decorator" content="default"/>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/tools/feedback/">玩家反馈列表</a></li>
</ul>
<form id="searchForm" action="${ctx}/tools/feedback/" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

    <div>
        <label>反馈类型:</label>
        <select id="feedbackType" name="feedbackType">
            <option value="">请选择</option>
            <c:forEach items="${fns:getDictList('feedback_type')}" var="feedbackType">
                <option value="${feedbackType.value}">${feedbackType.label}</option>
            </c:forEach>
        </select>
        <label>关键字：</label>
        <input type="text" id="keywords" name="keywords" class="input-small" value="${paramMap.keywords}"/>
        <label>反馈时间 ：</label>
        <input type="text" name="feedbackTimeStart" class="input-small" readonly="readonly" maxlength="20"
               value="${paramMap.feedbackTimeStart}" id="startDatePicker"
               onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
        -&nbsp;<input type="text" name="feedbackTimeEnd" class="input-small" readonly="readonly"
                      value="${paramMap.feedbackTimeEnd}" id="endDatePicker"
                      onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">
        &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
    </div>
</form>

<table id="contentTable" class="table table-striped table-bordered table-condensed table-hover">
    <thead>
    <tr>
        <th>标题</th>
        <th>内容</th>
        <th>反馈类型</th>
        <th>平台</th>
        <th>角色名</th>
        <th>时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="item">
        <tr>
            <td>${item.title}</td>
            <td width="20%">${item.content}</td>
            <td>${fns:getDictLabel(item.type, "feedback_type","未知")}</td>
            <td>${item.platformId}</td>
            <td>${item.roleName}</td>
            <td><fmt:formatDate value="${item.feedbackTime}" type="both"/></td>
            <td>
                <shiro:hasPermission name="game.feedback.reply">
                    <a href="<c:url value='${fns:getAdminPath()}/tools/feedback/feedbackForm?id=${item.id}&serverId=${item.serverId}&roleId=${item.roleId}'><c:param name='roleName' value='${fns:urlEncode(item.roleName)}'/></c:url>">回复玩家</a>
                </shiro:hasPermission>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>
