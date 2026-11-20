<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的处罚与申诉</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/theme.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助系统</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/appeal/my">我的处罚与申诉</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/profile">个人中心</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h3>我的处罚与申诉</h3>

    <c:if test="${not empty sessionScope.appealMsg}">
        <div class="alert alert-info">${sessionScope.appealMsg}</div>
        <c:remove var="appealMsg" scope="session"/>
    </c:if>

    <div class="card mb-4">
        <div class="card-header">我的处罚记录</div>
        <div class="card-body p-0">
            <table class="table table-striped mb-0 align-middle">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>类型</th>
                        <th>原因</th>
                        <th>开始时间</th>
                        <th>结束时间</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${punishments}">
                        <tr>
                            <td>${item.punishId}</td>
                            <td>${item.typeText}</td>
                            <td>${item.reason}</td>
                            <td><fmt:formatDate value="${item.startTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty item.endTime}">
                                        <fmt:formatDate value="${item.endTime}" pattern="yyyy-MM-dd HH:mm"/>
                                    </c:when>
                                    <c:otherwise>永久</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${item.status == 1}"><span class="badge bg-danger">生效中</span></c:when>
                                    <c:when test="${item.status == 2}"><span class="badge bg-secondary">已解除</span></c:when>
                                    <c:otherwise><span class="badge bg-secondary">已到期</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${item.status == 1}">
                                    <a href="${pageContext.request.contextPath}/appeal/apply?punishId=${item.punishId}"
                                       class="btn btn-sm btn-outline-primary">申诉</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty punishments}">
                        <tr>
                            <td colspan="7" class="text-center text-muted">暂无处罚记录</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <div class="card">
        <div class="card-header">我的申诉记录</div>
        <div class="card-body p-0">
            <table class="table table-striped mb-0 align-middle">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>关联处罚</th>
                        <th>申诉说明</th>
                        <th>佐证</th>
                        <th>申诉时间</th>
                        <th>状态</th>
                        <th>复核意见</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${list}">
                        <tr>
                            <td>${item.appealId}</td>
                            <td>#${item.punishId} ${item.punishTypeText}</td>
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
                                    <div class="small text-muted">
                                        <fmt:formatDate value="${item.reviewTime}" pattern="yyyy-MM-dd HH:mm"/>
                                    </div>
                                    <div class="small">${item.reviewOpinion}</div>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty list}">
                        <tr>
                            <td colspan="7" class="text-center text-muted">暂无申诉记录</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
