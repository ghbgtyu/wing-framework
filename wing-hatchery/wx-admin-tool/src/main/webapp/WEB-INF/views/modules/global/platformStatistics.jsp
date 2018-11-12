<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>平台统计页</title>
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
		<li class="active"><a href="${ctx}/global/platformStatistics/platformStatistics">平台统计页</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/global/platformStatistics/platformStatistics" method="post" class="breadcrumb form-search">
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

	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span6 panel panel-primary">
				<div class="panel-heading">平台充值统计</div>
				<div style="height: 300px;line-height: 300px">
					<div class="highchart-income-pie" style="height: 300px"></div>
					<table class="highchart table"
						   data-graph-container=".highchart-income-pie" data-graph-type="pie" data-graph-pie-show-in-legend="1" data-graph-datalabels-enabled="1" style="display: none">
						<caption>各平台收入比例</caption>
						<thead>
						<tr>
							<th data-graph-type="pie">平台</th>
							<th data-graph-type="pie">占比</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${statisticsList}" var="item">
							<tr>
								<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
								<td data-graph-name="${fns:getGamePlatformNameById(item.pid,item.pid)} : <fmt:formatNumber type="percent" value="${item.p_income}"/>"><fmt:formatNumber type="percent" value="${item.p_income}"/></td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			
			<div class="span6 panel panel-primary">
				<div class="panel-heading">平台充值统计-报表</div>
				<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
				<table id="dailyTable" class="table table-striped table-bordered table-condensed">
					<tr><th>时间段</th><th>平台名</th><th>充值</th><th>占比</th><th>环比（前）</th><th>环比（后）</th></tr>
					<c:forEach items="${statisticsList}" var="item">
						<tr>
							<td>${fn:substring(paramMap.createDateStart,"5","10")}~${fn:substring(paramMap.createDateEnd,"5","10")}</td>
							<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
							<td>${item.income}</td>
							<td><fmt:formatNumber  value="${item.p_income*100}" pattern="#0.00"/>%</td>
							<td><fmt:formatNumber  value="${item.p_income_before*100}" pattern="#0.00"/>%</td>
							<td><fmt:formatNumber  value="${item.p_income_after*100}" pattern="#0.00"/>%</td>
						</tr>
					</c:forEach>
				</table>
				</div>
			</div>
		</div>

		<div class="row-fluid">
			<div class="span6 panel panel-primary">
				<div class="panel-heading">平台导量统计</div>
				<div style="height: 300px;line-height: 300px">
					<div class="highchart-dru-pie" style="height: 300px"></div>
					<table class="highchart table"
						   data-graph-container=".highchart-dru-pie" data-graph-type="pie" data-graph-pie-show-in-legend="1" data-graph-datalabels-enabled="1" style="display: none">
						<caption>各平台导量比例</caption>
						<thead>
						<tr>
							<th data-graph-type="pie">平台</th>
							<th data-graph-type="pie">占比</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${statisticsList}" var="item">
							<tr>
								<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
								<td data-graph-name="${fns:getGamePlatformNameById(item.pid,item.pid)} : <fmt:formatNumber type="percent" value="${item.p_dru}"/>"><fmt:formatNumber type="percent" value="${item.p_dru}"/></td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<div class="span6 panel panel-primary">
				<div class="panel-heading">平台导量统计-报表</div>
				<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
				<table id="dailyTable" class="table table-striped table-bordered table-condensed">
					<tr><th>时间段</th><th>平台名</th><th>导量</th><th>导量占比</th><th>环比（前）</th><th>环比（后）</th><th>开服数</th><th>开服数占比</th><th>环比（前）</th><th>环比（后）</th></tr>
					<c:forEach items="${statisticsList}" var="item">
						<tr>
							<td>${fn:substring(paramMap.createDateStart,"5","10")}~${fn:substring(paramMap.createDateEnd,"5","10")}</td>
							<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
							<td>${item.dru}</td>
							<td><fmt:formatNumber  value="${item.p_dru*100}" pattern="#0.00"/>%</td>
							<td><fmt:formatNumber  value="${item.p_dru_before*100}" pattern="#0.00"/>%</td>
							<td><fmt:formatNumber  value="${item.p_dru_after*100}" pattern="#0.00"/>%</td>
							<td>${item.kaifu}</td>
							<td><fmt:formatNumber  value="${item.p_kaifu*100}" pattern="#0.00"/>%</td>
							<td><fmt:formatNumber  value="${item.p_kaifu_before*100}" pattern="#0.00"/>%</td>
							<td><fmt:formatNumber  value="${item.p_kaifu_after*100}" pattern="#0.00"/>%</td>
						</tr>
					</c:forEach>
				</table>
				</div>
			</div>
		</div>
		
		<div class="row-fluid">
			<div class="span6 panel panel-primary">
				<div class="panel-heading">平台活跃统计</div>
				<div style="height: 300px;line-height: 300px">
					<div class="highchart-au-pie" style="height: 300px"></div>
					<table class="highchart table"
						   data-graph-container=".highchart-au-pie" data-graph-type="pie" data-graph-pie-show-in-legend="1" data-graph-datalabels-enabled="1" style="display: none">
						<caption>各平台活跃比例</caption>
						<thead>
						<tr>
							<th data-graph-type="pie">平台</th>
							<th data-graph-type="pie">占比</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${activeStatisticsList}" var="item">
							<tr>
								<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
								<td data-graph-name="${fns:getGamePlatformNameById(item.pid,item.pid)} : <fmt:formatNumber type="percent" value="${item.p_au}"/>"><fmt:formatNumber type="percent" value="${item.p_au}"/></td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<div class="span6 panel panel-primary">
				<div class="panel-heading">平台活跃统计-报表</div>
				<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
				<table id="dailyTable" class="table table-striped table-bordered table-condensed">
					<tr><th>时间段</th><th>平台名</th><th>平台活跃</th><th>占比</th><th>环比（前）</th><th>环比（后）</th></tr>
					<c:forEach items="${activeStatisticsList}" var="item">
						<tr>
							<td>${fn:substring(paramMap.createDateStart,"5","10")}~${fn:substring(paramMap.createDateEnd,"5","10")}</td>
							<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
							<td>${item.au}</td>
							<td><fmt:formatNumber  value="${item.p_au*100}" pattern="#0.00"/>%</td>
							<td><fmt:formatNumber  value="${item.p_au_before*100}" pattern="#0.00"/>%</td>
							<td><fmt:formatNumber  value="${item.p_au_after*100}" pattern="#0.00"/>%</td>
						</tr>
					</c:forEach>
				</table>
				</div>
			</div>
		</div>
		
		<div class="row-fluid">
			<div class="span6 panel panel-primary">
				<div class="panel-heading">平台新用户注册转化率统计</div>
				<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
				<table id="dailyTable" class="table table-striped table-bordered table-condensed">
					<tr><th>时间段</th><th>平台名</th><th>创角页访问</th><th>创角数</th><th>创角率</th><th>环比（前）</th><th>环比（后）</th></tr>
					<c:forEach items="${regConvertionList}" var="item">
						<tr>
							<td>${fn:substring(paramMap.createDateStart,"5","10")}~${fn:substring(paramMap.createDateEnd,"5","10")}</td>
							<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
							<td>${item.visit_times}</td>
							<td>${item.role_num}</td>
							<td><fmt:formatNumber  value="${item.create_role_rate*100}" pattern="#0.00"/>%</td>
							<td><fmt:formatNumber  value="${item.p_role_num_before*100}" pattern="#0.00"/>%</td>
							<td><fmt:formatNumber  value="${item.p_role_num_after*100}" pattern="#0.00"/>%</td>
						</tr>
					</c:forEach>
				</table>
				</div>
			</div>
		</div>
		
		<div class="row-fluid">
			<div class="span6 panel panel-primary">
				<div class="panel-heading">平台消费统计</div>
				<div style="height: 300px;line-height: 300px">
					<div class="highchart-consume-pie" style="height: 300px"></div>
					<table class="highchart table"
						   data-graph-container=".highchart-consume-pie" data-graph-type="pie" data-graph-pie-show-in-legend="1" data-graph-datalabels-enabled="1" style="display: none">
						<caption>各平台消费比例</caption>
						<thead>
						<tr>
							<th data-graph-type="pie">平台</th>
							<th data-graph-type="pie">占比</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${statisticsList}" var="item">
							<tr>
								<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
								<td data-graph-name="${fns:getGamePlatformNameById(item.pid,item.pid)} : <fmt:formatNumber type="percent" value="${item.p_consume}"/>"><fmt:formatNumber type="percent" value="${item.p_consume}"/></td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<div class="span6 panel panel-primary">
				<div class="panel-heading">平台消费统计-报表</div>
				<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
				<table id="dailyTable" class="table table-striped table-bordered table-condensed">
					<tr><th>时间段</th><th>平台名</th><th>消费</th><th>占比</th><th>环比（前）</th><th>环比（后）</th></tr>
					<c:forEach items="${statisticsList}" var="item">
						<tr>
							<td>${fn:substring(paramMap.createDateStart,"5","10")}~${fn:substring(paramMap.createDateEnd,"5","10")}</td>
							<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
							<td>${item.consume}</td>
							<td><fmt:formatNumber  value="${item.p_consume*100}" pattern="#0.00"/>%</td>
							<td><fmt:formatNumber  value="${item.p_consume_before*100}" pattern="#0.00"/>%</td>
							<td><fmt:formatNumber  value="${item.p_consume_after*100}" pattern="#0.00"/>%</td>
						</tr>
					</c:forEach>
				</table>
				</div>
			</div>
		</div>
		
		<div class="row-fluid">
			<div class="span6 panel panel-primary">
				<div class="panel-heading">平台付费渗透率统计</div>
				<div style="height: 300px;line-height: 300px">
					<div  class="highchart-pay_rate" style="height: 300px"></div>
					<table class="highchart table"
						   data-graph-container=".highchart-pay_rate" data-graph-type="column" data-graph-xaxis-reversed="1"
						   data-graph-yaxis-1-title-text = '付费率' data-graph-zoom-type="xy" style="display: none">
						<caption>付费率</caption>
						<thead>
						<tr>
							<th>平台</th>
							<th data-graph-type="column">付费率</th>
						</tr>
						</thead>
						<tbody>
							<c:forEach items="${statisticsList}" var="item">
								<tr>
									<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
									<td><fmt:formatNumber  value="${item.pay_rate*100}" pattern="#0.00"/>%</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<div class="span6 panel panel-primary">
				<div class="panel-heading">平台付费渗透率统计-报表</div>
				<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
				<table id="dailyTable" class="table table-striped table-bordered table-condensed">
					<tr><th>时间段</th><th>平台名</th><th>付费率</th><th>环比（前）</th><th>环比（后）</th></tr>
					<c:forEach items="${statisticsList}" var="item">
						<tr>
							<td>${fn:substring(paramMap.createDateStart,"5","10")}~${fn:substring(paramMap.createDateEnd,"5","10")}</td>
							<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
							<td><fmt:formatNumber  value="${item.pay_rate*100}" pattern="#0.00"/>%</td>
							<td><fmt:formatNumber  value="${item.p_pay_rate_before*100}" pattern="#0.00"/>%</td>
							<td><fmt:formatNumber  value="${item.p_pay_rate_after*100}" pattern="#0.00"/>%</td>
						</tr>
					</c:forEach>
				</table>
				</div>
			</div>
		</div>
		
		<div class="row-fluid">
			<div class="span6 panel panel-primary">
				<div class="panel-heading">平台ARPU统计</div>
				<div style="height: 300px;line-height: 300px">
					<div  class="highchart-ARPU" style="height: 300px"></div>
					<table class="highchart table"
						   data-graph-container=".highchart-ARPU" data-graph-type="column" data-graph-xaxis-reversed="1"
						   data-graph-yaxis-1-title-text = 'ARPU' data-graph-zoom-type="xy" style="display: none">
						<caption>ARPU</caption>
						<thead>
						<tr>
							<th>平台</th>
							<th data-graph-type="column">ARPU</th>
						</tr>
						</thead>
						<tbody>
							<c:forEach items="${statisticsList}" var="item">
								<tr>
									<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
									<td><fmt:formatNumber  value="${item.arpu*100}" pattern="#0.00"/>%</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<div class="span6 panel panel-primary">
				<div class="panel-heading">平台ARPU统计-报表</div>
				<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
				<table id="dailyTable" class="table table-striped table-bordered table-condensed">
					<tr><th>时间段</th><th>平台名</th><th>ARPU</th><th>环比（前）</th><th>环比（后）</th></tr>
					<c:forEach items="${statisticsList}" var="item">
						<tr>
							<td>${fn:substring(paramMap.createDateStart,"5","10")}~${fn:substring(paramMap.createDateEnd,"5","10")}</td>
							<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
							<td>${item.arpu}</td>
							<td><fmt:formatNumber  value="${item.p_arpu_before*100}" pattern="#0.00"/>%</td>
							<td><fmt:formatNumber  value="${item.p_arpu_after*100}" pattern="#0.00"/>%</td>
						</tr>
					</c:forEach>
				</table>
				</div>
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
		$("#s2id_pids").hide();
		$("#pids").multiselect({
			includeSelectAllOption:true,
			enableFiltering:true
		});
	});
</script>

</body>
</html>