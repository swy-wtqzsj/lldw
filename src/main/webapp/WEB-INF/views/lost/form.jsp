<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>发布寻宠启事</title>
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
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4" style="max-width: 720px;">
    <h3>发布寻宠启事</h3>

    <c:if test="${not empty sessionScope.lostMsg}">
        <div class="alert alert-warning">${sessionScope.lostMsg}</div>
        <c:remove var="lostMsg" scope="session"/>
    </c:if>

    <form action="${pageContext.request.contextPath}/lost/save" method="post" enctype="multipart/form-data">
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">宠物名</label>
                <input type="text" name="petName" class="form-control" maxlength="50">
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">种类</label>
                <select name="species" class="form-select">
                    <option value="1">猫</option>
                    <option value="2">狗</option>
                </select>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">品种</label>
                <input type="text" name="breed" class="form-control" maxlength="50">
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">性别</label>
                <select name="gender" class="form-select">
                    <option value="0">未知</option>
                    <option value="1">公</option>
                    <option value="2">母</option>
                </select>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label">身体特征</label>
            <textarea name="features" class="form-control" rows="3" maxlength="500"
                      placeholder="毛色、体型、有无项圈等明显特征"></textarea>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">走失时间</label>
                <input type="datetime-local" name="lostTime" class="form-control">
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">悬赏金额（元）</label>
                <input type="number" name="reward" class="form-control" min="0" step="0.01" value="0">
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label">走失地点</label>
            <input type="text" name="lostLocation" class="form-control" maxlength="255">
        </div>

        <div class="mb-3">
            <label class="form-label">联系方式</label>
            <input type="text" name="contact" class="form-control" maxlength="50" required>
        </div>

        <div class="mb-3">
            <label class="form-label">宠物照片（选填）</label>
            <input type="file" name="photoFile" class="form-control" accept="image/*">
            <div class="form-text">支持 jpg/jpeg/png/gif/webp，大小不超过 5MB</div>
        </div>

        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-primary">提交发布</button>
            <a href="${pageContext.request.contextPath}/lost/my" class="btn btn-outline-secondary">我的启事</a>
        </div>
    </form>
</div>
</body>
</html>
