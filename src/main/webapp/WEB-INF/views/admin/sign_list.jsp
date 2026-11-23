<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>志愿签到记录 - 后台</title>
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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/help/list">求助</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/activity/list">活动</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/material/list">物资</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/sign/list">志愿签到</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/sign/stats">工时统计</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid px-4 mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">志愿签到记录</h3>
        <a href="${pageContext.request.contextPath}/admin/sign/stats" class="btn btn-outline-primary">查看工时统计</a>
    </div>

    <c:if test="${not empty sessionScope.adminSignMsg}">
        <div class="alert alert-info">${sessionScope.adminSignMsg}</div>
        <c:remove var="adminSignMsg" scope="session"/>
    </c:if>

    <form class="row g-2 mb-3" method="get" action="${pageContext.request.contextPath}/admin/sign/list">
        <div class="col-auto">
            <select name="status" class="form-select">
                <option value="">全部状态</option>
                <option value="1" ${status == 1 ? 'selected' : ''}>服务中</option>
                <option value="2" ${status == 2 ? 'selected' : ''}>已签退</option>
                <option value="3" ${status == 3 ? 'selected' : ''}>已作废</option>
            </select>
        </div>
        <div class="col-auto">
            <select name="auditStatus" class="form-select">
                <option value="">全部审核</option>
                <option value="1" ${auditStatus == 1 ? 'selected' : ''}>待审核</option>
                <option value="2" ${auditStatus == 2 ? 'selected' : ''}>已通过</option>
                <option value="3" ${auditStatus == 3 ? 'selected' : ''}>已驳回</option>
            </select>
        </div>
        <div class="col-auto">
            <input type="text" name="keyword" class="form-control" placeholder="用户 / 服务内容" value="${keyword}">
        </div>
        <div class="col-auto"><button type="submit" class="btn btn-primary">筛选</button></div>
        <div class="col-auto"><a href="${pageContext.request.contextPath}/admin/sign/list" class="btn btn-outline-secondary">重置</a></div>
    </form>

    <div class="table-responsive">
        <table class="table table-hover align-middle bg-white">
            <thead class="table-light">
            <tr>
                <th>ID</th><th>志愿者</th><th>服务类型</th><th>关联活动</th><th>内容</th>
                <th>签到</th><th>签退</th><th>工时</th><th>状态</th><th>审核</th><th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="s" items="${list}">
                <tr>
                    <td>${s.signId}</td>
                    <td>${empty s.nickname ? s.username : s.nickname}<br><small class="text-muted">${s.username}</small></td>
                    <td>${s.serviceTypeText}</td>
                    <td>${empty s.activityTitle ? '—' : s.activityTitle}</td>
                    <td>${empty s.content ? '—' : s.content}</td>
                    <td><fmt:formatDate value="${s.signInTime}" pattern="MM-dd HH:mm"/></td>
                    <td><c:choose>
                        <c:when test="${not empty s.signOutTime}"><fmt:formatDate value="${s.signOutTime}" pattern="MM-dd HH:mm"/></c:when>
                        <c:otherwise>—</c:otherwise>
                    </c:choose></td>
                    <td>${empty s.workHours ? 0 : s.workHours}</td>
                    <td>${s.statusText}</td>
                    <td>
                        ${s.auditStatusText}
                        <c:if test="${not empty s.auditRemark}"><br><small class="text-muted">${s.auditRemark}</small></c:if>
                    </td>
                    <td>
                        <c:if test="${s.status == 2 and s.auditStatus == 1}">
                            <form action="${pageContext.request.contextPath}/admin/sign/audit" method="post" class="d-inline">
                                <input type="hidden" name="signId" value="${s.signId}">
                                <input type="hidden" name="auditStatus" value="2">
                                <button type="submit" class="btn btn-sm btn-success">通过</button>
                            </form>
                            <form action="${pageContext.request.contextPath}/admin/sign/audit" method="post" class="d-inline">
                                <input type="hidden" name="signId" value="${s.signId}">
                                <input type="hidden" name="auditStatus" value="3">
                                <input type="text" name="auditRemark" class="form-control form-control-sm d-inline-block w-auto"
                                       placeholder="驳回原因" style="width:110px;">
                                <button type="submit" class="btn btn-sm btn-outline-danger">驳回</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty list}">
                <tr><td colspan="11" class="text-center text-muted py-4">暂无符合条件的签到记录</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
