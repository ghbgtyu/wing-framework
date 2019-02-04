package com.mokylin.cabal.modules.log.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.MapUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mokylin.cabal.common.persistence.MybatisParameter;
import com.mokylin.cabal.common.persistence.Page;
import com.mokylin.cabal.common.utils.StringUtils;
import com.mokylin.cabal.common.web.BaseController;
import com.mokylin.cabal.modules.tools.entity.GameEmail;

/**
 * 邮件日志
 *
 * @author maojs
 * @date 2015年1月8日
 */
@Controller
@RequestMapping(value = "${adminPath}/log/mail")
public class MailController extends BaseController {


    @RequestMapping(value = "list")
    public String getMailList(HttpServletRequest request, HttpServletResponse response, Model model) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        setDefaultTimeRange(parameter);

        // 有adminEmailId的邮件 表示从后台发过来的
        parameter.put("serverId", MapUtils.getString(parameter, "currentServerId"));
        Page<Map<String, Object>> page = logPaging(request, response, "mail.findMailList");

        for (Map<String, Object> map : page.getList()) {
            String adminEmailId = MapUtils.getString(map, "admin_email_id");
            if (StringUtils.isNotBlank(adminEmailId)) {
                GameEmail gameEmail = toolDaoTemplate.selectOne("gameEmail.selectOneById", adminEmailId);
                map.put("gmName", gameEmail.getCreateName());
            }
        }

        model.addAttribute("page", page);

        model.addAttribute("roleId", MapUtils.getString(parameter, "roleId"));
        model.addAttribute("roleName", MapUtils.getString(parameter, "roleName"));
        model.addAttribute("contentKey", MapUtils.getString(parameter, "contentKey"));

        return "modules/logs/mailList";
    }

    /**
     * gm后台详细信息
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "getGmMailInfo")
    public String getGmMailInfo(HttpServletRequest request, Model model) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        String adminEmailId = MapUtils.getString(parameter, "gmMailId");
        GameEmail gameEmail = toolDaoTemplate.selectOne("gameEmail.selectOneById", adminEmailId);
        model.addAttribute("gameEmail", gameEmail);

        return "modules/logs/gmMailDialog";
    }
}
