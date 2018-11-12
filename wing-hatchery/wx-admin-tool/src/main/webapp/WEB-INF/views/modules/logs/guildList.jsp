<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>公会日志</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/highcharts.jsp" %>
	<script type="text/javascript">
	$(document).ready(function(){
		$("#s2id_pids").hide();
		$("#pids").multiselect({
			includeSelectAllOption:true,
			enableFiltering:true
		});
	});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/log/guildLog/getGuildList">公会日志</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/log/guildLog/getGuildList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>公会名 ：</label>
		<input id="name" name="name" type="text" value="${name}"/>
		<label>时间 ：</label>
		<input name="createDateStart" id="createDateStart" maxlength="50"  value="${paramMap.createDateStart}" class="input-small required" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
		-
		<input name="createDateEnd" maxlength="50"  class="input-small required" value="${paramMap.createDateEnd}" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'createDateStart\')}'})"/>
		&nbsp;
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" onclick="return page();"/>
		<input id="btnExport" class="btn btn-primary" type="button" value="导出" onclick="exportXls('${ctx}/log/moneyGetLog/exportXls')"/>
	</form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr><th>公会名称</th>	<th>会长</th>	<th>创建时间</th>	<th>公会等级</th>	<th>公会战斗力</th>
			<th>公会成员</th>	<th>公会状态</th> <th>公会操作</th></tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="item">
			<tr>
				<td>${item.name}</td>
				<td>${item.leader_name}</td>
				<td><fmt:formatDate value="${item.add_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>${item.level}</td>
				<td>${item.combat_power}</td>
				<td>${item.current_member_num}</td>
				<td></td>
				<td><a href="${ctx}/log/guildLog/deleteGuild" onclick="return confirmx('确认要删除该公会吗？', this.href)">删除<a></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	
	<script type="text/javascript">
		$(document).ready(function(){
			$('table.highchart').highchartTable();
		});
	</script>

</body>
</html>