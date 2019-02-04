package com.mokylin.cabal.modules.log.web;

import com.mokylin.cabal.common.persistence.MybatisParameter;
import com.mokylin.cabal.common.persistence.Page;
import com.mokylin.cabal.common.web.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * 作者: 稻草鸟人
 * 日期: 2014/11/24 15:05
 * 项目: cabal-tools
 */
@Controller(value = "roleRecharge")
@RequestMapping(value = "${adminPath}/log/recharge")
public class RechargeController extends BaseController {


    @RequestMapping(value = {"list", ""})
    public String list(HttpServletRequest request, HttpServletResponse response, Model model) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        parameter.setPage(new Page(request, response));
        Page<Map<String, Object>> page = logDaoTemplate.paging("roleRecharge.paging", parameter);

        model.addAttribute("page", page);
        return "modules/logs/rechargeList";
    }

    @RequestMapping(value = "chargeStatistics")
    public String chargeStatistic(HttpServletRequest request, HttpServletResponse response, Model model) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        parameter.setPage(new Page(request, response));
        Page<Map<String, Object>> page = logDaoTemplate.paging("roleRecharge.chargeStatistics", parameter);

        model.addAttribute("page", page);
        return "modules/logs/chargeStatistics";
    }
}
