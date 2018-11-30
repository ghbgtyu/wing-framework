<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>日充值统计</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/highcharts.jsp" %>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/global/rechargeConsume/dailyRechargeReport">日充值统计</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/global/rechargeConsume/dailyRechargeReport" method="post" class="breadcrumb form-search">
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
			<div class="span12 panel panel-primary">
				<div class="panel-heading">每日充值总计</div>
				<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
				<table id="dailyTable" class="table table-striped table-bordered table-condensed">
					<tr><th>日期</th><th>开服数</th><th>充值金额</th><th>新增注册数</th><th>活跃用户</th><th>充值人数</th><th>充值次数</th><th>付费率</th><th>ARPU</th><th>活跃ARPU</th><th>首充值人数</th><th>首充值金额</th></tr>
					<c:forEach items="${dailyList}" var="item">
						<tr>
							<td>${item.log_day}</td>
							<td>${item.kaifuNum}</td>
							<td>${item.income}</td>
							<td>${item.dru}</td>
							<td>${item.dau}</td>
							<td>${item.dpa}</td>
							<td>${item.dP_times}</td>
							<td>${item.pay_rate}</td>
							<td>${item.arpu}</td>
							<td>${item.active_arpu}</td>
							<td>${item.first_pay_user}</td>
							<td>${item.first_pay_value}</td>
						</tr>
					</c:forEach>
				</table>
				</div>
			</div>
		</div>
		<div class="row-fluid">
			<div class="span12 panel panel-primary">
				<div class="panel-heading">用户分类充值总计</div>
				<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
				<table id="dailyTable" class="table table-striped table-bordered table-condensed">
					<tr><th></th><th></th><th colspan="4">当日新服</th><th colspan="4">3日新服</th><th colspan="4">7日新服</th><th colspan="4">新新</th><th colspan="4">老新</th><th colspan="4">老老</th></tr>
					<tr><th>日期</th><th>收入</th><th>充值人数</th><th>充值金额</th><th>付费率</th><th>ARPU</th><th>充值人数</th><th>充值金额</th><th>付费率</th><th>ARPU</th><th>充值人数</th><th>充值金额</th><th>付费率</th><th>ARPU</th><th>充值人数</th><th>充值金额</th><th>付费率</th><th>ARPU</th><th>充值人数</th><th>充值金额</th><th>付费率</th><th>ARPU</th><th>充值人数</th><th>充值金额</th><th>付费率</th><th>ARPU</th></tr>
					<c:forEach items="${dailyList}" var="item">
						<tr>
							<td>${item.log_day}</td>
							<td>${item.income}</td>
							
							<td>${item.first_day_dpa}</td>
							<td>${item.first_day_income}</td>
							<td>${item.first_day_pay_rate}</td>
							<td>${item.first_day_arpu}</td>
							
							<td>${item.third_day_dpa}</td>
							<td>${item.third_day_income}</td>
							<td>${item.third_day_pay_rate}</td>
							<td>${item.third_day_arpu}</td>
							
							<td>${item.seventh_day_dpa}</td>
							<td>${item.seventh_day_income}</td>
							<td>${item.seventh_day_pay_rate}</td>
							<td>${item.seventh_day_arpu}</td>
							
							<td>${item.nn_pa}</td>
							<td>${item.nn_pay_value}</td>
							<td>${item.nn_pay_rate}</td>
							<td>${item.nn_arpu}</td>
							
							<td>${item.on_pa}</td>
							<td>${item.on_pay_value}</td>
							<td>${item.on_pay_rate}</td>
							<td>${item.on_arpu}</td>
							
							<td>${item.oo_pa}</td>
							<td>${item.oo_pay_value}</td>
							<td>${item.oo_pay_rate}</td>
							<td>${item.oo_arpu}</td>
						</tr>
					</c:forEach>
				</table>
				</div>
			</div>
		</div>
		<div class="row-fluid">
			<div class="span6 panel panel-primary">
				<div class="panel-heading">分平台充值统计</div>
				<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
				<table id="dailyTable" class="table table-striped table-bordered table-condensed">
					<tr><th>日期</th><th>平台</th><th>活跃人数</th><th>充值人数</th><th>充值金额</th><th>付费率</th><th>APRU</th><th>活跃APRU</th></tr>
					<c:forEach items="${dailyPlatFormList}" var="item">
						<tr>
							<td>${item.log_day}</td>
							<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
							<td>${item.dau}</td>
							<td>${item.dpa}</td>
							<td>${item.income}</td>
							<td>${item.pay_rate}</td>
							<td>${item.arpu}</td>
							<td>${item.active_arpu}</td>
						</tr>
					</c:forEach>
				</table>
				</div>
			</div>
			<div class="span6 panel panel-primary">
				<div class="panel-heading">平台充值金额饼图（多天数据累加）</div>
				<div style="height: 300px;line-height: 300px">
					<div class="highchart-income-pie" style="height: 300px"></div>
					<table class="highchart table"
						   data-graph-container=".highchart-income-pie" data-graph-type="pie" data-graph-pie-show-in-legend="1" data-graph-datalabels-enabled="1" style="display: none">
						<caption>平台收入比例</caption>
						<thead>
						<tr>
							<th data-graph-type="pie">平台</th>
							<th data-graph-type="pie">金额</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${mapList}" var="item">
							<tr>
								<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
								<td data-graph-name="${fns:getGamePlatformNameById(item.pid,item.pid)} : ${item.income}">${item.income}</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	</div>
<script type="text/javascript">
	$(document).ready(function(){
		$('table.highchart').highchartTable();
	});
</script>

</body>
</html>