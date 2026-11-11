<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>知识科普 - 流浪猫狗救助系统</title>
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
                <li class="nav-item"><a class="nav-link" href="/pet-adoption/activity/list">志愿活动</a></li>
                <li class="nav-item"><a class="nav-link active" href="/pet-adoption/knowledge/list">知识科普</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h3>知识科普</h3>

    <!-- 分类筛选 -->
    <div class="mb-3">
        <a href="/pet-adoption/knowledge/list" class="btn btn-sm ${empty categoryId ? 'btn-primary' : 'btn-outline-primary'}">全部</a>
        <c:forEach var="cat" items="${categories}">
            <a href="/pet-adoption/knowledge/list?categoryId=${cat.categoryId}" 
               class="btn btn-sm ${categoryId == cat.categoryId ? 'btn-primary' : 'btn-outline-primary'}">
                ${cat.categoryName}
            </a>
        </c:forEach>
    </div>

    <!-- 文章列表 -->
    <div class="row">
        <c:forEach var="item" items="${list}">
            <div class="col-md-6 mb-3">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">${item.title}</h5>
                        <p class="card-text text-muted">
                            <small>分类：${item.categoryName} | 浏览：${item.viewCount}次 | ${item.publishTime}</small>
                        </p>
                        <a href="/pet-adoption/knowledge/detail/${item.articleId}" class="btn btn-sm btn-primary">阅读全文</a>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty list}">
            <div class="col-12 text-center text-muted py-5">
                暂无知识文章
            </div>
        </c:if>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
