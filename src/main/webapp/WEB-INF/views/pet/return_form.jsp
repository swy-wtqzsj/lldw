<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>申请退养</title>
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
    <h3>申请退养</h3>
    <p class="text-muted">如果无法继续照顾宠物，可以申请退养，我们会重新为它寻找领养人。</p>

    <form action="${pageContext.request.contextPath}/pet/return_save" method="post">
        <input type="hidden" name="adoptId" value="${adoptId}">
        <input type="hidden" name="petId" value="${petId}">

        <div class="mb-3">
            <label class="form-label">退养原因</label>
            <select name="reason" class="form-select" required>
                <option value="">请选择</option>
                <option value="搬家无法继续饲养">搬家无法继续饲养</option>
                <option value="个人健康原因">个人健康原因</option>
                <option value="经济原因">经济原因</option>
                <option value="宠物不适应家庭环境">宠物不适应家庭环境</option>
                <option value="其他">其他</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">详细描述</label>
            <textarea name="description" class="form-control" rows="4" placeholder="请详细说明退养原因..." required></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">宠物现状照片（可选）</label>
            <input type="text" name="photo" class="form-control" placeholder="粘贴照片URL">
        </div>

        <button type="submit" class="btn btn-danger">提交退养申请</button>
        <a href="${pageContext.request.contextPath}/pet/my" class="btn btn-outline-secondary">返回</a>
    </form>
</div>
</body>
</html>
