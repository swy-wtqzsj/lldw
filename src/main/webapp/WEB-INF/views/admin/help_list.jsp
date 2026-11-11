<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>求助管理 - 后台</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="/pet-adoption/admin/dashboard">后台管理</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="/pet-adoption/admin/dashboard">看板</a></li>
                <li class="nav-item"><a class="nav-link" href="/pet-adoption/admin/pet/list">宠物管理</a></li>
                <li class="nav-item"><a class="nav-link" href="/pet-adoption/admin/pet/adoption_list">领养审核</a></li>
                <li class="nav-item"><a class="nav-link active" href="/pet-adoption/admin/help/list">求助管理</a></li>
                <li class="nav-item"><a class="nav-link" href="/pet-adoption/admin/help/comments">评论管理</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h3>求助管理</h3>

    <!-- 筛选 -->
    <div class="mb-3">
        <a href="/pet-adoption/admin/help/list" class="btn btn-sm ${empty auditStatus ? 'btn-primary' : 'btn-outline-primary'}">全部</a>
        <a href="/pet-adoption/admin/help/list?auditStatus=1" class="btn btn-sm ${auditStatus == 1 ? 'btn-warning' : 'btn-outline-warning'}">待审核</a>
        <a href="/pet-adoption/admin/help/list?auditStatus=2" class="btn btn-sm ${auditStatus == 2 ? 'btn-success' : 'btn-outline-success'}">已通过</a>
        <a href="/pet-adoption/admin/help/list?auditStatus=3" class="btn btn-sm ${auditStatus == 3 ? 'btn-danger' : 'btn-outline-danger'}">已拒绝</a>
    </div>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>标题</th>
                <th>类型</th>
                <th>发布人</th>
                <th>审核状态</th>
                <th>处理状态</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.helpId}</td>
                    <td>${item.title}</td>
                    <td>${item.typeText}</td>
                    <td>${item.username}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.auditStatus == 1}">
                                <span class="badge bg-warning">待审核</span>
                            </c:when>
                            <c:when test="${item.auditStatus == 2}">
                                <span class="badge bg-success">已通过</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger">已拒绝</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${item.handleStatusText}</td>
                    <td>
                        <c:if test="${item.auditStatus == 1}">
                            <button class="btn btn-sm btn-outline-success" data-bs-toggle="modal" data-bs-target="#auditModal${item.helpId}">
                                审核
                            </button>
                        </c:if>
                    </td>
                </tr>

                <!-- 审核弹窗 -->
                <div class="modal fade" id="auditModal${item.helpId}" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">审核求助 #${item.helpId}</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <form action="/pet-adoption/admin/help/audit" method="post">
                                <div class="modal-body">
                                    <input type="hidden" name="helpId" value="${item.helpId}">
                                    <div class="mb-3">
                                        <label class="form-label">审核结果</label>
                                        <select name="auditStatus" class="form-select">
                                            <option value="2">通过</option>
                                            <option value="3">拒绝</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">审核意见</label>
                                        <textarea name="auditOpinion" class="form-control" rows="3"></textarea>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                                    <button type="submit" class="btn btn-primary">提交</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="7" class="text-center text-muted">暂无求助记录</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
