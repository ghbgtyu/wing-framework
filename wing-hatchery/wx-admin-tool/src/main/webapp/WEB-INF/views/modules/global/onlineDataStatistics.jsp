<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>在线数据统计</title>
	<meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/highcharts.jsp" %>
	<script src="${ctxStatic}/common/fixtable.js" type="text/javascript"></script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/global/onlinedata/onlineDataStatistics">在线数据统计</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/global/onlinedata/onlineDataStatistics" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		
		<label>日期选择：</label>
	     <input type="text" name="createDateStart" class="input_search" size="10" readonly="readonly" maxlength="20" value="${paramMap.createDateStart}" id="startDatePicker" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
		-&nbsp;<input type="text" name="createDateEnd"   class="input_search" size="10" readonly="readonly" value="${paramMap.createDateEnd}"   id="endDatePicker" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">
		<label>服务器：</label>
	    <input id="serverIds" name="serverIds" value="${paramMap.serverIdList}" readonly="readonly"/>
		<input type="button" class="btn btn-primary" value="选择服务器" onclick="openSeverDialog();">
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" onclick="return page();"/>
	</form>
	<tags:message content="${message}"/>
	 <div class="row-fluid">
	 <div class="span12 panel panel-primary">
				<div class="panel-heading">最高在线及平均在线</div>
				<div style="height: 300px;line-height: 300px">
					<div class="highchart-accupccu" style="height: 300px"></div>
					<table class="highchart table"
						   data-graph-container=".highchart-accupccu" data-graph-type="spline"
						   data-graph-yaxis-1-title-text = '最高在线和平均在线'  style="display: none">
						<caption>平均及最高在线</caption>
						<thead>
						<tr>
							<th>日期</th>
							<th>平均在线</th>
							<th>最高在线</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${list}" var="item">
							<tr>
								<td>${item.log_day}</td>
								<td>${item.hight}</td>
								<td>${item.avg}</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
</div>
	
		<div class="row-fluid">
			<div class="span12 panel panel-primary">
				<div class="panel-heading">最高在线和平均在线详情</div>
				<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
				<table id="online-date" class="table table-striped table-bordered table-condensed ">
					<tr><th>日期</th><th>最高在线</th><th>平均在线</th><th>平高比(%)</th></tr>
					<c:forEach items="${list}" var="item">
						<tr>
							<td>${item.log_day}</td>
							<td>${item.hight}</td>
							<td>${item.avg}</td>
							<td><c:if test="${item.hight > 0}">
							<fmt:parseNumber value="${item.avg*100/item.hight}" pattern="#0.00"/>%
							</c:if>
							</td>
						</tr>
					</c:forEach>
				</table>
				</div>
			</div>
		</div>
	
<script type="text/javascript">
	$(document).ready(function(){
		$('table.highchart').highchartTable();
	});
</script>
</body>_
</html>