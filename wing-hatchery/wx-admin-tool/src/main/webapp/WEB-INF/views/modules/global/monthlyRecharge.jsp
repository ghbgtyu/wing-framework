<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>月充值数据</title>
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
    <li class="active"><a href="${ctx}/global/rechargeConsume/monthlyRecharge">月充值数据</a></li>
</ul>
<form id="searchForm" action="${ctx}/global/rechargeConsume/monthlyRecharge" method="post"
      class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

    <label>时间 ：</label>
    <input type="text" name="createDateStart" class="input_search" size="10" readonly="readonly" maxlength="20"
           value="${paramMap.createDateStart}" id="startDatePicker"
           onfocus="WdatePicker({dateFmt:'yyyy-MM',maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
    -&nbsp;<input type="text" name="createDateEnd" class="input_search" size="10" readonly="readonly"
                  value="${paramMap.createDateEnd}" id="endDatePicker"
                  onfocus="WdatePicker({dateFmt:'yyyy-MM',minDate:'#F{$dp.$D(\'startDatePicker\')}'})">
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

<div class=" panel panel-primary">
    <div class="panel-heading">月充值数据</div>
    <table id="contentTable" class="datatable table table-striped table-bordered table-condensed"
           style="overflow: scroll">
        <thead>
        <tr>
            <th>月份</th>
            <th>开服数</th>
            <th>收入</th>
            <th>新注册</th>
            <th>活跃用户</th>
            <th>老用户数</th>
            <th>充值用户</th>
            <th>充值次数</th>
            <th>付费率</th>
            <th>ARPU</th>
            <th>活跃ARPU</th>
            <th>首充人数</th>
            <th>首充次数</th>
            <th>首充金额</th>
            <th>新新充值人数</th>
            <th>新新充值次数</th>
            <th>新新充值金额</th>
            <th>新新付费率</th>
            <th>新新ARPU</th>
            <th>老充值人数</th>
            <th>老充值次数</th>
            <th>老充值金额</th>
            <th>老付费率</th>
            <th>老ARPU</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${rechargeList}" var="item">
            <tr>
                <td>${item.log_month}</td>
                <td>${item.kaifuNum}</td>
                <td>${item.income}</td>
                <td>${item.ru}</td>
                <td>${item.au}</td>
                <td>${item.ou}</td>
                <td>${item.pa}</td>
                <td>${item.pay_times}</td>
                <td>${item.pay_rate}</td>
                <td>${item.arpu}</td>
                <td>${item.active_arpu}</td>
                <td>${item.first_pay_user}</td>
                <td>${item.first_pay_times}</td>
                <td>${item.first_pay_value}</td>
                <td>${item.mnn_pa}</td>
                <td>${item.nn_pay_times}</td>
                <td>${item.nn_pay_value}</td>
                <td>${item.nn_pay_rate}</td>
                <td>${item.nn_arpu}</td>
                <td>${item.d_n_pa}</td>
                <td>${item.df_times}</td>
                <td>${item.i_f_pay_value}</td>
                <td>${item.on_pay_rate}</td>
                <td>${item.on_arpu}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

</div>

<div class=" panel panel-primary">
    <div class="panel-heading">新老服充值数据对比</div>
    <table id="contentTable" class="datatable table table-striped table-bordered table-condensed"
           style="overflow: scroll">
        <thead>
        <tr>
            <th>月份</th>
            <th>总收入</th>
            <th>新服活跃</th>
            <th>新服充值人数</th>
            <th>新服充值次数</th>
            <th>新服充值金额</th>
            <th>新服付费率</th>
            <th>新服ARPU</th>
            <th>老服活跃</th>
            <th>老服充值人数</th>
            <th>老服充值次数</th>
            <th>老服充值金额</th>
            <th>老服付费率</th>
            <th>老服ARPU</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${newOldList}" var="item">
            <tr>
                <td>${item.log_month}</td>
                <td>${item.income}</td>
                <td>${item.new_au}</td>
                <td>${item.new_pa}</td>
                <td>${item.new_pay_times}</td>
                <td>${item.new_income}</td>
                <td>${item.new_pay_rate}</td>
                <td>${item.new_arpu}</td>
                <td>${item.old_au}</td>
                <td>${item.old_pa}</td>
                <td>${item.old_pay_times}</td>
                <td>${item.old_income}</td>
                <td>${item.old_pay_rate}</td>
                <td>${item.old_arpu}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<div class=" panel panel-primary">
    <div class="panel-heading">新老服充值数据对比</div>
    <table id="contentTable" class="datatable table table-striped table-bordered table-condensed"
           style="overflow: scroll">
        <thead>
        <tr>
            <th>月份</th>
            <th>平台</th>
            <th>活跃用户</th>
            <th>充值人数</th>
            <th>充值次数</th>
            <th>充值金额</th>
            <th>付费率</th>
            <th>ARPU</th>
            <th>活跃ARPU</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${platformList}" var="item">
            <tr>
                <td>${item.log_month}</td>
                <td>${fns:getGamePlatformNameById(item.pid,item.pid)}</td>
                <td>${item.au}</td>
                <td>${item.pa}</td>
                <td>${item.pay_times}</td>
                <td>${item.income}</td>
                <td>${item.pay_rate}</td>
                <td>${item.arpu}</td>
                <td>${item.active_arpu}</td>
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