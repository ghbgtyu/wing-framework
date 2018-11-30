<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>月留存图表</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/highcharts.jsp" %>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/global/monthRemainer/monthRemainerReport">新注册用户月留存率</a></li>
		<li class="active"><a href="${ctx}/global/monthRemainer/monthRemainerReport?isLineChart=1">月留存图表</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/global/monthRemainer/monthRemainerReport" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input type="hidden" id="isLineChart" name="isLineChart" value="1">
		<label>时间 ：</label>
		<input type="text" name="createDateStart" class="input_search" size="10" readonly="readonly" maxlength="20" value="${paramMap.createDateStart}" id="startDatePicker" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
		-&nbsp;<input type="text" name="createDateEnd"   class="input_search" size="10" readonly="readonly" value="${paramMap.createDateEnd}"   id="endDatePicker" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">
		<label>服务器：</label>
	    <input id="serverIds" name="serverIds" value="${paramMap.serverIdList}" readonly="readonly"/>
		<input type="button" class="btn btn-primary" value="选择服务器" onclick="openSeverDialog();">
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" onclick="return page();"/>
	</form>
	<tags:message content="${message}"/>
	<div  class="highchart-daysActive" style="height: 300px"></div>
	<table class="highchart table"
		   data-graph-container=".highchart-daysActive" data-graph-type="spline" data-graph-xaxis-reversed="1"
		   data-graph-yaxis-1-title-text = '月留存' data-graph-zoom-type="xy" style="display: none">
		<caption>月留存</caption>
		<thead>
		<tr>
			<th>日期</th>
			<th data-graph-type="line">月留存</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${monthRemainer}" var="item">
			<tr>
				<td>${item.log_day}</td>
				<td>${item.sum_30_dau}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	
	<script type="text/javascript">
		$(document).ready(function(){
			$('table.highchart').highchartTable();
		});
	</script>

</body>
</html>