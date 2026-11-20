<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>提交申诉</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助系统</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/appeal/my">我的处罚与申诉</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4" style="max-width: 640px;">
    <h3>提交申诉</h3>

    <div class="card mb-3">
        <div class="card-body">
            <h5 class="card-title">处罚 #${punishment.punishId} · ${punishment.typeText}</h5>
            <p class="mb-1"><strong>处罚原因：</strong>${punishment.reason}</p>
            <p class="mb-1"><strong>开始时间：</strong>
                <fmt:formatDate value="${punishment.startTime}" pattern="yyyy-MM-dd HH:mm"/>
            </p>
            <p class="mb-0"><strong>结束时间：</strong>
                <c:choose>
                    <c:when test="${not empty punishment.endTime}">
                        <fmt:formatDate value="${punishment.endTime}" pattern="yyyy-MM-dd HH:mm"/>
                    </c:when>
                    <c:otherwise>永久</c:otherwise>
                </c:choose>
            </p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/appeal/save" method="post" enctype="multipart/form-data">
        <input type="hidden" name="punishId" value="${punishment.punishId}">

        <div class="mb-3">
            <label class="form-label">申诉说明</label>
            <textarea name="content" class="form-control" rows="5" maxlength="500" required
                      placeholder="请说明申诉理由"></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">佐证材料（选填）</label>
            <input type="file" name="evidenceFile" class="form-control" accept="image/*">
            <div class="form-text">支持 jpg/jpeg/png/gif/webp，大小不超过 5MB</div>
        </div>

        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-primary">提交申诉</button>
            <a href="${pageContext.request.contextPath}/appeal/my" class="btn btn-outline-secondary">返回</a>
        </div>
    </form>
</div>
</body>
</html>
