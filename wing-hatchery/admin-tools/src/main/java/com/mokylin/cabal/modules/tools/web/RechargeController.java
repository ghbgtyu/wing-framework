package com.mokylin.cabal.modules.tools.web;

import com.mokylin.cabal.common.config.Global;
import com.mokylin.cabal.common.persistence.MybatisParameter;
import com.mokylin.cabal.common.persistence.Page;
import com.mokylin.cabal.common.persistence.Result;
import com.mokylin.cabal.common.persistence.dynamicDataSource.LookupContext;
import com.mokylin.cabal.common.utils.StringUtils;
import com.mokylin.cabal.common.web.BaseController;
import com.mokylin.cabal.modules.tools.entity.Recharge;
import edu.emory.mathcs.backport.java.util.Arrays;
import org.apache.commons.collections.MapUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 作者: 稻草鸟人
 * 日期: 2014/11/13 17:06
 * 项目: cabal-tools
 * 元宝充值
 */
@Controller
@RequestMapping(value = "${adminPath}/tools/recharge")
public class RechargeController extends BaseController {

    @ModelAttribute
    public Recharge get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return toolDaoTemplate.selectOne("recharge.selectOneById", id);
        } else {
            return new Recharge();
        }
    }

    @RequestMapping(value = {"list", ""})
    public String list(Recharge recharge, HttpServletRequest request, HttpServletResponse response, Model model) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        parameter.setPage(new Page(request, response));
        Page<Map<String, Object>> page = toolDaoTemplate.paging("recharge.paging", parameter);

        model.addAttribute("page", page);
        return "modules/tools/rechargeList";
    }

    @RequiresPermissions("game.recharge.apply")
    @RequestMapping(value = "form")
    public String form(Recharge recharge, Model model) {

        return "modules/tools/rechargeForm";
    }

    @RequiresPermissions("game.recharge.apply")
    @RequestMapping(value = "save")
    public String save(Recharge recharge, Model model, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        List<String> roleNameList = new ArrayList<>();
        List<String> roleIdList = new ArrayList<>();
        List<Map> list = new ArrayList<Map>();
        recharge.setServerId(LookupContext.getCurrentServerId());
        //判断是按照角色名充值还是按照角色Id
      
        if(recharge.getRoleNames()!=null){
        	 roleNameList = Arrays.asList(StringUtils.split(recharge.getRoleNames(), "\r\n"));
             parameter.put("roleNameList", roleNameList);
             list = gameDaoTemplate.selectListByServerId(LookupContext.getCurrentServerId(), "role.findRoleByRoleNameList", parameter);
        }else{
        	roleIdList = Arrays.asList(StringUtils.split(recharge.getRoleIds(), "\r\n"));
             parameter.put("roleIdList", roleIdList);
             list = gameDaoTemplate.selectListByServerId(LookupContext.getCurrentServerId(), "role.findRoleByRoleIdList", parameter);
        }
        String roleIds = "";
        String roleNames = "";
        String userIds = "";
        for (Map map : list) {
            roleIds = roleIds == "" ? roleIds + MapUtils.getString(map, "id") : roleIds + "," + MapUtils.getString(map, "id");
            roleNames = roleNames == "" ? roleNames + MapUtils.getString(map, "name") : roleNames + "," + MapUtils.getString(map, "name");
            userIds = userIds == "" ? userIds + MapUtils.getString(map, "user_id") : userIds + "," + MapUtils.getString(map, "user_id");
        }

        if (roleIds == "" || StringUtils.isBlank(roleIds)) {
            addMessage(model, "当前服查询按照角色查询不到对应的玩家信息");
            return form(recharge, model);
        }

        int size = Arrays.asList(StringUtils.split(roleIds, ",")).size();
        System.out.println(roleIdList.size());
        if(roleNameList.size()!=0){
        	if (roleNameList.size() != size) {
                addMessage(model, "输入的角色名数量和当前服查询到的玩家数量不一致");
                return form(recharge, model);
            }
        }else{
        	if (roleIdList.size() != size) {
                addMessage(model, "输入的角色ID数量和当前服查询到的玩家数量不一致");
                return form(recharge, model);
            }
        }
        parameter.put("serverId", recharge.getServerId());
        parameter.put("userIds", userIds);
        parameter.put("roleIds", roleIds);
        parameter.put("roleNames", roleNames);
        toolDaoTemplate.insert("recharge.insert", parameter);
        addMessage(redirectAttributes, "申请成功，此次申请人数共:" + size + "人");

        return "redirect:" + Global.getAdminPath() + "/tools/recharge/";
    }

    /**
     * 批量审核，然后直接充值
     *
     * @return
     */
    @RequiresPermissions("game.recharge.batchadd")
    @RequestMapping(value = "batchAdd")
    public String batchAdd(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");

        List<Recharge> rechargeList = toolDaoTemplate.selectList("recharge.findRechargeByIdList", parameter);

        gameTemplate.treasureOperation().recharge(rechargeList);

        parameter.put("rechargeStatus", 1);  //通过
        toolDaoTemplate.update("recharge.batchUpdateStatus", parameter);

        addMessage(redirectAttributes, "审核并充值成功！！");

        return "redirect:" + Global.getAdminPath() + "/tools/recharge/";
    }

    @RequiresPermissions("game.recharge.batchcancel")
    @ResponseBody
    @RequestMapping(value = "batchCancel")
    public Result batchCancel(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        List<String> recordId = (List<String>) MapUtils.getObject(parameter, "recordIdList");
        List<String> status = toolDaoTemplate.selectList("recharge.selectStatus", parameter); 
        if(status.contains("1")||status.contains("2")){
            String data = "已取消和已审核的申请将不能再取消，请重新选择！";
            return new Result(false).data(data);
        }else{
        	 parameter.put("rechargeStatus", 2);  //取消状态
             toolDaoTemplate.update("recharge.batchUpdateStatus", parameter);
             String data = "取消成功，共取消申请：" + recordId.size() + "条";
             return new Result(true).data(data);
        }
       
    }

    
    
    @RequiresPermissions("game.recharge.batchrecover")
    @ResponseBody
    @RequestMapping(value = "batchRecover")
    public Result batchRecover(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        MybatisParameter parameter = (MybatisParameter) request.getAttribute("paramMap");
        List<String> recordIds = (List<String>) MapUtils.getObject(parameter, "recordIdList");
        List<String> status = toolDaoTemplate.selectList("recharge.selectStatus", parameter); 
        if(status.contains("0")||status.contains("1")){
        	String data = "待审核和已审核的申请将不能再恢复，请重新选择！";
            return new Result(false).data(data);
        	
        }else{
        	 parameter.put("rechargeStatus", 0);  //待审核状态
        	 toolDaoTemplate.update("recharge.batchUpdateStatus", parameter);
        	 String data = "恢复成功，共恢复申请：" + recordIds.size() + "条";
             return new Result(true).data(data);
          }
        
    }
    
    /**
     * 按角色id申请充值跳转
     */
    @RequiresPermissions("game.recharge.apply")
    @RequestMapping(value = "roleIdRechargeForm")
    public String RoleIdRechargeForm(Recharge recharge, Model model) {
        return "modules/tools/roleIdRechargeForm";
    }
    
    
}
