<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>玩家在线日志</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/log/roleOnline/">玩家在线</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/log/roleOnline" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

		<label>时间 ：</label>
		<input name="createDateStart" id="createDateStart" maxlength="50"  value="${paramMap.createDateStart}" class="input-small required" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
		-
		<input name="createDateEnd" maxlength="50"  class="input-small required" value="${paramMap.createDateEnd}" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'createDateStart\')}'})"/>

		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" onclick="return page();"/>
	</form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<tr><th>时间</th><th>在线人数</th></tr>
		<c:forEach items="${page.list}" var="item">
			<tr>
				<td>${item.log_hour}</td>
				<td>${item.count}</td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>