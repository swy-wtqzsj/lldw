<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>举报管理 - 后台</title>
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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/punishment/list">处罚</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/report/list">举报</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/cert/list">证书</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid px-4 mt-4">
    <h3 class="mb-3">举报管理</h3>

    <c:if test="${not empty sessionScope.adminReportMsg}">
        <div class="alert alert-info">${sessionScope.adminReportMsg}</div>
        <c:remove var="adminReportMsg" scope="session"/>
    </c:if>

    <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
        <div>
            <a href="${pageContext.request.contextPath}/admin/report/list" class="btn btn-sm ${empty status ? 'btn-primary' : 'btn-outline-primary'}">全部状态</a>
            <a href="${pageContext.request.contextPath}/admin/report/list?status=1" class="btn btn-sm ${status == 1 ? 'btn-warning' : 'btn-outline-warning'}">待处理</a>
            <a href="${pageContext.request.contextPath}/admin/report/list?status=2" class="btn btn-sm ${status == 2 ? 'btn-success' : 'btn-outline-success'}">已成立</a>
            <a href="${pageContext.request.contextPath}/admin/report/list?status=3" class="btn btn-sm ${status == 3 ? 'btn-secondary' : 'btn-outline-secondary'}">不成立</a>
        </div>
        <div>
            <c:set var="statusParam"><c:if test="${not empty status}">&status=${status}</c:if></c:set>
            <a href="${pageContext.request.contextPath}/admin/report/list${empty status ? '' : '?status='}${status}" class="btn btn-sm ${empty targetType ? 'btn-dark' : 'btn-outline-dark'}">全部对象</a>
            <a href="${pageContext.request.contextPath}/admin/report/list?targetType=1${statusParam}" class="btn btn-sm ${targetType == 1 ? 'btn-dark' : 'btn-outline-dark'}">评论</a>
            <a href="${pageContext.request.contextPath}/admin/report/list?targetType=2${statusParam}" class="btn btn-sm ${targetType == 2 ? 'btn-dark' : 'btn-outline-dark'}">求助</a>
            <a href="${pageContext.request.contextPath}/admin/report/list?targetType=3${statusParam}" class="btn btn-sm ${targetType == 3 ? 'btn-dark' : 'btn-outline-dark'}">用户</a>
            <a href="${pageContext.request.contextPath}/admin/report/list?targetType=4${statusParam}" class="btn btn-sm ${targetType == 4 ? 'btn-dark' : 'btn-outline-dark'}">活动</a>
        </div>
    </div>

    <table class="table table-striped align-middle">
        <thead>
            <tr>
                <th>ID</th>
                <th>举报人</th>
                <th>举报对象</th>
                <th>原因</th>
                <th>证据</th>
                <th>举报时间</th>
                <th>状态</th>
                <th>处理信息</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.reportId}</td>
                    <td>${item.reporterName}</td>
                    <td>${item.targetTypeText} #${item.targetId}</td>
                    <td>${item.reason}</td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty item.evidence}">
                                <a href="${pageContext.request.contextPath}${item.evidence}" target="_blank">查看</a>
                            </c:when>
                            <c:otherwise><span class="text-muted">无</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td><fmt:formatDate value="${item.reportTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${item.status == 1}"><span class="badge bg-warning text-dark">待处理</span></c:when>
                            <c:when test="${item.status == 2}"><span class="badge bg-success">已成立</span></c:when>
                            <c:otherwise><span class="badge bg-secondary">不成立</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${not empty item.handleTime}">
                            <div>${item.handlerName}</div>
                            <div class="text-muted small"><fmt:formatDate value="${item.handleTime}" pattern="yyyy-MM-dd HH:mm"/></div>
                            <div class="text-muted small">${item.handleOpinion}</div>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${item.status == 1}">
                            <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#handleModal${item.reportId}">处理</button>
                        </c:if>
                    </td>
                </tr>

                <div class="modal fade" id="handleModal${item.reportId}" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">处理举报 #${item.reportId}</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <form action="${pageContext.request.contextPath}/admin/report/handle" method="post">
                                <div class="modal-body">
                                    <input type="hidden" name="reportId" value="${item.reportId}">
                                    <div class="mb-3">
                                        <label class="form-label">处理结果</label>
                                        <select name="status" class="form-select" required>
                                            <option value="2">举报成立</option>
                                            <option value="3">举报不成立</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">处理意见</label>
                                        <textarea name="handleOpinion" class="form-control" rows="3" maxlength="500"></textarea>
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
                    <td colspan="9" class="text-center text-muted">暂无举报记录</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
