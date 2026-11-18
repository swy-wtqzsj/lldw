<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>回访管理 - 后台</title>
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
    <h3>回访管理</h3>

    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/admin/pet/revisit_list" class="btn btn-sm ${empty status ? 'btn-primary' : 'btn-outline-primary'}">全部</a>
        <a href="${pageContext.request.contextPath}/admin/pet/revisit_list?status=1" class="btn btn-sm ${status == 1 ? 'btn-warning' : 'btn-outline-warning'}">待审核</a>
        <a href="${pageContext.request.contextPath}/admin/pet/revisit_list?status=2" class="btn btn-sm ${status == 2 ? 'btn-success' : 'btn-outline-success'}">正常</a>
        <a href="${pageContext.request.contextPath}/admin/pet/revisit_list?status=3" class="btn btn-sm ${status == 3 ? 'btn-danger' : 'btn-outline-danger'}">异常</a>
    </div>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>宠物</th>
                <th>领养人</th>
                <th>健康描述</th>
                <th>状态</th>
                <th>回访时间</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.revisitId}</td>
                    <td>${item.petName}</td>
                    <td>${item.username}</td>
                    <td>${item.healthDesc}</td>
                    <td>
                        <c:choose>
                            <c:when test="${item.status == 1}">
                                <span class="badge bg-warning">待审核</span>
                            </c:when>
                            <c:when test="${item.status == 2}">
                                <span class="badge bg-success">正常</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger">异常</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${item.revisitDate}</td>
                    <td>
                        <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#auditModal${item.revisitId}">
                            审核
                        </button>
                    </td>
                </tr>

                <div class="modal fade" id="auditModal${item.revisitId}" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">审核回访 #${item.revisitId}</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <form action="${pageContext.request.contextPath}/admin/pet/revisit_audit" method="post">
                                <div class="modal-body">
                                    <input type="hidden" name="revisitId" value="${item.revisitId}">
                                    <div class="mb-3">
                                        <label class="form-label">审核结果</label>
                                        <select name="status" class="form-select">
                                            <option value="2">正常</option>
                                            <option value="3">异常</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">备注</label>
                                        <textarea name="adminRemark" class="form-control" rows="3"></textarea>
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
