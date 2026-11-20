<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${lostPet.petName} - 寻宠启事</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助系统</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/lost/list">寻宠启事</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="row">
        <div class="col-md-5">
            <c:if test="${not empty lostPet.photo}">
                <img src="${pageContext.request.contextPath}${lostPet.photo}" class="img-fluid rounded mb-3" alt="${lostPet.petName}">
            </c:if>
        </div>
        <div class="col-md-7">
            <h3>${lostPet.petName}</h3>
            <p class="text-muted">
                <span class="badge bg-info">${lostPet.speciesText}</span>
                <span class="badge bg-secondary">${lostPet.statusText}</span>
            </p>
            <p><strong>品种：</strong>${lostPet.breed}</p>
            <p><strong>性别：</strong>${lostPet.genderText}</p>
            <p><strong>身体特征：</strong>${lostPet.features}</p>
            <p><strong>走失时间：</strong>
                <c:if test="${not empty lostPet.lostTime}">
                    <fmt:formatDate value="${lostPet.lostTime}" pattern="yyyy-MM-dd HH:mm"/>
                </c:if>
            </p>
            <p><strong>走失地点：</strong>${lostPet.lostLocation}</p>
            <p><strong>悬赏金额：</strong><span class="text-danger">￥${lostPet.reward}</span></p>
            <p><strong>联系方式：</strong>${lostPet.contact}</p>
            <p class="text-muted small">发布人：${lostPet.username} |
                <fmt:formatDate value="${lostPet.publishTime}" pattern="yyyy-MM-dd HH:mm"/>
            </p>
            <a href="${pageContext.request.contextPath}/lost/list" class="btn btn-outline-secondary">返回列表</a>
        </div>
    </div>
</div>
</body>
</html>
