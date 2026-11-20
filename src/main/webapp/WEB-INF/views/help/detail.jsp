<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${help.title}</title>
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
    <div class="row">
        <div class="col-md-8">
            <h3>${help.title}</h3>
            <p class="text-muted">
                <span class="badge bg-info">${help.typeText}</span>
                <span class="badge bg-secondary ms-2">${help.handleStatusText}</span>
                | 发布人：${help.username} | ${help.publishTime}
            </p>

            <c:if test="${not empty help.photo}">
                <img src="${help.photo}" class="img-fluid mb-3" alt="求助照片">
            </c:if>

            <p>${help.content}</p>

            <c:if test="${not empty sessionScope.helpRespMsg}">
                <div class="alert alert-info">${sessionScope.helpRespMsg}</div>
                <c:remove var="helpRespMsg" scope="session"/>
            </c:if>

            <hr>

            <!-- 响应区 -->
            <h5>求助响应 (${responses.size()})</h5>
            <c:if test="${canRespond}">
                <form action="${pageContext.request.contextPath}/help/response/save" method="post" class="mb-3">
                    <input type="hidden" name="helpId" value="${help.helpId}">
                    <textarea name="content" class="form-control mb-2" rows="2" maxlength="500"
                              placeholder="描述你能提供的帮助..." required></textarea>
                    <button type="submit" class="btn btn-sm btn-primary">提交响应</button>
                </form>
            </c:if>
            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <c:if test="${not canRespond and sessionScope.loginUser.userId == help.userId}">
                        <p class="text-muted small">这是你发布的求助，等待他人响应</p>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <p class="text-muted small">登录后可响应求助</p>
                </c:otherwise>
            </c:choose>
            <c:forEach var="response" items="${responses}">
                <div class="card mb-2">
                    <div class="card-body py-2">
                        <div class="d-flex justify-content-between">
                            <strong>${response.responderName}</strong>
                            <span class="badge bg-secondary">${response.statusText}</span>
                        </div>
                        <p class="mb-1">${response.content}</p>
                        <small class="text-muted">
                            <fmt:formatDate value="${response.respTime}" pattern="yyyy-MM-dd HH:mm"/>
                        </small>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty responses}">
                <p class="text-muted">暂无响应</p>
            </c:if>

            <hr>

            <!-- 评论区 -->
            <h5>评论 (${comments.size()})</h5>

            <!-- 发表评论 -->
            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <form action="${pageContext.request.contextPath}/help/comment" method="post" class="mb-4">
                        <input type="hidden" name="targetId" value="${help.helpId}">
                        <div class="input-group">
                            <input type="text" name="content" class="form-control" maxlength="500" placeholder="发表评论...">
                            <button type="submit" class="btn btn-primary">发表</button>
                        </div>
                    </form>
                </c:when>
                <c:otherwise>
                    <p class="text-muted">登录后可发表评论</p>
                </c:otherwise>
            </c:choose>

            <!-- 评论列表 -->
            <c:forEach var="comment" items="${comments}">
                <div class="card mb-2">
                    <div class="card-body py-2">
                        <div class="d-flex justify-content-between">
                            <strong>${comment.username}</strong>
                            <span>
                                <small class="text-muted">${comment.commentTime}</small>
                                <a href="${pageContext.request.contextPath}/report/publish?targetType=1&amp;targetId=${comment.commentId}" class="ms-2 small">举报</a>
                            </span>
                        </div>
                        <p class="mb-0">${comment.content}</p>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty comments}">
                <p class="text-muted">暂无评论，来抢沙发~</p>
            </c:if>
        </div>

        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5>求助信息</h5>
                    <p><strong>位置：</strong>${help.location}</p>
                    <p><strong>联系方式：</strong>${help.contact}</p>
                    <a href="${pageContext.request.contextPath}/report/publish?targetType=2&amp;targetId=${help.helpId}" class="btn btn-sm btn-outline-danger">举报该求助</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
