<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>知识管理 - 后台</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">后台管理</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/pet/list">宠物管理</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/pet/adoption_list">领养审核</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/help/list">求助管理</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/activity/list">活动管理</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/knowledge/list">知识管理</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">知识管理</h3>
        <a href="${pageContext.request.contextPath}/admin/knowledge/add" class="btn btn-primary">新增文章</a>
    </div>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>标题</th>
                <th>分类</th>
                <th>浏览量</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.articleId}</td>
                    <td>${item.title}</td>
                    <td>${item.categoryName}</td>
                    <td>${item.viewCount}</td>
                    <td>${item.statusText}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/knowledge/edit/${item.articleId}" class="btn btn-sm btn-outline-primary">编辑</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
