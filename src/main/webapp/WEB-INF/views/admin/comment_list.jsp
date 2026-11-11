<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>评论管理 - 后台</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="/pet-adoption/admin/dashboard">后台管理</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="/pet-adoption/admin/dashboard">看板</a></li>
                <li class="nav-item"><a class="nav-link" href="/pet-adoption/admin/pet/list">宠物管理</a></li>
                <li class="nav-item"><a class="nav-link" href="/pet-adoption/admin/help/list">求助管理</a></li>
                <li class="nav-item"><a class="nav-link active" href="/pet-adoption/admin/help/comments">评论管理</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h3>评论管理</h3>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>评论人</th>
                <th>对象类型</th>
                <th>评论内容</th>
                <th>评论时间</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.commentId}</td>
                    <td>${item.username}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.targetType == 1}">宠物</c:when>
                            <c:when test="${item.targetType == 2}">活动</c:when>
                            <c:when test="${item.targetType == 3}">知识</c:when>
                            <c:when test="${item.targetType == 4}">求助</c:when>
                            <c:otherwise>未知</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${item.content}</td>
                    <td>${item.commentTime}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.status == 1}">
                                <span class="badge bg-success">正常</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary">已隐藏</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="/pet-adoption/admin/help/comment_delete?commentId=${item.commentId}" 
                           class="btn btn-sm btn-outline-danger" 
                           onclick="return confirm('确认删除？')">删除</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="7" class="text-center text-muted">暂无评论</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>
</body>
</html>
