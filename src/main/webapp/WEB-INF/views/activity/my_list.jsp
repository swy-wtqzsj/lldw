<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的活动 - 流浪猫狗救助系统</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助系统</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/activity/list">志愿活动</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/activity/my">我的活动</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/profile">${sessionScope.loginUser.nickname}</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h3 class="mb-3">我的活动</h3>

    <div class="row">
        <c:forEach var="item" items="${list}">
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-body">
                        <h5 class="card-title">${item.title}</h5>
                        <p class="card-text text-muted">
                            <small>时间：<fmt:formatDate value="${item.startTime}" pattern="yyyy-MM-dd HH:mm"/></small><br>
                            <small>地点：${item.location}</small><br>
                            <small>已报名：${item.signupCount}/${item.maxPeople == 0 ? '不限' : item.maxPeople}人</small>
                        </p>
                        <a href="${pageContext.request.contextPath}/activity/detail/${item.activityId}" class="btn btn-sm btn-primary">查看详情</a>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty list}">
            <div class="col-12 text-center text-muted py-5">
                你还没有报名任何活动，去<a href="${pageContext.request.contextPath}/activity/list">志愿活动</a>看看吧
            </div>
        </c:if>
    </div>
</div>
</body>
</html>
