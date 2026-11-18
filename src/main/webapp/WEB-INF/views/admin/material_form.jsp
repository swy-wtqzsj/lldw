<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${empty material ? '新增物资' : '编辑物资'} - 后台</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">后台管理</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/material/list">物资管理</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4" style="max-width: 640px;">
    <h3>${empty material ? '新增物资' : '编辑物资'}</h3>

    <form action="${pageContext.request.contextPath}/admin/material/${empty material ? 'save' : 'update'}" method="post">
        <c:if test="${not empty material}">
            <input type="hidden" name="materialId" value="${material.materialId}">
        </c:if>

        <div class="mb-3">
            <label class="form-label">物资名称</label>
            <input type="text" name="name" class="form-control" maxlength="50" required value="${material.name}">
        </div>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">类别</label>
                <select name="category" class="form-select" required>
                    <option value="1" ${material.category == 1 ? 'selected' : ''}>食物</option>
                    <option value="2" ${material.category == 2 ? 'selected' : ''}>药品</option>
                    <option value="3" ${material.category == 3 ? 'selected' : ''}>用品</option>
                </select>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">单位</label>
                <input type="text" name="unit" class="form-control" maxlength="10" value="${empty material ? '件' : material.unit}">
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">${empty material ? '初始库存' : '当前库存'}</label>
                <input type="number" name="quantity" class="form-control" min="0"
                       value="${empty material ? 0 : material.quantity}" ${empty material ? '' : 'readonly'}>
                <c:if test="${not empty material}">
                    <div class="form-text">库存数量请通过入库 / 出库操作调整</div>
                </c:if>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">预警阈值</label>
                <input type="number" name="warnThreshold" class="form-control" min="0" value="${empty material ? 5 : material.warnThreshold}">
            </div>
        </div>
        <div class="mb-3">
            <label class="form-label">捐赠人</label>
            <input type="text" name="donor" class="form-control" maxlength="50" value="${material.donor}">
        </div>

        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-primary">保存</button>
            <a href="${pageContext.request.contextPath}/admin/material/list" class="btn btn-outline-secondary">返回列表</a>
        </div>
    </form>
</div>
</body>
</html>
