<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>处罚申诉管理 - 后台</title>
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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/help-response/list">求助响应</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/help/comments">评论</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/activity/list">活动</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/knowledge/list">知识</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/material/list">物资</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/punishment/list">处罚</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/report/list">举报</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/cert/list">证书</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/lost/list">寻宠启事</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/appeal/list">处罚申诉</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid px-4 mt-4">
    <h3 class="mb-3">处罚申诉管理</h3>

    <c:if test="${not empty sessionScope.adminAppealMsg}">
        <div class="alert alert-info">${sessionScope.adminAppealMsg}</div>
        <c:remove var="adminAppealMsg" scope="session"/>
    </c:if>

    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/admin/appeal/list" class="btn btn-sm ${empty status ? 'btn-primary' : 'btn-outline-primary'}">全部状态</a>
        <a href="${pageContext.request.contextPath}/admin/appeal/list?status=1" class="btn btn-sm ${status == 1 ? 'btn-warning' : 'btn-outline-warning'}">待复核</a>
        <a href="${pageContext.request.contextPath}/admin/appeal/list?status=2" class="btn btn-sm ${status == 2 ? 'btn-danger' : 'btn-outline-danger'}">维持处罚</a>
        <a href="${pageContext.request.contextPath}/admin/appeal/list?status=3" class="btn btn-sm ${status == 3 ? 'btn-info' : 'btn-outline-info'}">减轻处罚</a>
        <a href="${pageContext.request.contextPath}/admin/appeal/list?status=4" class="btn btn-sm ${status == 4 ? 'btn-success' : 'btn-outline-success'}">解除处罚</a>
    </div>

    <table class="table table-striped align-middle">
        <thead>
            <tr>
                <th>ID</th>
                <th>关联处罚</th>
                <th>申诉人</th>
                <th>申诉说明</th>
                <th>佐证</th>
                <th>申诉时间</th>
                <th>状态</th>
                <th>复核信息</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.appealId}</td>
                    <td>
                        <div>#${item.punishId} ${item.punishTypeText}</div>
                        <div class="text-muted small">${item.punishReason}</div>
                    </td>
                    <td>${item.username}</td>
                    <td>${item.content}</td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty item.evidence}">
                                <a href="${pageContext.request.contextPath}${item.evidence}" target="_blank">查看</a>
                            </c:when>
                            <c:otherwise><span class="text-muted">无</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td><fmt:formatDate value="${item.appealTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${item.status == 1}"><span class="badge bg-warning text-dark">待复核</span></c:when>
                            <c:when test="${item.status == 2}"><span class="badge bg-danger">维持处罚</span></c:when>
                            <c:when test="${item.status == 3}"><span class="badge bg-info">减轻处罚</span></c:when>
                            <c:otherwise><span class="badge bg-success">解除处罚</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${not empty item.reviewTime}">
                            <div>${item.adminName}</div>
                            <div class="text-muted small"><fmt:formatDate value="${item.reviewTime}" pattern="yyyy-MM-dd HH:mm"/></div>
                            <div class="text-muted small">${item.reviewOpinion}</div>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${item.status == 1}">
                            <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#reviewModal${item.appealId}">复核</button>
                        </c:if>
                    </td>
                </tr>

                <div class="modal fade" id="reviewModal${item.appealId}" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">复核申诉 #${item.appealId}</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <form action="${pageContext.request.contextPath}/admin/appeal/review" method="post">
                                <div class="modal-body">
                                    <input type="hidden" name="appealId" value="${item.appealId}">
                                    <div class="mb-3">
                                        <label class="form-label">复核结果</label>
                                        <select name="status" class="form-select" required>
                                            <option value="2">维持原处罚</option>
                                            <option value="3">减轻处罚</option>
                                            <option value="4">解除处罚</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">复核意见</label>
                                        <textarea name="reviewOpinion" class="form-control" rows="3" maxlength="500"></textarea>
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
                    <td colspan="9" class="text-center text-muted">暂无申诉记录</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
