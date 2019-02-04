<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>大中R监控</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/highcharts.jsp" %>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/game/daZhongRMonitor/daZhongRMonitorReport">大中R监控 </a></li>
</ul>
<form id="searchForm" action="${ctx}/game/daZhongRMonitor/daZhongRMonitorReport" method="post"
      class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <label>总充值金额 ：</label>
    <select name="amount">
        <option selected="selected" value="0">0+</option>
        <option value="5000">5000+</option>
        <option value="10000">10000+</option>
        <option value="20000">20000+</option>
        <option value="50000">50000+</option>
        <option value="100000">100000+</option>
    </select>
    <!--<label>服务器：</label>
	    <input id="serverIds" name="serverIds" value="${paramMap.serverIdList}" readonly="readonly"/>
		<input type="button" class="btn btn-primary" value="选择服务器" onclick="openSeverDialog();">-->
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>"
                 onclick="return page();"/>
</form>
<tags:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>平台</th>
        <th>服务器</th>
        <th>玩家ID</th>
        <th>角色名</th>
        <th>总充值金额</th>
        <th>注册时间</th>
        <th>首次充值时间</th>
        <th>最后充值时间</th>
        <th>游戏天数</th>
        <th>总充值次数</th>
        <th>元宝存量</th>
        <th>未登录天数</th>
        <th>登录状态</th>
        <th>未支付天数</th>
        <th>支付状态</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${daZhongRMonitor.list}" var="item">
        <tr>
            <td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
            <td>${item.area_id}</td>
            <td>${item.user_id}</td>
            <td>${item.role_name}</td>
            <td><fmt:formatNumber value="${item.amount}" pattern="0.00"/></td>

            <td><fmt:formatDate value="${item.reg_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td><fmt:formatDate value="${item.first_pay_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td><fmt:formatDate value="${item.last_pay_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>${item.sub_reg_time}</td>
            <td>${item.pay_times}</td>

            <td>${item.surplus_coin}</td>
            <td>${item.sub_last_login_time}</td>
            <td>
                <c:choose>
                    <c:when test="${item.sub_last_login_time>warnLogin}"><span
                            class="label label-important">预警</span></c:when>
                    <c:otherwise><span class="label label-info">正常</span></c:otherwise>
                </c:choose>
            </td>
            <td>${item.sub_last_pay_time}</td>
            <td>
                <c:choose>
                    <c:when test="${item.sub_last_pay_time>warnCharge}"><span
                            class="label label-important">预警</span></c:when>
                    <c:otherwise><span class="label label-info">正常</span></c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${daZhongRMonitor}</div>

<script type="text/javascript">
    $(document).ready(function () {
        $('table.highchart').highchartTable();
    });
</script>

</body>
</html>