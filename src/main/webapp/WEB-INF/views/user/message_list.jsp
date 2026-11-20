<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>消息中心 - 流浪猫狗救助系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">流浪猫狗救助</a>
        </div>
        <ul class="nav navbar-nav">
            <li><a href="${pageContext.request.contextPath}/profile">个人中心</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="${pageContext.request.contextPath}/logout">退出</a></li>
        </ul>
    </div>
</nav>

<div class="container">
    <h2>消息中心 <small>未读 ${unread} 条</small></h2>
    <div class="btn-group" style="margin-bottom:15px;">
        <a href="${pageContext.request.contextPath}/message/list" class="btn btn-default ${empty isRead ? 'active' : ''}">全部</a>
        <a href="${pageContext.request.contextPath}/message/list?isRead=0" class="btn btn-default ${isRead == 0 ? 'active' : ''}">未读</a>
        <a href="${pageContext.request.contextPath}/message/list?isRead=1" class="btn btn-default ${isRead == 1 ? 'active' : ''}">已读</a>
        <a href="${pageContext.request.contextPath}/message/readAll" class="btn btn-primary">全部标为已读</a>
    </div>

    <c:choose>
        <c:when test="${empty messages}">
            <div class="alert alert-info">暂无消息。</div>
        </c:when>
        <c:otherwise>
            <div class="list-group">
                <c:forEach var="m" items="${messages}">
                    <div class="list-group-item ${m.isRead == 0 ? 'list-group-item-warning' : ''}">
                        <h4 class="list-group-item-heading">
                            ${m.title}
                            <c:if test="${m.isRead == 0}"><span class="label label-danger">未读</span></c:if>
                            <small class="pull-right">${m.sendTime} · ${m.senderTypeName}</small>
                        </h4>
                        <p class="list-group-item-text">${m.content}</p>
                        <c:if test="${m.isRead == 0}">
                            <a href="${pageContext.request.contextPath}/message/read/${m.messageId}" class="btn btn-xs btn-default">标记已读</a>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
