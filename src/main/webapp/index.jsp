<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>流浪猫狗救助系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-inverse">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助</a>
        </div>
        <ul class="nav navbar-nav">
            <li class="active"><a href="#">首页</a></li>
            <li><a href="#">领养中心</a></li>
            <li><a href="#">知识科普</a></li>
            <li><a href="#">团队活动</a></li>
            <li><a href="#">求助中心</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <li><a href="${pageContext.request.contextPath}/profile">${sessionScope.loginUser.nickname}</a></li>
                    <li><a href="${pageContext.request.contextPath}/logout">退出</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${pageContext.request.contextPath}/login">登录</a></li>
                    <li><a href="${pageContext.request.contextPath}/register">注册</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>

<div class="container">
    <div class="jumbotron">
        <h1>给流浪的它一个家</h1>
        <p>浏览待领养的流浪猫狗，在线申请领养，让它们回归温暖的家庭。</p>
        <p><a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/login">开始领养</a></p>
    </div>
</div>
</body>
</html>
