<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>平台注册转化统计</title>
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
		<li class="active"><a href="${ctx}/global/platformStatistics/platformRegConvertionStatistics">平台注册转化统计</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/global/platformStatistics/platformRegConvertionStatistics" method="post" class="breadcrumb form-search">
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
			<div class="panel panel-primary">
				<div class="panel-heading">平台分时注册数据</div>
				<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
				<table id="dailyTable" class="table table-striped table-bordered table-condensed">
					<tr><th>日期</th><th>平台</th><th>0:00</th><th>1:00</th><th>2:00</th><th>3:00</th><th>4:00</th><th>5:00</th><th>6:00</th>
					<th>7:00</th><th>8:00</th><th>9:00</th><th>10:00</th><th>11:00</th><th>12:00</th><th>13:00</th><th>14:00</th><th>15:00</th>
					<th>16:00</th><th>17:00</th><th>18:00</th><th>19:00</th><th>20:00</th><th>21:00</th><th>22:00</th><th>23:00</th>
					</tr>
					<c:forEach items="${regDistribution}" var="item">
						<tr>
							<td>${item.log_day}</td>
							<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
							<td>${item.section_1}</td>
							<td>${item.section_2}</td>
							<td>${item.section_3}</td>
							<td>${item.section_4}</td>
							<td>${item.section_5}</td>
							<td>${item.section_6}</td>
							<td>${item.section_7}</td>
							<td>${item.section_8}</td>
							<td>${item.section_9}</td>
							<td>${item.section_10}</td>
							<td>${item.section_11}</td>
							<td>${item.section_12}</td>
							<td>${item.section_13}</td>
							<td>${item.section_14}</td>
							<td>${item.section_15}</td>
							<td>${item.section_16}</td>
							<td>${item.section_17}</td>
							<td>${item.section_18}</td>
							<td>${item.section_19}</td>
							<td>${item.section_20}</td>
							<td>${item.section_21}</td>
							<td>${item.section_22}</td>
							<td>${item.section_23}</td>
							<td>${item.section_24}</td>
						</tr>
					</c:forEach>
				</table>
				</div>
			</div>
		
		<div class="panel panel-primary">
				<div class="panel-heading">平台注册转化数据</div>
				<div class="" style="width:100%;height:300px;line-height:300px;overflow:auto;overflow-x:hidden;">
				<table id="dailyTable" class="table table-striped table-bordered table-condensed">
					<tr><th>日期</th><th>平台</th><th>创角页访问</th> <th>步骤1</th> <th>步骤2</th> <th>步骤3</th> <th>步骤4</th>
					<th>创角按钮点击</th><th>创角成功</th> <th>创角率</th> <th>初始场景登录</th> <th>创角登录率</th> <th>名字框点击</th><th>随机名字按钮点击</th> 
					</tr>
					<c:forEach items="${convertionList}" var="item">
						<tr>
							<td>${item.log_day}</td>
							<td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
							<td>${item.visit_times}</td>
							<td>${item.step1}</td>
							<td>${item.step2}</td>
							<td>${item.step3}</td>
							<td>${item.step4}</td>
							<td>${item.create_role_times}</td>
							<td>${item.role_num}</td>
							<td><fmt:formatNumber value="${item.create_role_rate *100}" pattern="#0.00" />% </td>
							<td>${item.login_times}</td>
							<td><fmt:formatNumber value="${item.login_rate *100}" pattern="#0.00" />% </td>
							<td>${item.enter_name_times}</td>
							<td>${item.random_times}</td>
						</tr>
					</c:forEach>
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
		$("#s2id_pids").hide();
		$("#pids").multiselect({
			includeSelectAllOption:true,
			enableFiltering:true
		});
	});
</script>

</body>
</html>