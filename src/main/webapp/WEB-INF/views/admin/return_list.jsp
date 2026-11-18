<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>退养审核 - 后台</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">后台管理</a>
    </div>
</nav>

<div class="container mt-4">
    <h3>退养审核</h3>

    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/admin/pet/return_list" class="btn btn-sm ${empty status ? 'btn-primary' : 'btn-outline-primary'}">全部</a>
        <a href="${pageContext.request.contextPath}/admin/pet/return_list?status=1" class="btn btn-sm ${status == 1 ? 'btn-warning' : 'btn-outline-warning'}">待审核</a>
        <a href="${pageContext.request.contextPath}/admin/pet/return_list?status=2" class="btn btn-sm ${status == 2 ? 'btn-success' : 'btn-outline-success'}">已通过</a>
        <a href="${pageContext.request.contextPath}/admin/pet/return_list?status=3" class="btn btn-sm ${status == 3 ? 'btn-danger' : 'btn-outline-danger'}">已拒绝</a>
    </div>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>宠物</th>
                <th>申请人</th>
                <th>退养原因</th>
                <th>状态</th>
                <th>申请时间</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.returnId}</td>
                    <td>${item.petName}</td>
                    <td>${item.username}</td>
                    <td>${item.reason}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.status == 1}">
                                <span class="badge bg-warning">待审核</span>
                            </c:when>
                            <c:when test="${item.status == 2}">
                                <span class="badge bg-success">已通过</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger">已拒绝</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${item.applyTime}</td>
                    <td>
                        <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#auditModal${item.returnId}">
                            审核
                        </button>
                    </td>
                </tr>

                <div class="modal fade" id="auditModal${item.returnId}" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">审核退养申请 #${item.returnId}</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <form action="${pageContext.request.contextPath}/admin/pet/return_audit" method="post">
                                <div class="modal-body">
                                    <input type="hidden" name="returnId" value="${item.returnId}">
                                    <p><strong>详细描述：</strong>${item.description}</p>
                                    <div class="mb-3">
                                        <label class="form-label">审核结果</label>
                                        <select name="status" class="form-select">
                                            <option value="2">通过（宠物回流）</option>
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
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
