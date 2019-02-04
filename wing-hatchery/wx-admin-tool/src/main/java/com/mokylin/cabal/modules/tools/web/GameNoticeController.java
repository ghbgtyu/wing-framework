package com.mokylin.cabal.modules.tools.web;

import com.mokylin.cabal.common.config.Global;
import com.mokylin.cabal.common.persistence.MybatisParameter;
import com.mokylin.cabal.common.persistence.Page;
import com.mokylin.cabal.common.persistence.Result;
import com.mokylin.cabal.common.utils.IdGen;
import com.mokylin.cabal.common.utils.StringUtils;
import com.mokylin.cabal.common.web.BaseController;
import com.mokylin.cabal.modules.tools.entity.GameNotice;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 作者: 稻草鸟人
 * 日期: 2014/10/30 11:27
 * 项目: cabal-tools
 */
@Controller
@RequestMapping(value = "${adminPath}/tools/gameNotice")
public class GameNoticeController extends BaseController {

    @ModelAttribute
    public GameNotice get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return toolDaoTemplate.selectOne("gameNotice.selectOneById", id);
        } else {
            return new GameNotice();
        }
    }

    @RequestMapping(value = {"list", ""})
    public String getGameServerList(GameNotice gameNotice, HttpServletRequest request, HttpServletResponse response, Model model) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        parameter.setPage(new Page(request, response));

        Page<GameNotice> page = toolDaoTemplate.paging("gameNotice.paging", parameter);

        model.addAttribute("page", page);
        return "modules/tools/gameNoticeList";
    }

    @RequiresPermissions("game.notice.edit")
    @RequestMapping(value = "form")
    public String form(GameNotice gameNotice, Model model) {

//        JSONArray nodes = new JSONArray();
//        for(GamePlatform gamePlatform : gamePlatforms){
//            JSONObject object = new JSONObject();
//            object.put("name",gamePlatform.getName());
//            JSONArray array = new JSONArray();
//            Collection<Server> serverList = GameAreaUtils.getGameServerList(gamePlatform.getPid());
//            for(Server gameServer : serverList){
//                JSONObject jsonObject = new JSONObject();
//                jsonObject.put("id",gameServer.getWorldId());
//                jsonObject.put("name",gameServer.getWorldName()+"【"+gameServer.getWorldId()+"】");
//                array.add(jsonObject);
//            }
//            object.put("children",array);
//            nodes.add(object);
//        }
//        model.addAttribute("nodes",nodes);
//        model.addAttribute("gamePlatform", UserUtils.getGamePlatformList());
//        model.addAttribute("gameServerList", GameServerUtils.getGameServerWithoutHeFu());

        return "modules/tools/gameNoticeForm";
    }

    @RequiresPermissions("game.notice.edit")
    @RequestMapping(value = "save")
    public String save(GameNotice gameNotice, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        parameter.put("id", IdGen.uuid());
        parameter.put("noticeStatus", 0);    //尚未发布

        toolDaoTemplate.insert("gameNotice.insert", parameter);
        addMessage(redirectAttributes, "新增公告成功");

        return "redirect:" + Global.getAdminPath() + "/tools/gameNotice/";
    }


    /**
     * GM 后台标记为已删除状态，请求游戏删除公告，达到取消的目的
     *
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("game.notice.delete")
    @RequestMapping(value = "delete")
    public String delete(GameNotice gameNotice, RedirectAttributes redirectAttributes) {
        //请求Game接口要求删除服务器公告
        Result result = gameTemplate.announceOperation().deleteAnnounce(gameNotice);
        if (result.isSuccess()) {
            toolDaoTemplate.delete("gameNotice.delete", gameNotice.getId());
        }
        addMessage(redirectAttributes, "删除公告成功");
        return "redirect:" + Global.getAdminPath() + "/tools/gameNotice/";
    }

    @RequiresPermissions("game.notice.publish")
    @RequestMapping(value = "publish")
    public String publish(@ModelAttribute GameNotice gameNotice, Model model, RedirectAttributes redirectAttributes, HttpSession session) {

        Result result = gameTemplate.announceOperation().addAnnounce(gameNotice);
        if (result.isSuccess()) {
            gameNotice.setNoticeStatus("1");                      //1 表示已发布，这里应该可以再改进，不直接写1
            toolDaoTemplate.update("gameNotice.updateStatus", gameNotice);
        }
        addMessage(redirectAttributes, "发布公告成功");
        return "redirect:" + Global.getAdminPath() + "/tools/gameNotice/";
    }
}
