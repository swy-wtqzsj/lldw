package com.salmon.pet.listener;

import com.salmon.pet.utils.XssELResolver;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.jsp.JspFactory;

/**
 * 应用启动时把全局 XSS 转义 Resolver 注册进 JSP EL 上下文。
 * 注册后全站 JSP 的 ${...} 字符串输出自动做 HTML 转义。
 */
public class XssResolverListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        JspFactory.getDefaultFactory()
                .getJspApplicationContext(sce.getServletContext())
                .addELResolver(new XssELResolver());
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // no-op
    }
}
