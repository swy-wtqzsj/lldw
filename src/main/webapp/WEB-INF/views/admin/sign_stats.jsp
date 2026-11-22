<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>工时统计 - 后台</title>
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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/activity/list">活动</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/material/list">物资</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/sign/list">志愿签到</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/sign/stats">工时统计</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid px-4 mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">志愿工时统计</h3>
        <a href="${pageContext.request.contextPath}/admin/sign/list" class="btn btn-outline-primary">签到记录</a>
    </div>

    <div class="row mb-4">
        <div class="col-md-2"><div class="card text-center"><div class="card-body">
            <h6 class="text-muted">累计签到</h6><h3 class="mb-0">${empty summary.sign_total ? 0 : summary.sign_total}</h3>
        </div></div></div>
        <div class="col-md-2"><div class="card text-center"><div class="card-body">
            <h6 class="text-muted">今日签到</h6><h3 class="mb-0">${empty today ? 0 : today}</h3>
        </div></div></div>
        <div class="col-md-2"><div class="card text-center"><div class="card-body">
            <h6 class="text-muted">服务中</h6><h3 class="mb-0">${empty summary.signing_now ? 0 : summary.signing_now}</h3>
        </div></div></div>
        <div class="col-md-2"><div class="card text-center"><div class="card-body">
            <h6 class="text-muted">累计工时</h6><h3 class="mb-0">${empty summary.hours_total ? 0 : summary.hours_total}</h3>
        </div></div></div>
        <div class="col-md-2"><div class="card text-center"><div class="card-body">
            <h6 class="text-muted">参与志愿者</h6><h3 class="mb-0">${empty summary.volunteer_total ? 0 : summary.volunteer_total}</h3>
        </div></div></div>
        <div class="col-md-2"><div class="card text-center"><div class="card-body">
            <h6 class="text-muted">待审核工时</h6><h3 class="mb-0">${empty summary.audit_pending ? 0 : summary.audit_pending}</h3>
        </div></div></div>
    </div>

    <div class="card">
        <div class="card-header">志愿者工时排行</div>
        <div class="card-body table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                <tr><th>排名</th><th>志愿者</th><th>账号</th><th>签到次数</th><th>已完成</th><th>累计工时(小时)</th></tr>
                </thead>
                <tbody>
                <c:forEach var="r" items="${rank}" varStatus="vs">
                    <tr>
                        <td>${vs.count}</td>
                        <td>${empty r.nickname ? '—' : r.nickname}</td>
                        <td>${r.username}</td>
                        <td>${r.sign_count}</td>
                        <td>${r.finish_count}</td>
                        <td><strong>${empty r.total_hours ? 0 : r.total_hours}</strong></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty rank}">
                    <tr><td colspan="6" class="text-center text-muted py-4">暂无工时数据</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
