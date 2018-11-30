package com.mokylin.cabal.web;

import com.mokylin.cabal.common.persistence.BaseTest;
import com.mokylin.cabal.common.persistence.MybatisParameter;
import com.mokylin.cabal.modules.global.web.DashboardController;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.mock.web.MockServletContext;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter;

import javax.servlet.http.HttpServletRequest;

import static org.junit.Assert.assertEquals;

/**
 * 作者: 稻草鸟人
 * 日期: 2015/1/4 12:54
 * 项目: admin-tools
 */
public class DashboardControllerTest extends BaseTest {

    private MockHttpServletRequest request = new MockHttpServletRequest();
    private MockHttpServletResponse response = new MockHttpServletResponse();
    private MockServletContext msc = new MockServletContext();
    private DashboardController dashboardController;
    @Autowired
    private RequestMappingHandlerAdapter handlerAdapter;

    @Test
    public void testBaseReport() throws Exception {
        dashboardController = (DashboardController) applicationContext.getBean("dashboardController");
        request.setMethod(HttpMethod.POST.name());
        MybatisParameter paramMap = new MybatisParameter();
        request.setAttribute("paramMap", paramMap);
        ModelAndView modelAndView = handlerAdapter.handle(request, response, new HandlerMethod(dashboardController,"baseReport",HttpServletRequest.class,Model.class));
        assertEquals("modules/global/baseReport", modelAndView.getViewName());
    }
}
