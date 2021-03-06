<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>公告管理</title>
	<meta name="decorator" content="default"/>
    <script type="text/javascript">
//       $(function(){
//           $("#tipDiv").tooltip('show');
//       });

    </script>
</head>
<body>
	<form:form method="post" class="breadcrumb form-search" action="${ctx}/tools/gameEmail/goodsDialog"  id="searchForm">
		<label>物品名称：</label>
		<input type="text" id="goodsName" name="goodsName" value="${paramMap.goodsName}" class="required">
		<input type="hidden" name="targetId" value="${paramMap.targetId}">
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" onclick="return page();"/>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-bordered table-condensed">
		<tr><th hidden="hidden">物品ID</th><th>物品名</th><th>最大堆叠数</th><th>描述</th></tr>
		<tbody>
		<c:forEach items="${list}" var="item">
			<tr>
				<td hidden="hidden">${item.id}</td>
				<td width="15%">${item.name}</td>
                <td width="10%">${item.maxStack}</td>
                <td style="word-break: keep-all" title="${item.goodsDesc}">${item.goodsDesc}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>

<script type="text/javascript">

	var goodsId = "";
	var goodsName = "";

	$(function(){
		$("#contentTable > tbody > tr").click(function(){
			removeAllSelected();
			$(this).addClass("selected");
			goodsId = $(this).children("td").get(0).innerHTML;
			goodsName = $(this).children("td").get(1).innerHTML;
		});
	});

	function removeAllSelected(){
		$("#contentTable > tbody > tr").each(function(){
			$(this).removeClass("selected");
		});
	}

</script>


</body>
</html>