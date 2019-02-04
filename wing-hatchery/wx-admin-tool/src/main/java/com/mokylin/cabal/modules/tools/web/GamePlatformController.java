package com.mokylin.cabal.modules.tools.web;

import com.google.common.collect.Lists;
import com.mokylin.cabal.common.config.Global;
import com.mokylin.cabal.common.utils.StringUtils;
import com.mokylin.cabal.common.web.BaseController;

import com.mokylin.cabal.modules.sys.service.SystemService;
import com.mokylin.cabal.modules.tools.entity.GamePlatform;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

/**
 * 作者: 稻草鸟人
 * 日期: 2014/10/27 18:15
 * 项目: cabal-tools
 */
@Controller
@RequestMapping(value = "${adminPath}/tools/gamePlatform")
public class GamePlatformController extends BaseController {

    @Autowired
    private SystemService systemService;

    @ModelAttribute("gamePlatform")
    public GamePlatform get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return systemService.getGamePlatform(id);
        } else {
            return new GamePlatform();
        }
    }

    @RequestMapping(value = {"list", ""})
    public String list(GamePlatform gamePlatform, Model model) {
        List<GamePlatform> list = systemService.findAllGamePlatform();
        model.addAttribute("list", list);
        return "modules/tools/gamePlatformList";
    }

    @RequestMapping(value = "form")
    public String form(GamePlatform gamePlatform, Model model) {

        model.addAttribute("gamePlatform", gamePlatform);
        return "modules/tools/gamePlatformForm";
    }

    @RequestMapping(value = "save")
    public String save(GamePlatform gamePlatform, Model model, String oldName, RedirectAttributes redirectAttributes) {

        if (!beanValidator(model, gamePlatform)) {
            return form(gamePlatform, model);
        }
        if (!"true".equals(checkName(oldName, gamePlatform.getName()))) {
            addMessage(model, "保存平台'" + gamePlatform.getName() + "'失败, 平台名已存在");
            return form(gamePlatform, model);
        }

        systemService.saveGamePlatform(gamePlatform);
        addMessage(redirectAttributes, "保存平台'" + gamePlatform.getName() + "'成功");
        return "redirect:" + Global.getAdminPath() + "/tools/gamePlatform/";
    }


    public String checkName(String oldName, String name) {
        if (name != null && name.equals(oldName)) {
            return "true";
        } else if (name != null && systemService.findGamePlatformByName(name) == null) {
            return "true";
        }
        return "false";
    }


    @RequestMapping(value = "delete")
    public String delete(String id, RedirectAttributes redirectAttributes) {
        systemService.deleteGamePlatform(id);
        addMessage(redirectAttributes, "删除平台成功");
        return "redirect:" + Global.getAdminPath() + "/tools/gamePlatform/";
    }
}
