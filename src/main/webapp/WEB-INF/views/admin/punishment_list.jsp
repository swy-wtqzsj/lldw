<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>处罚管理 - 后台</title>
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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/material/list">物资</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/punishment/list">处罚</a></li>
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
        <h3 class="mb-0">处罚管理</h3>
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addModal">新增处罚</button>
    </div>

    <c:if test="${not empty sessionScope.adminPunishMsg}">
        <div class="alert alert-info">${sessionScope.adminPunishMsg}</div>
        <c:remove var="adminPunishMsg" scope="session"/>
    </c:if>

    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/admin/punishment/list" class="btn btn-sm ${empty status ? 'btn-primary' : 'btn-outline-primary'}">全部</a>
        <a href="${pageContext.request.contextPath}/admin/punishment/list?status=1" class="btn btn-sm ${status == 1 ? 'btn-danger' : 'btn-outline-danger'}">生效中</a>
        <a href="${pageContext.request.contextPath}/admin/punishment/list?status=2" class="btn btn-sm ${status == 2 ? 'btn-success' : 'btn-outline-success'}">已解除</a>
        <a href="${pageContext.request.contextPath}/admin/punishment/list?status=3" class="btn btn-sm ${status == 3 ? 'btn-secondary' : 'btn-outline-secondary'}">已到期</a>
    </div>

    <table class="table table-striped align-middle">
        <thead>
            <tr>
                <th>ID</th>
                <th>被处罚用户</th>
                <th>类型</th>
                <th>原因</th>
                <th>开始时间</th>
                <th>结束时间</th>
                <th>状态</th>
                <th>操作管理员</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.punishId}</td>
                    <td>
                        ${item.username}
                        <c:if test="${not empty item.nickname}">
                            <span class="text-muted">(${item.nickname})</span>
                        </c:if>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${item.type == 1}"><span class="badge bg-warning text-dark">警告</span></c:when>
                            <c:when test="${item.type == 2}"><span class="badge bg-info text-dark">禁言</span></c:when>
                            <c:otherwise><span class="badge bg-danger">封禁</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>${item.reason}</td>
                    <td><fmt:formatDate value="${item.startTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${empty item.endTime}">永久</c:when>
                            <c:otherwise><fmt:formatDate value="${item.endTime}" pattern="yyyy-MM-dd HH:mm"/></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <span class="badge ${item.status == 1 ? 'bg-danger' : (item.status == 2 ? 'bg-success' : 'bg-secondary')}">${item.statusText}</span>
                    </td>
                    <td>${item.adminName}</td>
                    <td>
                        <c:if test="${item.status == 1}">
                            <form action="${pageContext.request.contextPath}/admin/punishment/lift" method="post" onsubmit="return confirm('确定解除该处罚吗？');">
                                <input type="hidden" name="punishId" value="${item.punishId}">
                                <button type="submit" class="btn btn-sm btn-outline-success">解除</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="9" class="text-center text-muted">暂无处罚记录</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

<div class="modal fade" id="addModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">新增处罚</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/punishment/add" method="post">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">被处罚用户</label>
                        <select name="userId" class="form-select" required>
                            <option value="">请选择用户</option>
                            <c:forEach var="u" items="${users}">
                                <option value="${u.userId}">${u.username}${empty u.nickname ? '' : '（'}${u.nickname}${empty u.nickname ? '' : '）'}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">处罚类型</label>
                        <select name="type" class="form-select" required>
                            <option value="1">警告</option>
                            <option value="2">禁言</option>
                            <option value="3">封禁</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">处罚原因</label>
                        <textarea name="reason" class="form-control" rows="3" maxlength="255" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">结束时间</label>
                        <input type="datetime-local" name="endTime" class="form-control">
                        <div class="form-text">留空表示永久处罚</div>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
