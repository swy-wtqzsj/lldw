<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${empty knowledge ? '新增文章' : '编辑文章'} - 后台</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">后台管理</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/knowledge/list">知识管理</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4" style="max-width: 820px;">
    <h3 class="mb-3">${empty knowledge ? '新增文章' : '编辑文章'}</h3>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin/knowledge/save" method="post">
        <c:if test="${not empty knowledge}">
            <input type="hidden" name="articleId" value="${knowledge.articleId}">
        </c:if>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">文章分类</label>
                <select name="categoryId" class="form-select" required>
                    <option value="">请选择分类</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.categoryId}" ${knowledge.categoryId == cat.categoryId ? 'selected' : ''}>${cat.categoryName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">状态</label>
                <select name="status" class="form-select">
                    <option value="1" ${knowledge.status == 1 ? 'selected' : ''}>草稿</option>
                    <option value="2" ${empty knowledge or knowledge.status == 2 ? 'selected' : ''}>已发布</option>
                    <option value="3" ${knowledge.status == 3 ? 'selected' : ''}>已下架</option>
                </select>
            </div>
        </div>
        <div class="mb-3">
            <label class="form-label">标题</label>
            <input type="text" name="title" class="form-control" maxlength="100" required value="${knowledge.title}">
        </div>
        <div class="mb-3">
            <label class="form-label">封面图</label>
            <input type="text" id="coverImage" name="coverImage" class="form-control" maxlength="255" value="${knowledge.coverImage}" placeholder="/static/img/article.jpg">
            <input type="file" accept="image/*" class="form-control mt-2" onchange="uploadImage(this,'coverImage','coverPreview')">
            <img id="coverPreview" class="mt-2 rounded" style="max-height: 140px; display: ${empty knowledge.coverImage ? 'none' : 'block'};"
                 src="${pageContext.request.contextPath}${empty knowledge.coverImage ? '/static/img/default.svg' : knowledge.coverImage}" alt="预览">
        </div>
        <div class="mb-3">
            <label class="form-label">正文</label>
            <textarea name="content" class="form-control" rows="12" required>${knowledge.content}</textarea>
        </div>

        <button type="submit" class="btn btn-primary">保存</button>
        <a href="${pageContext.request.contextPath}/admin/knowledge/list" class="btn btn-outline-secondary">返回</a>
    </form>
</div>
<script>window.APP_CTX = '${pageContext.request.contextPath}';</script>
<script src="${pageContext.request.contextPath}/static/js/upload.js"></script>
</body>
</html>
