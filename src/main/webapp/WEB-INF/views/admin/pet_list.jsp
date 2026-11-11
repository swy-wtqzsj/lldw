<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>宠物管理 - 后台</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="/pet-adoption/admin/dashboard">后台管理</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="/pet-adoption/admin/dashboard">看板</a></li>
                <li class="nav-item"><a class="nav-link active" href="/pet-adoption/admin/pet/list">宠物管理</a></li>
                <li class="nav-item"><a class="nav-link" href="/pet-adoption/admin/pet/adoption_list">领养审核</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>宠物管理</h3>
        <a href="/pet-adoption/admin/pet/add" class="btn btn-primary">新增宠物</a>
    </div>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>编号</th>
                <th>名称</th>
                <th>种类</th>
                <th>品种</th>
                <th>性别</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="pet" items="${petList}">
                <tr>
                    <td>${pet.petId}</td>
                    <td>${pet.petNo}</td>
                    <td>${pet.petName}</td>
                    <td>${pet.speciesText}</td>
                    <td>${pet.breed}</td>
                    <td>${pet.genderText}</td>
                    <td>
                        <span class="badge ${pet.adoptStatus == 2 ? 'bg-success' : 'bg-secondary'}">${pet.adoptStatusText}</span>
                    </td>
                    <td>
                        <a href="/pet-adoption/admin/pet/edit/${pet.petId}" class="btn btn-sm btn-outline-primary">编辑</a>
                        <a href="/pet-adoption/admin/pet/delete/${pet.petId}" class="btn btn-sm btn-outline-danger" onclick="return confirm('确认删除？')">删除</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
