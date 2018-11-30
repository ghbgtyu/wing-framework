<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>gm邮件详细信息</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/dialog.jsp" %>
    <script type="text/javascript">

    </script>
    <style type="text/css">
        .modal-header{ border-bottom: none;}
        .modal-body{border-bottom: 1px solid #EEEEEE}
    </style>
</head>
<body>

<div id="gmMailDialog" class="">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr><th>id</th>	<th>发送者</th> <th>审核者</th></tr>
		</thead>
		<tbody>
			<tr>
				<td>${gameEmail.id}</td>
				<td>${gameEmail.createName}</td>
				<td>${gameEmail.approveName}</td>			
			</tr>
		</tbody>
	</table>
</div>
</body>
</html>
