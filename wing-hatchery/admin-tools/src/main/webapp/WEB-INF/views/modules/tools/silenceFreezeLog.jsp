<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>封号禁言日志</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/game/role/silenceFreezeLog">禁言封号列表</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/game/role/silenceFreezeLog" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>角色名：</label>
		<input type="text" id="roleName" name="roleName"  class="input-small" value="${paramMap.roleName}"/>
		<label>角色账号 ：</label>
		<input type="text" id="roleId" name="roleId"  class="input-small" value="${paramMap.roleId}"/>
		<label>时间 ：</label>
		<input type="text" name="createDateStart" class="input_search" size="10" readonly="readonly" maxlength="20" value="${paramMap.createDateStart}" id="startDatePicker" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
		-&nbsp;<input type="text" name="createDateEnd"   class="input_search" size="10" readonly="readonly" value="${paramMap.createDateEnd}"   id="endDatePicker" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">		
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" onclick="return page();"/>
	</form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<tr><th>玩家账号</th><th>角色账号</th><th>角色名称</th><th>是否禁言</th><th>是否封号</th><th>服务器编号</th><th>操作类型</th><th>禁言封号原因</th><th>操作者</th><th>时间</th></tr>
		<c:forEach items="${page.list}" var="item">
			<tr>
				<td>${item.userId}</td>
				<td>${item.roleId}</td>
				<td>${item.roleName}</td>
				<td><c:choose>
				      <c:when test="${item.isjinyan eq false}"><span class="label label-info">否</span></c:when>
				      <c:otherwise><span class="label label-warning">是</span></c:otherwise>
				     </c:choose>
				 </td>
				<td><c:choose>
				      <c:when test="${item.isfenghao eq false}"><span class="label label-info">否</span></c:when>
				      <c:otherwise><span class="label label-warning">是</span></c:otherwise>
				     </c:choose>
				</td>
				<td>${item.serverId}</td>
				<td>
					<c:if test="${item.operationType eq 0}">禁言</c:if>
					<c:if test="${item.operationType eq 1}">封号</c:if>
					<c:if test="${item.operationType eq 2}">取消禁言</c:if>
					<c:if test="${item.operationType eq 3}">取消封号</c:if>
				</td>
				<td>${item.msg}</td>
				<td>${item.createName}</td>
                <td><fmt:formatDate value="${item.createDate}" type="both"/></td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>