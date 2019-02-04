<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>平台充值消费统计</title>
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
    <li><a href="${ctx}/global/platformRechargeConsume/platformRechargeConsume">平台充值统计 </a></li>
    <li><a href="${ctx}/global/platformRechargeConsume/platformRechargeTimePeriod">平台充值时段统计</a></li>
    <li><a href="${ctx}/global/platformRechargeConsume/platformConsume">平台消费统计 </a></li>
    <li class="active"><a href="${ctx}/global/platformRechargeConsume/platformConsumeTimePeriod">平台消费时段统计 </a></li>
</ul>
<form id="searchForm" action="${ctx}/global/platformRechargeConsume/platformConsumeTimePeriod" method="post"
      class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

    <input type="text" name="createDateStart" class="input_search" size="10" readonly="readonly" maxlength="20"
           value="${paramMap.createDateStart}" id="startDatePicker"
           onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
    -&nbsp;<input type="text" name="createDateEnd" class="input_search" size="10" readonly="readonly"
                  value="${paramMap.createDateEnd}" id="endDatePicker"
                  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">
    <label>平台 ：</label>
    <!-- 默认为全部选中，查询后页面跳转，记录的是上次选中的服务器选项 -->
    <select id="pids" name="pids" multiple="multiple">
        <c:forEach items="${fns:getGamePlatformList()}" var="item">
            <c:choose>
                <c:when test="${fn:length(selectedPids)==0}">
                    <option value="${item.pid}">${item.name}</option>
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
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>"
                 onclick="return page();"/>
</form>
<tags:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>日期</th>
        <th>平台</th>
        <th>0:00:00</th>
        <th>1:00:00</th>
        <th>2:00:00</th>
        <th>3:00:00</th>
        <th>4:00:00</th>
        <th>5:00:00</th>
        <th>6:00:00</th>
        <th>7:00:00</th>
        <th>8:00:00</th>
        <th>9:00:00</th>
        <th>10:00:00</th>
        <th>11:00:00</th>
        <th>12:00:00</th>
        <th>13:00:00</th>
        <th>14:00:00</th>
        <th>15:00:00</th>
        <th>16:00:00</th>
        <th>17:00:00</th>
        <th>18:00:00</th>
        <th>19:00:00</th>
        <th>20:00:00</th>
        <th>21:00:00</th>
        <th>22:00:00</th>
        <th>23:00:00</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${platformConsumeTimePeriod.list}" var="item">
        <tr>
            <td>${item.log_day}</td>
            <td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
            <td>${item.s_1}</td>
            <td>${item.s_2}</td>
            <td>${item.s_3}</td>
            <td>${item.s_4}</td>
            <td>${item.s_5}</td>
            <td>${item.s_6}</td>
            <td>${item.s_7}</td>
            <td>${item.s_8}</td>
            <td>${item.s_9}</td>
            <td>${item.s_10}</td>
            <td>${item.s_11}</td>
            <td>${item.s_12}</td>
            <td>${item.s_13}</td>
            <td>${item.s_14}</td>
            <td>${item.s_15}</td>
            <td>${item.s_16}</td>
            <td>${item.s_17}</td>
            <td>${item.s_18}</td>
            <td>${item.s_19}</td>
            <td>${item.s_20}</td>
            <td>${item.s_21}</td>
            <td>${item.s_22}</td>
            <td>${item.s_23}</td>
            <td>${item.s_24}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${platformConsumeTimePeriod}</div>

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

</body>
</html>