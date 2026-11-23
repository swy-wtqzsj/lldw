<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>志愿签到 - 流浪猫狗救助系统</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助系统</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">首页</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/pet/list">领养中心</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/help/list">求助中心</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/activity/list">志愿活动</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/knowledge/list">知识科普</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/material/list">物资捐赠</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/sign/list">志愿签到</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/profile">个人中心</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h3 class="mb-3">志愿签到与工时</h3>

    <c:if test="${not empty sessionScope.signMsg}">
        <div class="alert alert-info">${sessionScope.signMsg}</div>
        <c:remove var="signMsg" scope="session"/>
    </c:if>

    <div class="row mb-4">
        <div class="col-md-4">
            <div class="card text-center"><div class="card-body">
                <h6 class="text-muted">已审核累计工时</h6>
                <h2 class="mb-0">${empty myStats.total_hours ? 0 : myStats.total_hours} <small>小时</small></h2>
            </div></div>
        </div>
        <div class="col-md-4">
            <div class="card text-center"><div class="card-body">
                <h6 class="text-muted">累计签到次数</h6>
                <h2 class="mb-0">${empty myStats.sign_count ? 0 : myStats.sign_count}</h2>
            </div></div>
        </div>
        <div class="col-md-4">
            <div class="card text-center"><div class="card-body">
                <h6 class="text-muted">当前服务中</h6>
                <h2 class="mb-0">${empty myStats.signing_now ? 0 : myStats.signing_now}</h2>
            </div></div>
        </div>
    </div>

    <div class="card mb-4">
        <div class="card-header">发起签到</div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/sign/in" method="post" class="row g-3">
                <div class="col-md-3">
                    <label class="form-label">服务类型</label>
                    <select name="serviceType" class="form-select">
                        <option value="1">活动服务</option>
                        <option value="2">日常照护</option>
                        <option value="3">物资整理</option>
                        <option value="4" selected>其他</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label">关联活动（可选）</label>
                    <select name="activityId" class="form-select">
                        <option value="">不关联活动</option>
                        <c:forEach var="a" items="${activities}">
                            <option value="${a.activityId}">${a.title}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-5">
                    <label class="form-label">服务内容</label>
                    <input type="text" name="content" class="form-control" maxlength="255"
                           placeholder="例如：猫舍清洁、物资分拣">
                </div>
                <div class="col-12">
                    <button type="submit" class="btn btn-primary">签到</button>
                    <span class="text-muted ms-2">同一时间只能有一条进行中的签到，服务结束后请签退结算工时。</span>
                </div>
            </form>
        </div>
    </div>

    <div class="card">
        <div class="card-header">我的签到记录</div>
        <div class="card-body table-responsive">
            <table class="table table-hover align-middle">
                <thead>
                <tr>
                    <th>服务日期</th><th>类型</th><th>关联活动</th><th>内容</th>
                    <th>签到时间</th><th>签退时间</th><th>工时</th><th>状态</th><th>审核</th><th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="s" items="${list}">
                    <tr>
                        <td><fmt:formatDate value="${s.signDate}" pattern="yyyy-MM-dd"/></td>
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
                        <td>${s.auditStatusText}</td>
                        <td>
                            <c:if test="${s.status == 1}">
                                <form action="${pageContext.request.contextPath}/sign/out" method="post" class="d-inline">
                                    <input type="hidden" name="signId" value="${s.signId}">
                                    <button type="submit" class="btn btn-sm btn-outline-primary">签退</button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="10" class="text-center text-muted py-4">暂无签到记录，先在上方发起签到吧</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
