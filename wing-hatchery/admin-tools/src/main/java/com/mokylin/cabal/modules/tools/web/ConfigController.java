package com.mokylin.cabal.modules.tools.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mokylin.cabal.common.config.Global;
import com.mokylin.cabal.common.persistence.MybatisParameter;
import com.mokylin.cabal.common.utils.StringUtils;
import com.mokylin.cabal.common.web.BaseController;
import com.mokylin.cabal.modules.tools.entity.ConfigFile;
import com.mokylin.cabal.modules.tools.entity.mothRevenue;

/**
 * 运营数据配置
 * @author 
 */
@Controller
@RequestMapping(value = "${adminPath}/tools/config")
public class ConfigController extends BaseController {

	@ModelAttribute
    public mothRevenue get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return toolDaoTemplate.selectOne("monthRevenue.selectOneById", id);
        } else {
            return new mothRevenue();
        }
    }

	
	
	
	/**
	 * 月营收入指标列表
	 */
	@RequestMapping( value = "list")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model){
		  model.addAttribute("list", toolDaoTemplate.selectList("monthRevenue.index"));
		  return "modules/tools/mothRevenueList";
	}
	
	
	
	/**
	 * 月营收指标模型（添加）
	 */
	@RequestMapping(value ="save")
	public  String monthRevenueModel(mothRevenue monthRevenue,HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes){
		  MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
		  if(monthRevenue!=null){
			  parameter.put("payment",Double.valueOf(parameter.get("payNum").toString()) /Double.valueOf(parameter.get("active").toString()));
	    	  parameter.put("arpu", Integer.valueOf(parameter.get("income").toString())/Integer.valueOf(parameter.get("payNum").toString()));
			     if(parameter.containsKey("type")&&parameter.get("type").equals("新增")){
			    	  toolDaoTemplate.insert("monthRevenue.insert",parameter);
				      addMessage(redirectAttributes,"保存成功");
				      return "redirect:"+ Global.getAdminPath()+"/tools/config/list";
			     }else{
			    	 toolDaoTemplate.update("monthRevenue.updateRevenue", parameter);
				     addMessage(redirectAttributes,"修改成功");
				  return "redirect:"+ Global.getAdminPath()+"/tools/config/list";
			     }
			     
		  }else{
			  addMessage(redirectAttributes,"输入有误！");
			  return "redirect:"+ Global.getAdminPath()+"/tools/config/form";
		  }			
	}
	
	/**
	 * 月营收指标模型（修改跳转页面）
	 */
	 @RequestMapping(value = "form")
	 public String form(String id, HttpServletRequest request, HttpServletResponse response,Model model) {
		  model.addAttribute("id", id);
	      return "modules/tools/mothRevenueModel";
	    }
	
	 
	 
	 
}
