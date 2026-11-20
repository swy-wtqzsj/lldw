<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的领养</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助系统</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">首页</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/pet/list">领养中心</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/pet/my">我的领养</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/pet/my_return">我的退养</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h3>我的领养申请</h3>

    <c:if test="${not empty msg}">
        <div class="alert alert-success">${msg}</div>
    </c:if>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>宠物名</th>
                <th>种类</th>
                <th>品种</th>
                <th>申请时间</th>
                <th>状态</th>
                <th>审核意见</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.petName}</td>
                    <td>${item.petSpecies == 1 ? '猫' : '狗'}</td>
                    <td>${item.petBreed}</td>
                    <td><fmt:formatDate value="${item.applyTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${item.status == 1}">
                                <span class="badge bg-warning">待审核</span>
                            </c:when>
                            <c:when test="${item.status == 2}">
                                <span class="badge bg-success">已通过</span>
                            </c:when>
                            <c:when test="${item.status == 4}">
                                <span class="badge bg-secondary">退养终止</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger">已拒绝</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${item.auditOpinion}</td>
                    <td>
                        <c:if test="${item.status == 2}">
                            <a href="${pageContext.request.contextPath}/pet/revisit_form?adoptId=${item.adoptId}" class="btn btn-sm btn-outline-primary">提交回访</a>
                            <a href="${pageContext.request.contextPath}/pet/return_form?adoptId=${item.adoptId}&petId=${item.petId}" class="btn btn-sm btn-outline-danger">申请退养</a>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/pet/my_return" class="btn btn-sm btn-outline-secondary">退养记录</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="7" class="text-center text-muted">暂无领养申请记录</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>
</body>
</html>
