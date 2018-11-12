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
		<li class="active"><a href="${ctx}/global/onlineTime/onlineTimeReport">每日用户在线时长</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/global/onlineTime/onlineTimeReport" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

		<label>时间 ：</label>
		<input name="createDateStart" id="createTimeStart" maxlength="50"  value="${paramMap.createDateStart}" class="input-small required" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
		<label>服务器：</label>
	    <input id="serverIds" name="serverIds" value="${paramMap.serverIdList}" readonly="readonly"/>
		<input type="button" class="btn btn-primary" value="选择服务器" onclick="openSeverDialog();">
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" onclick="return page();"/>
	</form>
	<tags:message content="${message}"/>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span6 panel panel-primary">
			<div class="panel-heading">每日用户在线时长</div>
			<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
				<table id="contentTable" class="table table-striped table-bordered table-condensed">
					<thead>
					<tr><th>日期</th> <th>等级</th> <th>在线用户数</th> <th>总在线时长(分钟)</th> <th>平均在线时长</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach items="${onlineTime}" var="item">
						<tr>
							<td>${item.log_day}</td>
							<td>${item.level}</td>
							<td>${item.num}</td>
							<td>${item.tot}</td>
							<td><fmt:formatNumber value="${item.dt}" pattern="0.00"/></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
			</div>
			<div class="span6 panel panel-primary">
				<div class="panel-heading">在线时长区间分布图</div>
				<div style="height: 300px;line-height: 300px">
					<div  class="highchart-userRate" style="height: 300px"></div>
					<table class="highchart table"
						   data-graph-container=".highchart-userRate" data-graph-type="pie" data-graph-pie-show-in-legend="1" data-graph-datalabels-enabled="1" style="display: none">
						<caption>用户人数比例</caption>
						<thead>
						<tr>
							<th>注册人数</th>
							<th>时间：百分比</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${onlineTimeArea}" var="item">
							<tr>
								<td>${item.time}分钟</td>
								<td data-graph-name='${item.time} 分钟 : <fmt:formatNumber type="percent" value="${item.num/sumNum}"/>'><fmt:formatNumber type="percent" value="${item.num/sumNum}"/></td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<div class="panel panel-primary">
			<div class="panel-heading">在线时长等级分布</div>
			<div style="height: 300px;line-height: 300px">
				<div  class="highchart-onLineTimeLevel" style="height: 300px"></div>
				<table class="highchart table"
					   data-graph-container=".highchart-onLineTimeLevel" data-graph-type="line"
					   data-graph-yaxis-1-title-text = '时长(分钟)' data-graph-zoom-type="xy" style="display: none">
					<caption>在线时长等级分布</caption>
					<thead>
					<tr>
						<th>等级</th>
						<th data-graph-type="column">平均时长</th>
						<th data-graph-type="line">总时长</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach items="${onlineTimeLevel}" var="item">
						<tr>
							<td>${item.level} 级</td>
							<td><fmt:formatNumber value="${item.per_dt}" pattern="0.00"/> 分钟</td>
							<td>${item.sum_tot}</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<div class="panel panel-primary">
			<div class="panel-heading">在线时长区间人数分布</div>
			<div style="height: 300px;line-height: 300px">
				<div  class="highchart-onLineTimeUserNum" style="height: 300px"></div>
				<table class="highchart table"
					   data-graph-container=".highchart-onLineTimeUserNum" data-graph-type="column"
					   data-graph-yaxis-1-title-text = '注册人数' data-graph-zoom-type="xy" style="display: none">
					<caption>在线时长区间人数分布</caption>
					<thead>
					<tr>
						<th>时间</th>
						<th>用户人数</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach items="${onlineTimeArea}" var="item">
						<tr>
							<td>${item.time}分钟</td>
							<td>${item.num}人</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
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