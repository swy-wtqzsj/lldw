<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // 错误页不向客户端暴露任何异常堆栈或框架信息
    Integer code = (Integer) request.getAttribute("javax.servlet.error.status_code");
    int status = (code == null) ? 500 : code;
    String title;
    String desc;
    switch (status) {
        case 400: title = "请求有误"; desc = "请求参数不正确，请检查后重试。"; break;
        case 403: title = "禁止访问"; desc = "您没有权限访问该资源。"; break;
        case 404: title = "页面不存在"; desc = "您访问的页面不存在或已被移除。"; break;
        default:  title = "系统繁忙"; desc = "服务暂时不可用，请稍后再试。";
    }
    pageContext.setAttribute("errStatus", status);
    pageContext.setAttribute("errTitle", title);
    pageContext.setAttribute("errDesc", desc);
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${errTitle} - 流浪猫狗救助系统</title>
    <style>
        body{margin:0;font-family:-apple-system,"Microsoft YaHei",sans-serif;background:#f5f7fa;color:#333;}
        .wrap{min-height:100vh;display:flex;align-items:center;justify-content:center;text-align:center;}
        .card{background:#fff;padding:48px 56px;border-radius:12px;box-shadow:0 4px 20px rgba(0,0,0,.08);max-width:460px;}
        .code{font-size:72px;font-weight:700;color:#4a90e2;margin:0;line-height:1;}
        h1{font-size:22px;margin:16px 0 8px;}
        p{color:#888;margin:0 0 24px;}
        a{display:inline-block;padding:10px 28px;background:#4a90e2;color:#fff;text-decoration:none;border-radius:6px;}
        a:hover{background:#357abd;}
    </style>
</head>
<body>
<div class="wrap">
    <div class="card">
        <p class="code">${errStatus}</p>
        <h1>${errTitle}</h1>
        <p>${errDesc}</p>
        <a href="${pageContext.request.contextPath}/">返回首页</a>
    </div>
</div>
</body>
</html>
