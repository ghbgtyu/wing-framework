<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>日活跃总数</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/highcharts.jsp" %>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/global/monthRemainer/monthRemainerReport">新注册用户月留存率</a></li>
		<li><a href="${ctx}/global/monthRemainer/monthRemainerReport?isLineChart=1">月留存图表</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/global/monthRemainer/monthRemainerReport" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

		<label>时间 ：</label>
		<input type="text" name="createDateStart" class="input_search" size="10" readonly="readonly" maxlength="20" value="${paramMap.createDateStart}" id="startDatePicker" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
		-&nbsp;<input type="text" name="createDateEnd"   class="input_search" size="10" readonly="readonly" value="${paramMap.createDateEnd}"   id="endDatePicker" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">
		<label>服务器：</label>
	    <input id="serverIds" name="serverIds" value="${paramMap.serverIdList}" readonly="readonly"/>
		<input type="button" class="btn btn-primary" value="选择服务器" onclick="openSeverDialog();">
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" onclick="return page();"/>
	</form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr><th>注册日期</th> <th>注册用户数</th> <th>次日用户</th> <th>次日留存</th> <th>7日用户</th>
			<th>周留存</th> <th>14日用户</th> <th>双周留存</th> <th>30日用户</th> <th>月留存</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${monthRemainer}" var="item">
			<tr>
				<td>${item.log_day}</td>
				<td>${item.sum_dru}</td>
				<td>${item.sum_2}</td>
				<td><fmt:formatNumber value="${item.sum_2_dau*100}" pattern="0.00"/>%</td>
				<td>${item.sum_7}</td>
				<td><fmt:formatNumber value="${item.sum_7_dau*100}" pattern="0.00"/>%</td>
				<td>${item.sum_14}</td>
				<td><fmt:formatNumber value="${item.sum_14_dau*100}" pattern="0.00"/>%</td>
				<td>${item.sum_30}</td>
				<td><fmt:formatNumber value="${item.sum_30_dau*100}" pattern="0.00"/>%</td>
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