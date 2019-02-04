<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>公会日志</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/highcharts.jsp" %>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/game/guildLog/getGuildList">公会日志</a></li>
</ul>
<form id="searchForm" action="${ctx}/game/guildLog/getGuildList" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <label>公会名 ：</label>
    <input id="name" name="name" type="text" value="${name}"/>
    <label>时间 ：</label>
    <input type="text" name="createDateStart" class="input_search" size="10" readonly="readonly" maxlength="20"
           value="${paramMap.createDateStart}" id="startDatePicker"
           onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
    -&nbsp;<input type="text" name="createDateEnd" class="input_search" size="10" readonly="readonly"
                  value="${paramMap.createDateEnd}" id="endDatePicker"
                  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">
    &nbsp;
    <input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>"
           onclick="return page();"/>
    <shiro:hasPermission name="game.guild.export">
        <input id="btnExport" class="btn btn-primary" type="button" value="导出"
               onclick="exportXls('${ctx}/game/guildLog/exportXls')"/>
    </shiro:hasPermission>
</form>
<tags:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>公会名称</th>
        <th>会长</th>
        <th>创建时间</th>
        <th>公会等级</th>
        <th>公会战斗力</th>
        <th>公会成员</th>
        <th>公会状态</th>
        <th>公会操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="item">
        <tr>
            <td>${item.name}</td>
            <td>${item.leader_name}</td>
            <td><fmt:formatDate value="${item.add_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>${item.level}</td>
            <td>${item.combat_power}</td>
            <td>${item.current_member_num}</td>
            <td></td>

            <td>
                <shiro:hasPermission name="game.guild.delete">
                    <a href="${ctx}/game/guildLog/deleteGuild?id=${item.id}"
                       onclick="return confirmx('确认要删除该公会吗？', this.href)">删除</a>
                </shiro:hasPermission>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>

<script type="text/javascript">
    $(document).ready(function () {
        $('table.highchart').highchartTable();
    });
</script>

</body>
</html>