<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>邮件日志查询</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/highcharts.jsp" %>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/log/mail/list">邮件日志查询</a></li>
</ul>
<form id="searchForm" action="${ctx}/log/mail/list" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <label>账号 ：</label>
    <input id="roleId" name="roleId" type="text" value="${roleId}"/>
    <label>角色名 ：</label>
    <input id="roleName" name="roleName" type="text" value="${roleName}"/>
    <label>时间 ：</label>
    <input type="text" name="createDateStart" class="input-small" readonly="readonly" maxlength="20"
           value="${paramMap.createDateStart}" id="startDatePicker"
           onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDatePicker\')}'})">
    -&nbsp;<input type="text" name="createDateEnd" class="input-small" readonly="readonly"
                  value="${paramMap.createDateEnd}" id="endDatePicker"
                  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startDatePicker\')}'})">
    &nbsp;
    <label>关键字 ：</label>
    <input id="contentKey" name="contentKey" type="text" value="${contentKey}"/>
    <input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>"
           onclick="return page();"/>
</form>
<tags:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>邮件标题</th>
        <th>发送者</th>
        <th>收件人</th>
        <th>发送时间</th>
        <th>邮件内容</th>
        <th>邮件附件内容</th>
        <th>是否读取</th>
        <th>是否删除</th>
        <th>是否提取附件</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="item">
        <tr>
            <td>
                <c:if test="${not empty  item.admin_email_id}">
                    <a href="javascript:;" onclick="getGmMailInfo('${item.admin_email_id}');">${item.title}</a>
                </c:if>
                <c:if test="${empty  item.admin_email_id}">
                    ${item.title}
                </c:if>
            </td>
            <td>${item.sender_name}</td>
            <td>${item.role_name}</td>
            <td><fmt:formatDate value="${item.send_time}" type="both"/></td>
            <td>${item.content}</td>
            <td>${item.attachment}</td>
            <td>
                <c:choose>
                    <c:when test="${item.is_open eq true}"><span class="label label-success">是</span></c:when>
                    <c:when test="${item.is_open eq false}"><span class="label label-info">否</span></c:when>
                    <c:otherwise>${item.is_open}</c:otherwise>
                </c:choose>
            </td>
            <td>
                <c:choose>
                    <c:when test="${item.is_del eq true}"><span class="label label-success">是</span></c:when>
                    <c:when test="${item.is_del eq false}"><span class="label label-info">否</span></c:when>
                    <c:otherwise>${item.is_del}</c:otherwise>
                </c:choose>
            </td>
            <td>
                <c:choose>
                    <c:when test="${item.is_received eq true}"><span class="label label-success">是</span></c:when>
                    <c:when test="${item.is_received eq false}"><span class="label label-info">否</span></c:when>
                    <c:otherwise>${item.is_received}</c:otherwise>
                </c:choose>
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

    function getGmMailInfo(gmMailId) {
        top.$.jBox.open("iframe:" + BASE + "/log/mail/getGmMailInfo?gmMailId=" + gmMailId, "gm邮件信息", 1000, $(top.document).height() - 240, {
            buttons: {"确定": "ok", "关闭": true}, bottomText: "gm邮件信息", loaded: function (h) {
                $(".jbox-content", top.document).css("overflow-y", "hidden");
            }
        });
    }
</script>

</body>
</html>