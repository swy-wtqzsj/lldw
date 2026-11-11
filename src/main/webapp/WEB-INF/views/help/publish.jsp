<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>发布求助</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="/pet-adoption/">流浪猫狗救助系统</a>
    </div>
</nav>

<div class="container mt-4">
    <h3>发布求助</h3>

    <form action="/pet-adoption/help/save" method="post">
        <div class="mb-3">
            <label class="form-label">求助标题</label>
            <input type="text" name="title" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">求助类型</label>
            <select name="type" class="form-select">
                <option value="1">发现流浪动物</option>
                <option value="2">动物受伤</option>
                <option value="3">寻找失主</option>
                <option value="4">其他</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">详细描述</label>
            <textarea name="content" class="form-control" rows="4" required></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">位置信息</label>
            <input type="text" name="location" class="form-control" placeholder="如：成都市武侯区XX路XX号">
        </div>

        <div class="mb-3">
            <label class="form-label">联系方式</label>
            <input type="text" name="contact" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-primary">提交发布</button>
        <a href="/pet-adoption/help/list" class="btn btn-outline-secondary">返回</a>
    </form>
</div>
</body>
</html>
