<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>游戏服务器</title>
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
    <li class="active"><a href="${ctx}/tools/gameAreaController/gameAreas">游戏服务器</a></li>
</ul>
<form id="searchForm" action="${ctx}/tools/gameAreaController/gameAreas" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>


    <label>服务器编号：</label>
    <input id="serverId" name="serverId" value="${paramMap.serverId}"/>
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>"
                 onclick="return page();"/>
</form>
<tags:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>世界ID</th>
        <th>区域ID</th>
        <th>世界名称</th>
        <th>区域名称</th>
        <th>区域类型</th>
        <th>外部IP</th>
        <th>外部端口</th>
        <th>web端口</th>
        <th>内部端口</th>
        <th>内部IP</th>
        <th>平台ID</th>
        <th>状态</th>
        <th>子服务器ID</th>
        <th>开服时间</th>
        <th>更新时间</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="item">
        <tr>
            <td>${item.world_id}</td>
            <td>${item.area_id}</td>
            <td>${item.world_name}</td>
            <td>${item.area_name}</td>
            <td>${item.area_type}</td>

            <td>${item.external_ip}</td>
            <td>${item.tcp_port}</td>
            <td>${item.web_port}</td>
            <td>${item.inner_port}</td>
            <td>${item.inner_ip}</td>
            <td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
            <td>
                <c:choose>
                    <c:when test="${item.status == 0}"><span
                            class="label label-info">${fns:getDictLabel(item.status, "server_status","未知")}</span></c:when>
                    <c:when test="${item.status == 1}"><span
                            class="label label-warning">${fns:getDictLabel(item.status, "server_status","未知")}</span></c:when>
                    <c:otherwise><span
                            class="label label-important">${fns:getDictLabel(item.status, "server_status","未知")}</span></c:otherwise>
                </c:choose>
            </td>
            <td>${item.follower_id}</td>
            <td><fmt:formatDate value="${item.open_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td><fmt:formatDate value="${item.update_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>

<script type="text/javascript">
    $(document).ready(function () {
        $('table.highchart').highchartTable();
        $("#s2id_pids").hide();
        $("#pids").multiselect({
            includeSelectAllOption: true,
            enableFiltering: true
        });
    });
</script>

</html>