<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>活动管理 - 后台</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="/pet-adoption/admin/dashboard">后台管理</a>
    </div>
</nav>

<div class="container mt-4">
    <h3>活动管理</h3>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>标题</th>
                <th>时间</th>
                <th>地点</th>
                <th>人数</th>
                <th>状态</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.activityId}</td>
                    <td>${item.title}</td>
                    <td>${item.startTime}</td>
                    <td>${item.location}</td>
                    <td>${item.signupCount}/${item.maxPeople}</td>
                    <td>${item.statusText}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
