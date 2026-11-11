<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>知识管理 - 后台</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="/pet-adoption/admin/dashboard">后台管理</a>
    </div>
</nav>

<div class="container mt-4">
    <h3>知识管理</h3>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>标题</th>
                <th>分类</th>
                <th>浏览量</th>
                <th>状态</th>
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
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
