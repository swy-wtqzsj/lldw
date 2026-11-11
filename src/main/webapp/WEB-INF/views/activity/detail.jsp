<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${activity.title}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="/pet-adoption/">流浪猫狗救助系统</a>
    </div>
</nav>

<div class="container mt-4">
    <h3>${activity.title}</h3>
    <p class="text-muted">
        时间：${activity.startTime} ~ ${activity.endTime}<br>
        地点：${activity.location}<br>
        已报名：${activity.signupCount}/${activity.maxPeople}人
    </p>

    <hr>

    <p>${activity.content}</p>

    <hr>

    <c:choose>
        <c:when test="${not empty sessionScope.loginUser}">
            <a href="/pet-adoption/activity/signup?activityId=${activity.activityId}" class="btn btn-primary">立即报名</a>
            <a href="/pet-adoption/activity/cancel?activityId=${activity.activityId}" class="btn btn-outline-danger">取消报名</a>
        </c:when>
        <c:otherwise>
            <p class="text-muted">登录后可报名活动</p>
        </c:otherwise>
    </c:choose>

    <a href="/pet-adoption/activity/list" class="btn btn-outline-secondary">返回列表</a>
</div>
</body>
</html>
