<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${activity.title}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助系统</a>
    </div>
</nav>

<div class="container mt-4">
    <h3>${activity.title}</h3>
    <p class="text-muted">
        时间：<fmt:formatDate value="${activity.startTime}" pattern="yyyy-MM-dd HH:mm"/> ~ <fmt:formatDate value="${activity.endTime}" pattern="yyyy-MM-dd HH:mm"/><br>
        地点：${activity.location}<br>
        已报名：${activity.signupCount}/${activity.maxPeople == 0 ? '不限' : activity.maxPeople}人
    </p>

    <c:if test="${not empty sessionScope.activityMsg}">
        <div class="alert alert-warning">${sessionScope.activityMsg}</div>
        <c:remove var="activityMsg" scope="session"/>
    </c:if>

    <hr>

    <p>${activity.content}</p>

    <hr>

    <c:choose>
        <c:when test="${not empty sessionScope.loginUser}">
            <c:choose>
                <c:when test="${userSignup}">
                    <a href="${pageContext.request.contextPath}/activity/cancel?activityId=${activity.activityId}" class="btn btn-outline-danger">取消报名</a>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${activity.status == 2}">
                            <a href="${pageContext.request.contextPath}/activity/signup?activityId=${activity.activityId}" class="btn btn-primary">立即报名</a>
                        </c:when>
                        <c:otherwise>
                            <span class="text-muted">该活动暂未开放报名</span>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
            <a href="${pageContext.request.contextPath}/activity/my" class="btn btn-outline-secondary">我的活动</a>
            <a href="${pageContext.request.contextPath}/report/publish?targetType=4&amp;targetId=${activity.activityId}" class="btn btn-outline-danger">举报该活动</a>
        </c:when>
        <c:otherwise>
            <p class="text-muted">登录后可报名活动</p>
        </c:otherwise>
    </c:choose>

    <a href="${pageContext.request.contextPath}/activity/list" class="btn btn-outline-secondary">返回列表</a>

    <hr>

    <h5>留言</h5>
    <c:choose>
        <c:when test="${not empty sessionScope.loginUser}">
            <form action="${pageContext.request.contextPath}/comment/add" method="post" class="mb-3">
                <input type="hidden" name="targetType" value="2">
                <input type="hidden" name="targetId" value="${activity.activityId}">
                <div class="input-group">
                    <input type="text" name="content" class="form-control" maxlength="500" placeholder="写下你的留言...">
                    <button type="submit" class="btn btn-primary">发表</button>
                </div>
            </form>
        </c:when>
        <c:otherwise>
            <p class="text-muted">登录后可发表留言</p>
        </c:otherwise>
    </c:choose>

    <c:forEach var="comment" items="${comments}">
        <div class="card mb-2">
            <div class="card-body py-2">
                <div class="d-flex justify-content-between">
                    <strong>${comment.username}</strong>
                    <span>
                        <small class="text-muted"><fmt:formatDate value="${comment.commentTime}" pattern="yyyy-MM-dd HH:mm"/></small>
                        <a href="${pageContext.request.contextPath}/report/publish?targetType=1&amp;targetId=${comment.commentId}" class="ms-2 small">举报</a>
                    </span>
                </div>
                <p class="mb-0">${comment.content}</p>
            </div>
        </div>
    </c:forEach>
    <c:if test="${empty comments}">
        <p class="text-muted">暂无留言，来抢沙发~</p>
    </c:if>
</div>
</body>
</html>
