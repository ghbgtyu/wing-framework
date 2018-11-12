<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>指导员管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/game/role/gmList">指导员列表</a></li>
		<shiro:hasPermission name="game.gm.edit">
			<li><a href="${ctx}/game/role/gmForm">添加指导员</a></li>
		</shiro:hasPermission>
		<li><a href="${ctx}/game/role/gmPublish">GM禁言封号列表</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/game/role/gmList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>角色名：</label>
		<input type="text" id="roleName" name="roleName"  class="input-small" value="${paramMap.roleName}"/>
		<label>类型：</label>
		<select id="roleType" name="roleType">
			<option value="" name="roleType">请选择</option>
			<c:forEach items="${fns:getDictList('role_type')}" var="roleType">
				<option value="${roleType.value}" name="roleType">${roleType.label}</option>
			</c:forEach>
		</select>

		<label>时间 ：</label>
		<input type="text" name="createDateStart" class="input-small" readonly="readonly" maxlength="20" value="${paramMap.createDateStart}" id="startDatePicker" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
		-&nbsp;<input type="text" name="createDateEnd"   class="input-small" readonly="readonly" value="${paramMap.createDateEnd}"   id="endDatePicker" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">		
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" onclick="return page();"/>
	</form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<tr><th>平台名称</th><th>服务器</th><th>角色名</th><th>角色类型</th><th>创建者</th><th>创建时间</th><th>操作</th></tr>
		<c:forEach items="${page.list}" var="item">
			<tr>
				<td>${item.platformId}</td>
				<td>${item.serverId}</td>
				<td>${item.roleName}</td>
				<td>
					${fns:getDictLabel(item.roleType,"role_type" ,"无" )}
				</td>
				<td>${item.createName}</td>
                <td><fmt:formatDate value="${item.createDate}" type="both"/></td>
				<td>
					<shiro:hasPermission name="game.gm.edit">
					<a href="${ctx}/game/role/updateGmForm?id=${item.id}">修改</a>
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>