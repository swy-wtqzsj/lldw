<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>求助中心 - 流浪猫狗救助系统</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="/pet-adoption/">流浪猫狗救助系统</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="/pet-adoption/">首页</a></li>
                <li class="nav-item"><a class="nav-link" href="/pet-adoption/pet/list">领养中心</a></li>
                <li class="nav-item"><a class="nav-link active" href="/pet-adoption/help/list">求助中心</a></li>
            </ul>
            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${not empty sessionScope.loginUser}">
                        <li class="nav-item"><a class="nav-link" href="/pet-adoption/help/my">我的求助</a></li>
                        <li class="nav-item"><a class="nav-link" href="/pet-adoption/user/profile">个人中心</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="/pet-adoption/login">登录</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>求助中心</h3>
        <a href="/pet-adoption/help/publish" class="btn btn-primary">发布求助</a>
    </div>

    <!-- 筛选栏 -->
    <div class="mb-3">
        <a href="/pet-adoption/help/list" class="btn btn-sm ${empty type ? 'btn-primary' : 'btn-outline-primary'}">全部</a>
        <a href="/pet-adoption/help/list?type=1" class="btn btn-sm ${type == 1 ? 'btn-primary' : 'btn-outline-primary'}">发现流浪动物</a>
        <a href="/pet-adoption/help/list?type=2" class="btn btn-sm ${type == 2 ? 'btn-primary' : 'btn-outline-primary'}">动物受伤</a>
        <a href="/pet-adoption/help/list?type=3" class="btn btn-sm ${type == 3 ? 'btn-primary' : 'btn-outline-primary'}">寻找失主</a>
        <a href="/pet-adoption/help/list?type=4" class="btn btn-sm ${type == 4 ? 'btn-primary' : 'btn-outline-primary'}">其他</a>
    </div>

    <!-- 求助列表 -->
    <div class="row">
        <c:forEach var="item" items="${list}">
            <div class="col-md-6 mb-3">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">${item.title}</h5>
                        <p class="card-text">
                            <span class="badge bg-info">${item.typeText}</span>
                            <span class="badge bg-secondary ms-2">${item.handleStatusText}</span>
                            <br>
                            <small class="text-muted">发布人：${item.username} | ${item.publishTime}</small>
                        </p>
                        <p class="card-text">${item.content}</p>
                        <a href="/pet-adoption/help/detail/${item.helpId}" class="btn btn-sm btn-primary">查看详情</a>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty list}">
            <div class="col-12 text-center text-muted py-5">
                暂无求助信息
            </div>
        </c:if>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
