<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>平台充值消费统计</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/highcharts.jsp" %>
	<style type="text/css">
		span.input-group-btn {
			display: none;
		}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/global/platformRechargeConsume/platformRechargeConsume">平台充值统计 </a></li>
		<li><a href="${ctx}/global/platformRechargeConsume/platformRechargeTimePeriod">平台充值时段统计</a></li>
		<li><a href="${ctx}/global/platformRechargeConsume/platformConsume">平台消费统计</a></li>
		<li><a href="${ctx}/global/platformRechargeConsume/platformConsumeTimePeriod">平台消费时段统计 </a></li>
	</ul>
	<form id="searchForm" action="${ctx}/global/platformRechargeConsume/platformRechargeConsume" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		
		<input type="text" name="createDateStart" class="input_search" size="10" readonly="readonly" maxlength="20" value="${paramMap.createDateStart}" id="startDatePicker" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
		-&nbsp;<input type="text" name="createDateEnd"   class="input_search" size="10" readonly="readonly" value="${paramMap.createDateEnd}"   id="endDatePicker" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">
		<label>平台 ：</label>
		<!-- 默认为全部选中，查询后页面跳转，记录的是上次选中的服务器选项 -->
		<select id="pids" name="pids" multiple="multiple">
			<c:forEach items="${fns:getGamePlatformList()}" var="item">
				<c:choose>
					<c:when test="${fn:length(selectedPids)==0}">
						<option value="${item.pid}" >${item.name}</option>
					</c:when>
					<c:otherwise>
					<option value="${item.pid}" 
						<c:forEach items="${selectedPids}" var="pid">
							<c:if test="${pid==item.pid}">
								selected="selected"
							</c:if>
						</c:forEach>
					>${item.name}</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select>
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" onclick="return page();"/>
	</form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr><th>日期</th>	<th>平台</th>	<th>活跃用户数</th>	<th>充值金额</th>	<th>充值用户数</th>
			<th>付费率</th>	<th>ARPU</th>	<th>活跃ARPU</th>	<th>新新充值用户</th>	<th>新新充值金额</th>
			<th>新新付费率</th>	<th>新新ARPU</th>	<th>老新充值用户</th>	<th>老新充值金额</th>	<th>老新付费率</th>
			<th>老新ARPU</th>	<th>老充值用户</th>	<th>老充值金额</th>	<th>老付费率</th>	<th>老ARPU</th>
		</tr>
		</thead>
		<tbody>
			<c:forEach items="${platformRecharge.list}" var="item">
				<tr>
					<td>${item.log_day}</td>
					<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
					<td>${item.dau}</td>
					<td>${item.income}</td>
					<td>${item.dpa}</td>
					
					<td><fmt:formatNumber type="percent" value="${item.dpa_dau}"/></td>
					<td>${item.income_dpa}</td>
					<td>${item.income_dau}</td>
					<td>${item.nn_pa}</td>
					<td>${item.nn_pay_value}</td>
					
					<td><fmt:formatNumber type="percent" value="${item.nn_pa_dau}"/></td>
					<td>${item.nn_pay_value_nn_pa}</td>
					<td>${item.on_pa}</td>
					<td>${item.on_pay_value}</td>
					<td><fmt:formatNumber type="percent" value="${item.on_pa_dau}"/></td>
					
					<td>${item.on_pay_value_on_pa}</td>
					<td>${item.oo_pa}</td>
					<td>${item.oo_pay_value}</td>
					<td><fmt:formatNumber type="percent" value="${item.oo_pa_dau}"/></td>
					<td>${item.oo_pay_value_oo_pa}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${platformRecharge}</div>

	
	<script type="text/javascript">
		$(document).ready(function(){
			$('table.highchart').highchartTable();
			$("#s2id_pids").hide();
			$("#pids").multiselect({
				includeSelectAllOption:true,
				enableFiltering:true
			});
		});
	</script>

</body>
</html>