<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>

<head>
    <title>综合日志</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/highcharts.jsp" %>
    <script src="${ctxStatic}/common/fixtable.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#s2id_operaType").hide();
            $("#operaType").multiselect({
                includeSelectAllOption: true,
                enableFiltering: true
            });
        });

        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctx}/log/comprehensiveLogController/comprehensiveList");
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
    <li class="active"><a href="${ctx}/log/comprehensiveLogController/comprehensiveList">综合日志</a></li>
</ul>
<form id="searchForm"
      action="${ctx}/log/comprehensiveLogController/comprehensiveList" method="post"
      class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/> <label>角色名：</label> <input type="text"
                                                                                                             id="roleName"
                                                                                                             name="roleName"
                                                                                                             value="${paramMap.roleName}"/>
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
    <input type="text" name="createDateStart" class="input_search" size="10" readonly="readonly" maxlength="20"
           value="${paramMap.createDateStart}" id="startDatePicker"
           onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
    -&nbsp;<input type="text" name="createDateEnd" class="input_search" size="10" readonly="readonly"
                  value="${paramMap.createDateEnd}" id="endDatePicker"
                  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>"
                 onclick="return page();"/>
    <shiro:hasPermission name="log.comprehensive.export">
        &nbsp;<input id="btnExport" class="btn btn-primary" type="button" value="导出" onclick="doExport('${ctx}/log/comprehensiveLogController/export')" />
    </shiro:hasPermission>
</form>
<tags:message content="${message}"/>

<table id="active-yb"
       class="table table-striped table-bordered table-condensed">
    <tr>
        <th>角色名</th>
        <th>事件</th>
        <th>失败次数</th>
        <th>成功次数</th>
        <th>时间</th>
    </tr>
    <c:forEach items="${page.list }" var="item">
        <tr>
            <td>${item.roleName }</td>
            <td>${fns:getOperationType(item.operationType)}</td>
            <td>${item.failTimes }</td>
            <td>${item.succTimes }</td>
            <td>${item.logHour}</td>
        </tr>
    </c:forEach>
</table>
<div class="pagination">${page}</div>
</body>
</html>