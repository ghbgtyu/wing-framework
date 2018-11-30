<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>开服回本数据</title>
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
	<style type="text/css">
		span.input-group-btn {
			display: none;
		}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/global/openServiceIncome/openServiceIncomeMany">开服回本数据 (平台多选)</a></li>
		<li><a href="${ctx}/global/openServiceIncome/openServiceIncomeSingle">开服回本数据 (平台单选)</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/global/openServiceIncome/openServiceIncomeMany" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		
		<label>时间 ：</label>
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
		<tr><th>日期</th>	<th>平台</th>	<th>创角页新增访问</th>	<th>导量成本</th>	<th>首日充值</th>
			<th>回款率</th>	<th>三日充值</th>	<th>回款率</th>	<th>七日充值</th>	<th>回款率</th>
			<th>十日充值</th>	<th>回款率</th>	<th>十四日充值</th>	<th>回款率</th>	<th>三十日充值</th>
			<th>回款率</th>	<th>六十日充值</th>	<th>回款率</th>	<th>九十日充值</th>	<th>回款率</th></tr>
		</thead>
		<tbody>
		<c:forEach items="${openManyServiceIncome.list}" var="item">
			<tr>
				<td>${createDateStart}-${createDateEnd}</td>
				<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
				<td>${item.sum_pv}</td>
				<td>${item.cpa_cost}</td>
				<td>${item.income_1}</td>

				<td><fmt:formatNumber value="${item.income_back_rate1}" pattern="0.00"></fmt:formatNumber></td>
				<td>${item.income_3}</td>
				<td><fmt:formatNumber value="${item.income_back_rate3}" pattern="0.00"></fmt:formatNumber></td>
				<td>${item.income_7}</td>
				<td><fmt:formatNumber value="${item.income_back_rate7}" pattern="0.00"></fmt:formatNumber></td>

				<td>${item.income_10}</td>
				<td><fmt:formatNumber value="${item.income_back_rate10}" pattern="0.00"></fmt:formatNumber></td>
				<td>${item.income_14}</td>
				<td><fmt:formatNumber value="${item.income_back_rate14}" pattern="0.00"></fmt:formatNumber></td>
				<td>${item.income_30}</td>

				<td><fmt:formatNumber value="${item.income_back_rate30}" pattern="0.00"></fmt:formatNumber></td>
				<td>${item.income_60}</td>
				<td><fmt:formatNumber value="${item.income_back_rate60}" pattern="0.00"></fmt:formatNumber></td>
				<td>${item.income_90}</td>
				<td><fmt:formatNumber value="${item.income_back_rate90}" pattern="0.00"></fmt:formatNumber></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${openManyServiceIncome}</div>

</body>
</html>