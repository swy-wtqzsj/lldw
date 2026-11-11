<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>志愿活动 - 流浪猫狗救助系统</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="/pet-adoption/">流浪猫狗救助系统</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="/pet-adoption/pet/list">领养中心</a></li>
                <li class="nav-item"><a class="nav-link" href="/pet-adoption/help/list">求助中心</a></li>
                <li class="nav-item"><a class="nav-link active" href="/pet-adoption/activity/list">志愿活动</a></li>
                <li class="nav-item"><a class="nav-link" href="/pet-adoption/knowledge/list">知识科普</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h3>志愿活动</h3>

    <div class="row">
        <c:forEach var="item" items="${list}">
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-body">
                        <h5 class="card-title">${item.title}</h5>
                        <p class="card-text text-muted">
                            <small>时间：${item.startTime}</small><br>
                            <small>地点：${item.location}</small><br>
                            <small>已报名：${item.signupCount}/${item.maxPeople}人</small>
                        </p>
                        <a href="/pet-adoption/activity/detail/${item.activityId}" class="btn btn-sm btn-primary">查看详情</a>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty list}">
            <div class="col-12 text-center text-muted py-5">
                暂无进行中的活动
            </div>
        </c:if>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
