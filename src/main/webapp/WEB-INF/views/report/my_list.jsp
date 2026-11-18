<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的举报</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助系统</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/report/my">我的举报</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/cert/apply">认证申请</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/profile">个人中心</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h3 class="mb-3">我的举报</h3>

    <c:if test="${not empty sessionScope.reportMsg}">
        <div class="alert alert-success">${sessionScope.reportMsg}</div>
        <c:remove var="reportMsg" scope="session"/>
    </c:if>

    <table class="table table-striped align-middle">
        <thead>
            <tr>
                <th>ID</th>
                <th>举报对象</th>
                <th>举报原因</th>
                <th>证据</th>
                <th>提交时间</th>
                <th>状态</th>
                <th>处理意见</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.reportId}</td>
                    <td>${item.targetTypeText} #${item.targetId}</td>
                    <td>${item.reason}</td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty item.evidence}">
                                <a href="${pageContext.request.contextPath}${item.evidence}" target="_blank">查看</a>
                            </c:when>
                            <c:otherwise><span class="text-muted">无</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td><fmt:formatDate value="${item.reportTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${item.status == 1}"><span class="badge bg-warning text-dark">待处理</span></c:when>
                            <c:when test="${item.status == 2}"><span class="badge bg-success">已成立</span></c:when>
                            <c:otherwise><span class="badge bg-secondary">不成立</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td class="text-muted small">${item.handleOpinion}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="7" class="text-center text-muted">暂无举报记录</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>
</body>
</html>
