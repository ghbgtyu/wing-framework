<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>活动面板消费分布</title>
	<meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/highcharts.jsp" %>
	<script src="${ctxStatic}/common/fixtable.js" type="text/javascript"></script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/global/tradeController/activePanelDistribution">活动面板消费分布</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/global/tradeController/activePanelDistribution" method="post" class="breadcrumb form-search">
		
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
				<div class="panel-heading">活动面板消费分布（元宝）</div>
				<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
				<table id="active-yb" class="table table-striped table-bordered table-condensed">
					<tr><th>时间段</th><th>活动面板</th><th>元宝消耗</th><th>消耗占比(%)</th><th>消费人数</th><th>人数占比(%)</th></tr>
					<c:forEach items="${activeList}" var="item">
						<tr>
							<td>${createDateStart } ~ ${createDateEnd }</td>
							<td>面板${item.active_panel }</td>
							<td>${item.yb }</td>
							<td><c:if test="${totalYb > 0 }"><fmt:formatNumber  value="${item.yb*100/totalYb }" pattern="#0.00"/> %</c:if></td>
							<td>${item.num }</td>
							<td><c:if test="${ybNum > 0 }"><fmt:formatNumber  value="${item.num*100/ybNum }" pattern="#0.00"/> %</c:if> </td>
						</tr>
					</c:forEach>
					<tr>
					  <td style="font-weight: bold;">总计</td>
					  <td></td>
					  <td>${totalYb }</td>
					  <td>100%</td>
					  <td>${ybNum }</td>
					  <td>100%</td>
					</tr>
				</table>
				</div>
			</div>
		</div>
		
		<div class="row-fluid">
			<div class="span12 panel panel-primary">
				<div class="panel-heading">活动面板消费分布（绑定元宝）</div>
				<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
				<table id="active-bind-yb" class="table table-striped table-bordered table-condensed">
					<tr><th>时间段</th><th>活动面板</th><th>绑定元宝消耗</th><th>消耗占比(%)</th><th>消费人数</th><th>人数占比(%)</th></tr>
					<c:forEach items="${activeList}" var="item">
						<tr>
							<tr>
							<td>${createDateStart } ~ ${createDateEnd }</td>
							<td>面板${item.active_panel }</td>
							<td>${item.bind_yb }</td>
							<td><c:if test="${totalBind > 0 }"><fmt:formatNumber value="${item.bind_yb*100/totalBind }" pattern="#0.00"/>%</c:if></td>
							<td>${item.bind_num }</td>
							<td><c:if test="${bindNum > 0 }"><fmt:formatNumber value="${item.bind_num*100/bindNum }" pattern="#0.00"/>%</c:if></td>
						</tr>
					</c:forEach>
					<tr>
					  <td style="font-weight: bold;">总计</td>
					  <td></td>
					  <td>${totalBind }</td>
					  <td>100%</td>
					  <td>${bindNum }</td>
					  <td>100%</td>
					</tr>
				</table>
				</div>
			</div>
		</div>
</body>
</html>