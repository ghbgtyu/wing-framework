<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>封号禁言日志</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/game/role/gmList/">指导员列表</a></li>
		<shiro:hasPermission name="game.gm.edit">
			<li><a href="${ctx}/game/role/gmForm">添加指导员</a></li>
		</shiro:hasPermission>
		<li class="active"><a href="${ctx}/game/role/gmPublish">GM禁言封号列表</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/game/role/gmPublish" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>角色名：</label>
		<input type="text" id="roleName" name="roleName"  class="input-small" value="${paramMap.roleName}"/>
		<label>角色账号 ：</label>
		<input type="text" id="roleId" name="roleId"  class="input-small" value="${paramMap.roleId}"/>
		<label>时间 ：</label>
		<input name="createDateStart" id="createDateStart" maxlength="50"  value="${paramMap.createDateStart}" class="input-small required" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"/>
		-
		<input name="createDateEnd" maxlength="50"  class="input-small required" value="${paramMap.createDateEnd}"  readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'createDateStart\')}'})"/>

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
				<td>
					<c:if test="${item.isjinyan eq 0 }"><span class="label label-info">未禁言</span></c:if>
					<c:if test="${item.isjinyan eq 1 }"><span class="label label-success">已禁言</span></c:if>
				</td>
				<td>
					<c:if test="${item.isfenhao eq 0 }"><span class="label label-info">未封号</span></c:if>
					<c:if test="${item.isfenhao eq 1 }"><span class="label label-success">已封号</span></c:if>
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
                <td>${fns:parseLong(item.createDate)}</td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>