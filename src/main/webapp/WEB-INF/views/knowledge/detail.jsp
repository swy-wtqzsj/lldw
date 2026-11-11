<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${knowledge.title}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="/pet-adoption/">流浪猫狗救助系统</a>
    </div>
</nav>

<div class="container mt-4">
    <h3>${knowledge.title}</h3>
    <p class="text-muted">
        分类：${knowledge.categoryName} | 浏览：${knowledge.viewCount}次 | 发布时间：${knowledge.publishTime}
    </p>

    <hr>

    <div class="content">
        ${knowledge.content}
    </div>

    <hr>
    <a href="/pet-adoption/knowledge/list" class="btn btn-outline-secondary">返回列表</a>
</div>
</body>
</html>
