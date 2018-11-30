<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>在线数据时点分布</title>
	<meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/highcharts.jsp" %>
	<script src="${ctxStatic}/common/fixtable.js" type="text/javascript"></script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/global/onlinedata/onlinePointDisList">在线数据时点分布</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/global/onlinedata/onlinePointDisList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		
		<label>日期选择：</label>
	    <input name="paday" style="width: 216px" readonly="readonly" value="${paramMap.paday}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
	    <label>服务器：</label>
	    <input id="serverIds" name="serverIds" value="${paramMap.serverIdList}" readonly="readonly"/>
		<input type="button" class="btn btn-primary" value="选择服务器" onclick="openSeverDialog();">
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" onclick="return page();"/>
	</form>
	<tags:message content="${message}"/>
	 
		
		<div class="row-fluid">
			<div class="span12 panel panel-primary">
				<div class="panel-heading">在线数据时点分布</div>
				<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
				<table id="online-point" class="table table-striped table-bordered table-condensed">
					<tr><th>日期</th><th>时间</th><th>在线数</th></tr>
					<c:forEach items="${list}" var="item">
						<tr>
							<td>${item.logDay}</td>
							<td>${item.logHour }</td>
							<td>${item.onlineCount } </td>
						</tr>
					</c:forEach>
				</table>
				</div>
			</div>
		</div>
	
		<div class="row-fluid">
		 <div class="span12 panel panel-primary">
				<div class="panel-heading">时点在线对比图（7天前）</div>
				<div style="height: 300px;line-height: 300px">
					<div class="highchart-newactive" style="height: 300px"></div>
					<table class="highchart table"
					    data-graph-container=".highchart-newactive" data-graph-type="spline"
						   data-graph-yaxis-1-title-text = '人数' style="display: none" >
						<caption>时点在线对比图（7天前）</caption>
						<thead>
						<tr>
							<th>时间点</th>
							<th>${after }</th>
							<th>${paday }</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${compare}" var="item" varStatus="status">
							<tr>
								<td>${fn:substring(item.log_day,1,3)}</td>
								<td>${item.befor}</td>
								<td>${item.after}</td>
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