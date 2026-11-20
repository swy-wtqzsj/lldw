<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的求助响应</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助系统</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/help/list">求助中心</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/help/response/my">我的响应</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h3>我的求助响应</h3>

    <table class="table table-striped align-middle">
        <thead>
            <tr>
                <th>ID</th>
                <th>求助</th>
                <th>响应内容</th>
                <th>响应时间</th>
                <th>状态</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.respId}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/help/detail/${item.helpId}">
                            ${item.helpTitle} #${item.helpId}
                        </a>
                    </td>
                    <td>${item.content}</td>
                    <td><fmt:formatDate value="${item.respTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${item.status == 1}"><span class="badge bg-warning text-dark">待沟通</span></c:when>
                            <c:when test="${item.status == 2}"><span class="badge bg-success">已接受</span></c:when>
                            <c:otherwise><span class="badge bg-secondary">已完成</span></c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="5" class="text-center text-muted">你还没有响应过求助</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>
</body>
</html>
