package com.mokylin.cabal.modules.tools.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.MapUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mokylin.cabal.common.persistence.MybatisParameter;
import com.mokylin.cabal.common.persistence.Page;
import com.mokylin.cabal.common.persistence.Result;
import com.mokylin.cabal.common.persistence.dynamicDataSource.LookupContext;
import com.mokylin.cabal.common.utils.StringUtils;
import com.mokylin.cabal.common.web.BaseController;
import com.mokylin.cabal.modules.sys.utils.ConfigConstants;
import com.mokylin.cabal.modules.sys.utils.UserUtils;
import com.mokylin.cabal.modules.tools.entity.GamePlatform;

@Controller
@RequestMapping(value = "${adminPath}/tools/gameArea")
public class GameAreaController extends BaseController {

    @RequestMapping(value = "gameAreas")
    public String gameAreas(HttpServletRequest request, HttpServletResponse response, Model model) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        parameter.setPage(new Page(request, response));
        Page<Map<String, Object>> page = toolDaoTemplate.paging("gameArea.findGameAreas", parameter);
        model.addAttribute("page", page);
        return "modules/tools/gameAreaList";
    }

    @RequestMapping(value = {"selectSingleGameServer"})
    public String selectSingleGameServer(HttpServletRequest request, HttpServletResponse response, Model model) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        String pid = MapUtils.getString(parameter, "pid");
        parameter.put("pid", pid);
        Page<Map<String, Object>> page = null;
        // 没有平台参数，默认不查询
        if (pid != null && StringUtils.isNotBlank(pid)) {
            page = toolPaging(request, response, "gameArea.findGameAreaByPid");
        } else {
            page = new Page<Map<String, Object>>(request, response);
        }
        model.addAttribute("page", page);
        return "modules/tools/singleGameAreaList";
    }

    @RequestMapping(value = "changeGameServer")
    public @ResponseBody
    Result changeGameServer(HttpServletRequest request, Model model) {
        String gameServerId = request.getParameter("gameServerId");
        request.getSession().setAttribute(ConfigConstants.SELECTED_SERVER_KEY,
                gameServerId);
        LookupContext.setCurrentServerId(gameServerId);
        model.addAttribute("message", "切换服务器成功");
        return new Result(true).data(request.getParameter("gameServerName"));
    }

    /**
     * 多选服务器弹窗，去除了合过服的机器
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "openGameServerDialog")
    public String openServerDialog(HttpServletRequest request, Model model) {

        model.addAttribute("gamePlatform", UserUtils.getGamePlatformListContainServer());

        return "modules/tools/gameServerDialog";
    }

}
