<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>

<head>
	<title>道具获取日志</title>
	<meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/highcharts.jsp" %>
	<script src="${ctxStatic}/common/fixtable.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		$("#s2id_operaType").hide();
		$("#operaType").multiselect({
			includeSelectAllOption:true,
			enableFiltering:true
		});
	});
	function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctx}/log/propController/propGainList");
            $("#searchForm").submit();
            return false;
    }
	</script>
	<style type="text/css">
		span.input-group-btn {
			display: none;
		}
	</style>
</head>
<body>
     <ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/log/propController/propGainList">道具获取日志</a></li>
	 </ul>
	<form id="searchForm" action="${ctx}/log/propController/propGainList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		
		<label>角色名：</label>
		<input type="text" id="roleName" name="roleName" value="${paramMap.roleName}"/>
		
		<label>道具名：</label>
		<input type="text" id="itemName" name="itemName" value="${paramMap.itemName}"/>
		
		<label>操作类型：</label>
		<select id="operaType" name="operaType" multiple="multiple">	
			<c:forEach items="${fns:getOperaTypeMap()}" var="item">
			<c:choose>
			 <c:when test="${fn:length(selectedOperas)==0}">
			   <option value="${item.key }">${item.value.chDes }</option>
			 </c:when>
			 <c:otherwise>
					<option value="${item.key}" 
						<c:forEach items="${selectedOperas}" var="opera">
							<c:if test="${opera==item.key}">
								selected="selected"
							</c:if>
						</c:forEach>
					>${item.value.chDes}</option>
					</c:otherwise>
			</c:choose>
			</c:forEach>	
		</select>
		
		<label>日期选择：</label>
		<input type="text" name="createDateStart" class="input-small" readonly="readonly" maxlength="20" value="${paramMap.createDateStart}" id="startDatePicker" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
		-&nbsp;<input type="text" name="createDateEnd"   class="input-small" readonly="readonly" value="${paramMap.createDateEnd}"   id="endDatePicker" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">		

	    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" onclick="return page();"/>
		<shiro:hasPermission name="log.propGain.export">
	    &nbsp;<input id="btnExport" class="btn btn-primary" type="button" value="导出" onclick="doExport('${ctx}/log/propController/gainExport')"/>
		</shiro:hasPermission>
	</form>
	<tags:message content="${message}"/>
	<table id="active-yb" class="table table-striped table-bordered table-condensed">
		<tr><th>角色ID</th><th>资源线</th><th>活动面板</th><th>事件</th><th>道具名称</th><th>道具变化</th><th>道具变化数量</th><th>道具变化前数量</th>
			<th>道具变化后数量</th><th>时间</th></tr>
		<c:forEach items="${page.list }" var="item">
			<tr>
				<td>${item.userId }</td>
				<td>${item.resource }</td>
				<td>${item.active }</td>
				<td>${fns:getOperationType(item.opereateType)}</td>
				<td>${item.itemName }</td>
				<td>减少</td>
				<td>${item.value }</td>
				<td>${item.beforeValue }</td>
				<td>${item.afterValue }</td>
				<td>${item.logTime }</td>
			</tr>
		</c:forEach>
    </table> 
    <div class="pagination">${page}</div>
</body>
</html>