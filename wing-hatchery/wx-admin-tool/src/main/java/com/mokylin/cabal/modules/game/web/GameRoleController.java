package com.mokylin.cabal.modules.game.web;

import com.alibaba.fastjson.JSON;
import com.mokylin.cabal.common.config.Global;
import com.mokylin.cabal.common.persistence.MybatisParameter;
import com.mokylin.cabal.common.persistence.Page;
import com.mokylin.cabal.common.persistence.Result;
import com.mokylin.cabal.common.persistence.dynamicDataSource.LookupContext;
import com.mokylin.cabal.common.redis.Server;
import com.mokylin.cabal.common.utils.Encodes;
import com.mokylin.cabal.common.utils.IdGen;
import com.mokylin.cabal.common.utils.StringUtils;
import com.mokylin.cabal.common.web.BaseController;
import com.mokylin.cabal.modules.game.utils.TongyongLogin;
import com.mokylin.cabal.modules.sys.utils.ConfigConstants;
import com.mokylin.cabal.modules.sys.utils.UserUtils;
import com.mokylin.cabal.modules.tools.entity.GamePlatform;
import com.mokylin.cabal.modules.tools.utils.GameAreaUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * 虞美人·春花秋月何时了 五代·李煜
 * <p>
 * 春花秋月何时了？往事知多少。小楼昨夜又东风，故国不堪回首月明中。
 * 雕栏玉砌应犹在，只是朱颜改。问君能有几多愁？恰似一江春水向东流
 * <p>
 * 作者: 稻草鸟人
 * 日期: 2014/11/11 13:33
 * 项目: cabal-tools
 */
@Controller
@RequestMapping(value = "${adminPath}/game/role")
public class GameRoleController extends BaseController {

    @RequestMapping(value = "gameRoleDialog")
    public String openGameRoleDialog(String serverId, HttpServletRequest request, HttpServletResponse response, Model model) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        parameter.setPage(new Page(request, response));
        String roleId = MapUtils.getString(parameter, "roleId");
        String roleName = MapUtils.getString(parameter, "roleName");
        String startLevel = MapUtils.getString(parameter, "startLevel");
        String endLevel = MapUtils.getString(parameter, "endLevel");

        if (StringUtils.isNotBlank(serverId) && (StringUtils.isNotBlank(roleId) || StringUtils.isNotBlank(roleName)
                || StringUtils.isNotBlank(startLevel) || StringUtils.isNotBlank(endLevel))) {
            model.addAttribute("page", gameDaoTemplate.paging(serverId, "role.roleDialog", parameter));
        }

        return "modules/game/gameRoleDialog";
    }

    @RequestMapping(value = {"list", ""})
    public String list(HttpServletRequest request, HttpServletResponse response, Model model) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        parameter.setPage(new Page(request, response));
        Page<Map<String, Object>> page = gameDaoTemplate.paging("role.paging", parameter);

        model.addAttribute("page", page);

        return "modules/game/gameRoleList";
    }

    @RequiresPermissions("game.role.logingame")
    @RequestMapping(value = "loginGame")
    public String loginGame(String userId, String serverId, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String url = null;
        Server server = GameAreaUtils.getGameServerByServerId(serverId);
        if (server == null) {
            addMessage(redirectAttributes, "找不到游戏服务器！");
            return "redirect:" + url;
        }
        GamePlatform gamePlatform = GameAreaUtils.getGamePlatformByPId(String.valueOf(server.getPlatformId()));
        try {
            url = TongyongLogin.LoginGame(userId, serverId, server.createGateUrl(), gamePlatform.getSignKey());
        } catch (Exception e) {
            logger.error("", JSON.toJSONString(gamePlatform));
            logger.error("", ExceptionUtils.getStackTrace(e));
        }

        return "redirect:" + url;
    }


    @RequestMapping(value = "form")
    public String form(String id, HttpServletRequest request, Model model) {
        model.addAttribute("role", gameDaoTemplate.selectOne("role.findRoleById", id));
        model.addAttribute("items", gameDaoTemplate.selectList("item.findItemByRoleId", id));
        model.addAttribute("horse", gameDaoTemplate.selectList("horse.findHorseByRoleId", id));    //主资源信息（坐骑）
        model.addAttribute("cloak", gameDaoTemplate.selectList("cloak.findCloakByRoleId", id));    //主资源线信息（神翼）cloak
        model.addAttribute("nvwushen", gameDaoTemplate.selectList("nvwushen.findByRoleId", id));   //主资源线信息（女武神）role_nvwushen
        model.addAttribute("touxian", gameDaoTemplate.selectList("touxian.findByRoleId", id));     //主资源线信息（头衔）role_touxian
        model.addAttribute("tiansuo", gameDaoTemplate.selectList("tiansuo.findByRoleId", id));     //主资源线信息（天梭）role_tiansuo
        model.addAttribute("huashen", gameDaoTemplate.selectList("huashen.findByRoleId", id));     //主资源线信息（化神）role_huashen
        model.addAttribute("shengyi", gameDaoTemplate.selectList("shengyi.findByRoleId", id));     //主资源线信息（圣衣）role_shengyi

        return "modules/game/gameRoleForm";
    }

    @RequiresPermissions("game.role.jinyan")
    @RequestMapping(value = "jinYan")
    public Result jinYan(HttpServletRequest request, RedirectAttributes redirectAttributes) {

        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");

        Result result = gameTemplate.roleOperation().jinYan(MapUtils.getString(parameter, "serverId"), MapUtils.getString(parameter, "roleId"));
        if (result.isSuccess()) {
            //禁言之后的角色信息,查询出来，插入禁言封号日志表
            parameter.put("operationType", ConfigConstants.OPERATION_TYPE_SILENCE);
            parameter.put("msg", Encodes.urlEncode("监控禁言"));

            logging(parameter);

            return new Result(true).data("监控禁言成功");
        }

        return new Result(true).data("监控禁言失败");
    }

    @RequiresPermissions("game.role.jinyan")
    @RequestMapping(value = "batchJinYan")
    public String batchJinYan(HttpServletRequest request, RedirectAttributes redirectAttributes) {

        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        List<String> roleIds = (List<String>) parameter.get("recordIdList");
        Result result = gameTemplate.roleOperation().batchJinYan(roleIds);
        if (result.isSuccess()) {
            //禁言之后的角色信息,查询出来，插入禁言封号日志表
            parameter.put("operationType", ConfigConstants.OPERATION_TYPE_SILENCE);

            logging(parameter);

            addMessage(redirectAttributes, "批量禁言成功，共禁言:" + roleIds.size() + "角色");
        } else {
            addMessage(redirectAttributes, "批量禁言失败！");
        }
        return "redirect:" + Global.getAdminPath() + "/game/role/";
    }

    @RequiresPermissions("game.role.fenghao")
    @RequestMapping(value = "batchFengHao")
    public String batchFengHao(HttpServletRequest request, RedirectAttributes redirectAttributes) {

        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        List<String> roleIds = (List<String>) parameter.get("recordIdList");
        Result result = gameTemplate.roleOperation().batchFenHao(roleIds);
        if (result.isSuccess()) {
            parameter.put("operationType", ConfigConstants.OPERATION_TYPE_FREEZE);
            logging(parameter);
            addMessage(redirectAttributes, "批量封号成功，共封号:" + roleIds.size() + "角色");
        } else {
            addMessage(redirectAttributes, "批量封号失败！");
        }
        return "redirect:" + Global.getAdminPath() + "/game/role/";
    }

    @RequiresPermissions("game.role.jinyan")
    @RequestMapping(value = "batchCancelJinYan")
    public String batchCancelJinYan(HttpServletRequest request, RedirectAttributes redirectAttributes) {

        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        List<String> roleIds = (List<String>) parameter.get("recordIdList");
        Result result = gameTemplate.roleOperation().batchCancelJinYan(roleIds);
        if (result.isSuccess()) {
            parameter.put("operationType", ConfigConstants.OPERATION_TYPE_CANCEL_SILENCE);
            logging(parameter);
            addMessage(redirectAttributes, "批量禁言成功，共禁言:" + roleIds.size() + "角色");
        } else {
            addMessage(redirectAttributes, "批量禁言失败！");
        }
        return "redirect:" + Global.getAdminPath() + "/game/role/";
    }

    @RequiresPermissions("game.role.fenghao")
    @RequestMapping(value = "batchCancelFengHao")
    public String batchCancelFengHao(HttpServletRequest request, RedirectAttributes redirectAttributes) {

        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        List<String> roleIds = (List<String>) parameter.get("recordIdList");
        Result result = gameTemplate.roleOperation().batchCancelFenHao(roleIds);
        if (result.isSuccess()) {
            parameter.put("operationType", ConfigConstants.OPERATION_TYPE_CANCEL_FREEZE);
            logging(parameter);
            addMessage(redirectAttributes, "批量取消封号成功，共封号:" + roleIds.size() + "角色");
        } else {
            addMessage(redirectAttributes, "批量封号失败！");
        }
        return "redirect:" + Global.getAdminPath() + "/game/role/";
    }

    private void logging(Map<String, Object> map) {
        //角色信息,查询出来，插入禁言封号日志表
        List<Map<String, Object>> roleList = gameDaoTemplate.selectList("role.findRoleByIdList", map);
        String createName = UserUtils.getUser().getLoginName();
        String createBy = UserUtils.getUser().getId();
        for (Map<String, Object> role : roleList) {
            role.put("msg", Encodes.urlDecode(MapUtils.getString(map, "msg")));
            role.put("id", IdGen.uuid());                   //一条记录一个主键
            role.put("createName", createName);
            role.put("createBy", createBy);
            role.put("operationType", MapUtils.getString(map, "operationType"));
        }

        toolDaoTemplate.batchInsert2("silenceFreezeLog.batchInsert", roleList);
    }

    @RequestMapping(value = "silenceFreezeLog")
    public String log(HttpServletRequest request, HttpServletResponse response, Model model) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        parameter.setPage(new Page(request, response));
        Page<Map<String, Object>> page = toolDaoTemplate.paging("silenceFreezeLog.paging", parameter);
        model.addAttribute("page", page);
        return "modules/tools/silenceFreezeLog";
    }

    @RequestMapping(value = "gmList")
    public String gmList(HttpServletRequest request, HttpServletResponse response, Model model) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        parameter.setPage(new Page(request, response));
        Page<Map<String, Object>> page = toolDaoTemplate.paging("gmAccount.paging", parameter);
        model.addAttribute("page", page);

        return "modules/tools/gmList";
    }


    /**
     * 指导员和GM 表单
     *
     * @param model
     * @return
     */
    @RequiresPermissions("game.gm.edit")
    @RequestMapping(value = "gmForm")
    public String addGm(Model model) {

        return "modules/tools/gmForm";
    }

    @RequiresPermissions("game.gm.edit")
    @RequestMapping(value = "updateGmForm")
    public String updateGmForm(HttpServletRequest request, Model model) {
        String id = request.getParameter("id");
        if (StringUtils.isNotBlank(id) && StringUtils.isNotEmpty(id)) {
            Map<String, Object> map = toolDaoTemplate.selectOne("gmAccount.findGmAccountById", id);
            model.addAttribute("map", map);
        }
        return "modules/tools/updateGmForm";
    }

    @RequiresPermissions("game.gm.edit")
    @RequestMapping(value = "saveGm")
    public String saveGm(HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        String roleName = MapUtils.getString(parameter, "roleName");
        String serverId = MapUtils.getString(parameter, "serverIds");
        String roleId = gameDaoTemplate.selectOneByServerId(serverId, "role.findRoleIdByRoleName", parameter);
        if (StringUtils.isEmpty(roleId) || StringUtils.isBlank(roleId)) {
            addMessage(model, "当前服不存在用户:" + roleName);
            return addGm(model);
        }

        parameter.put("roleId", roleId);
        //调用游戏接口，更新角色类型，O、普通玩家 2、指导员 1、GM
        gameTemplate.roleOperation().updateRoleType(serverId, roleId, MapUtils.getString(parameter, "roleType"));

        toolDaoTemplate.insert("gmAccount.insert", parameter);
        addMessage(redirectAttributes, "添加成功，用户名:" + roleName);


        return "redirect:" + Global.getAdminPath() + "/game/role/gmList";
    }

    @RequiresPermissions("game.gm.edit")
    @RequestMapping(value = "updateGm")
    public String updateGm(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");

        //更新游戏角色类型
        Result result = gameTemplate.roleOperation().updateRoleType(MapUtils.getString(parameter, "serverId"),
                MapUtils.getString(parameter, "roleId"), MapUtils.getString(parameter, "roleType"));
        if (result.isSuccess()) {
            toolDaoTemplate.update("gmAccount.update", parameter);
            addMessage(redirectAttributes, "更新角色：" + MapUtils.getString(parameter, "roleName") + "成功");
        } else {
            addMessage(redirectAttributes, "更新角色：" + MapUtils.getString(parameter, "roleName") + "失败");
        }
        return "redirect:" + Global.getAdminPath() + "/game/role/gmList";
    }

    @RequestMapping(value = "gmPublish")
    public String gmPublish(HttpServletRequest request, HttpServletResponse response, Model model) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        parameter.setPage(new Page(request, response));
        Page<Map<String, Object>> page = logDaoTemplate.paging("gmPublish.paging", parameter);
        model.addAttribute("page", page);

        return "modules/logs/gmPublishLog";
    }


    /**
     * 角色等级排行
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "levelRanking")
    public String levelRanking(HttpServletRequest request, HttpServletResponse response, Model model) {

        model.addAttribute("page", gamePaging(request, response, "role.levelRanking"));

        return "modules/game/levelRankingList";
    }

    /**
     * 角色战斗力排行
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = "battleRanking")
    public String powerRanking(HttpServletRequest request, HttpServletResponse response, Model model) {

        model.addAttribute("page", gamePaging(request, response, "role.battleRanking"));

        return "modules/game/battleRankingList";
    }

    @RequiresPermissions("game.role.delete")
    @RequestMapping(value = "delete")
    public String deleteRole(HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        long roleId = MapUtils.getLongValue(parameter, "id");
        String serverId = LookupContext.getCurrentServerId();
        Result result = gameTemplate.roleOperation().delete(serverId, roleId);

        if (result.isSuccess()) {
            addMessage(redirectAttributes, "删除成功");
        } else {
            addMessage(redirectAttributes, "删除失败");
        }
        return "redirect:" + Global.getAdminPath() + "/game/role/";
    }
}
