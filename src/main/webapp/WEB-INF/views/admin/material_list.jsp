<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>物资管理 - 后台</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark admin-nav">
    <div class="container-fluid px-4">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">后台管理</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">看板</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/pet/list">宠物</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/pet/adoption_list">领养审核</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/user/list">用户</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/help/list">求助</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/help/comments">评论</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/activity/list">活动</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/knowledge/list">知识</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/material/list">物资</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/punishment/list">处罚</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/report/list">举报</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/cert/list">证书</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid px-4 mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">物资管理</h3>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/admin/material/recent" class="btn btn-outline-secondary">最近流水</a>
            <a href="${pageContext.request.contextPath}/admin/material/add" class="btn btn-primary">新增物资</a>
        </div>
    </div>

    <c:if test="${not empty sessionScope.adminMaterialMsg}">
        <div class="alert alert-info">${sessionScope.adminMaterialMsg}</div>
        <c:remove var="adminMaterialMsg" scope="session"/>
    </c:if>

    <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
        <div>
            <a href="${pageContext.request.contextPath}/admin/material/list${empty keyword ? '' : '?keyword='}${keyword}" class="btn btn-sm ${empty category ? 'btn-primary' : 'btn-outline-primary'}">全部</a>
            <a href="${pageContext.request.contextPath}/admin/material/list?category=1${empty keyword ? '' : '&keyword='}${keyword}" class="btn btn-sm ${category == 1 ? 'btn-primary' : 'btn-outline-primary'}">食物</a>
            <a href="${pageContext.request.contextPath}/admin/material/list?category=2${empty keyword ? '' : '&keyword='}${keyword}" class="btn btn-sm ${category == 2 ? 'btn-primary' : 'btn-outline-primary'}">药品</a>
            <a href="${pageContext.request.contextPath}/admin/material/list?category=3${empty keyword ? '' : '&keyword='}${keyword}" class="btn btn-sm ${category == 3 ? 'btn-primary' : 'btn-outline-primary'}">用品</a>
        </div>
        <form action="${pageContext.request.contextPath}/admin/material/list" method="get" class="d-flex gap-2">
            <c:if test="${not empty category}">
                <input type="hidden" name="category" value="${category}">
            </c:if>
            <input type="text" name="keyword" class="form-control" placeholder="物资名称/捐赠人" value="${keyword}">
            <button type="submit" class="btn btn-primary">搜索</button>
            <a href="${pageContext.request.contextPath}/admin/material/list" class="btn btn-outline-secondary">重置</a>
        </form>
    </div>

    <table class="table table-striped align-middle">
        <thead>
            <tr>
                <th>ID</th>
                <th>名称</th>
                <th>类别</th>
                <th>库存</th>
                <th>单位</th>
                <th>预警阈值</th>
                <th>捐赠人</th>
                <th>更新时间</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.materialId}</td>
                    <td>
                        ${item.name}
                        <c:if test="${item.lowStock}">
                            <span class="badge bg-danger">库存不足</span>
                        </c:if>
                    </td>
                    <td>${item.categoryText}</td>
                    <td class="${item.lowStock ? 'text-danger fw-bold' : ''}">${item.quantity}</td>
                    <td>${item.unit}</td>
                    <td>${item.warnThreshold}</td>
                    <td>${item.donor}</td>
                    <td><fmt:formatDate value="${item.updateTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td class="d-flex gap-1">
                        <button class="btn btn-sm btn-outline-success" data-bs-toggle="modal" data-bs-target="#inModal${item.materialId}">入库</button>
                        <button class="btn btn-sm btn-outline-warning" data-bs-toggle="modal" data-bs-target="#outModal${item.materialId}">出库</button>
                        <a href="${pageContext.request.contextPath}/admin/material/edit?materialId=${item.materialId}" class="btn btn-sm btn-outline-primary">编辑</a>
                        <a href="${pageContext.request.contextPath}/admin/material/records?materialId=${item.materialId}" class="btn btn-sm btn-outline-secondary">流水</a>
                        <form action="${pageContext.request.contextPath}/admin/material/delete" method="post" onsubmit="return confirm('确定删除该物资吗？');">
                            <input type="hidden" name="materialId" value="${item.materialId}">
                            <button type="submit" class="btn btn-sm btn-outline-danger">删除</button>
                        </form>
                    </td>
                </tr>

                <div class="modal fade" id="inModal${item.materialId}" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">入库 - ${item.name}</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <form action="${pageContext.request.contextPath}/admin/material/stock" method="post">
                                <div class="modal-body">
                                    <input type="hidden" name="materialId" value="${item.materialId}">
                                    <input type="hidden" name="type" value="1">
                                    <div class="mb-3">
                                        <label class="form-label">入库数量</label>
                                        <input type="number" name="quantity" class="form-control" min="1" required>
                                        <div class="form-text">当前库存：${item.quantity} ${item.unit}</div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                                    <button type="submit" class="btn btn-success">确认入库</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="outModal${item.materialId}" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">出库 - ${item.name}</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <form action="${pageContext.request.contextPath}/admin/material/stock" method="post">
                                <div class="modal-body">
                                    <input type="hidden" name="materialId" value="${item.materialId}">
                                    <input type="hidden" name="type" value="2">
                                    <div class="mb-3">
                                        <label class="form-label">出库数量</label>
                                        <input type="number" name="quantity" class="form-control" min="1" max="${item.quantity}" required>
                                        <div class="form-text">当前库存：${item.quantity} ${item.unit}</div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">出库用途</label>
                                        <input type="text" name="usageDesc" class="form-control" placeholder="如：日常喂养">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                                    <button type="submit" class="btn btn-warning">确认出库</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="9" class="text-center text-muted">暂无物资记录</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
