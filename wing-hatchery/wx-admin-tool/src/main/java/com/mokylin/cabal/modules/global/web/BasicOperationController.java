package com.mokylin.cabal.modules.global.web;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.MapUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mokylin.cabal.common.persistence.MybatisParameter;
import com.mokylin.cabal.common.persistence.Page;
import com.mokylin.cabal.common.utils.Collections3;
import com.mokylin.cabal.common.utils.DateUtils;
import com.mokylin.cabal.common.utils.StringUtils;
import com.mokylin.cabal.common.web.BaseController;

/**
 * 基础运营配置
 * 作者: maojs
 * 日期: 2014/12/15 10:17
 * 项目: cabal-tools
 */

@Controller
@RequestMapping(value = "${adminPath}/global/basicOperation")
public class BasicOperationController extends BaseController {

    // 注册转化分服
    @RequestMapping(value = "regConvertionRealTime")
    public String regConvertionRealTime(HttpServletRequest request, HttpServletResponse response, Model model) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        setDefaultDay(parameter);
        setServerIdList(parameter);
        Page<Map<String, Object>> page = globalPaging(request, response, "regConvertion.findRegConvertionRealTime");

        if (!Collections3.isEmpty(page.getList())) {
            for (Map<String, Object> map : page.getList()) {
                int role_num = MapUtils.getIntValue(map, "role_num");
                int visit_times = MapUtils.getIntValue(map, "visit_times");
                int login_times = MapUtils.getIntValue(map, "login_times");
                if (visit_times == 0) {
                    map.put("create_role_rate", 0);
                } else {
                    map.put("create_role_rate", role_num * 1.f / visit_times * 1.f);
                }
                if (role_num == 0) {
                    map.put("login_rate", 0);
                } else {
                    map.put("login_rate", login_times * 1.f / role_num * 1.f);
                }
            }
        }

        model.addAttribute("page", page);
        // 把serverIdList转成string
        parameter.put("serverIdList", parameter.get("serverIds"));
        return "modules/global/regConvertionRealTime";
    }

    // 注册转化统计
    @RequestMapping(value = "regConvertionTotal")
    public String dailyComprehensiveReport(HttpServletRequest request, HttpServletResponse response, Model model) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        setDefaultTimeRange(parameter);
        setServerIdList(parameter);
        Page<Map<String, Object>> page = globalPaging(request, response, "regConvertion.findRegConvertionTotal");

        if (!Collections3.isEmpty(page.getList())) {
            for (Map<String, Object> map : page.getList()) {
                if (map == null)
                    continue;
                int role_num = MapUtils.getIntValue(map, "role_num");
                int visit_times = MapUtils.getIntValue(map, "visit_times");
                int login_times = MapUtils.getIntValue(map, "login_times");
                if (visit_times == 0) {
                    map.put("create_role_rate", 0);
                } else {
                    map.put("create_role_rate", role_num * 1.f / visit_times * 1.f);
                }
                if (role_num == 0) {
                    map.put("login_rate", 0);
                } else {
                    map.put("login_rate", login_times * 1.f / role_num * 1.f);
                }
            }
        }
        model.addAttribute("page", page);
        // 把serverIdList转成string
        parameter.put("serverIdList", parameter.get("serverIds"));
        return "modules/global/regConvertionTotal";
    }

}
