<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>寻宠启事 - 流浪猫狗救助系统</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助系统</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/pet/list">领养中心</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/help/list">求助中心</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/lost/list">寻宠启事</a></li>
            </ul>
            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${not empty sessionScope.loginUser}">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/lost/publish">发布启事</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/lost/my">我的启事</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">退出</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login">登录</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">寻宠启事</h3>
        <a href="${pageContext.request.contextPath}/lost/publish" class="btn btn-primary">发布寻宠启事</a>
    </div>

    <c:if test="${not empty sessionScope.lostMsg}">
        <div class="alert alert-info">${sessionScope.lostMsg}</div>
        <c:remove var="lostMsg" scope="session"/>
    </c:if>

    <div class="row">
        <c:forEach var="item" items="${list}">
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <c:if test="${not empty item.photo}">
                        <img src="${pageContext.request.contextPath}${item.photo}" class="card-img-top"
                             alt="${item.petName}" style="height: 200px; object-fit: cover;">
                    </c:if>
                    <div class="card-body">
                        <h5 class="card-title">${item.petName}</h5>
                        <p class="card-text mb-1 text-muted">
                            ${item.speciesText} · ${item.breed} · ${item.genderText}
                        </p>
                        <p class="card-text mb-1">走失地点：${item.lostLocation}</p>
                        <p class="card-text mb-2">
                            悬赏：<span class="text-danger">￥${item.reward}</span>
                        </p>
                        <a href="${pageContext.request.contextPath}/lost/detail/${item.lostId}" class="btn btn-sm btn-outline-primary">查看详情</a>
                    </div>
                    <div class="card-footer text-muted small">
                        <fmt:formatDate value="${item.publishTime}" pattern="yyyy-MM-dd HH:mm"/>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <c:if test="${empty list}">
        <p class="text-muted text-center py-5">暂无发布中的寻宠启事</p>
    </c:if>
</div>
</body>
</html>
