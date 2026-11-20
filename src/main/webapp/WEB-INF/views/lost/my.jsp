<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的寻宠启事</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助系统</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/lost/list">寻宠启事</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/lost/my">我的启事</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">我的寻宠启事</h3>
        <a href="${pageContext.request.contextPath}/lost/publish" class="btn btn-primary">发布启事</a>
    </div>

    <c:if test="${not empty sessionScope.lostMsg}">
        <div class="alert alert-info">${sessionScope.lostMsg}</div>
        <c:remove var="lostMsg" scope="session"/>
    </c:if>

    <table class="table table-striped align-middle">
        <thead>
            <tr>
                <th>ID</th>
                <th>宠物</th>
                <th>走失地点</th>
                <th>悬赏</th>
                <th>发布时间</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.lostId}</td>
                    <td>${item.petName}（${item.speciesText} ${item.breed}）</td>
                    <td>${item.lostLocation}</td>
                    <td>￥${item.reward}</td>
                    <td><fmt:formatDate value="${item.publishTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${item.status == 1}"><span class="badge bg-warning text-dark">待审核</span></c:when>
                            <c:when test="${item.status == 2}"><span class="badge bg-success">发布中</span></c:when>
                            <c:when test="${item.status == 3}"><span class="badge bg-info">已找回</span></c:when>
                            <c:when test="${item.status == 4}"><span class="badge bg-secondary">已撤回</span></c:when>
                            <c:otherwise><span class="badge bg-danger">已下架</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/lost/detail/${item.lostId}" class="btn btn-sm btn-outline-primary">详情</a>
                        <c:if test="${item.status == 1 || item.status == 2}">
                            <a href="${pageContext.request.contextPath}/lost/withdraw?lostId=${item.lostId}"
                               class="btn btn-sm btn-outline-danger confirm-link">撤回</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="7" class="text-center text-muted">你还没有发布过寻宠启事</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

<script>
    document.querySelectorAll('.confirm-link').forEach(function (link) {
        link.addEventListener('click', function (e) {
            if (!confirm('确定要撤回该启事吗？')) {
                e.preventDefault();
            }
        });
    });
</script>
</body>
</html>
