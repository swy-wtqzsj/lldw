<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户管理 - 后台</title>
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/user/list">用户管理</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/help/list">求助管理</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/activity/list">活动管理</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/knowledge/list">知识管理</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">用户管理</h3>
        <form action="${pageContext.request.contextPath}/admin/user/list" method="get" class="d-flex gap-2">
            <input type="text" name="keyword" class="form-control" placeholder="用户名/昵称/手机号" value="${keyword}">
            <button type="submit" class="btn btn-primary">搜索</button>
            <a href="${pageContext.request.contextPath}/admin/user/list" class="btn btn-outline-secondary">重置</a>
        </form>
    </div>

    <c:if test="${not empty sessionScope.adminUserMsg}">
        <div class="alert alert-warning">${sessionScope.adminUserMsg}</div>
        <c:remove var="adminUserMsg" scope="session"/>
    </c:if>

    <table class="table table-striped align-middle">
        <thead>
            <tr>
                <th>ID</th>
                <th>用户名</th>
                <th>昵称</th>
                <th>手机号</th>
                <th>角色</th>
                <th>信用分</th>
                <th>注册时间</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.userId}</td>
                    <td>${item.username}</td>
                    <td>${item.nickname}</td>
                    <td>${item.phone}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.role == 9}">超级管理员</c:when>
                            <c:when test="${item.role == 3}">管理员</c:when>
                            <c:when test="${item.role == 2}">志愿者</c:when>
                            <c:otherwise>普通用户</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${item.creditScore}</td>
                    <td><fmt:formatDate value="${item.registerTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <span class="badge ${item.status == 1 ? 'bg-success' : 'bg-secondary'}">
                            ${item.status == 1 ? '正常' : '已禁用'}
                        </span>
                    </td>
                    <td>
                        <form action="${pageContext.request.contextPath}/admin/user/status" method="post">
                            <input type="hidden" name="userId" value="${item.userId}">
                            <input type="hidden" name="keyword" value="${keyword}">
                            <c:choose>
                                <c:when test="${item.status == 1}">
                                    <input type="hidden" name="status" value="0">
                                    <button type="submit" class="btn btn-sm btn-outline-danger">禁用</button>
                                </c:when>
                                <c:otherwise>
                                    <input type="hidden" name="status" value="1">
                                    <button type="submit" class="btn btn-sm btn-outline-success">启用</button>
                                </c:otherwise>
                            </c:choose>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="9" class="text-center text-muted">暂无匹配用户</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>
</body>
</html>
