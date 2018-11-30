<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>实时分服统计</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/highcharts.jsp" %>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/log/realTimeService/realTimeServiceReport">实时分服统计</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/log/realTimeService/realTimeServiceReport" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

		<label>时间 ：</label>
		<input name="createDateStart" id="createTimeStart" maxlength="50"  value="${paramMap.createDateStart}" class="input-small required" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH'})"/>
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" onclick="return page();"/>
	</form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr><th>统计时间</th> <th>平台</th> <th>服务器</th> <th>新注册</th> <th>日登录</th>
			<th>当前在线</th> <th>充值人数</th><th>充值次数</th> <th>充值金额</th> <th>付费率</th> <th>ARPU</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="item">
			<tr>
				<td>${item.log_minute}</td>
				<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
				<td>${item.area_id}</td>
				<td>${item.ru}</td>
				<td>${item.au}</td>
				<td>${item.num}</td>
				<td>${item.pa}</td>
				<td>${item.pay_times}</td>
				<td>${item.income}</td>
				<td>${item.pay_rate}</td>
				<td>${item.arpu}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>

	
	
	<script type="text/javascript">
		$(document).ready(function(){
// 			$('table.highchart').highchartTable();
		});
	</script>

</body>
</html>