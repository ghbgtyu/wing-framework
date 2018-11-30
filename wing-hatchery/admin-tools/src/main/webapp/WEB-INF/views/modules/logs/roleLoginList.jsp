<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>玩家登陆日志</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/log/roleLogin/">玩家登陆日志</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/log/roleLogin" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>角色名：</label>
		<input type="text" id="roleName" name="roleName"  class="input-small" value="${paramMap.roleName}"/>
		<label>玩家账号 ：</label>
		<input type="text" id="userId" name="userId"  class="input-small" value="${paramMap.userId}"/>
		<label>角色账号 ：</label>
		<input type="text" id="roleId" name="roleId"  class="input-small" value="${paramMap.roleId}"/>
		<label>时间 ：</label>
		<input type="text" name="createDateStart" class="input-small" readonly="readonly" maxlength="20" value="${paramMap.createDateStart}" id="startDatePicker" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
		-&nbsp;<input type="text" name="createDateEnd"   class="input-small" readonly="readonly" value="${paramMap.createDateEnd}"   id="endDatePicker" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">		
		
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" onclick="return page();"/>
	</form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<tr><th>玩家账号</th><th>角色账号</th><th>角色名称</th><th>登陆时间</th><th>登出时间</th><th>等级</th><th>IP地址</th><th>省</th><th>市</th><th>区</th><th>时间</th></tr>
		<c:forEach items="${page.list}" var="item">
			<tr>
				<td>${item.userId}</td>
				<td>${item.roleId}</td>
				<td>${item.roleName}</td>
				<td>${fns:parseLong(item.loginTime)}</td>
				<td>${fns:parseLong(item.logoutTime)}</td>
				<td>${item.level}</td>
				<td>${item.ip}</td>
				<td>${item.province}</td>
				<td>${item.city}</td>
				<td>${item.area}</td>
                <td>${fns:parseLong(item.logTime)}</td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>