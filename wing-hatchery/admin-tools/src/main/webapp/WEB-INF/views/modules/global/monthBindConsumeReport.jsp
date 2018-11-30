<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>月消费数据（绑元）</title>
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
		<li class="active"><a href="${ctx}/global/rechargeConsume/monthBindConsumeReport">月消费统计</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/global/rechargeConsume/monthBindConsumeReport" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

		<label>时间 ：</label>
		<input name="createDateStart" id="createDateStart" maxlength="50"  value="${paramMap.createDateStart}" class="input-small required" readonly="readonly" onclick="selectMonth()"/>
		-
		<input name="createDateEnd" maxlength="50"  class="input-small required" value="${paramMap.createDateEnd}" readonly="readonly" onclick="selectMonth()"/>
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
			<div class="span12 panel panel-primary">
				<div class="panel-heading">新老服消费数据对比（绑元）</div>
				<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
				<table id="dailyTable" class="table table-striped table-bordered table-condensed">
					<tr><th>日期</th><th>开服数</th><th>收入</th><th>绑元产出</th><th>绑元总量</th><th>新注册</th><th>活跃用户</th><th>老用户数</th><th>消费用户</th><th>消费次数</th><th>消费金额</th><th>付费率</th><th>ARPU</th><th>活跃ARPU</th><th>首消费人数</th><th>首消费金额</th></tr>
					<c:forEach items="${monthList}" var="item">
						<tr>
							<td>${item.log_month}</td>
							<td>${item.kaifuNum}</td>
							<td>${item.amount}</td>
							<td>${item.total}</td>
							<td>${item.produce}</td>
							<td>${item.dru}</td>
							<td>${item.dau}</td>
							<td>${item.ou}</td>
							<td>${item.num}</td>
							<td>${item.times}</td>
							<td>${item.amount}</td>
							<td>${item.pay_rate}</td>
							<td>${item.arpu}</td>
							<td>${item.active_arpu}</td>
							<td>${item.first_num}</td>
							<td>${item.first_amount}</td>
						</tr>
					</c:forEach>
				</table>
				</div>
			</div>
		</div>
		<div class="row-fluid">
			<div class="span12 panel panel-primary">
				<div class="panel-heading">新老服消费数据对比</div>
				<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
				<table id="dailyTable" class="table table-striped table-bordered table-condensed">
					<tr><th>日期</th><th>总收入</th><th>新服活跃</th><th>新服消费人数</th><th>新服消费金额</th><th>新服付费率</th><th>新服ARPU</th><th>老服活跃</th><th>老服消费人数</th><th>老服消费金额</th><th>老服付费率</th><th>老服ARPU</th></tr>
					<c:forEach items="${monthList}" var="item">
						<tr>
							<td>${item.log_month}</td>
							<td>${item.amount}</td>
							
							<td>${item.month_new_dau}</td>
							<td>${item.month_new_num}</td>
							<td>${item.month_new_amount}</td>
							<td>${item.month_new_pay_rate}</td>
							<td>${item.month_new_arpu}</td>
							
							<td>${item.month_old_dau}</td>
							<td>${item.month_old_num}</td>
							<td>${item.month_old_amount}</td>
							<td>${item.month_old_pay_rate}</td>
							<td>${item.month_old_arpu}</td>
						</tr>
					</c:forEach>
				</table>
				</div>
			</div>
		</div>
		<div class="row-fluid">
			<div class="span6 panel panel-primary">
				<div class="panel-heading">平台消费数据对比（绑元）</div>
				<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
				<table id="dailyTable" class="table table-striped table-bordered table-condensed">
					<tr><th>日期</th><th>平台</th><th>活跃人数</th><th>消费人数</th><th>消费金额</th><th>付费率</th><th>APRU</th><th>活跃APRU</th></tr>
					<c:forEach items="${monthPlatFormList}" var="item">
						<tr>
							<td>${item.log_month}</td>
							<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
							<td>${item.dau}</td>
							<td>${item.num}</td>
							<td>${item.amount}</td>
							<td>${item.pay_rate}</td>
							<td>${item.arpu}</td>
							<td>${item.active_arpu}</td>
						</tr>
					</c:forEach>
				</table>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
	$(document).ready(function(){
		$('table.highchart').highchartTable();
		$("#s2id_pids").hide();
		$("#pids").multiselect({
			includeSelectAllOption:true,
			enableFiltering:true
		});
	});
	
	function selectMonth() {  
	       WdatePicker({ dateFmt: 'yyyy-MM', isShowToday: false, isShowClear: false });  
	    }  
</script>

</body>
</html>