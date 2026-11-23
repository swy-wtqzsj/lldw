<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${empty activity ? '新增活动' : '编辑活动'} - 后台</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">后台管理</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/activity/list">活动管理</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4" style="max-width: 760px;">
    <h3 class="mb-3">${empty activity ? '新增活动' : '编辑活动'}</h3>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <c:if test="${not empty activity}">
        <fmt:formatDate var="startVal" value="${activity.startTime}" pattern="yyyy-MM-dd'T'HH:mm"/>
        <fmt:formatDate var="endVal" value="${activity.endTime}" pattern="yyyy-MM-dd'T'HH:mm"/>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin/activity/save" method="post">
        <c:if test="${not empty activity}">
            <input type="hidden" name="activityId" value="${activity.activityId}">
        </c:if>

        <div class="mb-3">
            <label class="form-label">活动标题</label>
            <input type="text" name="title" class="form-control" maxlength="100" required value="${activity.title}">
        </div>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">开始时间</label>
                <input type="datetime-local" name="startTime" class="form-control" required value="${startVal}">
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">结束时间</label>
                <input type="datetime-local" name="endTime" class="form-control" required value="${endVal}">
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">活动地点</label>
                <input type="text" name="location" class="form-control" maxlength="128" value="${activity.location}">
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">人数上限（0 为不限）</label>
                <input type="number" name="maxPeople" class="form-control" min="0" value="${empty activity ? 0 : activity.maxPeople}">
            </div>
        </div>
        <div class="mb-3">
            <label class="form-label">封面图</label>
            <input type="text" id="coverImage" name="coverImage" class="form-control" maxlength="255" value="${activity.coverImage}" placeholder="/static/img/activity.jpg">
            <input type="file" accept="image/*" class="form-control mt-2" onchange="uploadImage(this,'coverImage','coverPreview')">
            <img id="coverPreview" class="mt-2 rounded" style="max-height: 140px; display: ${empty activity.coverImage ? 'none' : 'block'};"
                 src="${pageContext.request.contextPath}${empty activity.coverImage ? '/static/img/default.svg' : activity.coverImage}" alt="预览">
        </div>
        <div class="mb-3">
            <label class="form-label">活动内容</label>
            <textarea name="content" class="form-control" rows="8">${activity.content}</textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">状态</label>
            <select name="status" class="form-select">
                <option value="1" ${activity.status == 1 ? 'selected' : ''}>草稿</option>
                <option value="2" ${empty activity or activity.status == 2 ? 'selected' : ''}>发布中</option>
                <option value="3" ${activity.status == 3 ? 'selected' : ''}>已结束</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">保存</button>
        <a href="${pageContext.request.contextPath}/admin/activity/list" class="btn btn-outline-secondary">返回</a>
    </form>
</div>
<script>window.APP_CTX = '${pageContext.request.contextPath}';</script>
<script src="${pageContext.request.contextPath}/static/js/upload.js"></script>
</body>
</html>
