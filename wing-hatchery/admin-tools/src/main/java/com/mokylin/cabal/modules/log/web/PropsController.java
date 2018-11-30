package com.mokylin.cabal.modules.log.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mokylin.cabal.common.config.Global;
import com.mokylin.cabal.common.persistence.MybatisParameter;
import com.mokylin.cabal.common.persistence.Page;
import com.mokylin.cabal.common.utils.DateUtils;
import com.mokylin.cabal.common.utils.excel.ExportExcel;
import com.mokylin.cabal.common.web.BaseController;
import com.mokylin.cabal.modules.log.entity.PropsDetail;
import com.mokylin.cabal.modules.tools.service.OperationTypeService;

/**
 * 关于道具的日志
 * @author ln
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/log/propController")
public class PropsController extends BaseController {

	/**
	 * 道具消耗日志
	 */
	@RequestMapping(value = "propConsumeList")
	public String propConsumeList(HttpServletRequest request, HttpServletResponse response, Model model){
		MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");	
		List operaTypeList = new ArrayList();
//		if(!parameter.containsKey("createDateStart")&& !parameter.containsKey("createDateEnd")){
			setDefaultTimeRange(parameter);
//		}
		    if(!parameter.containsKey("operaTypeList")&&parameter.containsKey("operaType")){
		    	operaTypeList.add(parameter.get("operaType").toString());
					parameter.put("operaTypeList", operaTypeList);
				} else if(parameter.containsKey("operaTypeList")){
					operaTypeList = (List) parameter.get("operaTypeList");
					 if(operaTypeList.size()==OperationTypeService.getOperaTypeMap().size()){
//						 operaTypeList= new ArrayList();
//						 parameter.put("operaTypeList", operaTypeList);
						 parameter.put("operaTypeList", null);
					 }
				}
			
		parameter.setPage(new Page(request, response));
        Page<Map<String,Object>> page = logDaoTemplate.paging("goodsFlowLog.paging", parameter);
        model.addAttribute("selectedOperas", parameter.get("operaType"));
        model.addAttribute("page", page);
		
		return "modules/logs/propConsumeList";
	}
	
	/**
	 * 道具消耗导出excel
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("log.propConsume.export")
    @RequestMapping(value = "export", method= RequestMethod.POST)
    public String exportFile(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
    	List<String> operaTypeList = new ArrayList<String>();
    	if(!parameter.containsKey("operaTypeList")&&parameter.containsKey("operaType")){
	    	operaTypeList.add(parameter.get("operaType").toString());
				parameter.put("operaTypeList", operaTypeList);
			} else if(parameter.containsKey("operaTypeList")){
				operaTypeList = (List) parameter.get("operaTypeList");
				 if(operaTypeList.size()==OperationTypeService.getOperaTypeMap().size()){
//					 operaTypeList= new ArrayList();
//					 parameter.put("operaTypeList", operaTypeList);
					 parameter.put("operaTypeList", null);
				 }
			}

        try {
            String fileName = "道具消耗"+ DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            List<PropsDetail> PropConsumeList = logDaoTemplate.selectList("goodsFlowLog.paging", parameter);	
            for (int i = 0; i < PropConsumeList.size(); i++) {
				PropConsumeList.get(i).setOpereateType(OperationTypeService.getOperationType(PropConsumeList.get(i).getOpereateType()));
				PropConsumeList.get(i).setFlowType("减少");
			
			}
            new ExportExcel("道具消耗", PropsDetail.class).setDataList(PropConsumeList).write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
            addMessage(redirectAttributes, "导出道具消耗！失败信息："+e.getMessage());
        }
        return "redirect:"+ Global.getAdminPath()+"/log/propController/propConsumeList?repage";
    }
    
    
    /**
     * 道具获取日志
     */
     @RequestMapping(value = "propGainList")
     public String propGainList(HttpServletRequest request, HttpServletResponse response, Model model){
    	 MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");	
 		 List operaTypeList = new ArrayList();
// 		if(!parameter.containsKey("createDateStart")&& !parameter.containsKey("createDateEnd")){
			setDefaultTimeRange(parameter);
//		}
 	
		    if(!parameter.containsKey("operaTypeList")&&parameter.containsKey("operaType")){
		    	operaTypeList.add(parameter.get("operaType").toString());
					parameter.put("operaTypeList", operaTypeList);
				} else if(parameter.containsKey("operaTypeList")){
					operaTypeList = (List) parameter.get("operaTypeList");
					 if(operaTypeList.size()==OperationTypeService.getOperaTypeMap().size()){	
//						 operaTypeList= new ArrayList();
//						 parameter.put("operaTypeList", operaTypeList);
						 parameter.put("operaTypeList", null);
					 }
				}
 			
 		 parameter.setPage(new Page(request, response));
         Page<Map<String,Object>> page = logDaoTemplate.paging("goodsFlowLog.propGainPaging", parameter);
         model.addAttribute("selectedOperas", parameter.get("operaType"));
         model.addAttribute("page", page);
 		 return "modules/logs/propGainList";
    }

     /**
      * 道具获取导出excel
      */
     @RequiresPermissions("log.propGain.export")
     @RequestMapping(value = "gainExport", method= RequestMethod.POST)
     public String gainExport(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        setDefaultTimeRange(parameter);
     	List<String> operaTypeList = new ArrayList<String>();
     	if(!parameter.containsKey("operaTypeList")&&parameter.containsKey("operaType")){
	    	operaTypeList.add(parameter.get("operaType").toString());
				parameter.put("operaTypeList", operaTypeList);
			} else if(parameter.containsKey("operaTypeList")){
				operaTypeList = (List) parameter.get("operaTypeList");
				 if(operaTypeList.size()==OperationTypeService.getOperaTypeMap().size()){
					 // operaTypeList= new ArrayList();
					 parameter.put("operaTypeList", null);
				 }
			}
          try {

             String fileName = "道具获取"+ DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
             List<PropsDetail> PropConsumeList = logDaoTemplate.selectList("goodsFlowLog.propGainPaging", parameter);
            
             for (int i = 0; i < PropConsumeList.size(); i++) {
 				PropConsumeList.get(i).setOpereateType(OperationTypeService.getOperationType(PropConsumeList.get(i).getOpereateType()));
 				PropConsumeList.get(i).setFlowType("增加");
 			
 			}
             new ExportExcel("道具获取", PropsDetail.class).setDataList(PropConsumeList).write(response, fileName).dispose();
             return null;
         } catch (Exception e) {
             addMessage(redirectAttributes, "导出道具获取失败！失败信息："+e.getMessage());
         }
         return "redirect:"+ Global.getAdminPath()+"/log/propController/propGainList?repage";
     }
     
     
}
