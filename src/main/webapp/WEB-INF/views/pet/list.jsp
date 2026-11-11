<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>领养中心 - 流浪猫狗救助系统</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="/pet-adoption/">流浪猫狗救助系统</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="/pet-adoption/">首页</a></li>
                <li class="nav-item"><a class="nav-link active" href="/pet-adoption/pet/list">领养中心</a></li>
            </ul>
            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${not empty sessionScope.loginUser}">
                        <li class="nav-item"><a class="nav-link" href="/pet-adoption/pet/my">我的领养</a></li>
                        <li class="nav-item"><a class="nav-link" href="/pet-adoption/user/profile">个人中心</a></li>
                        <li class="nav-item"><a class="nav-link" href="/pet-adoption/user/logout">退出</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="/pet-adoption/login">登录</a></li>
                        <li class="nav-item"><a class="nav-link" href="/pet-adoption/register">注册</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h3>领养中心</h3>

    <!-- 筛选栏 -->
    <div class="card mb-4">
        <div class="card-body">
            <form method="get" action="/pet-adoption/pet/list" class="row g-3">
                <div class="col-md-2">
                    <select name="species" class="form-select">
                        <option value="">种类</option>
                        <option value="1" ${species == 1 ? 'selected' : ''}>猫</option>
                        <option value="2" ${species == 2 ? 'selected' : ''}>狗</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <input type="text" name="breed" class="form-control" placeholder="品种" value="${breed}">
                </div>
                <div class="col-md-2">
                    <select name="gender" class="form-select">
                        <option value="">性别</option>
                        <option value="1" ${gender == 1 ? 'selected' : ''}>公</option>
                        <option value="2" ${gender == 2 ? 'selected' : ''}>母</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <select name="ageStage" class="form-select">
                        <option value="">年龄段</option>
                        <option value="1" ${ageStage == 1 ? 'selected' : ''}>幼年</option>
                        <option value="2" ${ageStage == 2 ? 'selected' : ''}>成年</option>
                        <option value="3" ${ageStage == 3 ? 'selected' : ''}>老年</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary">筛选</button>
                    <a href="/pet-adoption/pet/list" class="btn btn-outline-secondary">重置</a>
                </div>
            </form>
        </div>
    </div>

    <!-- 宠物列表 -->
    <div class="row">
        <c:forEach var="pet" items="${petList}">
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <img src="${empty pet.photo ? '/pet-adoption/static/img/default.jpg' : pet.photo}" class="card-img-top" style="height: 200px; object-fit: cover;" alt="${pet.petName}">
                    <div class="card-body">
                        <h5 class="card-title">${pet.petName}</h5>
                        <p class="card-text">
                            ${pet.speciesText} | ${pet.breed} | ${pet.genderText} | ${pet.ageStageText}<br>
                            <small class="text-muted">${pet.neuteredText} | ${pet.vaccinatedText}</small>
                        </p>
                        <a href="/pet-adoption/pet/detail/${pet.petId}" class="btn btn-primary btn-sm">查看详情</a>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty petList}">
            <div class="col-12 text-center text-muted py-5">
                暂无待领养的宠物
            </div>
        </c:if>
    </div>

    <!-- 分页 -->
    <c:if test="${pageInfo.pages > 1}">
        <nav aria-label="分页">
            <ul class="pagination justify-content-center">
                <li class="page-item ${pageInfo.pageNum <= 1 ? 'disabled' : ''}">
                    <a class="page-link" href="?pageNum=${pageInfo.pageNum - 1}">上一页</a>
                </li>
                <c:forEach begin="1" end="${pageInfo.pages}" var="i">
                    <li class="page-item ${pageInfo.pageNum == i ? 'active' : ''}">
                        <a class="page-link" href="?pageNum=${i}">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${pageInfo.pageNum >= pageInfo.pages ? 'disabled' : ''}">
                    <a class="page-link" href="?pageNum=${pageInfo.pageNum + 1}">下一页</a>
                </li>
            </ul>
        </nav>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
