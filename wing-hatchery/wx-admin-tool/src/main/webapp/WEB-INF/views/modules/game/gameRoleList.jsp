<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>角色列表</title>
	<meta name="decorator" content="default"/>
    <script type="text/javascript">
//       $(function(){
//           $("#tipDiv").tooltip('show');
//       });

    </script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/game/role/">角色列表</a></li>
	</ul>
    <form id="searchForm" action="${ctx}/game/role/" method="post" class="breadcrumb form-search">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <label>角色名：</label>
        <input type="text" id="name" name="name"  class="input-small" value="${paramMap.name}"/>
        <label>玩家账号：</label>
        <input type="text" id="userId" name="userId"  class="input-small" value="${paramMap.userId}"/>
        <label>角色账号：</label>
        <input type="text" id="roleId" name="roleId"  class="input-small" value="${paramMap.roleId}"/>
        <label>等级：</label>
        <input type="text" name="startLevel" class="input-small" value="${paramMap.startLevel}"> - <input type="text" class="input-small" name="endLevel" value="${paramMap.endLevel}">
        &nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="operation.search"/>" onclick="return page();"/>
        <div class="">
        <br/>
		<shiro:hasPermission name="game.role.jinyan">
        &nbsp;<input id="batchJinYan" class="btn btn-primary" type="button" value="禁言" onclick="submitCheckedRecordIdsWithPrompt('${ctx}/game/role/batchJinYan')"/>
        &nbsp;<input id="batchCancelJinYan" class="btn btn-primary" type="button" value="取消禁言" onclick="submitCheckedRecordIdsWithPrompt('${ctx}/game/role/batchCancelJinYan')"/>
        </shiro:hasPermission>
        <shiro:hasPermission name="game.role.fenghao">
        &nbsp;<input id="batchFenHao" class="btn btn-primary" type="button" value="封号" onclick="submitCheckedRecordIdsWithPrompt('${ctx}/game/role/batchFengHao')"/>
        &nbsp;<input id="batchCancelFenHao" class="btn btn-primary" type="button" value="取消封号" onclick="submitCheckedRecordIdsWithPrompt('${ctx}/game/role/batchCancelFengHao')"/>
		</shiro:hasPermission>
        </div>
    </form>
	<tags:message content="${message}"/>
    <form id="tableForm" action="">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
        <input type="text" style="display: none" hidden="hidden" name="msg" id="msg"/>
		<tr><th width="18px"><input id="checkAllOrNot" name="checkAllOrNot" type="checkbox"></th><th>用户账号</th><th>角色名</th><th>职业</th><th>性别</th><th>等级</th><th>当前经验</th><th>最后上线时间</th><th>最后离线时间</th><th>角色创建时间</th><th>服务器</th><th>是否禁言</th><th>是否封号</th><th>操作</th></tr>
		<c:forEach items="${page.list}" var="role">
			<tr>
                <td><input type="checkbox" name="recordIds" value="${role.id}"></td>
                <td>${role.userId}</td>
                <td>${role.name}</td>
                <td>${role.job}</td>
                <td>${role.gender}</td>
                <td>${role.level}</td>
                <td>${role.exp}</td>
                <td><fmt:formatDate value="${role.lastLoginTime}" type="both"/></td>
                <td><fmt:formatDate value="${role.lastLogoutTime}" type="both"/></td>
                <td><fmt:formatDate value="${role.addTime}" type="both"/></td>
                <td>${role.serverId}</td>
                <td>
                    <c:if test="${role.isjinyan eq true}"><span class="label label-success">是</span></c:if>
                    <c:if test="${role.isjinyan eq false}"><span class="label label-info">否</span></c:if>
                </td>
                <td>
                    <c:if test="${role.isfenghao eq true}"><span class="label label-success">是</span></c:if>
                    <c:if test="${role.isfenghao eq false}"><span class="label label-info">否</span></c:if>
                </td>
				<td>
                    <shiro:hasPermission name="game.role.delete">
                        <a href="${ctx}/game/role/delete?id=${role.id}" onclick="return confirmx('确认要删除该角色吗？', this.href)">删除角色</a>
                    </shiro:hasPermission>
					<shiro:hasPermission name="game.role.logingame">
						<a target="_blank" href="${ctx}/game/role/loginGame?userId=${role.name}&serverId=${role.serverId}">登陆游戏</a>
					</shiro:hasPermission>
                    <a href="${ctx}/game/role/form?id=${role.id}">详细信息</a>
				</td>
			</tr>
		</c:forEach>
	</table>
        </form>
    <div class="pagination">${page}</div>
</body>
</html>