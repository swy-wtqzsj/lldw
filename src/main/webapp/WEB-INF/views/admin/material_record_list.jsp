<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>物资流水 - 后台</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">后台管理</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/material/list">物资管理</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <c:choose>
        <c:when test="${not empty material}">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3 class="mb-0">流水记录 - ${material.name}</h3>
                <a href="${pageContext.request.contextPath}/admin/material/list" class="btn btn-outline-secondary">返回列表</a>
            </div>
            <p class="text-muted">
                当前库存：<strong>${material.quantity}</strong> ${material.unit}
                （预警阈值 ${material.warnThreshold}）
            </p>
        </c:when>
        <c:otherwise>
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3 class="mb-0">最近出入库流水</h3>
                <a href="${pageContext.request.contextPath}/admin/material/list" class="btn btn-outline-secondary">返回列表</a>
            </div>
        </c:otherwise>
    </c:choose>

    <table class="table table-striped align-middle">
        <thead>
            <tr>
                <th>流水ID</th>
                <th>物资</th>
                <th>类型</th>
                <th>数量</th>
                <th>用途</th>
                <th>操作人</th>
                <th>操作时间</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="record" items="${list}">
                <tr>
                    <td>${record.recordId}</td>
                    <td>${record.materialName}</td>
                    <td>
                        <span class="badge ${record.type == 1 ? 'bg-success' : 'bg-warning text-dark'}">${record.typeText}</span>
                    </td>
                    <td>${record.type == 1 ? '+' : '-'}${record.quantity}</td>
                    <td>${record.usageDesc}</td>
                    <td>${record.operator}</td>
                    <td><fmt:formatDate value="${record.recordTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                </tr>
            </c:forEach>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="7" class="text-center text-muted">暂无流水记录</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>
</body>
</html>
