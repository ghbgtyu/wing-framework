<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>月营收考核</title>
	<meta name="decorator" content="default"/>

	<script src="${ctxStatic}/common/fixtable.js" type="text/javascript"></script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/global/dashboard/monthSalesReport">月营收考核</a></li>
	</ul>
	<form id="searchForm" action="${ctx}/global/dashboard/monthSalesReport" method="post" class="breadcrumb form-search">
		<label>日期选择：</label>
	      <input name="month" style="width: 216px" readonly="readonly" value="${paramMap.month}" onfocus="WdatePicker({dateFmt:'yyyy-MM'})"/>
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" onclick="return page();"/>
	</form>
	<tags:message content="${message}"/>
	 <table id="monthly-sales" class="datatable table table-striped table-bordered table-condensed">
		<thead>
		<tr><th><c:if test="${empty revenue.month }">月份</c:if><c:if test="${not empty revenue.month }">${month }</c:if></th>
		    <th>新注册</th><th>老用户</th><th>月活跃</th><th>付费率(%)</th><th>ARPU(%)</th><th>收入</th>
		</thead>
	 	<tbody>
			<tr>
				<td>当月指标</td>
				<td><c:if test="${not empty revenue.newUser}">${revenue.newUser}</c:if><c:if test="${empty revenue.newUser }">0</c:if></td>
				<td><c:if test="${not empty revenue.oldUser}">${revenue.oldUser}</c:if><c:if test="${empty revenue.oldUser}">0</c:if></td>
				<td><c:if test="${not empty revenue.active}">${revenue.active}</c:if><c:if test="${empty revenue.active}">0</c:if></td>
				<td><c:if test="${not empty revenue.payrate}">${revenue.payrate }%</c:if><c:if test="${empty revenue.payrate }">0</c:if></td>
				<td><c:if test="${not empty revenue.arpu}">${revenue.arpu }%</c:if><c:if test="${empty revenue.arpu }">0</c:if></td>
				<td><c:if test="${not empty revenue.income}">${revenue.income}</c:if><c:if test=" ${empty revenue.income}">0</c:if> </td>
			</tr>
		  <tr>
		      <td>实际数据</td>
			  <td>${real.newUser}</td>
			  <td>${real.oldUser}</td>
			  <td>${real.active}</td>
			  <td><c:if test="${not empty real.payrate && real.payrate > 0 }">${real.payrate}%</c:if>
			      <c:if test="${ real.payrate <= 0 }">0</c:if>
			  </td>
			  <td><c:if test="${not empty real.arpu && real.arpu > 0 }">${real.arpu}</c:if>
			      <c:if test="${ real.arpu <= 0 }">0</c:if>
			  </td>
			  <td>${real.income}</td>
		  </tr>
		    <tr>
		      <td>时间进度</td>
			  <td><c:if test="${not empty speed }">${speed }%</c:if></td>
			  <td><c:if test="${not empty speed }">${speed }%</c:if></td>
			  <td><c:if test="${not empty speed }">${speed }%</c:if></td>
			  <td><c:if test="${not empty speed }">${speed }%</c:if></td>
			  <td><c:if test="${not empty speed }">${speed }%</c:if></td>
			  <td><c:if test="${not empty speed }">${speed }%</c:if></td>
		  </tr>
		  <tr>
		      <td>指标偏差</td>
			  <td><c:if test="${real.newUser-revenue.newUser >0 }">+ ${real.newUser-revenue.newUser}</c:if><c:if test="${real.newUser-revenue.newUser <=0 }"> ${real.newUser-revenue.newUser}</c:if>
			      
			  </td>
			  <td><c:if test="${real.oldUser-revenue.oldUser >0 }">+ ${real.oldUser-revenue.oldUser}</c:if><c:if test="${real.oldUser-revenue.oldUser <=0 }"> ${real.oldUser-revenue.oldUser}</c:if>
			   
			  </td>
			  <td><c:if test="${real.active-revenue.active >0 }">+ ${real.active-revenue.active}</c:if><c:if test="${real.active-revenue.active <=0 }"> ${real.active-revenue.active}</c:if>
			      
			  </td>
			  <td><c:if test="${real.payrate-revenue.payrate >0 }">+ ${real.payrate-revenue.payrate}</c:if><c:if test="${real.payrate-revenue.payrate <=0 }"> ${real.payrate-revenue.payrate}</c:if>
			     
			  </td>
			  <td><c:if test="${real.arpu-revenue.arpu >0 }">+ ${real.arpu-revenue.arpu}</c:if><c:if test="${real.arpu-revenue.arpu <=0 }"> ${real.arpu-revenue.arpu}</c:if>
			     
			  </td>
			  <td><c:if test="${real.income-revenue.income >0 }">+ ${real.income-revenue.income}</c:if><c:if test="${real.income-revenue.income <=0 }"> ${real.income-revenue.income}</c:if>
			     
			   </td>
		  </tr>
		  <tr>
		      <td>后续每日需</td>
			  <td><c:if test="${surplus >0 && revenue.newUser-real.newUser >0 }"><fmt:formatNumber value=" ${(revenue.newUser-real.newUser)/surplus }"></fmt:formatNumber></c:if>
			      <c:if test="${surplus == 0 && revenue.newUser-real.newUser >0}">${revenue.newUser-real.newUser }</c:if>
			      <c:if test="${surplus == 0 && revenue.newUser-real.newUser <=0 }">0</c:if>
			  </td>
			  <td></td>
			  <td></td>
			  <td></td>
			  <td></td>
			  <td><c:if test="${surplus >0 && revenue.income-real.income >0 }"><fmt:formatNumber value=" ${(revenue.income-real.income)/surplus }"></fmt:formatNumber></c:if>
			      <c:if test="${surplus == 0 && revenue.income-real.income >0}">${revenue.income-real.income }</c:if>
			      <c:if test="${surplus == 0 && revenue.income-real.income <=0 }">0</c:if>
			  </td>
		  </tr>
		</tbody>
	</table>

	<div class="row-fluid">
			<div class="span12 panel panel-primary">
				<div class="panel-heading">月营收考核分析</div>
				<div class="" style="width:100%;height:500px;line-height:500px;overflow:auto;overflow-x:hidden;">
	<table id="monthly-report" class="datatable table table-striped table-bordered table-condensed">
		<thead>
		<tr><th>日期</th><th>预估日收入</th><th>实际日收入</th><th>偏离量</th><th>运营商1收入</th><th>运营商2收入</th><th>运营商3收入</th>
		    <th>预估新注册</th><th>实际新注册</th><th>偏离量</th><th>运营商1新注册</th><th>运营商2新注册</th><th>运营商3新注册</th></tr>
	   </thead>
		<tbody>
		<c:forEach items="${realDayList}" var="item">
			<tr>
				<td>${item.day}</td>
				<td>${redayincome }</td>
				<td>${item.dayIncome }</td>
				<td><c:if test="${item.dayIncome-redayincome >0}"> +${item.dayIncome-redayincome }</c:if> 
				    <c:if test="${item.dayIncome-redayincome <=0}"> ${item.dayIncome-redayincome }</c:if> 
				   
				</td>
				<td>${item.pid1Income }</td>
				<td>${item.pid2Income }</td>
				<td>${item.pid3Income }</td>
				<td>${redayuser}</td>
				<td>${item.newUser}</td>
				<td><c:if test="${item.newUser-redayuser <= 0}"> ${item.newUser-redayuser}</c:if>
				    <c:if test="${item.newUser-redayuser >0}">+${item.newUser-redayuserr} </c:if>
				</td>
				<td>${item.pid1newUser }</td>
				<td>${item.pid2newUser }</td>
				<td>${item.pid3newUser }</td>
			</tr>
		</c:forEach>
	 </tbody>
	</table>
	</div>
 </div>
 </div>

</body>
</html>