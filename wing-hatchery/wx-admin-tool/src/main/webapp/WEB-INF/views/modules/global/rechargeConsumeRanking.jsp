<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>充值消费排行</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/highcharts.jsp" %>
	<style type="text/css">
        .SortDescCss{background-image:url(Asc.gif);background-repeat:no-repeat;background-position:right center;}
        .SortAscCss{background-image:url(${ctxStatic}/images/Asc.gif);background-repeat:no-repeat;background-position:right center;}
    </style>
    <script src="${ctxStatic}/common/TableSorterV2.js"></script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/global/rechargeConsume/rechargeConsumeRanking">充值消费排行</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/global/rechargeConsume/rechargeConsumeRanking" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

		<label>时间 ：</label>
		<input type="text" name="createDateStart" class="input_search" size="10" readonly="readonly" maxlength="20" value="${paramMap.createDateStart}" id="startDatePicker" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
		-&nbsp;<input type="text" name="createDateEnd"   class="input_search" size="10" readonly="readonly" value="${paramMap.createDateEnd}"   id="endDatePicker" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">
		<label>服务器：</label>
	    <input id="serverIds" name="serverIds" value="${paramMap.serverIdList}" readonly="readonly"/>
		<input type="button" class="btn btn-primary" value="选择服务器" onclick="openSeverDialog();">
		&nbsp;
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" onclick="return page();"/>
		<br>
		<input type="hidden" id="hidden1" name="hidden1" value="${paramMap.jeValue}">
		<input type="radio" id="jeValue" name="jeValue" value="0">0+
		<input type="radio" id="jeValue" name="jeValue" value="500" checked="checked">500+
		<input type="radio" id="jeValue" name="jeValue" value="1000">1000+
		<input type="radio" id="jeValue" name="jeValue" value="2000">2000+
		<input type="radio" id="jeValue" name="jeValue" value="5000">5000+
		<input type="radio" id="jeValue" name="jeValue" value="10000">10000+
		<input type="radio" id="jeValue" name="jeValue" value="20000">20000+
		<input type="radio" id="jeValue" name="jeValue" value="50000">50000+
		<input type="radio" id="jeValue" name="jeValue" value="100000">100000+
	</form>
	<tags:message content="${message}"/>
	
	<div class="container-fluid">
	<div class="row-fluid">
	<div class="span6 panel panel-primary">
		<div class="panel-heading">单服充值排行</div>
		<table id="contentTable1" class="datatable table table-striped table-bordered table-condensed" style="overflow: scroll">
			<thead>
			<tr><th>时间段</th><th>平台</th><th>服务器</th><th>充值人数</th><th>充值金额</th><th>ARPU</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${tableList1}" var="item">
				<tr>
					<td>${fn:substring(paramMap.createDateStart,"5","10")}~${fn:substring(paramMap.createDateEnd,"5","10")}</td>
					<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
					<td>${item.area_id}</td>
					<td>${item.pa}</td>
					<td>${item.s_income}</td>
					<td>${item.arpu}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div class="span6 panel panel-primary">
		<div class="panel-heading">平台充值排行</div>
		<table id="contentTable2" class="datatable table table-striped table-bordered table-condensed" style="overflow: scroll">
			<thead>
			<tr><th>时间段</th><th>平台</th><th>充值人数</th><th>充值金额</th><th>ARPU</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${tableList2}" var="item">
				<tr>
					<td>${fn:substring(paramMap.createDateStart,"5","10")}~${fn:substring(paramMap.createDateEnd,"5","10")}</td>
					<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
					<td>${item.pa}</td>
					<td>${item.s_income}</td>
					<td>${item.arpu}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	</div>
	</div>
	
	<div class="container-fluid">
	<div class="row-fluid">
	<div class="span6 panel panel-primary">
		<div class="panel-heading">单服消费排行</div>
		<table id="contentTable3" class="datatable table table-striped table-bordered table-condensed" style="overflow: scroll">
			<thead>
			<tr><th>时间段</th><th>平台</th><th>服务器</th><th>消费人数</th><th>消费金额</th><th>ARPU</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${tableList3}" var="item">
				<tr>
					<td>${fn:substring(paramMap.createDateStart,"5","10")}~${fn:substring(paramMap.createDateEnd,"5","10")}</td>
					<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
					<td>${item.area_id}</td>
					<td>${item.num}</td>
					<td>${item.s_amount}</td>
					<td>${item.arpu}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div class="span6 panel panel-primary">
		<div class="panel-heading">平台消费排行</div>
		<table id="contentTable4" class="datatable table table-striped table-bordered table-condensed" style="overflow: scroll">
			<thead>
			<tr><th>时间段</th><th>平台</th><th>消费人数</th><th>消费金额</th><th>ARPU</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${tableList4}" var="item">
				<tr>
					<td>${fn:substring(paramMap.createDateStart,"5","10")}~${fn:substring(paramMap.createDateEnd,"5","10")}</td>
					<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
					<td>${item.num}</td>
					<td>${item.s_amount}</td>
					<td>${item.arpu}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	</div>
	</div>
	
	<div class="container-fluid">
	<div class="row-fluid">
	<div class="span6 panel panel-primary">
		<div class="panel-heading">单服消费排行(绑元)</div>
		<table id="contentTable5" class="datatable table table-striped table-bordered table-condensed" style="overflow: scroll">
			<thead>
			<tr><th>时间段</th><th>平台</th><th>服务器</th><th>消费人数</th><th>消费金额</th><th>ARPU</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${tableList5}" var="item">
				<tr>
					<td>${fn:substring(paramMap.createDateStart,"5","10")}~${fn:substring(paramMap.createDateEnd,"5","10")}</td>
					<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
					<td>${item.area_id}</td>
					<td>${item.num}</td>
					<td>${item.s_amount}</td>
					<td>${item.arpu}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div class="span6 panel panel-primary">
		<div class="panel-heading">平台消费排行(绑元)</div>
		<table id="contentTable6" class="datatable table table-striped table-bordered table-condensed" style="overflow: scroll">
			<thead>
			<tr><th>时间段</th><th>平台</th><th>消费人数</th><th>消费金额</th><th>ARPU</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${tableList6}" var="item">
				<tr>
					<td>${fn:substring(paramMap.createDateStart,"5","10")}~${fn:substring(paramMap.createDateEnd,"5","10")}</td>
					<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
					<td>${item.num}</td>
					<td>${item.s_amount}</td>
					<td>${item.arpu}</td>
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
		new TableSorter("contentTable1");
		new TableSorter("contentTable2");
		new TableSorter("contentTable3");
		new TableSorter("contentTable4");
		new TableSorter("contentTable5");
		new TableSorter("contentTable6");
		var radioVal = $("#hidden1").val();
		if (radioVal==500) {
			$("input[id=jeValue][value=500]").attr("checked",true);
		} else if(radioVal==1000){
			$("input[id=jeValue][value=1000]").attr("checked",true);
		} else if(radioVal==2000){
			$("input[id=jeValue][value=2000]").attr("checked",true);
		} else if(radioVal==5000){
			$("input[id=jeValue][value=5000]").attr("checked",true);
		} else if(radioVal==10000){
			$("input[id=jeValue][value=10000]").attr("checked",true);
		}  else if(radioVal==20000){
			$("input[id=jeValue][value=20000]").attr("checked",true);
		} else if(radioVal==50000){
			$("input[id=jeValue][value=50000]").attr("checked",true);
		} else if(radioVal==100000){
			$("input[id=jeValue][value=100000]").attr("checked",true);
		} else if(radioVal==0){
			$("input[id=jeValue][value=0]").attr("checked",true);
		}
	
	});
</script>

</body>
</html>