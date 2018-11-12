<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货币消耗日志</title>
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
		<li class="active"><a href="${ctx}/log/moneyConsumeLog/moneyConsumeLogReport">货币消耗日志</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/log/moneyConsumeLog/moneyConsumeLogReport" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>角色名称 ：</label>
		<input id="roleName" name="roleName" type="text" value="${roleName}"/>
		<label>时间 ：</label>
		<input type="text" name="createDateStart" class="input-small" readonly="readonly" maxlength="20" value="${paramMap.createDateStart}" id="startDatePicker" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
		-&nbsp;<input type="text" name="createDateEnd"   class="input-small" readonly="readonly" value="${paramMap.createDateEnd}"   id="endDatePicker" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">		
		<label>货币类型 ：</label>
			<select name="moneyType">
					<option value="">请选择</option>
			 	<c:forEach items="${fns:getDictList('money_type')}" var="item">
					<option value="${item.value}"
						<c:if test="${item.value==paramMap.moneyType}">selected="selected"</c:if>
					>${item.label}</option>
			 	</c:forEach>
			</select>
		<label>事件 ：</label>
			<select name="operateType">
					<option value="">请选择</option>
				<c:forEach items="${fns:getOperaTypeMap()}" var="item">
					<option value="${item.key}"
						<c:if test="${item.key==paramMap.operateType}">selected="selected"</c:if>
					>${item.value.chDes }</option>
			 	</c:forEach>
			</select>
		&nbsp;
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" onclick="return page();"/>
		<shiro:hasPermission name="log.moneyConsume.export">
		<input id="btnExport" class="btn btn-primary" type="button" value="导出" onclick="exportXls('${ctx}/log/moneyConsumeLog/exportXls')"/>
		</shiro:hasPermission>
	</form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr><th>角色名</th>	<th>项目</th>	<th>事件</th>	<th>货币变化数量</th>	<th>货币变化前数量</th>
			<th>货币变化后数量</th>	<th>时间</th></tr>
		</thead>
		<tbody>
		<c:forEach items="${moneyConsumeLog.list}" var="item">
			<tr>
				<td>${item.role_name}</td>
				<td>${fns:getDictLabel(item.money_type,'money_type','类别错误')}</td>
				<td>${fns:getOperationType(item.operate_type)}</td>
				<td>${item.value}</td>
				<td>${item.before_value}</td>

				<td>${item.after_value}</td>
				<td>${item.add_time}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${moneyConsumeLog}</div>
	
	<script type="text/javascript">
		$(document).ready(function(){
			$('table.highchart').highchartTable();
		});
	</script>

</body>
</html>