<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>提交举报</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助系统</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/report/my">我的举报</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4" style="max-width: 640px;">
    <h3>提交举报</h3>

    <c:if test="${not empty sessionScope.reportMsg}">
        <div class="alert alert-warning">${sessionScope.reportMsg}</div>
        <c:remove var="reportMsg" scope="session"/>
    </c:if>

    <div class="card mb-3">
        <div class="card-body py-2">
            举报对象：<strong>${targetTypeText} #${targetId}</strong>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/report/save" method="post" enctype="multipart/form-data">
        <input type="hidden" name="targetType" value="${targetType}">
        <input type="hidden" name="targetId" value="${targetId}">

        <div class="mb-3">
            <label class="form-label">举报原因</label>
            <textarea name="reason" class="form-control" rows="4" maxlength="255" required
                      placeholder="请描述被举报对象的违规情况"></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">证据截图（选填）</label>
            <input type="file" name="evidenceFile" class="form-control" accept="image/*">
            <div class="form-text">支持 jpg/jpeg/png/gif/webp，大小不超过 5MB</div>
        </div>

        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-primary">提交举报</button>
            <a href="javascript:history.back()" class="btn btn-outline-secondary">返回</a>
        </div>
    </form>
</div>
</body>
</html>
