<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>平台历史月度数据</title>
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
    <li class="active"><a href="${ctx}/global/platformHistoryMonthData/platformHistoryMonthData">平台历史月度数据 </a></li>
</ul>
<form id="searchForm" action="${ctx}/global/platformHistoryMonthData/platformHistoryMonthData" method="post"
      class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

    <label>时间 ：</label>
    <input type="text" name="createDateStart" class="input_search" size="10" readonly="readonly" maxlength="20"
           value="${paramMap.createDateStart}" id="startDatePicker"
           onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}',dateFmt:'yyyy-MM'})">
    -&nbsp;<input type="text" name="createDateEnd" class="input_search" size="10" readonly="readonly"
                  value="${paramMap.createDateEnd}" id="endDatePicker"
                  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}',dateFmt:'yyyy-MM'})">
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
<div class="panel panel-primary" style="overflow: scroll;">
    <div class="panel-heading">平台月度数据统计</div>
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th>月份</th>
            <th>平台名</th>
            <th>月开服数</th>
            <th>月收入</th>
            <th>月新注册</th>
            <th>月活跃</th>
            <th>ACCU</th>
            <th>PCCU</th>
            <th>DT时长</th>
            <th>月老用户数</th>
            <th>月留存率</th>
            <th>月充值用户</th>
            <th>月付费率</th>
            <th>月ARPU</th>
            <th>月活跃ARPU</th>
            <th>月首充人数</th>
            <th>月首充金额</th>
            <th>月新新充值人数</th>
            <th>月新新充值金额</th>
            <th>月新新付费率</th>
            <th>月新新ARPU</th>
            <th>月老充值人数</th>
            <th>月老充值金额</th>
            <th>月老付费率</th>
            <th>月老ARPU</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${monthData}" var="item">
            <tr>
                <td>${item.log_month}</td>
                <td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
                <td>${item.new_server_num}</td>
                <td><fmt:formatNumber value="${item.income}" pattern="0.00"></fmt:formatNumber></td>
                <td>${item.ru}</td>

                <td>${item.au}</td>
                <td><fmt:formatNumber value="${item.acu}" pattern="0.00"></fmt:formatNumber></td>
                <td>${item.pcu}</td>
                <td><fmt:formatNumber value="${item.dt}" pattern="0.00"></fmt:formatNumber></td>
                <td>${item.ou}</td>

                <td><fmt:formatNumber type="percent" value="${item.mr_r}"/></td>
                <td>${item.pa}</td>
                <td><fmt:formatNumber type="percent" value="${item.pa_au}"/></td>
                <td><fmt:formatNumber value="${item.income_pa}" pattern="0.00"></fmt:formatNumber></td>
                <td><fmt:formatNumber value="${item.income_au}" pattern="0.00"></fmt:formatNumber></td>

                <td>${item.first_pay_user}</td>
                <td><fmt:formatNumber value="${item.first_pay_value}" pattern="0.00"></fmt:formatNumber></td>
                <td>${item.nn_pa}</td>
                <td><fmt:formatNumber value="${item.nn_pay_value}" pattern="0.00"></fmt:formatNumber></td>
                <td><fmt:formatNumber type="percent" value="${item.nn_pa_ru}"/></td>

                <td><fmt:formatNumber value="${item.nn_pay_value_nn_pa}" pattern="0.00"></fmt:formatNumber></td>
                <td>${item.ou_pa}</td>
                <td><fmt:formatNumber value="${item.ou_pay_value}" pattern="0.00"></fmt:formatNumber></td>
                <td><fmt:formatNumber type="percent" value="${item.ou_pa_ou}"/></td>
                <td><fmt:formatNumber value="${item.ou_pay_value_ou_pa}" pattern="0.00"></fmt:formatNumber></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div class="panel panel-primary">
    <div class="panel-heading">平台新服月度数据统计</div>
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th>月份</th>
            <th>平台名</th>
            <th>月新服数</th>
            <th>月收入</th>
            <th>月新注册</th>
            <th>月活跃</th>
            <th>ACCU</th>
            <th>PCCU</th>
            <th>DT时长</th>
            <th>月充值用户</th>
            <th>月付费率</th>
            <th>月ARPU</th>
            <th>月活跃ARPU</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${newServerMonthData}" var="item">
            <tr>
                <td>${item.log_month}</td>
                <td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
                <td>${item.new_server_num}</td>
                <td><fmt:formatNumber value="${item.income}" pattern="0.00"></fmt:formatNumber></td>
                <td>${item.ru}</td>

                <td>${item.au}</td>
                <td><fmt:formatNumber value="${item.acu}" pattern="0.00"></fmt:formatNumber></td>
                <td>${item.pcu}</td>
                <td><fmt:formatNumber value="${item.dt}" pattern="0.00"></fmt:formatNumber></td>
                <td>${item.pa}</td>

                <td><fmt:formatNumber type="percent" value="${item.pa_au}"/></td>
                <td><fmt:formatNumber value="${item.income_pa}" pattern="0.00"></fmt:formatNumber></td>
                <td><fmt:formatNumber value="${item.income_au}" pattern="0.00"></fmt:formatNumber></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div class="panel panel-primary">
    <div class="panel-heading">平台老服月度数据统计</div>
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th>月份</th>
            <th>平台名</th>
            <th>月老服数</th>
            <th>月收入</th>
            <th>月新注册</th>
            <th>月活跃</th>
            <th>ACCU</th>
            <th>PCCU</th>
            <th>DT时长</th>
            <th>月充值用户</th>
            <th>月付费率</th>
            <th>月ARPU</th>
            <th>月活跃ARPU</th>
            <th>月首充人数</th>
            <th>月首充金额</th>
            <th>月新付费率</th>
            <th>月新ARPU</th>
            <th>月老充值人数</th>
            <th>月老充值金额</th>
            <th>月老付费率</th>
            <th>月老ARPU</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${oldServerMonthData}" var="item">
            <tr>
                <td>${item.log_month}</td>
                <td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
                <td>${item.new_server_num}</td>
                <td><fmt:formatNumber value="${item.income}" pattern="0.00"></fmt:formatNumber></td>
                <td>${item.ru}</td>

                <td>${item.au}</td>
                <td><fmt:formatNumber value="${item.acu}" pattern="0.00"></fmt:formatNumber></td>
                <td>${item.pcu}</td>
                <td><fmt:formatNumber value="${item.dt}" pattern="0.00"></fmt:formatNumber></td>
                <td>${item.pa}</td>

                <td><fmt:formatNumber type="percent" value="${item.pa_au}"/></td>
                <td><fmt:formatNumber value="${item.income_pa}" pattern="0.00"></fmt:formatNumber></td>
                <td><fmt:formatNumber value="${item.income_au}" pattern="0.00"></fmt:formatNumber></td>
                <td>${item.first_pay_user}</td>
                <td><fmt:formatNumber value="${item.first_pay_value}" pattern="0.00"></fmt:formatNumber></td>

                <td><fmt:formatNumber type="percent" value="${item.nn_pa_ru}"/></td>
                <td><fmt:formatNumber value="${item.nn_pay_value_nn_pa}" pattern="0.00"></fmt:formatNumber></td>
                <td>${item.ou_pa}</td>
                <td><fmt:formatNumber value="${item.ou_pay_value}" pattern="0.00"></fmt:formatNumber></td>
                <td><fmt:formatNumber type="percent" value="${item.ou_pa_ou}"/></td>

                <td><fmt:formatNumber value="${item.ou_pay_value_ou_pa}" pattern="0.00"></fmt:formatNumber></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $('table.highchart').highchartTable();
        $("#s2id_pids").hide();
        $("#pids").multiselect({
            includeSelectAllOption: true,
            enableFiltering: true
        });
    });

    function selectMonth() {
        WdatePicker({dateFmt: 'yyyy-MM', isShowToday: false, isShowClear: false});
    }
</script>

</body>
</html>