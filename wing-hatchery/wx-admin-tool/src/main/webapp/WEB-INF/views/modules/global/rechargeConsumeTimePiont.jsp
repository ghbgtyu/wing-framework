<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>充值消费时点分布</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/highcharts.jsp" %>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/global/rechargeConsume/rechargeConsumeTimePiont">充值消费时点分布</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/global/rechargeConsume/rechargeConsumeTimePiont" method="post" class="breadcrumb form-search">
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
	
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span6 panel panel-primary">
				<div class="panel-heading">充值时点分布</div>
				<table id="contentTable" class="datatable table table-striped table-bordered table-condensed" style="overflow: scroll">
					<thead>
					<tr><th>日期</th><th>时点</th><th>充值人数</th><th>充值金额</th><th>付费率</th><th>ARPU</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach items="${tableList1}" var="item">
						<tr>
							<td>${item.log_day}</td>
							<td>${item.log_hour}</td>
							<td>${item.pa}</td>
							<td>${item.income}</td>
							<td>${item.pay_rate}</td>
							<td>${item.arpu}</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
			
			<div class="span6 panel panel-primary">
				<div class="panel-heading">消费时点分布</div>
				<table id="contentTable" class="datatable table table-striped table-bordered table-condensed" style="overflow: scroll">
					<thead>
					<tr><th>日期</th><th>时点</th><th>消费人数</th><th>消费金额</th><th>付费率</th><th>ARPU</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach items="${tableList2}" var="item">
						<tr>
							<td>${item.log_day}</td>
							<td>${item.log_hour}</td>
							<td>${item.consume_account}</td>
							<td>${item.consume_amount}</td>
							<td>${item.pay_rate}</td>
							<td>${item.consume_account}</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="row-fluid">
			<div class="span6 panel panel-primary">
				<div class="panel-heading">消费时点分布（绑元）</div>
				<table id="contentTable" class="datatable table table-striped table-bordered table-condensed" style="overflow: scroll">
					<thead>
					<tr><th>日期</th><th>时点</th><th>消费人数</th><th>消费金额</th><th>付费率</th><th>ARPU</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach items="${tableList3}" var="item">
						<tr>
							<td>${item.log_day}</td>
							<td>${item.log_hour}</td>
							<td>${item.consume_account}</td>
							<td>${item.consume_amount}</td>
							<td>${item.pay_rate}</td>
							<td>${item.consume_account}</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<%--<table id="contentTable" class="table table-striped table-bordered table-condensed">--%>
		<%--<tr><th>日期</th><th>开服数</th><th>收入</th><th>新增注册数</th><th>活跃用户</th><th>老用户</th><th>ACCU</th><th>PCCU</th><th>DT时长(分)</th><th>充值人数</th>--%>
			<%--<th>付费率</th><th>ARPU</th><th>活跃ARPU</th><th>首充人数</th><th>首充金额</th><th>新新充值人数</th><th>新新充值金额</th><th>新新付费率</th><th>新新ARPU</th>--%>
			<%--<th>老新充值人数</th>老新充值金额<th>老新付费率</th><th>老新ARPU</th><th>老新充值人数</th><th>老老充值金额</th><th>老老付费率</th><th>老老ARPU</th></tr>--%>
		<%--<c:forEach items="${page.list}" var="item">--%>
			<%--<tr>--%>

			<%--</tr>--%>
		<%--</c:forEach>--%>
	<%--</table>--%>
	<%--<div class="pagination">${page}</div>--%>

<script type="text/javascript">
	$(document).ready(function(){
		$('table.highchart').highchartTable();
	});
</script>

</body>
</html>