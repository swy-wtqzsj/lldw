<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>求助响应管理 - 后台</title>
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/help-response/list">求助响应</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/help/comments">评论</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/activity/list">活动</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/knowledge/list">知识</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/material/list">物资</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/punishment/list">处罚</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/report/list">举报</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/cert/list">证书</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/lost/list">寻宠启事</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/appeal/list">处罚申诉</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid px-4 mt-4">
    <h3 class="mb-3">求助响应管理</h3>

    <c:if test="${not empty sessionScope.adminHelpRespMsg}">
        <div class="alert alert-info">${sessionScope.adminHelpRespMsg}</div>
        <c:remove var="adminHelpRespMsg" scope="session"/>
    </c:if>

    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/admin/help-response/list" class="btn btn-sm ${empty status ? 'btn-primary' : 'btn-outline-primary'}">全部状态</a>
        <a href="${pageContext.request.contextPath}/admin/help-response/list?status=1" class="btn btn-sm ${status == 1 ? 'btn-warning' : 'btn-outline-warning'}">待沟通</a>
        <a href="${pageContext.request.contextPath}/admin/help-response/list?status=2" class="btn btn-sm ${status == 2 ? 'btn-success' : 'btn-outline-success'}">已接受</a>
        <a href="${pageContext.request.contextPath}/admin/help-response/list?status=3" class="btn btn-sm ${status == 3 ? 'btn-secondary' : 'btn-outline-secondary'}">已完成</a>
    </div>

    <table class="table table-striped align-middle">
        <thead>
            <tr>
                <th>ID</th>
                <th>求助</th>
                <th>响应人</th>
                <th>响应内容</th>
                <th>响应时间</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${list}">
                <tr>
                    <td>${item.respId}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/help/detail/${item.helpId}" target="_blank">
                            ${item.helpTitle} #${item.helpId}
                        </a>
                    </td>
                    <td>${item.responderName}</td>
                    <td>${item.content}</td>
                    <td><fmt:formatDate value="${item.respTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${item.status == 1}"><span class="badge bg-warning text-dark">待沟通</span></c:when>
                            <c:when test="${item.status == 2}"><span class="badge bg-success">已接受</span></c:when>
                            <c:otherwise><span class="badge bg-secondary">已完成</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${item.status != 3}">
                            <form action="${pageContext.request.contextPath}/admin/help-response/status" method="post" class="d-flex gap-1">
                                <input type="hidden" name="respId" value="${item.respId}">
                                <select name="status" class="form-select form-select-sm" style="width: 110px;">
                                    <option value="1" ${item.status == 1 ? 'selected' : ''}>待沟通</option>
                                    <option value="2" ${item.status == 2 ? 'selected' : ''}>已接受</option>
                                    <option value="3">已完成</option>
                                </select>
                                <button type="submit" class="btn btn-sm btn-outline-primary">更新</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="7" class="text-center text-muted">暂无响应记录</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>
</body>
</html>
