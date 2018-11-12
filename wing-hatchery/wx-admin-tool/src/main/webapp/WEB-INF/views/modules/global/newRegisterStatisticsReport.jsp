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
		<li class="active"><a href="${ctx}/global/newRegisterStatistics/newRegisterStatisticsReport">新注册统计</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/global/newRegisterStatistics/newRegisterStatisticsReport" method="post" class="breadcrumb form-search">
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
			<div class="panel-heading">新注册总量时点分布 </div>
			<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
			<table id="contentTable" class="table table-striped table-bordered table-condensed">
				<thead>
				<tr><th>日期</th> <th>时间</th> <th>总注册数</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${newRegister}" var="item">
					<tr>
						<td>${item.log_day}</td>
						<td>${item.log_hour}:00</td>
						<td>${item.ru}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			</div>
			</div>

			<div class="span6 panel panel-primary">
			<div class="panel-heading">服务器新注册统计</div>
			<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
			<table id="contentTable" class="table table-striped table-bordered table-condensed">
				<thead>
				<tr><th>日期</th> <th>平台名 </th> <th>服务器 </th><th>新注册用户数 </th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${serverNewRegister}" var="item">
					<tr>
						<td>${item.log_day}</td>
						<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
						<td>${item.area_id}</td>
						<td>${item.sum_register}</td>
					</tr>
				</c:forEach>
				<tr>
					<td style="font-weight: bolder;">总计:</td>
					<td>${pidNum }</td>
					<td>${serverNum }</td>
					<td>${sumRu }</td>
				</tr>
				</tbody>
			</table>
			</div>
			</div>
		</div>
	</div>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span6 panel panel-primary">
				<div class="panel-heading">隔周对比曲线图</div>
				<div style="height: 300px;line-height: 300px">
					<div  class="highchart-daysActive" style="height: 300px"></div>
					<table class="highchart table"
						   data-graph-container=".highchart-daysActive" data-graph-type="spline"
						   data-graph-yaxis-1-title-text = '注册人数' data-graph-zoom-type="xy" style="display: none">
						<caption>隔周对比</caption>
						<thead>
						<tr>
							<th>日期</th>
							<th data-graph-type="line">注册人数</th>
							<th data-graph-type="line">同期上周注册人数</th>
						</tr>
						</thead>
						<tbody>
							<c:forEach items="${newRegister}" var="item">
								<tr>
									<td><fmt:formatNumber value="${item.log_hour}" pattern="0.00"/></td>
									<td>${item.ru}</td>
									<td>${item.sum_register_weekbefore}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
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