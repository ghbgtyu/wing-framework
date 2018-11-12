<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>元宝产出消耗统计</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/highcharts.jsp" %>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/global/coinProduceConsume/coinProduceConsumeReport">元宝产出消耗统计</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/global/coinProduceConsume/coinProduceConsumeReport" method="post" class="breadcrumb form-search">
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
		<tr><th>日期</th> <th>充值金额</th> <th>消费金额</th> <th>元宝冗余</th> <th>冗余比例</th> <th>总库存</th></tr>
		</thead>
		<tbody>
		<c:forEach items="${coinProduceConsume.list}" var="item">
			<tr>
				<td>${item.log_day}</td>
				<td>${item.sum_pay_coin}</td>
				<td>${item.sum_consume_coin}</td>
				<td>${item.sub_pay_consume_coin}</td>
				<td><fmt:formatNumber value="${item.redundance_rate*100}" pattern="0.00"/>%</td>
				<td>${item.all_surplus_coin}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${coinProduceConsume}</div>
	
	<script type="text/javascript">
		$(document).ready(function(){
			$('table.highchart').highchartTable();
		});
	</script>

</body>
</html>