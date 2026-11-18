<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>提交回访</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助系统</a>
    </div>
</nav>

<div class="container mt-4">
    <h3>提交回访</h3>
    <p class="text-muted">请定期反馈宠物近况，帮助我们了解它的适应情况。</p>

    <form action="${pageContext.request.contextPath}/pet/revisit_save" method="post">
        <input type="hidden" name="adoptId" value="${adoptId}">

        <div class="mb-3">
            <label class="form-label">宠物近况描述</label>
            <textarea name="healthDesc" class="form-control" rows="4" placeholder="描述宠物最近的健康状况、饮食、情绪等情况..." required></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">照片链接（可选）</label>
            <input type="text" name="photo" class="form-control" placeholder="粘贴照片URL">
        </div>

        <button type="submit" class="btn btn-primary">提交回访</button>
        <a href="${pageContext.request.contextPath}/pet/my" class="btn btn-outline-secondary">返回</a>
    </form>
</div>
</body>
</html>
