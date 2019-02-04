<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>注册转化（总计）</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/highcharts.jsp" %>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/global/basicOperation/regConvertionTotal">注册转化（总计）</a></li>
</ul>
<form id="searchForm" action="${ctx}/global/basicOperation/regConvertionTotal" method="post"
      class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

    <label>时间 ：</label>
    <input type="text" name="createDateStart" class="input_search" size="10" readonly="readonly" maxlength="20"
           value="${paramMap.createDateStart}" id="startDatePicker"
           onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
    -&nbsp;<input type="text" name="createDateEnd" class="input_search" size="10" readonly="readonly"
                  value="${paramMap.createDateEnd}" id="endDatePicker"
                  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">
    <label>服务器：</label>
    <input id="serverIds" name="serverIds" value="${paramMap.serverIdList}" readonly="readonly"/>
    <input type="button" class="btn btn-primary" value="选择服务器" onclick="openSeverDialog();">
    &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>"
                 onclick="return page();"/>
</form>
<tags:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>日期</th>
        <th>创角页访问</th>
        <th>步骤1</th>
        <th>步骤2</th>
        <th>步骤3</th>
        <th>步骤4</th>
        <th>创角按钮点击</th>
        <th>创角成功</th>
        <th>创角率</th>
        <th>初始场景登录</th>
        <th>创角登录率</th>
        <th>名字框点击</th>
        <th>随机名字按钮点击</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="item">
        <tr>
            <td>${item.log_day}</td>
            <td>${item.visit_times}</td>
            <td>${item.step1}</td>
            <td>${item.step2}</td>
            <td>${item.step3}</td>
            <td>${item.step4}</td>

            <td>${item.create_role_times}</td>
            <td>${item.role_num}</td>
            <td><fmt:formatNumber value="${item.create_role_rate *100}" pattern="#0.00"/>%</td>
            <td>${item.login_times}</td>
            <td><fmt:formatNumber value="${item.login_rate *100}" pattern="#0.00"/>%</td>
            <td>${item.enter_name_times}</td>
            <td>${item.random_times}</td>
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