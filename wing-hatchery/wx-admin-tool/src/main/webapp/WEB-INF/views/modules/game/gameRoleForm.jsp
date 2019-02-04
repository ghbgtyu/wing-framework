<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>角色详情</title>
    <meta name="decorator" content="default"/>

</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/game/role/">角色列表</a></li>
    <li class="active"><a>角色详细</a></li>
</ul>
<br/>

<div class="panel panel-primary">
    <div class="panel-heading">角色信息</div>
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <tr>
            <th>玩家账号</th>
            <td>${role.roleId}</td>
            <th>角色名</th>
            <th>${role.roleName}</th>
            <th>职业</th>
            <td>${role.job}</td>
            <th>性别</th>
            <th>${role.gender}</th>
        </tr>
        <tr>
            <th>等级</th>
            <td>${role.level}</td>
            <th>玩家战斗力</th>
            <td>${role.power}</td>
            <th>累计充值金额</th>
            <td>${role.leiji_jine}</td>
            <th>VIP等级</th>
            <td>无</td>
        </tr>
        <tr>
            <th>元宝</th>
            <td>${role.diamond}</td>
            <th>绑定元宝</th>
            <td>${role.bind_diamond}</td>
            <th>游戏币</th>
            <td>${role.coin}</td>

        </tr>
        <tr>
            <th>帮派</th>
            <td>${role.guild_name}</td>
            <th>帮派职位</th>
            <td>${role.position}</td>

        </tr>
        <tr>
            <th>创建时间</th>
            <td>${role.add_time}</td>
            <th>最后登陆时间</th>
            <td>${role.lastLoginTime}</td>
            <th>最后离线时间</th>
            <td>${role.lastLogoutTime}</td>
            <th>最后充值时间</th>
            <td>${role.lastChargeTime}</td>
        </tr>
    </table>
</div>
<div class="panel panel-primary">
    <div class="panel-heading">角色好友</div>
    <table id="friendsTable" class="table table-striped table-bordered table-condensed">
        <tr>
            <th>用户账号</th>
            <th>角色名</th>
            <th>职业</th>
            <th>性别</th>
            <th>等级</th>
        </tr>

    </table>
</div>

<div class="panel panel-primary">
    <div class="panel-heading">装备信息</div>
    <table id="itemsTable" class="table table-striped table-bordered table-condensed">
        <tr>
            <th>部位</th>
            <th>装备名称</th>
            <th>装备等级</th>
            <th>装备品质</th>
            <th>装备强化</th>
            <th>装备星级</th>
            <th>镶嵌宝石</th>
        </tr>
        <c:forEach items="${items}" var="item">
            <tr>
                <td>${item.position}</td>
                <td>${item.template_id}</td>
                <td>${item.level}</td>
                <td>${item.rarelevel}</td>
                <td>${fns:parseObject(item.attributes,'strengthenLevel')}</td>
                <td>${item.star_level}</td>
                <td>${fns:parseObject(item.attributes,'jewelries')}</td>
            </tr>
        </c:forEach>
    </table>
</div>

<div class="panel panel-primary">
    <div class="panel-heading">主资源线信息(坐骑)</div>
    <table id="horseTable" class="table table-striped table-bordered table-condensed">
        <tr>
            <th>最大等级</th>
            <th>当前等级</th>
            <th>获得时间</th>
            <th>更新时间</th>
        </tr>
        <c:forEach items="${horse}" var="horse">
            <tr>
                <td>${horse.maxRank}</td>
                <td>${horse.rank}</td>
                <td>${horse.create_time}</td>
                <td>${horse.update_time}</td>
            </tr>
        </c:forEach>
    </table>
</div>

<div class="panel panel-primary">
    <div class="panel-heading">主资源线信息(神翼)</div>
    <table id="cloakTable" class="table table-striped table-bordered table-condensed">
        <tr>
            <th>最大等级</th>
            <th>当前等级</th>
            <th>获得时间</th>
            <th>更新时间</th>
        </tr>
        <c:forEach items="${cloak }" var="cloak">
            <tr>
                <td>${cloak.maxRank}</td>
                <td>${cloak.rank}</td>
                <td>${cloak.create_time}</td>
                <td>${cloak.update_time}</td>
            </tr>
        </c:forEach>
    </table>
</div>

<div class="panel panel-primary">
    <div class="panel-heading">主资源线信息(女武神)</div>
    <table id="nvwushenTable" class="table table-striped table-bordered table-condensed">
        <tr>
            <th>最大等级</th>
            <th>当前等级</th>
            <th>获得时间</th>
            <th>更新时间</th>
        </tr>
        <c:forEach items="${nvwushen}" var="nvwushen">
            <tr>
                <td>${nvwushen.maxRank}</td>
                <td>${nvwushen.rank}</td>
                <td>${nvwushen.create_time}</td>
                <td>${nvwushen.update_time}</td>
            </tr>
        </c:forEach>
    </table>
</div>
<div class="panel panel-primary">
    <div class="panel-heading">主资源线信息(头衔)</div>
    <table id="touxianTable" class="table table-striped table-bordered table-condensed">
        <tr>
            <th>最大等级</th>
            <th>当前等级</th>
            <th>获得时间</th>
            <th>更新时间</th>
        </tr>
        <c:forEach items="${touxian}" var="touxian">
            <tr>
                <td>${touxian.maxRank}</td>
                <td>${touxian.rank}</td>
                <td>${touxian.create_time}</td>
                <td>${touxian.update_time}</td>
            </tr>
        </c:forEach>
    </table>
</div>

<div class="panel panel-primary">
    <div class="panel-heading">主资源线信息(天梭)</div>
    <table id="tainsuoTable" class="table table-striped table-bordered table-condensed">
        <tr>
            <th>最大等级</th>
            <th>当前等级</th>
            <th>获得时间</th>
            <th>更新时间</th>
        </tr>
        <c:forEach items="${tainsuo}" var="tainsuo">
            <tr>
                <td>${tainsuo.maxRank}</td>
                <td>${tainsuo.rank}</td>
                <td>${tainsuo.create_time}</td>
                <td>${tainsuo.update_time}</td>
            </tr>
        </c:forEach>
    </table>
</div>

<div class="panel panel-primary">
    <div class="panel-heading">主资源线信息(化神)</div>
    <table id="huashenTable" class="table table-striped table-bordered table-condensed">
        <tr>
            <th>最大等级</th>
            <th>当前等级</th>
            <th>获得时间</th>
            <th>更新时间</th>
        </tr>
        <c:forEach items="${huashen}" var="huashen">
            <tr>
                <td>${huashen.maxRank}</td>
                <td>${huashen.rank}</td>
                <td>${huashen.create_time}</td>
                <td>${huashen.update_time}</td>
            </tr>
        </c:forEach>
    </table>
</div>

<div class="panel panel-primary">
    <div class="panel-heading">主资源线信息(圣衣)</div>
    <table id="shengyiTable" class="table table-striped table-bordered table-condensed">
        <tr>
            <th>最大等级</th>
            <th>当前等级</th>
            <th>获得时间</th>
            <th>更新时间</th>
        </tr>
        <c:forEach items="${shengyi}" var="shengyi">
            <tr>
                <td>${shengyi.maxRank}</td>
                <td>${shengyi.rank}</td>
                <td>${shengyi.create_time}</td>
                <td>${shengyi.update_time}</td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>